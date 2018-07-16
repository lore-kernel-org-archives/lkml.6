Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECE03ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 20:31:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0A6B20850
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 20:31:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0A6B20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729930AbeGPVA3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 17:00:29 -0400
Received: from smtp2.provo.novell.com ([137.65.250.81]:45509 "EHLO
        smtp2.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728290AbeGPVA3 (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Mon, 16 Jul 2018 17:00:29 -0400
Received: from linux-r8p5.suse.de (prv-ext-foundry1int.gns.novell.com [137.65.251.240])
        by smtp2.provo.novell.com with ESMTP (TLS encrypted); Mon, 16 Jul 2018 14:31:23 -0600
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     herbert@gondor.apana.org.au
Cc:     linux-kernel@vger.kernel.org, dave@stgolabs.net,
        Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH] lib/crc10dif: Update crct10dif_fallback static key to modern api
Date:   Mon, 16 Jul 2018 13:31:15 -0700
Message-Id: <20180716203115.22248-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No changes in semantics -- key init is false; replace

static_key_slow_inc       with   static_branch_inc
static_key_false          with   static_branch_unlikely

Added a '_key' suffix to crc10dif_fallback for better self
documentation.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 lib/crc-t10dif.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/crc-t10dif.c b/lib/crc-t10dif.c
index 1ad33e555805..528b24249ddd 100644
--- a/lib/crc-t10dif.c
+++ b/lib/crc-t10dif.c
@@ -17,7 +17,7 @@
 #include <linux/static_key.h>
 
 static struct crypto_shash *crct10dif_tfm;
-static struct static_key crct10dif_fallback __read_mostly;
+static DEFINE_STATIC_KEY_FALSE(crct10dif_fallback_key);
 
 __u16 crc_t10dif_update(__u16 crc, const unsigned char *buffer, size_t len)
 {
@@ -27,7 +27,7 @@ __u16 crc_t10dif_update(__u16 crc, const unsigned char *buffer, size_t len)
 	} desc;
 	int err;
 
-	if (static_key_false(&crct10dif_fallback))
+	if (static_branch_unlikely(&crct10dif_fallback_key))
 		return crc_t10dif_generic(crc, buffer, len);
 
 	desc.shash.tfm = crct10dif_tfm;
@@ -51,7 +51,7 @@ static int __init crc_t10dif_mod_init(void)
 {
 	crct10dif_tfm = crypto_alloc_shash("crct10dif", 0, 0);
 	if (IS_ERR(crct10dif_tfm)) {
-		static_key_slow_inc(&crct10dif_fallback);
+		static_branch_inc(&crct10dif_fallback_key);
 		crct10dif_tfm = NULL;
 	}
 	return 0;
-- 
2.16.4

