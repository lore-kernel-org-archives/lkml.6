Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5C3FC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 07:14:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AFDE2184A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 07:14:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="QCnn15a4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728155AbfBLHOo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 02:14:44 -0500
Received: from conuserg-09.nifty.com ([210.131.2.76]:37578 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727166AbfBLHOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 02:14:37 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id x1C7DPdO019269;
        Tue, 12 Feb 2019 16:13:25 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com x1C7DPdO019269
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1549955606;
        bh=mQUdV4NTuI7qkTpa+3djKWY84fCz8ncLRAS3QcqZLO0=;
        h=From:To:Cc:Subject:Date:From;
        b=QCnn15a4Pj1kBdK3Sd2K9Oo0MuKJqoJd2E5DxaGvgjeOBck8D04hyyesryiRjCA6m
         A5kY2WQD5nmtxvE0uOfHeHVwhY2nIQJXUHAnfb74rA6sQakyADWaGEe6tyRw9poLGZ
         SXm1TiccWXwb+8oNGBoe9qK8JQWiEQU6lEJvgJfmauiyQyqoJpDGJlygeCK5zsIyZm
         sZi/0M7XPw7Drucff+qwMKVpgqhw61PbYhOdNsFOvYkhKXTCo8Q03sAVp4raiWCKjD
         5O9m8DCFAHUHEHJVKlbU+57fpYovaCvNt0CVIxp2RvVuebp7K3nN0PCsvVqMU75noK
         2463sTlktRD5w==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-mtd@lists.infradead.org,
        Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Boris Brezillon <bbrezillon@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        devicetree@vger.kernel.org,
        Brian Norris <computersforpeace@gmail.com>,
        linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 00/10] mtd: rawnand: denali: exec_op(), controller/chip separation, and cleanups
Date:   Tue, 12 Feb 2019 16:12:52 +0900
Message-Id: <1549955582-30346-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I took time for the Denali driver to catch up with the latest framework.

 - switch over to exec_op() and remove legacy hooks

 - separate controller/chips

 - various cleanups


Masahiro Yamada (10):
  mtd: rawnand: denali: use nand_chip pointer more for internal
    functions
  mtd: rawnand: denali: refactor syndrome layout handling for raw access
  mtd: rawnand: denali: remove unneeded casts in denali_{read,write}_pio
  mtd: rawnand: denali: switch over to ->exec_op() from legacy hooks
  mtd: rawnand: denali: use more precise timeout for
    NAND_OP_WAITRDT_INSTR
  mtd: rawnand: denali: use bool type instead of int where appropriate
  mtd: rawnand: denali_pci: rename goto labels
  mtd: rawnand: denali: decouple controller and NAND chips
  mtd: rawnand: denali: remove DENALI_NR_BANKS macro
  mtd: rawnand: denali: clean up coding style

 .../devicetree/bindings/mtd/denali-nand.txt        |   39 +-
 drivers/mtd/nand/raw/denali.c                      | 1144 +++++++++++---------
 drivers/mtd/nand/raw/denali.h                      |  119 +-
 drivers/mtd/nand/raw/denali_dt.c                   |   98 +-
 drivers/mtd/nand/raw/denali_pci.c                  |   38 +-
 5 files changed, 850 insertions(+), 588 deletions(-)

-- 
2.7.4

