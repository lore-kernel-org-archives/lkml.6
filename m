Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94B88C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 09:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 666DC21907
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 09:57:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732000AbeL1J5u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 04:57:50 -0500
Received: from smtp02.smtpout.orange.fr ([80.12.242.124]:56643 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731985AbeL1J5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 04:57:49 -0500
Received: from localhost.localdomain ([90.126.241.217])
        by mwinf5d25 with ME
        id HMxn1z00A4i89ZE03MxnfN; Fri, 28 Dec 2018 10:57:48 +0100
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 28 Dec 2018 10:57:48 +0100
X-ME-IP: 90.126.241.217
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com,
        rppt@linux.vnet.ibm.com, akpm@linux-foundation.org,
        yuehaibing@huawei.com, keescook@chromium.org
Cc:     linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 2/2] um: vector: Use 'kmalloc_array' instead of 'kmalloc'
Date:   Wed, 26 Dec 2018 08:54:49 +0100
Message-Id: <20181226075449.11071-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use 'kmalloc_array' instead of 'kmalloc' when appropriate.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
I don't know why it has not already been replaced in 6da2ec56059c
("treewide: kmalloc() -> kmalloc_array()".
---
 arch/um/drivers/vector_kern.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/um/drivers/vector_kern.c b/arch/um/drivers/vector_kern.c
index 5b917716289d..dee5246bda81 100644
--- a/arch/um/drivers/vector_kern.c
+++ b/arch/um/drivers/vector_kern.c
@@ -507,12 +507,12 @@ static struct vector_queue *create_queue(
 		return NULL;
 	result->max_depth = max_size;
 	result->dev = vp->dev;
-	result->mmsg_vector = kmalloc(
-		(sizeof(struct mmsghdr) * max_size), GFP_KERNEL);
+	result->mmsg_vector = kmalloc_array(max_size, sizeof(struct mmsghdr),
+					    GFP_KERNEL);
 	if (result->mmsg_vector == NULL)
 		goto out_mmsg_fail;
-	result->skbuff_vector = kmalloc(
-		(sizeof(void *) * max_size), GFP_KERNEL);
+	result->skbuff_vector = kmalloc_array(max_size, sizeof(void *),
+					      GFP_KERNEL);
 	if (result->skbuff_vector == NULL)
 		goto out_skb_fail;
 
-- 
2.19.1

