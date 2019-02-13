Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3CB1C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:47:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF773222C1
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:47:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732629AbfBMNro (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 08:47:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:59848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730351AbfBMNrn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 08:47:43 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 23985218D3;
        Wed, 13 Feb 2019 13:47:43 +0000 (UTC)
Date:   Wed, 13 Feb 2019 08:47:41 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     xiang xiao <xiaoxiang781216@gmail.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org, Xiang Xiao <xiaoxiang@xiaomi.com>
Subject: Re: [PATCH] printk: add KERN_NOTIME to skip the timestamp
Message-ID: <20190213084741.5512307a@gandalf.local.home>
In-Reply-To: <CAH2Cfb-Zd9TKgs52ROVGYg6F_hiN2ieWKwYPkxpVV8St+zwa2A@mail.gmail.com>
References: <1549995065-27597-1-git-send-email-xiaoxiang@xiaomi.com>
        <20190212144606.4b7cf0f8@gandalf.local.home>
        <CAH2Cfb-Zd9TKgs52ROVGYg6F_hiN2ieWKwYPkxpVV8St+zwa2A@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Feb 2019 14:19:01 +0800
xiang xiao <xiaoxiang781216@gmail.com> wrote:

> On Wed, Feb 13, 2019 at 3:46 AM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > On Wed, 13 Feb 2019 02:11:05 +0800
> > Xiang Xiao <xiaoxiang781216@gmail.com> wrote:
> >  
> > > Because log may already add the timestamp sometime  
> >
> > Can you be a bit more detailed on this. When and where does this
> > happen?  
> 
> Here is my case:
> 1.A small MCU(Cortex M4) in SoC run RTOS
> 2.RTOS append timestamp to log for the accurate timing
> 3.RTOS send log to Linux kernel when buffer exceed the threshold
> 4.Kernel call printk to dump the received buffer
> So I want that printk skip the timestamp here.
> 
> > If anything, I would probably prefer that we export whether
> > time is being printed, and have the caller not print time if printk is
> > doing it already, than to add the complexity into printk itself.  
> 
> Actually, the timestamp of our initial implementation like your
> suggestion come from printk,
> but we found that timestamp from kernel isn't accurate as from RTOS
> due the buffer and IPC.
>

If the timestamps are different, then you don't want to remove the
printk one. Otherwise you are going to have a confusion between your
added timestamp mixed in with the kernel's inaccurate timestamps.

-- Steve
