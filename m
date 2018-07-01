Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CA53C6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 17:00:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D056225511
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 17:00:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D056225511
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934115AbeGARAD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 13:00:03 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:37924 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032415AbeGAQnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:43:52 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D8087ACC;
        Sun,  1 Jul 2018 16:43:51 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Capenter <dan.carpenter@oracle.com>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Richard Weinberger <richard@nod.at>
Subject: [PATCH 4.17 160/220] um: Fix initialization of vector queues
Date:   Sun,  1 Jul 2018 18:23:04 +0200
Message-Id: <20180701160914.962882744@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701160908.272447118@linuxfoundation.org>
References: <20180701160908.272447118@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Anton Ivanov <anton.ivanov@cambridgegreys.com>

commit 4579a1ba692af81da7ea6ce197f8169ddc0c327f upstream.

UML vector drivers could derefence uninitialized memory
when cleaning up after a queue allocation failure.

Fixes: 49da7e64f33e ("High Performance UML Vector Network Driver")
Cc: <stable@vger.kernel.org>
Reported-by: Dan Capenter <dan.carpenter@oracle.com>
Signed-off-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Signed-off-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/um/drivers/vector_kern.c |   15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

--- a/arch/um/drivers/vector_kern.c
+++ b/arch/um/drivers/vector_kern.c
@@ -504,15 +504,19 @@ static struct vector_queue *create_queue
 
 	result = kmalloc(sizeof(struct vector_queue), GFP_KERNEL);
 	if (result == NULL)
-		goto out_fail;
+		return NULL;
 	result->max_depth = max_size;
 	result->dev = vp->dev;
 	result->mmsg_vector = kmalloc(
 		(sizeof(struct mmsghdr) * max_size), GFP_KERNEL);
+	if (result->mmsg_vector == NULL)
+		goto out_mmsg_fail;
 	result->skbuff_vector = kmalloc(
 		(sizeof(void *) * max_size), GFP_KERNEL);
-	if (result->mmsg_vector == NULL || result->skbuff_vector == NULL)
-		goto out_fail;
+	if (result->skbuff_vector == NULL)
+		goto out_skb_fail;
+
+	/* further failures can be handled safely by destroy_queue*/
 
 	mmsg_vector = result->mmsg_vector;
 	for (i = 0; i < max_size; i++) {
@@ -563,6 +567,11 @@ static struct vector_queue *create_queue
 	result->head = 0;
 	result->tail = 0;
 	return result;
+out_skb_fail:
+	kfree(result->mmsg_vector);
+out_mmsg_fail:
+	kfree(result);
+	return NULL;
 out_fail:
 	destroy_queue(result);
 	return NULL;


