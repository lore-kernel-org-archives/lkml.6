Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E103AC43612
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 03:02:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAA0920855
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 03:02:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZbfJ17HM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbeLaDCS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Dec 2018 22:02:18 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43511 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbeLaDCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Dec 2018 22:02:17 -0500
Received: by mail-pl1-f193.google.com with SMTP id gn14so12217577plb.10;
        Sun, 30 Dec 2018 19:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=0mGdjxHYv3EMsZoOLv88KdxsU/ATCRh8+Xrkp0fw/Mw=;
        b=ZbfJ17HMMEfZO5Rr7UufNe1pNvrZX9QAI1WUrDMf37nRv84tN/44r9uLPynpvjLfzu
         g5XFyXkULy/Gd0Qwt1H/qiL2kQxvQLc5aElI0iiL0NyTmyaw544mRUdmBmAj/cbopThg
         9Qul/0Zgf0WsPe3RH9gZVNClaUzON1U60R8+r7usRL8WyiZZLELTGzdk3/C7QLvUGkvC
         Glk2kCIZZPBXc+RPmpQTvBwKOg+PhyzLPmykfkb2RIvJ92JREJS4b1jVOzMvZWaLqTrm
         8KdrSrrVMKpF/3RHVIj+OHLT5RaEsuI77+Ew7Jn4PbFI6Z7uBNDnXkWMlEb+QQLu1/1r
         JvvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=0mGdjxHYv3EMsZoOLv88KdxsU/ATCRh8+Xrkp0fw/Mw=;
        b=HnXoLTiQOlp6aEsS1da3wrH6yYWd8ZN9KdbAyEQ689/yabyk/MPJ+c/Z3bu2z7R3Hw
         mZXnbmHhakXyMRgL8+eOBlYzb9xoqSv0l4Wu6WUarZBlLIdhrXoAf8mb/8gptiCdkrHC
         YtkSI8Tj/DbOXQkxAXsmPcMwspkeTfoxfm8VtS4S3gaJ1HDWrDUd064HbEatqE5imujH
         dOvrzJvjQhwpgQLLciiUTCSmFRVCyJrG7Ssm73nu2+mfcaIJUWVGxl9Dz1C8zBlyaAw0
         RUcisf882NRmPi+QwrdodOoAx+6XIXNuRzPVN1DCJzJq/hWAqHvFEp8YNava/2icKodD
         pmeQ==
X-Gm-Message-State: AJcUukfIatCfd+r9x8FW+wrkjehUJXmbTxixEbU5AgNgnG/1MXDwDDUO
        aVAmZkZ41XnRdIItiRD2SKI=
X-Google-Smtp-Source: ALg8bN7n07vjujaDj1zMk5oiGpC4Bd8Nfqo/0n6jN7GKtGIqisljuakFF5tPT8ie8gCGI+mYszwNVg==
X-Received: by 2002:a17:902:9a4c:: with SMTP id x12mr34963585plv.94.1546225335915;
        Sun, 30 Dec 2018 19:02:15 -0800 (PST)
Received: from software.domain.org ([172.247.34.138])
        by smtp.gmail.com with ESMTPSA id 85sm72097374pfw.17.2018.12.30.19.02.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 30 Dec 2018 19:02:15 -0800 (PST)
From:   Huacai Chen <chenhc@lemote.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>, stable@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Michael Hernandez <michael.hernandez@cavium.com>
Subject: [PATCH] genirq/affinity: Assign default affinity to pre/post vectors
Date:   Mon, 31 Dec 2018 11:03:24 +0800
Message-Id: <1546225404-6775-1-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Generally, irq_create_affinity_masks() assign default affinity to pre/
post vectors correctly. However, it ignore the case that there are only
pre/post vectors (when nvecs == affd->pre_vectors + affd->post_vectors)
and return NULL. This case usually happens when nvecs = 1 (e.g. in nvme
driver when MSI-X is unavailable and fallback to MSI) and will trigger
the warning in pci_irq_get_affinity(). This patch fix the corner case.

Fixes: 6f9a22bc5775d231ab8f ("PCI/MSI: Ignore affinity if pre/post vector count is more than min_vecs")
Cc: stable@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
Cc: Michael Hernandez <michael.hernandez@cavium.com>
Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 kernel/irq/affinity.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
index 45b68b4..9b766eb 100644
--- a/kernel/irq/affinity.c
+++ b/kernel/irq/affinity.c
@@ -240,13 +240,6 @@ irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
 	struct irq_affinity_desc *masks = NULL;
 	int i, nr_sets;
 
-	/*
-	 * If there aren't any vectors left after applying the pre/post
-	 * vectors don't bother with assigning affinity.
-	 */
-	if (nvecs == affd->pre_vectors + affd->post_vectors)
-		return NULL;
-
 	node_to_cpumask = alloc_node_to_cpumask();
 	if (!node_to_cpumask)
 		return NULL;
@@ -255,6 +248,17 @@ irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
 	if (!masks)
 		goto outnodemsk;
 
+	/*
+	 * If there aren't any vectors left after applying the pre/post
+	 * vectors then just assign the default affinity to all vectors.
+	 */
+	if (nvecs == affd->pre_vectors + affd->post_vectors) {
+		/* Fill all vectors that don't need affinity */
+		for (curvec = 0; curvec < nvecs; curvec++)
+			cpumask_copy(&masks[curvec].mask, irq_default_affinity);
+		goto outnodemsk;
+	}
+
 	/* Fill out vectors at the beginning that don't need affinity */
 	for (curvec = 0; curvec < affd->pre_vectors; curvec++)
 		cpumask_copy(&masks[curvec].mask, irq_default_affinity);
-- 
2.7.0

