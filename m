Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E1FCC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 02:16:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F064920989
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 02:16:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="l5AZRBmJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F064920989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbeK1NP4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 08:15:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:37208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726567AbeK1NP4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 08:15:56 -0500
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3AC2220873;
        Wed, 28 Nov 2018 02:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543371361;
        bh=qfGVPgES3/EO5fmOaDcRVNBlKWE6Z7Or5duZ0rSzIlM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=l5AZRBmJhQiVWtUHaHQ1z4S33CbSgJR9QLBBPxuqn5IbKWQblTzzunm946/RJ3A+K
         +WbIeRYV47Aurf+CTYN+4gQanVgZE6i7AFy05HfnD4zEHb0lbCX2saeNOVhq2uL1s3
         EUlnyHxdazMVq+KFKTDCGWLW/hwsKwEZg6tZA+sA=
Date:   Wed, 28 Nov 2018 11:15:58 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     rostedt@goodmis.org, tglx@linutronix.de, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v7 09/16] tracing: Add hist trigger snapshot() action
 test case
Message-Id: <20181128111558.5869fa4be7104314e833a801@kernel.org>
In-Reply-To: <1543359225.4223.5.camel@kernel.org>
References: <cover.1542221862.git.tom.zanussi@linux.intel.com>
        <a40dadf6ffa267a1a573b62bb1c9b4db9d91f744.1542221863.git.tom.zanussi@linux.intel.com>
        <20181126220332.215b461779d1d57f37b46e20@kernel.org>
        <1543359225.4223.5.camel@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tom,

On Tue, 27 Nov 2018 16:53:45 -0600
Tom Zanussi <zanussi@kernel.org> wrote:

> > > +ping $LOCALHOST -c 3
> > > +nice -n 1 ping $LOCALHOST -c 3
> > > +
> > > +echo 0 > /sys/kernel/debug/tracing/events/sched/enable
> > 
> > Shouldn't we stop tracing instead of disabling the event?
> > 
> 
> This is just reversing the enable, so should be fine, but I can stop
> tracing instead if you prefer.

Oops, maybe we have to check the difference between event enabling and
trace enabling.
echo 0 > tracing_on will stop writing ring buffer, but event may continue
to be called. Does this mean hist will be updated? (and I guess preferrable
behavior is to stop hist too, isn't it?)

Thank you,


-- 
Masami Hiramatsu <mhiramat@kernel.org>
