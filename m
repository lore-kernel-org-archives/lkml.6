Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8D26C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 16:16:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CC62208AF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 16:16:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CC62208AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966029AbeFOQQH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 12:16:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:60062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964966AbeFOQQG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 12:16:06 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6FD71208AF;
        Fri, 15 Jun 2018 16:16:05 +0000 (UTC)
Date:   Fri, 15 Jun 2018 12:16:03 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Joel Fernandes <joelaf@google.com>
Cc:     "BarclaycardUS" 
        <1eaff0972layfivcia3p5kbiaaaaabtyzcthzutkdtiyaaaaa@offers.BarclaycardUS.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] tracing: Call triggers only if event passes filter
 checks
Message-ID: <20180615121603.33007151@gandalf.local.home>
In-Reply-To: <20180615010113.127718-1-joel@joelfernandes.org>
References: <20180615010113.127718-1-joel@joelfernandes.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Jun 2018 18:01:13 -0700
Joel Fernandes <joelaf@google.com> wrote:

> From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> 
> Currently, trace event triggers are called regardless of if the event
> filter checks pass or fail. Thus if one were to enable event triggers
> and filters at the same time, then the triggers will always be called
> even if the filter checks didn't pass.
> 
> This is a problem for a usecase I was experimenting with: measuring the
> time preemption is disabled using synthetic events and dump the stack
> using the stacktrace trigger if the total preempt off time was greater
> than a threshold. Following are the commands for the same:
> 
> Create synthetic event:
> 
> echo 'preemptdisable u64 lat' >> \
> 	      /sys/kernel/debug/tracing/synthetic_events
> 
> echo 'hist:keys=cpu:ts0=common_timestamp.usecs:scpu=cpu' >> \
> 	      /sys/kernel/debug/tracing/events/preemptirq/preempt_disable/trigger
> 
> echo 'hist:keys=cpu:wakeup_lat=common_timestamp.usecs-$ts0:\
> onmatch(preemptirq.preempt_disable).preemptdisable($wakeup_lat)' >> \
> 	        /sys/kernel/debug/tracing/events/preemptirq/preempt_enable/trigger
> 
> Enable synthetic event:
> 
> echo stacktrace > /sys/kernel/debug/tracing/events/synthetic/preemptdisable/trigger
> echo 'lat > 400' > /sys/kernel/debug/tracing/events/synthetic/preemptdisable/filter
> echo 1 > /sys/kernel/debug/tracing/events/synthetic/preemptdisable/enable
> 
> With the patch, the stacktrace is triggered only if the filter checks
> passed. It also seems sensible to call triggers only if filter checks
> pass so lets do that.

No, it worked as expected. The filter is only to be used it the event
should be recorded or not. What you wanted to do is:

 echo 'stacktrace if lat > 400' > events/synthetic/preemptdisable/trigger

-- Steve
