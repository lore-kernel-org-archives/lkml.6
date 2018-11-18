Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5DDEC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 18:53:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B49320815
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 18:53:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B49320815
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725954AbeKSFOD convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 00:14:03 -0500
Received: from mail.bootlin.com ([62.4.15.54]:57400 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725755AbeKSFOD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 00:14:03 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id B4CE1207B0; Sun, 18 Nov 2018 19:52:59 +0100 (CET)
Received: from xps13 (unknown [91.224.148.103])
        by mail.bootlin.com (Postfix) with ESMTPSA id 228752074F;
        Sun, 18 Nov 2018 19:52:59 +0100 (CET)
Date:   Sun, 18 Nov 2018 19:52:58 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Naga Sureshkumar Relli <nagasure@xilinx.com>
Cc:     "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "richard@nod.at" <richard@nod.at>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "nagasuresh12@gmail.com" <nagasuresh12@gmail.com>,
        Michal Simek <michals@xilinx.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh@kernel.org" <robh@kernel.org>
Subject: Re: [LINUX PATCH v12 3/3] mtd: rawnand: arasan: Add support for
 Arasan NAND Flash Controller
Message-ID: <20181118195258.4966e2c4@xps13>
In-Reply-To: <MWHPR02MB26234433484426F333E9B60EAFDC0@MWHPR02MB2623.namprd02.prod.outlook.com>
References: <1541739641-17789-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
        <1541739641-17789-4-git-send-email-naga.sureshkumar.relli@xilinx.com>
        <MWHPR02MB26234433484426F333E9B60EAFDC0@MWHPR02MB2623.namprd02.prod.outlook.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Naga,

Naga Sureshkumar Relli <nagasure@xilinx.com> wrote on Thu, 15 Nov 2018
09:34:16 +0000:

> Hi Boris & Miquel,
> 
> I am updating the driver by addressing your comments, and I have one concern,  especially in anfc_read_page_hwecc(), 
> there I am checking for erased pages bit flips.
> Since Arasan NAND controller doesn't have multibit error detection beyond 24-bit( it can correct up to 24 bit),
> i.e. there is no indication from controller to detect uncorrectable error beyond 24bit.
> So I took some error count as default value(MULTI_BIT_ERR_CNT  16, I put this based on the error count that 
> I got while reading erased page on Micron device).
> And during a page read, will just read the error count register and compare this value with the default error count(16) and if it is more 
> Than default then I am checking for erased page bit flips.
> I am doubting that this will not work in all cases.
> In my case it is just working because the error count that it got on an erased page is 16.
> Could you please suggest a way to do detect erased_page bit flips when reading a page with HW-ECC?.

So the ECC engine is broken by design.

I think you should determine a number of bitflips (16 looks nice to me)
over which you declare the page bad anyway.

Now, this is generic logic: anytime a page is declared bad, you should
re-read the page in raw mode and check for the number of bitflips
manually (thanks to the helpers in the core). Again, if the number of BF
is above 16, we can assume the page is bad and increment ->ecc.failed
accordingly.


Thanks,
Miquèl
