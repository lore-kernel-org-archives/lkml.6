Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 554C7C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 14:31:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DEED222B5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 14:31:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392257AbfBMOb6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 09:31:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:39646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726655AbfBMOb5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 09:31:57 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 65C0B222B2;
        Wed, 13 Feb 2019 14:31:56 +0000 (UTC)
Date:   Wed, 13 Feb 2019 09:31:54 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     xiang xiao <xiaoxiang781216@gmail.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org, Xiang Xiao <xiaoxiang@xiaomi.com>
Subject: Re: [PATCH] printk: add KERN_NOTIME to skip the timestamp
Message-ID: <20190213093154.7af84743@gandalf.local.home>
In-Reply-To: <CAH2Cfb9YTAf4j7tv4Q5dWM_jQCzsWBo6ufoT=BXYx5qpgcMCNQ@mail.gmail.com>
References: <1549995065-27597-1-git-send-email-xiaoxiang@xiaomi.com>
        <20190212144606.4b7cf0f8@gandalf.local.home>
        <CAH2Cfb-Zd9TKgs52ROVGYg6F_hiN2ieWKwYPkxpVV8St+zwa2A@mail.gmail.com>
        <20190213084741.5512307a@gandalf.local.home>
        <CAH2Cfb9YTAf4j7tv4Q5dWM_jQCzsWBo6ufoT=BXYx5qpgcMCNQ@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Feb 2019 22:00:04 +0800
xiang xiao <xiaoxiang781216@gmail.com> wrote:

> On Wed, Feb 13, 2019 at 9:47 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > On Wed, 13 Feb 2019 14:19:01 +0800
> > xiang xiao <xiaoxiang781216@gmail.com> wrote:
> >  
> > > On Wed, Feb 13, 2019 at 3:46 AM Steven Rostedt <rostedt@goodmis.org> wrote:  
> > > >
> > > > On Wed, 13 Feb 2019 02:11:05 +0800
> > > > Xiang Xiao <xiaoxiang781216@gmail.com> wrote:
> > > >  
> > > > > Because log may already add the timestamp sometime  
> > > >
> > > > Can you be a bit more detailed on this. When and where does this
> > > > happen?  
> > >
> > > Here is my case:
> > > 1.A small MCU(Cortex M4) in SoC run RTOS
> > > 2.RTOS append timestamp to log for the accurate timing
> > > 3.RTOS send log to Linux kernel when buffer exceed the threshold
> > > 4.Kernel call printk to dump the received buffer
> > > So I want that printk skip the timestamp here.
> > >  
> > > > If anything, I would probably prefer that we export whether
> > > > time is being printed, and have the caller not print time if printk is
> > > > doing it already, than to add the complexity into printk itself.  
> > >
> > > Actually, the timestamp of our initial implementation like your
> > > suggestion come from printk,
> > > but we found that timestamp from kernel isn't accurate as from RTOS
> > > due the buffer and IPC.
> > >  
> >
> > If the timestamps are different, then you don't want to remove the
> > printk one. Otherwise you are going to have a confusion between your
> > added timestamp mixed in with the kernel's inaccurate timestamps.
> >  
> 
> Here is a sample output with this patch:
> [   10.991426] virtio_rpmsg_bus virtio1: rpmsg host is online
> [   10.991443] remoteproc remoteproc1: registered virtio1 (type 7)
> [   10.991450] remoteproc remoteproc1: remote processor
> f9210000.toppwr:sen-rproc is now up
> [   10.993715] virtio_rpmsg_bus virtio1: creating channel
> rpmsg-ttySENSOR addr 0x1
> [   10.994606] virtio_rpmsg_bus virtio1: creating channel rpmsg-ttyGPS addr 0x2
> [   10.995236] virtio_rpmsg_bus virtio1: creating channel rpmsg-clk addr 0x3
> [   10.995702] virtio_rpmsg_bus virtio1: creating channel rpmsg-syslog addr 0x4
> [   10.996197] virtio_rpmsg_bus virtio1: creating channel rpmsg-rtc addr 0x5
> [   10.997297] virtio_rpmsg_bus virtio1: creating channel rpmsg-hostfs addr 0x6
> [   10.999842] virtio_rpmsg_bus virtio1: creating channel rpmsg-usrsock addr 0x7
> [     0.007680] sensor: NuttX sensor 7.28 e3c2ecb Feb 12 2019 16:53:49
> arm song/banks
> ^^^^^^^^^^^^^
> [   11.918177] random: crng init done
> [   12.567362] e2fsck: e2fsck 1.42.9 (28-Dec-2013)
> 
> Without this patch:
> [   10.991426] virtio_rpmsg_bus virtio1: rpmsg host is online
> [   10.991443] remoteproc remoteproc1: registered virtio1 (type 7)
> [   10.991450] remoteproc remoteproc1: remote processor
> f9210000.toppwr:sen-rproc is now up
> [   10.993715] virtio_rpmsg_bus virtio1: creating channel
> rpmsg-ttySENSOR addr 0x1
> [   10.994606] virtio_rpmsg_bus virtio1: creating channel rpmsg-ttyGPS addr 0x2
> [   10.995236] virtio_rpmsg_bus virtio1: creating channel rpmsg-clk addr 0x3
> [   10.995702] virtio_rpmsg_bus virtio1: creating channel rpmsg-syslog addr 0x4
> [   10.996197] virtio_rpmsg_bus virtio1: creating channel rpmsg-rtc addr 0x5
> [   10.997297] virtio_rpmsg_bus virtio1: creating channel rpmsg-hostfs addr 0x6
> [   10.999842] virtio_rpmsg_bus virtio1: creating channel rpmsg-usrsock addr 0x7
> [   11.105345][     0.007680] sensor: NuttX sensor 7.28 e3c2ecb Feb 12
> 2019 16:53:49 arm song/banks
> ^^^^^^^^^^^^^^^^^^^^^^^^^^
> [   11.918177] random: crng init done
> [   12.567362] e2fsck: e2fsck 1.42.9 (28-Dec-2013)
> 
> Which one do you think better?

Honestly, the one without the patch.

Seriously, it also makes it easy to see where that message happened
with respect to the other printks. With your patch, we would have no
idea, and if I was a normal user, unaware of this patch, I would
probably submit a bug report claiming that something is wrong with the
timestamps.

-- Steve
