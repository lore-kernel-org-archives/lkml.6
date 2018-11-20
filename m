Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC53FC41537
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 12:09:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DA172075B
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 12:09:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DA172075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728929AbeKTWiB convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 17:38:01 -0500
Received: from mail.bootlin.com ([62.4.15.54]:54215 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727950AbeKTWiA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 17:38:00 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 0161420D92; Tue, 20 Nov 2018 13:09:09 +0100 (CET)
Received: from bbrezillon (aaubervilliers-681-1-13-146.w90-88.abo.wanadoo.fr [90.88.134.146])
        by mail.bootlin.com (Postfix) with ESMTPSA id AD27C20D2E;
        Tue, 20 Nov 2018 13:08:59 +0100 (CET)
Date:   Tue, 20 Nov 2018 13:08:59 +0100
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     miquel.raynal@bootlin.com, jmkrzyszt@gmail.com,
        Stefan Agner <stefan@agner.ch>, richard@nod.at,
        dwmw2@infradead.org, computersforpeace@gmail.com,
        marek.vasut@gmail.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [BUG BISECT] Missing MTD NAND partitions - mtd: rawnand: Move
 the ->exec_op() method to nand_controller_ops
Message-ID: <20181120130859.78d53da3@bbrezillon>
In-Reply-To: <CAJKOXPcrVXdCXqmxffJca7HfEV3G3agkzjWu1rfsNDDbMzc_XQ@mail.gmail.com>
References: <CAJKOXPdPnha1-1dCRFaPZ-CGzS1OzNcFrxuOJmWstHJcRAMZwg@mail.gmail.com>
        <20181120113326.0d4f061e@xps13>
        <CAJKOXPcrVXdCXqmxffJca7HfEV3G3agkzjWu1rfsNDDbMzc_XQ@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Nov 2018 12:48:46 +0100
Krzysztof Kozlowski <krzk@kernel.org> wrote:

> On Tue, 20 Nov 2018 at 11:33, Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> >
> > Hi Krzysztof,
> >
> > Krzysztof Kozłowski <k.kozlowski.k@gmail.com> wrote on Tue, 20 Nov 2018
> > 10:46:33 +0100:
> >  
> > > Hi all,
> > >
> > > Since few days linux-next has problem on Freescale VF500 - MTD seems
> > > to be broken.
> > >
> > > Bisect pointed me to commit 7c27338c728e39ef47c83d101959aa332506969d
> > > ("mtd: rawnand: Move the ->exec_op() method to nand_controller_ops")
> > > as reason of failure to find MTD partitions.
> > >
> > > Toradex Colibri VF50 on Iris board (ARMv7, UP, Cortext-A5, NXP VF500,
> > > 128 MB RAM, 128 MB NAND, Systemd: v232) booted from NFS root (NFSv4)
> > > trying to mount UBIFS from NAND/MTD. Board uses VF610 NAND driver.
> > >
> > > The MTD partitions are missing entirely (nothing under /dev/mtd).
> > > In the logs you can also see:
> > > [    1.232161] UBI error: cannot open mtd ubi2, error -2
> > >
> > > Attached - dmesg.log
> > >
> > > Let me know if you need defconfig or any other information.  
> >
> > Thank you very much for testing and reporting the bug!
> >
> > Could you please test with this diff applied [1] please? We discussed
> > with Boris and we think it should fix your setup (and all others also
> > impacted).
> >
> > [1] http://code.bulix.org/r1m99i-509201  
> 
> error: patch failed: drivers/mtd/nand/raw/nand_base.c:4399
> error: drivers/mtd/nand/raw/nand_base.c: patch does not apply
> 
> Maybe you have a git tree with this somewhere?

Yep: https://github.com/bbrezillon/linux/tree/nand/next-fix
