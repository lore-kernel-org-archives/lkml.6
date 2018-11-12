Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1B2FC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 02:01:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCF7E208A3
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 02:01:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCF7E208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730190AbeKLLv6 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 06:51:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:41534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729903AbeKLLv6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 06:51:58 -0500
Received: from vmware.local.home (unknown [64.114.255.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 61FF32087F;
        Mon, 12 Nov 2018 02:01:06 +0000 (UTC)
Date:   Sun, 11 Nov 2018 21:01:05 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Oleksandr Natalenko <oleksandr@natalenko.name>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Eric Dumazet <edumazet@google.com>,
        Dave Jones <davej@codemonkey.org.uk>, netdev@vger.kernel.org,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: WARN_ON() in netconsole with PREEMPT_RT
Message-ID: <20181111210105.7f376c35@vmware.local.home>
In-Reply-To: <a23ae3a8501d5c996d7a9dd2f27dd5fa@natalenko.name>
References: <f9111ab09dbc264c8ff8b3b79e9f4c06@natalenko.name>
        <a23ae3a8501d5c996d7a9dd2f27dd5fa@natalenko.name>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 Nov 2018 21:16:00 +0100
Oleksandr Natalenko <oleksandr@natalenko.name> wrote:


> > This is a v4.19.1-rt3-based kernel.
> > 
> > The WARN_ON() is:
> > 
> > 362 void netpoll_send_udp(struct netpoll *np, const char *msg, int len)
> > 363 {
> > …
> > 372     WARN_ON_ONCE(!irqs_disabled());
> > …
> > 
> > If that matters, I have "threadirqs" passed to the kernel.
> > 
> > Netconsole seems to work even after this warning. Is this OK/expected?
> > 
> > Thanks.  
> 
> Oh, I see that write_msg() calls netpoll_send_udp() under 
> spin_lock_irqsave(), but in PREEMPT_RT this, AFAIK, does not disable 
> interrupts.
> 
> So, the real question here is whether the interrupts should be indeed 
> disabled. And if so, -rt should replace spin_lock_irqsave() call there 
> with what? local_irq_save()? and get rid of the warning?
> 

Why do we care if interrupts are disabled with PREEMPT_RT here?

printk() itself has a lot of issues with PREEMPT_RT that we are working
on dealing with. Right now netconsole is actually at the end of that
todo list.

-- Steve
