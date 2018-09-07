Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDBEAC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 14:53:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80D802075E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 14:53:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80D802075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729993AbeIGTfH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 15:35:07 -0400
Received: from mail.bootlin.com ([62.4.15.54]:44987 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725944AbeIGTfH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 15:35:07 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 9C39720787; Fri,  7 Sep 2018 16:53:49 +0200 (CEST)
Received: from bbrezillon (AAubervilliers-681-1-30-219.w90-88.abo.wanadoo.fr [90.88.15.219])
        by mail.bootlin.com (Postfix) with ESMTPSA id 3F9A720701;
        Fri,  7 Sep 2018 16:53:49 +0200 (CEST)
Date:   Fri, 7 Sep 2018 16:53:48 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        DTML <devicetree@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH] mtd: rawnand: denali: add DT property to specify
 skipped bytes in OOB
Message-ID: <20180907165348.3e0027ee@bbrezillon>
In-Reply-To: <CAK7LNAQJOD3mxwbiOSn5wpDsU23DhZcx9QB_ufFZB8LUnh1KdQ@mail.gmail.com>
References: <1536317783-4942-1-git-send-email-yamada.masahiro@socionext.com>
        <20180907160822.319047c8@bbrezillon>
        <CAK7LNAQJOD3mxwbiOSn5wpDsU23DhZcx9QB_ufFZB8LUnh1KdQ@mail.gmail.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Sep 2018 23:42:53 +0900
Masahiro Yamada <yamada.masahiro@socionext.com> wrote:

> Hi Boris,
> 
> 2018-09-07 23:08 GMT+09:00 Boris Brezillon <boris.brezillon@bootlin.com>:
> > Hi Masahiro,
> >
> > On Fri,  7 Sep 2018 19:56:23 +0900
> > Masahiro Yamada <yamada.masahiro@socionext.com> wrote:
> >  
> >> NAND devices need additional data area (OOB) for error correction,
> >> but it is also used for Bad Block Marker (BBM).  In many cases, the
> >> first byte in OOB is used for BBM, but the location actually depends
> >> on chip vendors.  The NAND controller should preserve the precious
> >> BBM to keep track of bad blocks.
> >>
> >> In Denali IP, the SPARE_AREA_SKIP_BYTES register is used to specify
> >> the number of bytes to skip from the start of OOB.  The ECC engine
> >> will automatically skip the specified number of bytes when it gets
> >> access to OOB area.
> >>
> >> The same value for SPARE_AREA_SKIP_BYTES should be used between
> >> firmware and the operating system if you intend to use the NAND
> >> device across the control hand-off.
> >>
> >> In fact, the current denali.c code expects firmware to have already
> >> set the SPARE_AREA_SKIP_BYTES register, then reads the value out.
> >>
> >> If no firmware (or bootloader) has initialized the controller, the
> >> register value is zero, which is the default after power-on-reset.
> >>
> >> In other words, the Linux driver cannot initialize the controller
> >> by itself.  You cannot support the reset control either because
> >> resetting the controller will get register values lost.
> >>
> >> This commit adds a way to specify it via DT.  If the property
> >> "denali,oob-skip-bytes" exists, the value will be set to the register.  
> >
> > Hm, do we really need to make this config customizable? I mean, either
> > you have a large-page NAND (page > 512 bytes) and the 2 first bytes
> > must be reserved for the BBM or you have a small-page NAND and the BBM
> > is at position 4 and 5. Are you sure people configure that differently?
> > Don't you always have SPARE_AREA_SKIP_BYTES set to 6 or 2?  
> 
> 
> As I said in the patch description,
> I need to use the same SPARE_AREA_SKIP_BYTES value
> across firmware, boot-loader, Linux, and whatever.
> 
> I want to set the value to 8 for my platform
> because the on-chip boot ROM expects 8.
> I cannot change it since the boot ROM is hard-wired.
> 
> 
> The boot ROM skips 8 bytes in OOB
> when it loads images from the on-board NAND device.
> 
> So, when I update the image from U-Boot or Linux,
> I need to make sure to set the register to 8.
> 
> If I update the image with a different value,
> the Boot ROM fails to boot.
> 
> 
> 
> When the system has booted from NAND,
> the register is already set to 8.  It works.
> 
> However, when the system has booted from eMMC,
> the register is not initialized by anyone.
> I am searching for a way to set the register to 8
> in this case.
> 
> 
> The boot ROM in SOCFPGA might expect a different value,
> I am not sure.

Okay, then why not having a per-compatible value if it's related to the
BootROM? Unless the BootROM is part of the FPGA and can be
reprogrammed. I'd really prefer not having a generic property that
allows you to put anything you want.
