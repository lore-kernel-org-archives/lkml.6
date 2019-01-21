Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFEB3C282DE
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:34:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99AFF20989
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:34:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nOxgppnb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbfAUHeQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 02:34:16 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:32955 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726784AbfAUHeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 02:34:15 -0500
Received: by mail-pl1-f195.google.com with SMTP id z23so9409415plo.0
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jan 2019 23:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kvMKzn4llhsAXCz7nClSb99WoKQyMTJND7jRr4yO2iA=;
        b=nOxgppnbpHw50AVMZDSmtm88nYauhe/jyJcoo16iiXD7iNhca6GM6mNI2OQfOgZJM5
         07moG3u2Ap52DonJmLUMmAl1T9jVXaenWMCijenreumSR8uRWlA5dpuao9pGU4C69II6
         OAPZ1h6OsAFw0NoI9VbJPB4yJbN8sQjt5ThPE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kvMKzn4llhsAXCz7nClSb99WoKQyMTJND7jRr4yO2iA=;
        b=KP5Dfn52jXB1zPGiiqtN/AGq+1kI36S63LPkh1sz2IlIj/wZNI3f4uwPzlorbzpfWI
         Y3Lt2Ul1GzcJG1tjeWcR0F1VqLA8aNI+/voD8ho2DQbrBGCZn5woUymIcxU7pMAmGztR
         wLSTwJnhnOWF+QRHAg+njDmTYNCvCFKgeDoeIYnFFpTsVH5N5w8h45NFYh6q0VAjQZen
         ZaO+5sat2aOXNx+lG5YIgSa0cCUoMIqjjCqPVuT6TMbjvfqP78BmOj7h0BjESVMTknpc
         R20w5Q4xPyBkCX8AzBPh/RB/2tJ3pgd0xRG282imoCckw+YYBeA9nYhG7raas+mP1XFv
         ksow==
X-Gm-Message-State: AJcUukdcnoy5UOCYg46KCUwMbslHoBtTCX5dWrMbNA1VTJVwi6YFG/7H
        n3aSXtQv5Lkch109RbtlezOTNQ==
X-Google-Smtp-Source: ALg8bN7Ts/JgTi7B8Nb2cXk7y524UViJHL1pgAqv+4LF/3R8UE8zTOP7O8CqUFYqRNGgb15KG6rO+w==
X-Received: by 2002:a17:902:5066:: with SMTP id f35mr29208580plh.78.1548056054979;
        Sun, 20 Jan 2019 23:34:14 -0800 (PST)
Received: from pihsun-z840.tpe.corp.google.com ([2401:fa00:1:10:7889:7a43:f899:134c])
        by smtp.googlemail.com with ESMTPSA id r6sm19483243pgk.91.2019.01.20.23.34.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 Jan 2019 23:34:14 -0800 (PST)
From:   Pi-Hsun Shih <pihsun@chromium.org>
Cc:     Pi-Hsun Shih <pihsun@chromium.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-remoteproc@vger.kernel.org (open list:REMOTE PROCESSOR
        (REMOTEPROC) SUBSYSTEM), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/2] remoteproc: Add __iomem to return of rproc_da_to_va.
Date:   Mon, 21 Jan 2019 15:34:07 +0800
Message-Id: <20190121073408.56557-1-pihsun@chromium.org>
X-Mailer: git-send-email 2.20.1.321.g9e740568ce-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The return value of rproc_da_to_va would probably be device memory. Add
__iomem annotation to it.

Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>
---
I feel that there might be more things that need to be changed
(especially for the carveouts things). I didn't change them since I
don't know how to test that part. Comments needed.
---
 drivers/remoteproc/remoteproc_core.c     | 4 ++--
 drivers/remoteproc/remoteproc_internal.h | 2 +-
 include/linux/remoteproc.h               | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 54ec38fc5dca62..7cb8393e1b39f6 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -190,10 +190,10 @@ static phys_addr_t rproc_va_to_pa(void *cpu_addr)
  * here the output of the DMA API for the carveouts, which should be more
  * correct.
  */
-void *rproc_da_to_va(struct rproc *rproc, u64 da, int len)
+void __iomem *rproc_da_to_va(struct rproc *rproc, u64 da, int len)
 {
 	struct rproc_mem_entry *carveout;
-	void *ptr = NULL;
+	void __iomem *ptr = NULL;
 
 	if (rproc->ops->da_to_va) {
 		ptr = rproc->ops->da_to_va(rproc, da, len);
diff --git a/drivers/remoteproc/remoteproc_internal.h b/drivers/remoteproc/remoteproc_internal.h
index f6cad243d7cac9..df7abe049cdef2 100644
--- a/drivers/remoteproc/remoteproc_internal.h
+++ b/drivers/remoteproc/remoteproc_internal.h
@@ -51,7 +51,7 @@ void rproc_exit_sysfs(void);
 void rproc_free_vring(struct rproc_vring *rvring);
 int rproc_alloc_vring(struct rproc_vdev *rvdev, int i);
 
-void *rproc_da_to_va(struct rproc *rproc, u64 da, int len);
+void __iomem *rproc_da_to_va(struct rproc *rproc, u64 da, int len);
 int rproc_trigger_recovery(struct rproc *rproc);
 
 int rproc_elf_sanity_check(struct rproc *rproc, const struct firmware *fw);
diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
index 68e72f33c705e1..065a68a5e6e577 100644
--- a/include/linux/remoteproc.h
+++ b/include/linux/remoteproc.h
@@ -356,7 +356,7 @@ struct rproc_ops {
 	int (*start)(struct rproc *rproc);
 	int (*stop)(struct rproc *rproc);
 	void (*kick)(struct rproc *rproc, int vqid);
-	void * (*da_to_va)(struct rproc *rproc, u64 da, int len);
+	void __iomem *(*da_to_va)(struct rproc *rproc, u64 da, int len);
 	int (*parse_fw)(struct rproc *rproc, const struct firmware *fw);
 	struct resource_table *(*find_loaded_rsc_table)(
 				struct rproc *rproc, const struct firmware *fw);
-- 
2.20.1.321.g9e740568ce-goog

