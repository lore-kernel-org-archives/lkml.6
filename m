Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6FD7C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 18:04:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 995C42146F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 18:04:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 995C42146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbeLAFO4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 00:14:56 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:38553 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726409AbeLAFO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 00:14:56 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1gSn9f-0008Qr-IH; Fri, 30 Nov 2018 19:04:43 +0100
Date:   Fri, 30 Nov 2018 19:04:43 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Cc:     Oleksandr Natalenko <oleksandr@natalenko.name>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Eric Dumazet <edumazet@google.com>,
        Dave Jones <davej@codemonkey.org.uk>, netdev@vger.kernel.org,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: WARN_ON() in netconsole with PREEMPT_RT
Message-ID: <20181130180443.o2kjcpweaglmsmx6@linutronix.de>
References: <f9111ab09dbc264c8ff8b3b79e9f4c06@natalenko.name>
 <a23ae3a8501d5c996d7a9dd2f27dd5fa@natalenko.name>
 <20181111210105.7f376c35@vmware.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181111210105.7f376c35@vmware.local.home>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-11-11 21:01:05 [-0500], Steven Rostedt wrote:
> On Sun, 11 Nov 2018 21:16:00 +0100
> Oleksandr Natalenko <oleksandr@natalenko.name> wrote:
> > Oh, I see that write_msg() calls netpoll_send_udp() under 
> > spin_lock_irqsave(), but in PREEMPT_RT this, AFAIK, does not disable 
> > interrupts.
> > 
> > So, the real question here is whether the interrupts should be indeed 
> > disabled. And if so, -rt should replace spin_lock_irqsave() call there 
> > with what? local_irq_save()? and get rid of the warning?
> > 
> 
> Why do we care if interrupts are disabled with PREEMPT_RT here?

We don't actually. It was broken before for some reason and disabled on
RT. Later people asked for NETCONSOLE on RT and it seemed to have worked
so I allowed it again starting with v3.14.3-rt5.
A year later (v4.3-rc1) commit c9fd56b34efd0 ("netpoll: warn on
netpoll_send_udp users who haven't disabled irqs") introduced that
warning. 
It seems the only reason why netpoll_send_udp() is invoked with disabled
interrupts is because the caller acquired `target_list_lock' with
disabled interrupts. I remember that earlier there was some
local_irq_save() based locking but all this is gone now.

Nikolay could you please explain why interrupts have to be disabled at
this point? It looks to me that this check could be dropped.

> -- Steve

Sebastian
