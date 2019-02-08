Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E29CCC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 08:10:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A571D2147C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 08:10:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="iPU9GpNi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727425AbfBHIKo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 03:10:44 -0500
Received: from conuserg-07.nifty.com ([210.131.2.74]:61710 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727166AbfBHIKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 03:10:15 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id x1889029007241;
        Fri, 8 Feb 2019 17:09:01 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com x1889029007241
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1549613342;
        bh=qutwgLXWKEAKTr8AyxnKgPdwIiD2M8DDqupZD0bbfSk=;
        h=From:To:Cc:Subject:Date:From;
        b=iPU9GpNiAjajTnPHvP0jSQ4rGBBxRakTeOL+5UqKWcio3WzlP/7aWb/wHpbUDyufV
         SAGS05rPuu+mU+TJ8SJ8LQhc8OAt4ht0zRUdHZv4tTK/r4XmJunQjv+Itacnw/G+Ws
         f9QnsN+Q65jFjk33o6Ls6DPxo+d1e7HvnJ+clwce/fe0ys57iYLwMergMZl+cuk4e6
         FkkE8F/euQq/KDLHwuOmIb/jGVJ0N6LkvITLO/kxX3M9wbQOT9trLbDDjrTmYC5xki
         KVJ3hjlzZE7RSjN17KhqmTWtZWH/DtBzEo6RXlP43E+FBmqvtzLNErP8RhhnGuhrjn
         DK+gKEAhb5jZw==
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
Subject: [PATCH 00/11] mtd: rawnand: denali: exec_op(), controller/chip separation, and cleanups
Date:   Fri,  8 Feb 2019 17:08:44 +0900
Message-Id: <1549613335-30319-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I took time for the Denali driver to catch up with the latest framework.

 - switch over to exec_op() and remove legacy hooks

 - separate controller/chips

 - various cleanups



Masahiro Yamada (11):
  mtd: rawnand: denali: use nand_chip pointer more for internal
    functions
  mtd: rawnand: denali: refactor syndrome layout handling for raw access
  mtd: rawnand: denali: remove unneeded casts in denali_{read,write}_pio
  mtd: rawnand: denali: switch over to ->exec_op() from legacy hooks
  mtd: rawnand: denali: rename irq_status to irq_stat
  mtd: rawnand: denali: use more precise timeout for
    NAND_OP_WAITRDT_INSTR
  mtd: rawnand: denali: use bool type instead of int where appropriate
  mtd: rawnand: denali_pci: rename goto labels
  mtd: rawnand: denali: decouple controller and NAND chips
  mtd: rawnand: denali: remove DENALI_NR_BANKS macro
  mtd: rawnand: denali: clean up coding style

 .../devicetree/bindings/mtd/denali-nand.txt        |   39 +-
 drivers/mtd/nand/raw/denali.c                      | 1182 ++++++++++----------
 drivers/mtd/nand/raw/denali.h                      |  119 +-
 drivers/mtd/nand/raw/denali_dt.c                   |   98 +-
 drivers/mtd/nand/raw/denali_pci.c                  |   38 +-
 5 files changed, 867 insertions(+), 609 deletions(-)

-- 
2.7.4

