Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753821AbeDJXn4 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 19:43:56 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:55763 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752990AbeDJW0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 18:26:08 -0400
X-Google-Smtp-Source: AIpwx4/mehbPHTHh7Oq47Eujl74xWKFp7dLVGHo21kg6L57DfCKap52qdhU8qMfPShvrsdBgCDC0wQ==
From: Alex Elder <elder@linaro.org>
To: andy.gross@linaro.org
Cc: clew@codeaurora.org, aneela@codeaurora.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] soc: qcom: smem: return proper type for cached entry functions
Date: Tue, 10 Apr 2018 17:25:38 -0500
Message-Id: <20180410222542.29474-3-elder@linaro.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180410222542.29474-1-elder@linaro.org>
References: <20180410222542.29474-1-elder@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

What phdr_to_last_uncached_entry() returns is the address of the
start of the free space following all allocated uncached entries.
It really doesn't refer to an actual (initialized) private entry
structure.   Similarly phdr_to_last_cached_entry() returns the
address of the end of free space, preceding the last allocated cache
entry.  Change both functions' return type to be pointer to void
to reflect this.

Meanwhile, phdr_to_first_cached_entry() really *does* point to a
private entry structure, so change its return type to reflect
this fact.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/soc/qcom/smem.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
index 7f38c5e11440..3102aa94aec2 100644
--- a/drivers/soc/qcom/smem.c
+++ b/drivers/soc/qcom/smem.c
@@ -280,7 +280,7 @@ struct qcom_smem {
 	struct smem_region regions[0];
 };
 
-static struct smem_private_entry *
+static void *
 phdr_to_last_uncached_entry(struct smem_partition_header *phdr)
 {
 	void *p = phdr;
@@ -288,7 +288,8 @@ phdr_to_last_uncached_entry(struct smem_partition_header *phdr)
 	return p + le32_to_cpu(phdr->offset_free_uncached);
 }
 
-static void *phdr_to_first_cached_entry(struct smem_partition_header *phdr,
+static struct smem_private_entry *
+phdr_to_first_cached_entry(struct smem_partition_header *phdr,
 					size_t cacheline)
 {
 	void *p = phdr;
@@ -297,7 +298,8 @@ static void *phdr_to_first_cached_entry(struct smem_partition_header *phdr,
 	return p + le32_to_cpu(phdr->size) - ALIGN(sizeof(*e), cacheline);
 }
 
-static void *phdr_to_last_cached_entry(struct smem_partition_header *phdr)
+static void *
+phdr_to_last_cached_entry(struct smem_partition_header *phdr)
 {
 	void *p = phdr;
 
-- 
2.14.1
