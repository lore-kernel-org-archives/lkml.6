Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753771AbeDJXn5 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 19:43:57 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:39958 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752985AbeDJW0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 18:26:07 -0400
X-Google-Smtp-Source: AIpwx49zJ0smETBn3uWNyxuys0hd4aCmMizshg3rG5pONTiGEc5Cex7b8BusR6gv56RdA53fz2mHyA==
From: Alex Elder <elder@linaro.org>
To: andy.gross@linaro.org
Cc: clew@codeaurora.org, aneela@codeaurora.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] soc: qcom: smem: fix first cache entry calculation
Date: Tue, 10 Apr 2018 17:25:37 -0500
Message-Id: <20180410222542.29474-2-elder@linaro.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180410222542.29474-1-elder@linaro.org>
References: <20180410222542.29474-1-elder@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cached items are found at the high end of an smem partition.  A
cached item's shared memory precedes the private entry structure
that describes it.

The address of the structure describing the first cached item should
be returned by phdr_to_first_cached_entry().  However the function
calculates the start address using the wrong structure size.

Fix this by computing the first item's entry structure address by
subtracting the size of a private entry structure rather than a
partition header structure.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/soc/qcom/smem.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
index 0b94d62fad2b..7f38c5e11440 100644
--- a/drivers/soc/qcom/smem.c
+++ b/drivers/soc/qcom/smem.c
@@ -292,8 +292,9 @@ static void *phdr_to_first_cached_entry(struct smem_partition_header *phdr,
 					size_t cacheline)
 {
 	void *p = phdr;
+	struct smem_private_entry *e;
 
-	return p + le32_to_cpu(phdr->size) - ALIGN(sizeof(*phdr), cacheline);
+	return p + le32_to_cpu(phdr->size) - ALIGN(sizeof(*e), cacheline);
 }
 
 static void *phdr_to_last_cached_entry(struct smem_partition_header *phdr)
-- 
2.14.1
