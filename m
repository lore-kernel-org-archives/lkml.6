Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69113C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:19:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40C53222B1
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:19:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390380AbfBMNTR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 08:19:17 -0500
Received: from mx2.suse.de ([195.135.220.15]:39010 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730377AbfBMNTO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 08:19:14 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D0319B03B;
        Wed, 13 Feb 2019 13:19:12 +0000 (UTC)
Date:   Wed, 13 Feb 2019 14:19:12 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     xiang xiao <xiaoxiang781216@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org, Xiang Xiao <xiaoxiang@xiaomi.com>
Subject: Re: [PATCH] printk: add KERN_NOTIME to skip the timestamp
Message-ID: <20190213131912.4w3fonbgwjathpyp@pathway.suse.cz>
References: <1549995065-27597-1-git-send-email-xiaoxiang@xiaomi.com>
 <20190212144606.4b7cf0f8@gandalf.local.home>
 <CAH2Cfb-Zd9TKgs52ROVGYg6F_hiN2ieWKwYPkxpVV8St+zwa2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH2Cfb-Zd9TKgs52ROVGYg6F_hiN2ieWKwYPkxpVV8St+zwa2A@mail.gmail.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2019-02-13 14:19:01, xiang xiao wrote:
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

What do you exactly mean by the threshold, please? Does it mean
that you use the kernel buffer when there are too many messages
and they do not fit into the MCU local buffer?

How exactly the kernel gets the messages, please?
Via a kernel driver or from userspace (via /dev/kmsg)?


> 4.Kernel call printk to dump the received buffer
> So I want that printk skip the timestamp here.

If the messages are printed by a kernel driver then
a better solution would be to create a printk() API
where you could pass the time stamp as a parameter.

The aim is to store the precise time stamp in ts_nsec, struct
printk_log. Then it will get handled correctly by any
output, e.g. consoles, syslog, /dev/kmsg.


There are several problems with your approach:

1. The time stamp is still duplicated in the output via /dev/kmsg,
   see msg_print_ext_header(). We could not change this
   because the time stamp is part of the format.
   Any change could break userspace (systemd).


2. The time stamp stays part of the message:

     + It might have different format than the normal
       time stamp. Therefore it might be hard to filter

     + dmesg might be unable to parse it and show in
       the other formats.

     + Kernel-5.1 will allow to print information
       about the caller. It is supposed to be between
       the time stamp and the message text, see
       http://lkml.kernel.org/r/93f19e57-5051-c67d-9af4-b17624062d44@i-love.sakura.ne.jp


Best Regards,
Petr
