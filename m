Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D53F4C43144
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 19:22:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A9EF252E1
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 19:22:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="TsQcZKD+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A9EF252E1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751997AbeFXTWo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 15:22:44 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:36110 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751597AbeFXTWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 15:22:35 -0400
Received: from trochilidae.lan (unknown [IPv6:2a02:169:34d6:10::3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 062205C0E91;
        Sun, 24 Jun 2018 21:22:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1529868153;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:content-type:content-transfer-encoding:
         in-reply-to:references; bh=9BZOhWzWEsHaG2U8FFSMPlthqlugEd0Kg4/x5zj8voQ=;
        b=TsQcZKD+i7S4FV5CW1H5eWfUYk74JxSC4zMqpZK3sf9gv6JikKdj6ude8ikWDzKaNmmnxx
        DoF5BAjutzOnQd63jw2IE77OEr9bxcnFnJp5zF5DwzwyX9ETers6VuLqG8aLJbMcHKWzKI
        O83XCa35Q2Wlp+A/d+FpLcpNtZ2a/2o=
From:   Stefan Agner <stefan@agner.ch>
To:     boris.brezillon@bootlin.com, dwmw2@infradead.org,
        computersforpeace@gmail.com, marek.vasut@gmail.com,
        robh+dt@kernel.org, mark.rutland@arm.com, thierry.reding@gmail.com
Cc:     dev@lynxeye.de, miquel.raynal@bootlin.com, richard@nod.at,
        marcel@ziswiler.com, krzk@kernel.org, digetx@gmail.com,
        benjamin.lindqvist@endian.se, jonathanh@nvidia.com,
        pdeschrijver@nvidia.com, pgaikwad@nvidia.com, mirza.krak@gmail.com,
        gaireg@gaireg.de, linux-mtd@lists.infradead.org,
        linux-tegra@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stefan Agner <stefan@agner.ch>
Subject: [PATCH v7 0/6] mtd: rawnand: add NVIDIA Tegra NAND flash support
Date:   Sun, 24 Jun 2018 21:22:24 +0200
Message-Id: <20180624192230.4674-1-stefan@agner.ch>
X-Mailer: git-send-email 2.17.1
X-Spamd-Result: default: False [-2.10 / 15.00];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         RCPT_COUNT_TWELVE(0.00)[24];
         BAYES_HAM(-3.00)[100.00%];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         FROM_HAS_DN(0.00)[];
         FROM_EQ_ENVFROM(0.00)[];
         DKIM_SIGNED(0.00)[];
         TO_DN_SOME(0.00)[];
         RCVD_COUNT_ZERO(0.00)[0];
         MID_CONTAINS_FROM(1.00)[];
         ASN(0.00)[asn:13030, ipnet:2a02:169::/32, country:CH];
         RCVD_TLS_ALL(0.00)[];
         ARC_NA(0.00)[]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Seventh revision fixes some checkpatch shortcomings. The remaning
issues reported are either not applicable or on purpose, fixing
them would hurt readability.

--
Stefan

Changes since v1:
- Split controller and NAND chip structure
- Add BCH support
- Allow to select algorithm and strength using device tree
- Improve HW ECC error reporting and use DEC_STATUS_BUF only
- Use SPDX license identifier
- Use per algorithm mtd_ooblayout_ops
- Use setup_data_interface callback for NAND timing configuration

Changes since v2:
- Set clock rate using assigned-clocks
- Use BIT() macro
- Fix and improve timing calculation
- Improve ECC error handling
- Store OOB layout for tag area in Tegra chip structure
- Update/fix bindings
- Use more specific variable names (replace "value")
- Introduce nand-is-boot-medium
- Choose sensible ECC strenght automatically
- Use wait_for_completion_timeout
- Print register dump on completion timeout
- Unify tegra_nand_(read|write)_page in tegra_nand_page_xfer

Changes since v3:
- Implement tegra_nand_(read|write)_raw using DMA
- Implement tegra_nand_(read|write)_oob using DMA
- Name registers according to Tegra 2 Technical Reference Manual (v02p)
- Use wait_for_completion_io_timeout to account for IO
- Get chip select id from device tree reg property
- Clear interrupts and reinit wait queues in case command/DMA times out
- Set default MTD name after nand_set_flash_node
- Move MODULE_DEVICE_TABLE after declaration of tegra_nand_of_match
- Make (rs|bch)_strength static

Changes since v4:
- Pass OOB area to nand_check_erased_ecc_chunk
- Pass algorithm specific bits_per_step to tegra_nand_get_strength
- Store ECC layout in chip structure
- Fix pointer assignment (use NULL)
- Removed obsolete header delay.h
- Fixed newlines
- Use non-_io variant of wait_for_completion_timeout

Changes since v5:
- Drop extra OOB bytes support

Changes since v6:
- checkpatch.pl fixes

Lucas Stach (1):
  ARM: dts: tegra: add Tegra20 NAND flash controller node

Stefan Agner (5):
  mtd: rawnand: add Reed-Solomon error correction algorithm
  mtd: rawnand: add an option to specify NAND chip as a boot device
  mtd: rawnand: tegra: add devicetree binding
  mtd: rawnand: add NVIDIA Tegra NAND Flash controller driver
  ARM: dts: tegra: enable NAND flash on Colibri T20

 .../devicetree/bindings/mtd/nand.txt          |    6 +-
 .../bindings/mtd/nvidia-tegra20-nand.txt      |   64 +
 MAINTAINERS                                   |    7 +
 arch/arm/boot/dts/tegra20-colibri-512.dtsi    |   16 +
 arch/arm/boot/dts/tegra20.dtsi                |   15 +
 drivers/mtd/nand/raw/Kconfig                  |   10 +
 drivers/mtd/nand/raw/Makefile                 |    1 +
 drivers/mtd/nand/raw/nand_base.c              |    4 +
 drivers/mtd/nand/raw/tegra_nand.c             | 1223 +++++++++++++++++
 include/linux/mtd/rawnand.h                   |    7 +
 10 files changed, 1352 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/mtd/nvidia-tegra20-nand.txt
 create mode 100644 drivers/mtd/nand/raw/tegra_nand.c

-- 
2.17.1

