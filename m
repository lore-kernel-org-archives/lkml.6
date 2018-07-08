Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E70BEC3279B
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 11:30:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B414208A4
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 11:30:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mail.ru header.i=@mail.ru header.b="Ew5ZvrIn";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mail.ru header.i=@mail.ru header.b="Ew5ZvrIn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B414208A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=mail.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933016AbeGHLaY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 07:30:24 -0400
Received: from fallback12.mail.ru ([94.100.179.29]:38710 "EHLO
        fallback12.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932821AbeGHLaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 07:30:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru; s=mail2;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From; bh=7yAxILOlWndhqq1GrnVrauehthQSXwQtiEfFp3579RM=;
        b=Ew5ZvrInVjp06889L0nAYJlOAbScpimvxmCLQPhIBumtCxDXfpqj41rrC62dKh66npwbTyAoes2MRbd/COisbylZrS5+kEVOGvhnlFS6AwJxwcqaVJJZAc3hLQ7JjsdBDBR4W3sqVwKH+r472R3I4CKbdOrqmrnyGb5a/yQvdiw=;
Received: from [10.161.64.55] (port=40212 helo=smtp47.i.mail.ru)
        by fallback12.m.smailru.net with esmtp (envelope-from <cerg2010cerg2010@mail.ru>)
        id 1fc7tU-0007Dy-2m
        for linux-kernel@vger.kernel.org; Sun, 08 Jul 2018 14:30:20 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru; s=mail2;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From; bh=7yAxILOlWndhqq1GrnVrauehthQSXwQtiEfFp3579RM=;
        b=Ew5ZvrInVjp06889L0nAYJlOAbScpimvxmCLQPhIBumtCxDXfpqj41rrC62dKh66npwbTyAoes2MRbd/COisbylZrS5+kEVOGvhnlFS6AwJxwcqaVJJZAc3hLQ7JjsdBDBR4W3sqVwKH+r472R3I4CKbdOrqmrnyGb5a/yQvdiw=;
Received: by smtp47.i.mail.ru with esmtpa (envelope-from <cerg2010cerg2010@mail.ru>)
        id 1fc7tC-0006m8-Jn; Sun, 08 Jul 2018 14:30:02 +0300
From:   Sergey Larin <cerg2010cerg2010@mail.ru>
Cc:     boris.brezillon@bootlin.com, miquel.raynal@bootlin.com,
        richard@nod.at, dwmw2@infradead.org, computersforpeace@gmail.com,
        marek.vasut@gmail.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Sergey Larin <cerg2010cerg2010@mail.ru>
Subject: [PATCH 1/2] mtd: rawnand: docg4: fix NULL deref while probing
Date:   Sun,  8 Jul 2018 14:29:23 +0300
Message-Id: <30a41254ed09624a8972aa1daf14e4dd1efabed3.1531045014.git.cerg2010cerg2010@mail.ru>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1531045014.git.cerg2010cerg2010@mail.ru>
References: <cover.1531045014.git.cerg2010cerg2010@mail.ru>
X-7FA49CB5: 0D63561A33F958A5A21251E13F5BBE3F58CA4CFEA04898E7A5F2EEDDFE6365710A6AB1C7CE11FEE36925688D23FC3BD3BA3038C0950A5D36B5C8C57E37DE458B4C7702A67D5C33162DBA43225CD8A89FBFBFE0634520CEB901DCB9AC3877F4D084D29429A863A3F843847C11F186F3C5E7DDDDC251EA7DABCC89B49CDF41148F3F936871CC6C13B42623479134186CDE6BA297DBC24807EABDAD6C7F3747799A
X-Mailru-Sender: 77CB7D53813D46933669B4271CC84AE02A6C9228EA2B8BCA2652D3474070699FB7CBEF92542CD7C8D694F0A6A4F3F64130860A92898D06F0CCD8808EE49729257A5E07228308AC44B7D4B47F40347D15B4A721A3011E896F
X-Mras: OK
X-7FA49CB5: 0D63561A33F958A5B9C368DD27E5E54B83B4E2C6544388E7A557DE3E8AAE432D462275124DF8B9C938130EB80001CEACE5BFE6E7EFDEDCD789D4C264860C145E
X-Mailru-Sender: A5480F10D64C9005EB82917A46D952768C621377C84C4ABB6A41B1E48078782587D154BA7A9C8918CAD91EC71FC00F3837D2A27E1A8065646C7A2150F6097340301919DCEDD5454186FA049C4F996C4B5FEEDEB644C299C0ED14614B50AE0675
X-Mras: OK
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

nand_scan_tail() invokes nand_chip->scan_bbt() at the end, which is not set
by the driver. Use the default nand_default_bbt() function to avoid NULL
dereferncing.

Signed-off-by: Sergey Larin <cerg2010cerg2010@mail.ru>
---
 drivers/mtd/nand/raw/docg4.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/nand/raw/docg4.c b/drivers/mtd/nand/raw/docg4.c
index bb96cb33cd6b..bbed8ea7858c 100644
--- a/drivers/mtd/nand/raw/docg4.c
+++ b/drivers/mtd/nand/raw/docg4.c
@@ -1269,6 +1269,7 @@ static void __init init_mtd_structs(struct mtd_info *mtd)
 	nand->read_buf = docg4_read_buf;
 	nand->write_buf = docg4_write_buf16;
 	nand->erase = docg4_erase_block;
+	nand->scan_bbt = nand_default_bbt;
 	nand->set_features = nand_get_set_features_notsupp;
 	nand->get_features = nand_get_set_features_notsupp;
 	nand->ecc.read_page = docg4_read_page;
-- 
2.18.0

