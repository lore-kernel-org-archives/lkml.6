Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D23FC43142
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 15:37:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB41F24C47
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 15:37:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="z3lR/Yq6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB41F24C47
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751833AbeFWPhc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 11:37:32 -0400
Received: from conuserg-12.nifty.com ([210.131.2.79]:43867 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751492AbeFWPhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 11:37:31 -0400
Received: from grover.sesame (FL1-125-199-20-195.osk.mesh.ad.jp [125.199.20.195]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id w5NFZpFj013984;
        Sun, 24 Jun 2018 00:35:51 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com w5NFZpFj013984
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1529768152;
        bh=bp3zuQy2EhWTNPjBPy8HbIHgF0Lg2H/adam7m6NX0L0=;
        h=From:To:Cc:Subject:Date:From;
        b=z3lR/Yq6aTKizUlAMFXYYrHxoZoDaLqdqv5mk5ic2fheuKQ3kfm6giyjRt5CMVK8y
         cmtg62j7uKRVbrabdYNi9F7kkeQMB2JOZ2Ab7UC+t7ZWiOV+fHRPKe4AOAQUhFPhb7
         Ij7Nm2udE//8bjUtiDxZ+R5hul///tF7mzBwY/nA5jd0R4iBFxHj00P0b9SxHvh6X8
         hixP5CenPSeCbf4i9VbfO6lPiA0Cd3f5TvnuA3lfbFF9yUS/n5JhzPR34P3zFSjH45
         9+DdJ5bzzY9eK4mFzxxp/GnXI0kWm0319did88qoU3JWjl5/uMELWabw5BcHlE8Rqy
         OcYT/3hyi7opQ==
X-Nifty-SrcIP: [125.199.20.195]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-mtd@lists.infradead.org,
        Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>
Subject: [PATCH] mtd: replace VMLINUX_SYMBOL_STR() with string literal
Date:   Sun, 24 Jun 2018 00:35:42 +0900
Message-Id: <1529768142-9989-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the special case handling for Blackfin and Metag was removed by
commit 94e58e0ac312 ("export.h: remove code for prefixing symbols with
underscore"), VMLINUX_SYMBOL_STR() can be replaced with string literal.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/mtd/chips/gen_probe.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/chips/gen_probe.c b/drivers/mtd/chips/gen_probe.c
index b57ceea..879bebf 100644
--- a/drivers/mtd/chips/gen_probe.c
+++ b/drivers/mtd/chips/gen_probe.c
@@ -202,10 +202,10 @@ static inline struct mtd_info *cfi_cmdset_unknown(struct map_info *map,
 	struct cfi_private *cfi = map->fldrv_priv;
 	__u16 type = primary?cfi->cfiq->P_ID:cfi->cfiq->A_ID;
 #ifdef CONFIG_MODULES
-	char probename[sizeof(VMLINUX_SYMBOL_STR(cfi_cmdset_%4.4X))];
+	char probename[sizeof("cfi_cmdset_%4.4X")];
 	cfi_cmdset_fn_t *probe_function;
 
-	sprintf(probename, VMLINUX_SYMBOL_STR(cfi_cmdset_%4.4X), type);
+	sprintf(probename, "cfi_cmdset_%4.4X", type);
 
 	probe_function = __symbol_get(probename);
 	if (!probe_function) {
-- 
2.7.4

