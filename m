Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 4E9E2C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 01:20:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0018420693
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 01:20:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="b8ZRpkD6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0018420693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965408AbeFOBU5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 21:20:57 -0400
Received: from conuserg-08.nifty.com ([210.131.2.75]:27013 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964924AbeFOBU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 21:20:29 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id w5F1IuMK005465;
        Fri, 15 Jun 2018 10:18:56 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com w5F1IuMK005465
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1529025537;
        bh=+qIGTNlmq5SROdGPyHBw0csBO/ERnyEcIbUbhqg5spU=;
        h=From:To:Cc:Subject:Date:From;
        b=b8ZRpkD6FmcyFg9qlTY4dTCNtckm8Gbab0krd50+RU8CRJFqfug3QTXLve97GjGOH
         pMxA+KkrQTBUZshirMZTdOAzjMLIIz6+vcea/mvn9mb9yP990igBvrgbn5XYRB59gG
         ETRDDNPXXZyCrXHFz98FuSm0sXXQEO05B1DmNxZ2FEmvsi244WczS6BHTPPX7p/xva
         jMQDNkp7RZx7JTkop7MvLmqc9rMi5YuYfqMJrafE/lmRDU6pNWHAScrtxVQLTdRMkA
         oFzrIowWZZR7behGqL+QFRL0d6QjM7bWUGFlWBnzVambH/cXYWI1QwdrWWtVu0blin
         zcx4lwCZEh40Q==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-mtd@lists.infradead.org,
        Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-kbuild@vger.kernel.org,
        Richard Weinberger <richard@nod.at>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        devicetree@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v3 0/3] mtd: rawnand: denali: add new clocks and improve setup_data_interface
Date:   Fri, 15 Jun 2018 10:18:49 +0900
Message-Id: <1529025532-22087-1-git-send-email-yamada.masahiro@socionext.com>
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


Changes in v3:
  - Change the patch order so that the bug-fix one comes the first

Changes in v2:
  - Split patches into sensible chunks
  - Split patches into sensible chunks

Masahiro Yamada (3):
  mtd: rawnand: denali_dt: add more clocks based on IP datasheet
  mtd: rawnand: denali_dt: use dev as a shorthand of &pdev->dev
  mtd: rawnand: denali: optimize timing parameters for data interface

 .../devicetree/bindings/mtd/denali-nand.txt        |  5 ++
 drivers/mtd/nand/raw/denali.c                      | 49 ++++++++--------
 drivers/mtd/nand/raw/denali.h                      |  1 +
 drivers/mtd/nand/raw/denali_dt.c                   | 66 ++++++++++++++++++----
 drivers/mtd/nand/raw/denali_pci.c                  |  1 +
 5 files changed, 86 insertions(+), 36 deletions(-)

-- 
2.7.4

