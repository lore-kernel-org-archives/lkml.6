Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06271C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 04:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29FE820864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 04:53:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="W4Ee4sXU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29FE820864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754637AbeFRExM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 00:53:12 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:43533 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754264AbeFRExJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 00:53:09 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 0392284482;
        Mon, 18 Jun 2018 16:53:05 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail; t=1529297585;
        bh=3eYD2wmwBCAIbnK67fTH6Tf0uFLuelNiNR/YxcbSwlY=;
        h=From:To:Cc:Subject:Date;
        b=W4Ee4sXU1u6zYiZiAWxYqQPnSylyDsgR9QGycRWkm5/MaveJjFmT+lMUbPodi+b6v
         XOE2FW4F3uFq8P91D00Tl5SeQuDq6smhBWHLg07YAMxc0seqtt9/qRIQMn7jxt2hBu
         /hGHELAMzJqip+e1tqDLJHxuyIYRDyq9ci+v/cSM=
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5b273ab00000>; Mon, 18 Jun 2018 16:53:04 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by smtp (Postfix) with ESMTP id D7C6A13EED3;
        Mon, 18 Jun 2018 16:53:07 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id BE0C71E2626; Mon, 18 Jun 2018 16:53:04 +1200 (NZST)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     miquel.raynal@bootlin.com, boris.brezillon@bootlin.com,
        dwmw2@infradead.org, computersforpeace@gmail.com,
        linux-mtd@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [RFC PATCH 0/2] mtd: rawnand: support MT29F1G08ABAFAWP-ITE:F
Date:   Mon, 18 Jun 2018 16:52:53 +1200
Message-Id: <20180618045255.8015-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm looking at adding support for the Micron MT29F1G08ABAFAWP-ITE:F chip
to one of our boards which uses the Marvell NFCv2 controller.

This particular chip is a bit odd in that the datasheet states support
for ONFI 1.0 but the revision number field is 00 00. It also is marked
ABAFA but reports internally as ABAGA. Finally it has internal 8-bit ECC
which cannot be disabled.

I think that last point may cause some hassle since the internal ECC
implementation is probably not compatible with the Marvell NFCv2
implementation.

This series is very much RFC because even with these changes so far I
don't have a working system.

Here's a dump of the parameter page if anyone is interested

00000000: 4f 4e 46 49 00 00 18 00 3f 00 00 00 00 00 00 00 ONFI....?.......
00000010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
00000020: 4d 49 43 52 4f 4e 20 20 20 20 20 20 4d 54 32 39  MICRON MT29
00000030: 46 31 47 30 38 41 42 41 47 41 57 50 20 20 20 20  F1G08ABAGAWP    
00000040: 2c 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ,...............
00000050: 00 08 00 00 80 00 00 02 00 00 20 00 40 00 00 00  ..........  .@...
00000060: 00 04 00 00 01 22 01 14 00 01 05 08 00 00 04 00 ....."..........
00000070: 08 01 0e 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
00000080: 08 3f 00 3f 00 58 02 10 27 46 00 64 00 00 00 00 .?.?.X..'F.d....
00000090: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
000000a0: 00 00 00 00 01 00 00 00 00 02 04 80 01 81 04 03 ................
000000b0: 02 01 1e 90 00 00 00 00 00 00 00 00 00 00 00 00 ................
000000c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
000000d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
000000e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
000000f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 85 a6 ................

Chris Packham (2):
  mtd: rawnand: handle ONFI revision number field being 0
  mtd: rawnand: marvell: Support page size of 2048 with 8-bit ECC

 drivers/mtd/nand/raw/marvell_nand.c | 1 +
 drivers/mtd/nand/raw/nand_base.c    | 2 ++
 2 files changed, 3 insertions(+)

-- 
2.17.1

