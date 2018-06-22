Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C26D6C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 16:08:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C4D223FB7
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 16:08:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="JaV2eK5l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C4D223FB7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934251AbeFVQIk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 12:08:40 -0400
Received: from conuserg-12.nifty.com ([210.131.2.79]:30605 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933961AbeFVQIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 12:08:16 -0400
Received: from grover.sesame (FL1-125-199-20-195.osk.mesh.ad.jp [125.199.20.195]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id w5MG6m5a022587;
        Sat, 23 Jun 2018 01:06:48 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com w5MG6m5a022587
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1529683609;
        bh=objRHaprh4CO3zYIJJywNTYdPz+1v+FVMPHdBZh305I=;
        h=From:To:Cc:Subject:Date:From;
        b=JaV2eK5lOU/PzsfdV0dVYlS/OnWo5uMWHZvVuRsoX197r9Xv9+sTnd0/w7Nl2QxJF
         Y2DqpoYtCO3U2uqW/zRyHvXMBz4gyFf63C6JUkq75XzDIJeriMNSc8ACErVi8ZoD/u
         lb1sCrMBiVYfbqUGBemorlJuk1gFr7QXg/fG4ZyH196x8s/7yPu4UMtiy8GGOyQFH8
         xIN7JhR+Pj/34IEzvLtn5XaEEB/1Ei1WiFq/0YCdhnVpgDZhY2/NC4vzscQGUmDWv7
         RO4FjT7PWwqrkuHZKFZCwd/ehe1RQjIUh3FTp079Y3jOpCJpuLCxBtnFoTcJpANNMJ
         ZQAnBzl5uMj9g==
X-Nifty-SrcIP: [125.199.20.195]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-mtd@lists.infradead.org,
        Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marek Vasut <marek.vasut@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v4 0/5] mtd: rawnand: denali: add new clocks and improve setup_data_interface
Date:   Sat, 23 Jun 2018 01:06:33 +0900
Message-Id: <1529683598-25783-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


The ->setup_data_interface() hook needs to know the clock frequency.
In fact, this IP needs three clocks, but the current driver does not
represent it.  Thus, it is hard to understand what is the correct
clock frequency.
(at least, clock property is not described in the DT-binding at all.)

This series adds more clocks based on the IP datasheet, and document
it in the DT binding.
In the new binding, three clocks are required: core clock, bus interface
clock, ECC engine clock.

1/5 is a backport candidate to fix SOCFPGA.


Masahiro Yamada (5):
  mtd: rawnand: denali_dt: set clk_x_rate to 200 MHz unconditionally
  mtd: rawnand: denali_dt: use dev as a shorthand of &pdev->dev
  dt-binding: mtd: denali_dt: document clock property
  mtd: rawnand: denali_dt: add more clocks based on IP datasheet
  mtd: rawnand: denali: optimize timing parameters for data interface

 .../devicetree/bindings/mtd/denali-nand.txt        |  5 ++
 drivers/mtd/nand/raw/denali.c                      | 49 ++++++++--------
 drivers/mtd/nand/raw/denali.h                      |  1 +
 drivers/mtd/nand/raw/denali_dt.c                   | 66 ++++++++++++++++++----
 drivers/mtd/nand/raw/denali_pci.c                  |  1 +
 5 files changed, 86 insertions(+), 36 deletions(-)

-- 
2.7.4

