Return-Path: <SRS0=eDXJ=JC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DC81C433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 13:43:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B4BB20862
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 13:43:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gWRID9Q0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B4BB20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932939AbeFPNne (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Jun 2018 09:43:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:56504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932719AbeFPNnd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jun 2018 09:43:33 -0400
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F46C2088E;
        Sat, 16 Jun 2018 13:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529156612;
        bh=uYwP+hLfFsnuAzJU+RY4snGMjrLr4anNvc1JNvDjZCg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gWRID9Q0X7d9k3JIUtLfSwiW4HlwjXIprHpJ/R7CF2vtNZ3faodrpmsSfji2Cjx7B
         sTNe4C6A5wqIHIWRPV2Hi0d8NOu+6txdzO1Rg43Bj+Cf2uJL1tHoF/i92wUs2LdPiA
         N72aNNpoqFltOb3jAU2Wc+KOr6vYuo4ySQWqOjsY=
Date:   Sat, 16 Jun 2018 22:43:29 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Joel Fernandes <joelaf@google.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>, tglx@linutronix.de,
        mhiramat@kernel.org, namhyung@kernel.org,
        mathieu.desnoyers@efficios.com, linux-rt-users@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>, peterz@infradead.org
Subject: Re: [PATCH RFC] tracing: Call triggers only if event passes filter
 checks
Message-Id: <20180616224329.02e37ef4aee72c7d5685818e@kernel.org>
In-Reply-To: <20180615010113.127718-1-joel@joelfernandes.org>
References: <20180615010113.127718-1-joel@joelfernandes.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
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

Have you tried if statement as below?

echo "stacktrace if lat > 400" > /sys/kernel/debug/tracing/events/synthetic/preemptdisable/trigger

As my understanding, filter is used for controlling "recording the event"
and trigger is out of its scope. Trigger itself has own filter as
"if statement", so you should use it.

Thank you,


-- 
Masami Hiramatsu <mhiramat@kernel.org>
