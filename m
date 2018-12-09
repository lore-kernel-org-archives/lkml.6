Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A04F3C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 15:49:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 545C420865
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 15:49:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SSMgFM14"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 545C420865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbeLIPtz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 10:49:55 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34593 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbeLIPty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 10:49:54 -0500
Received: by mail-ed1-f68.google.com with SMTP id b3so7481787ede.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 Dec 2018 07:49:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2UnM7SjM5idYEYNJNMIosUvMnjrwJ6EuFmsmm9FT2VQ=;
        b=SSMgFM14IttMuSH3UyEfLMkZGbOEhxa3o2r3uxunMMRb+T3b8nKSZGGf6OK2r3kyG/
         wIs0zfZZzGlBPQOC/maTOHqCVyc04QzFk8Ci9AiPBBxmTZlAwj320e+MioXly/9yLl8h
         g8rng1ghnOejBDhnrtqIbwaHq9IWynMZqJXe+dZo759flQzn6rlQ+cSiR7BgxHP6W9pJ
         5GzO7NRLvWIHVAQEgZMRSBIAgX/pK1MTWxRYIGgU36wRlN5P1scOy9M+I37uiWwSXdlA
         Ho4tItWoMP2rz/F5T/smb8auL9EXkD/3IdPMRTGas6RBbEQSoJuQUfg4rG8h8JEg1LmS
         fEHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2UnM7SjM5idYEYNJNMIosUvMnjrwJ6EuFmsmm9FT2VQ=;
        b=Wq0oiSBcAt75MAa14NcHTvE1+59CmjodZ4Yw+XK5tfVYgfuIflusRO5hX9GobndwX9
         uOX9cyjwopuVKIaaLbMeMNIsVzd+VTbtiQzBaEntno7NwTTElENN98uU9EsCy3XsONyi
         3KMva6S1meQgjrgHIbgH7JBpuRyxB9VchrlviH2zwVuuanuwhfSzYw41S7DchbjdKsRN
         g8NNNizwpDQqhKyRQJleZ4jBsRXO/pyLT31TRkJAYDdDnH/VhCzf8VA7eZ/VkSUBJcyg
         C+4xB63MqT/EwUwB2gLjgbPICYU+VzLlCW+vbv2M1EBXxJpErYS0YowakI8kpFS+ZxP/
         aolQ==
X-Gm-Message-State: AA+aEWaX46HxVHaeONIU1IObn2kNQkfP82p8KIdHommBzr/ROAJPtNt/
        14KLZY71gufacXUg5hhJX9uGSIOTh5E=
X-Google-Smtp-Source: AFSGD/Xeom6oiEZ0mB/I2RQ6X43mJO6JJU/KmdR4u1cMOTRJJV2ED19FGXE45YWOlSSHZLeQ0ZfThA==
X-Received: by 2002:a50:ba3d:: with SMTP id g58mr8715554edc.35.1544370593189;
        Sun, 09 Dec 2018 07:49:53 -0800 (PST)
Received: from shadow.parknet.dk ([80.71.142.126])
        by smtp.gmail.com with ESMTPSA id p36sm2687506edc.78.2018.12.09.07.49.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Dec 2018 07:49:52 -0800 (PST)
From:   Thomas Jespersen <laumann.thomas@gmail.com>
To:     gaoxiang25@huawei.com, yuchao0@huawei.com
Cc:     gregkh@linuxfoundation.org, linux-erofs@lists.ozlabs.org,
        linux-kernel@vger.kernel.org,
        Thomas Jespersen <laumann.thomas@gmail.com>
Subject: [PATCH] staging: erofs: Add braces to do-while statements
Date:   Sun,  9 Dec 2018 16:59:00 +0100
Message-Id: <20181209155900.10164-1-laumann.thomas@gmail.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes warning reported by sparse (with -Wsparse-all).

Signed-off-by: Thomas Jespersen <laumann.thomas@gmail.com>
---
 drivers/staging/erofs/internal.h | 4 ++--
 drivers/staging/erofs/utils.c    | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/erofs/internal.h b/drivers/staging/erofs/internal.h
index 57575c7f5635..bf180a803446 100644
--- a/drivers/staging/erofs/internal.h
+++ b/drivers/staging/erofs/internal.h
@@ -232,9 +232,9 @@ static inline bool erofs_workgroup_get(struct erofs_workgroup *grp, int *ocnt)
 	/* spin if it is temporarily locked at the reclaim path */
 	if (unlikely(o == locked)) {
 #if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)
-		do
+		do {
 			cpu_relax();
-		while (atomic_read(&grp->refcount) == locked);
+		} while (atomic_read(&grp->refcount) == locked);
 #endif
 		goto repeat;
 	}
diff --git a/drivers/staging/erofs/utils.c b/drivers/staging/erofs/utils.c
index ea8a962e5c95..cd76df4a48c7 100644
--- a/drivers/staging/erofs/utils.c
+++ b/drivers/staging/erofs/utils.c
@@ -217,9 +217,9 @@ unsigned long erofs_shrink_scan(struct shrinker *shrink,
 	unsigned long freed = 0;
 
 	spin_lock(&erofs_sb_list_lock);
-	do
+	do {
 		run_no = ++shrinker_run_no;
-	while (run_no == 0);
+	} while (run_no == 0);
 
 	/* Iterate over all mounted superblocks and try to shrink them */
 	p = erofs_sb_list.next;
-- 
2.19.2

