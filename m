Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 24213C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 05:13:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD2E0208CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 05:13:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="Lb2vcKHm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD2E0208CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752827AbeFNFNP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 01:13:15 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:64793 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752743AbeFNFNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 01:13:11 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id w5E5BB4b003441;
        Thu, 14 Jun 2018 14:11:12 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com w5E5BB4b003441
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1528953073;
        bh=s9Ua+GfXwmnnKrOVECM3ySMSKbwMfG8JOtdWT2qz94g=;
        h=From:To:Cc:Subject:Date:From;
        b=Lb2vcKHmd8Pk3LJkW4YLypHdJQEYlcBPLtTFYIuCOpkd448OD2uUtBPoHRC9kTypB
         I9OvMwO9EWowRRQ27ctamf9MZpdpyH+H0XFcXMv1LsXFLfQZ5HzA6lkh794R/hXlKe
         +qs8qXpBavBE2qRkAvchWUK6VbdejYumZiI6YmpQOIAS/qlQADyxxDyR/82sMOlxgE
         R0bRSVJOSLm+wXdaCqvA4quqWmysQ21yE6jGvf3UYSe8G1QH+fYpUolmg4WqlrwCsk
         /GE6uMBpG3KJL+5TLxYrOUGQtpljZW8bgnISnMfaJe/wycZpu7uM907YpfOffTJ0qu
         zh0iovIuZPu4w==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-mtd@lists.infradead.org,
        Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Richard Weinberger <richard@sigma-star.at>,
        Philipp Rosenberger <p.rosenberger@linutronix.de>,
        Rob Herring <robh@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        devicetree@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 0/3] mtd: rawnand: denali: add new clocks and improve setup_data_interface
Date:   Thu, 14 Jun 2018 14:11:04 +0900
Message-Id: <1528953067-24324-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


The ->setup_data_interface() hook needs to know the clock frequency.
In fact, this IP needs three clocks, bus "which clock?" is really
confusing.  (It is not described in the DT-binding at all.)

This series adds more clocks.  In the new binding, three clocks
are required: core clock, bus interface clock, ECC engine clock.

This series also takes care of the backward compatibility by
providing hardcoded values in case the new clocks are missing.
So, existing DT should work.


Changes in v2:
  - Split patches into sensible chunks

Masahiro Yamada (3):
  mtd: rawnand: denali_dt: use dev as a shorthand of &pdev->dev
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

