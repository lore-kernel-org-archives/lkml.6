Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A43BEC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 08:49:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 761C3222A1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 08:49:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436831AbfBNIs6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 03:48:58 -0500
Received: from mx2.suse.de ([195.135.220.15]:33002 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388475AbfBNIs6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 03:48:58 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4CC03AAA9;
        Thu, 14 Feb 2019 08:48:56 +0000 (UTC)
Date:   Thu, 14 Feb 2019 09:48:55 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     xiang xiao <xiaoxiang781216@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org, Xiang Xiao <xiaoxiang@xiaomi.com>
Subject: Re: [PATCH] printk: add KERN_NOTIME to skip the timestamp
Message-ID: <20190214084855.xyug7cmnrybdcmos@pathway.suse.cz>
References: <1549995065-27597-1-git-send-email-xiaoxiang@xiaomi.com>
 <20190212144606.4b7cf0f8@gandalf.local.home>
 <CAH2Cfb-Zd9TKgs52ROVGYg6F_hiN2ieWKwYPkxpVV8St+zwa2A@mail.gmail.com>
 <20190213084741.5512307a@gandalf.local.home>
 <CAH2Cfb9YTAf4j7tv4Q5dWM_jQCzsWBo6ufoT=BXYx5qpgcMCNQ@mail.gmail.com>
 <20190213093154.7af84743@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190213093154.7af84743@gandalf.local.home>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2019-02-13 09:31:54, Steven Rostedt wrote:
> On Wed, 13 Feb 2019 22:00:04 +0800
> xiang xiao <xiaoxiang781216@gmail.com> wrote:
> > Here is a sample output with this patch:
> > [   10.991426] virtio_rpmsg_bus virtio1: rpmsg host is online
> > [   10.991443] remoteproc remoteproc1: registered virtio1 (type 7)
> > [   10.991450] remoteproc remoteproc1: remote processor
> > f9210000.toppwr:sen-rproc is now up
> > [   10.993715] virtio_rpmsg_bus virtio1: creating channel
> > rpmsg-ttySENSOR addr 0x1
> > [   10.994606] virtio_rpmsg_bus virtio1: creating channel rpmsg-ttyGPS addr 0x2
> > [   10.995236] virtio_rpmsg_bus virtio1: creating channel rpmsg-clk addr 0x3
> > [   10.995702] virtio_rpmsg_bus virtio1: creating channel rpmsg-syslog addr 0x4
> > [   10.996197] virtio_rpmsg_bus virtio1: creating channel rpmsg-rtc addr 0x5
> > [   10.997297] virtio_rpmsg_bus virtio1: creating channel rpmsg-hostfs addr 0x6
> > [   10.999842] virtio_rpmsg_bus virtio1: creating channel rpmsg-usrsock addr 0x7
> > [     0.007680] sensor: NuttX sensor 7.28 e3c2ecb Feb 12 2019 16:53:49
> > arm song/banks
> > ^^^^^^^^^^^^^
> > [   11.918177] random: crng init done
> > [   12.567362] e2fsck: e2fsck 1.42.9 (28-Dec-2013)
> > 
> > Without this patch:
> > [   10.991426] virtio_rpmsg_bus virtio1: rpmsg host is online
> > [   10.991443] remoteproc remoteproc1: registered virtio1 (type 7)
> > [   10.991450] remoteproc remoteproc1: remote processor
> > f9210000.toppwr:sen-rproc is now up
> > [   10.993715] virtio_rpmsg_bus virtio1: creating channel
> > rpmsg-ttySENSOR addr 0x1
> > [   10.994606] virtio_rpmsg_bus virtio1: creating channel rpmsg-ttyGPS addr 0x2
> > [   10.995236] virtio_rpmsg_bus virtio1: creating channel rpmsg-clk addr 0x3
> > [   10.995702] virtio_rpmsg_bus virtio1: creating channel rpmsg-syslog addr 0x4
> > [   10.996197] virtio_rpmsg_bus virtio1: creating channel rpmsg-rtc addr 0x5
> > [   10.997297] virtio_rpmsg_bus virtio1: creating channel rpmsg-hostfs addr 0x6
> > [   10.999842] virtio_rpmsg_bus virtio1: creating channel rpmsg-usrsock addr 0x7
> > [   11.105345][     0.007680] sensor: NuttX sensor 7.28 e3c2ecb Feb 12
> > 2019 16:53:49 arm song/banks
> > ^^^^^^^^^^^^^^^^^^^^^^^^^^
> > [   11.918177] random: crng init done
> > [   12.567362] e2fsck: e2fsck 1.42.9 (28-Dec-2013)
> > 
> > Which one do you think better?
> 
> Honestly, the one without the patch.
> 
> Seriously, it also makes it easy to see where that message happened
> with respect to the other printks. With your patch, we would have no
> idea, and if I was a normal user, unaware of this patch, I would
> probably submit a bug report claiming that something is wrong with the
> timestamps.

Just for record. I agree with Steven and Sergey here. The two clocks
are too out of sync. "Randomly" and quietly replacing one with
the other would cause more harm than good from my point of view.

Best Regards,
Petr
