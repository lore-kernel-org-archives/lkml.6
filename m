Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,URIBL_RHS_DOB
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ADE4C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 20:14:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB7422064D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 20:14:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB7422064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725976AbeLFUOI convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 15:14:08 -0500
Received: from mail.bootlin.com ([62.4.15.54]:57042 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725927AbeLFUOI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 15:14:08 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 9CF7920731; Thu,  6 Dec 2018 21:14:05 +0100 (CET)
Received: from xps13 (unknown [91.224.148.103])
        by mail.bootlin.com (Postfix) with ESMTPSA id E7C7020510;
        Thu,  6 Dec 2018 21:14:04 +0100 (CET)
Date:   Thu, 6 Dec 2018 21:14:04 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     boris.brezillon@bootlin.com, jmkrzyszt@gmail.com,
        Stefan Agner <stefan@agner.ch>, richard@nod.at,
        dwmw2@infradead.org, computersforpeace@gmail.com,
        marek.vasut@gmail.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [BUG BISECT] Missing MTD NAND partitions - mtd: rawnand: Move
 the ->exec_op() method to nand_controller_ops
Message-ID: <20181206211404.39cfe07c@xps13>
In-Reply-To: <CAJKOXPepDpdhz2yPmdBMcncJ8noRdNTyXqP6WbUZR4Cf=BnEFA@mail.gmail.com>
References: <CAJKOXPdPnha1-1dCRFaPZ-CGzS1OzNcFrxuOJmWstHJcRAMZwg@mail.gmail.com>
        <20181120113326.0d4f061e@xps13>
        <CAJKOXPcrVXdCXqmxffJca7HfEV3G3agkzjWu1rfsNDDbMzc_XQ@mail.gmail.com>
        <20181120130859.78d53da3@bbrezillon>
        <CAJKOXPfgyw9tFTC=eZFVHz8us1+6RxEcnmLUi-umO2+N9vRzDg@mail.gmail.com>
        <CAJKOXPepDpdhz2yPmdBMcncJ8noRdNTyXqP6WbUZR4Cf=BnEFA@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

Krzysztof Kozlowski <krzk@kernel.org> wrote on Wed, 5 Dec 2018 17:10:38
+0100:

> On Tue, 20 Nov 2018 at 13:15, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >
> > On Tue, 20 Nov 2018 at 13:09, Boris Brezillon
> > <boris.brezillon@bootlin.com> wrote:  
> > >
> > > On Tue, 20 Nov 2018 12:48:46 +0100
> > > Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > >  
> > > > On Tue, 20 Nov 2018 at 11:33, Miquel Raynal <miquel.raynal@bootlin.com> wrote:  
> > > > >
> > > > > Hi Krzysztof,
> > > > >
> > > > > Krzysztof Kozłowski <k.kozlowski.k@gmail.com> wrote on Tue, 20 Nov 2018
> > > > > 10:46:33 +0100:
> > > > >  
> > > > > > Hi all,
> > > > > >
> > > > > > Since few days linux-next has problem on Freescale VF500 - MTD seems
> > > > > > to be broken.
> > > > > >
> > > > > > Bisect pointed me to commit 7c27338c728e39ef47c83d101959aa332506969d
> > > > > > ("mtd: rawnand: Move the ->exec_op() method to nand_controller_ops")
> > > > > > as reason of failure to find MTD partitions.
> > > > > >
> > > > > > Toradex Colibri VF50 on Iris board (ARMv7, UP, Cortext-A5, NXP VF500,
> > > > > > 128 MB RAM, 128 MB NAND, Systemd: v232) booted from NFS root (NFSv4)
> > > > > > trying to mount UBIFS from NAND/MTD. Board uses VF610 NAND driver.
> > > > > >
> > > > > > The MTD partitions are missing entirely (nothing under /dev/mtd).
> > > > > > In the logs you can also see:
> > > > > > [    1.232161] UBI error: cannot open mtd ubi2, error -2
> > > > > >
> > > > > > Attached - dmesg.log
> > > > > >
> > > > > > Let me know if you need defconfig or any other information.  
> > > > >
> > > > > Thank you very much for testing and reporting the bug!
> > > > >
> > > > > Could you please test with this diff applied [1] please? We discussed
> > > > > with Boris and we think it should fix your setup (and all others also
> > > > > impacted).
> > > > >
> > > > > [1] http://code.bulix.org/r1m99i-509201  
> > > >
> > > > error: patch failed: drivers/mtd/nand/raw/nand_base.c:4399
> > > > error: drivers/mtd/nand/raw/nand_base.c: patch does not apply
> > > >
> > > > Maybe you have a git tree with this somewhere?  
> > >
> > > Yep: https://github.com/bbrezillon/linux/tree/nand/next-fix  
> >
> > Works fine now, thanks!
> > Tested-by: Krzysztof Kozlowski <krzk@kernel.org>  
> 
> Although the patch fixed the issue... but it seems it is not in
> linux-next. The next is broken since almost two weeks.
> 
> Best regards,
> Krzysztof

Sorry for the huge delay, fixup applied.


Thanks,
Miquèl
	
