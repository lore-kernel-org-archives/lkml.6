Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D58AC282C2
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 02:41:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24F7120869
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 02:41:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZSrX6jJz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbfBHClX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 21:41:23 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43341 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726801AbfBHClX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 21:41:23 -0500
Received: by mail-pf1-f195.google.com with SMTP id w73so956069pfk.10;
        Thu, 07 Feb 2019 18:41:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FZdp/8UUDT9VFTy7Uik++C+7AXZaIT9ArAQ6JN2y8+E=;
        b=ZSrX6jJzvedX/JhPKPsCydWjJ3lDTBbKTBqdG/dsQag7ff/XVcEuH4yRCOwl6cAIKf
         9w32ZyexClKqa/eV17HXgq28PQUV+wpk5bPIpCChNKqq5vHIAfNh+V5q/Hjxp0py1R5M
         sBJxwOo2A/FHwIbMRdSXjnSM8H47Q+MgJsf9SFsKTRbJBghFTvzjvFydg/96Hd2+devh
         ZuyH+tqWLwq/E7dgY5CT3+HzAsrsYHd55MTd8+Y0P3f2aStGiD96EGejwHDlZeCLBc0y
         /W+4Ha9nbn8mYdBLsteYRbHFR7NgJYs00N05pvRjfKOzGmbf8TFI6pOVTUXFRlWBJtOR
         v6tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FZdp/8UUDT9VFTy7Uik++C+7AXZaIT9ArAQ6JN2y8+E=;
        b=KvNiSVhuWOuEWEeu3UJUNS/9hQ2TSG07Y5yzco5+0BoMRzFAwB3SQPPEVWQpxskX1+
         I/M/yqYy/itV0dUOCKuysb0Qy8NJntrgCYmQ6utN85n5QZYcxbY6aedGfDUHVEm38HD8
         rF4ztiS6rJDp2DulwqMgUfV6F6RVK/ohFJt8urquTDASRe4IcpWY8ILDEs+y1YNIA78C
         iF2fHNAuv/kQbLr4EeEogp2Bo6lE9j0vT1rPrWHDvQ4QHqyGxrCd9dzNTNUE7fw2yiN7
         jMuSoWKRicnUVB9S5/eRWHFSrJv5YUwzSmk14fYRaCQRzWatKLrV2s5oxg64aWa5hbnV
         w2gw==
X-Gm-Message-State: AHQUAuZXND4pTUYZTEGHrFRir4lWKVqNznofVDeO23Bm0DtWdFSaeEVE
        rAbBXygicDXcPEu+DGY3n4aP495H
X-Google-Smtp-Source: AHgI3IY3iujn+6oeEpJj4UDuTrUU+CHaQVTqx4rEOk4pYnIQlThSsh0Whqd7BplV0L0vLSD3+7yGAQ==
X-Received: by 2002:a62:9913:: with SMTP id d19mr19619911pfe.107.1549593682080;
        Thu, 07 Feb 2019 18:41:22 -0800 (PST)
Received: from localhost.localdomain ([103.42.74.200])
        by smtp.gmail.com with ESMTPSA id x186sm638501pfb.59.2019.02.07.18.41.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Feb 2019 18:41:21 -0800 (PST)
From:   Allen <allen.lkml@gmail.com>
To:     linux-s390@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Allen Pais <allen.lkml@gmail.com>
Subject: [PATCH] Use ARRAY_SIZE instead of dividing sizeof array with sizeof an element.
Date:   Fri,  8 Feb 2019 08:11:10 +0530
Message-Id: <20190208024110.8021-1-allen.lkml@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Allen Pais <allen.lkml@gmail.com>

This issue was detected with the help of Coccinelle.

Signed-off-by: Allen Pais <allen.lkml@gmail.com>
---
 arch/s390/tools/gen_opcode_table.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/tools/gen_opcode_table.c b/arch/s390/tools/gen_opcode_table.c
index a1bc02b29c81..468b70c85f62 100644
--- a/arch/s390/tools/gen_opcode_table.c
+++ b/arch/s390/tools/gen_opcode_table.c
@@ -138,7 +138,7 @@ static struct insn_type *insn_format_to_type(char *format)
 	strcpy(tmp, format);
 	base_format = tmp;
 	base_format = strsep(&base_format, "_");
-	for (i = 0; i < sizeof(insn_type_table) / sizeof(insn_type_table[0]); i++) {
+	for (i = 0; i < ARRAY_SIZE(insn_type_table); i++) {
 		ptr = insn_type_table[i].format;
 		while (*ptr) {
 			if (!strcmp(base_format, *ptr))
-- 
2.19.1

