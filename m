Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754466AbeDJXmr (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 19:42:47 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:39961 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753027AbeDJW0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 18:26:10 -0400
X-Google-Smtp-Source: AIpwx4+VBVpERjb/EF/gWwMYvbIuK1INd05yvfurGgcNixoyPUop5uxna7APTWNjOb13QabdSUsP8Q==
From: Alex Elder <elder@linaro.org>
To: andy.gross@linaro.org
Cc: clew@codeaurora.org, aneela@codeaurora.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] soc: qcom: smem: fix off-by-one error in qcom_smem_alloc_private()
Date: Tue, 10 Apr 2018 17:25:40 -0500
Message-Id: <20180410222542.29474-5-elder@linaro.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180410222542.29474-1-elder@linaro.org>
References: <20180410222542.29474-1-elder@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's OK if the space for a newly-allocated uncached entry actually
touches the free cached space boundary.  It's only a problem if it
would cross it.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/soc/qcom/smem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
index 82f0908b90e1..0ed263055988 100644
--- a/drivers/soc/qcom/smem.c
+++ b/drivers/soc/qcom/smem.c
@@ -375,7 +375,7 @@ static int qcom_smem_alloc_private(struct qcom_smem *smem,
 
 	/* Check that we don't grow into the cached region */
 	alloc_size = sizeof(*hdr) + ALIGN(size, 8);
-	if ((void *)hdr + alloc_size >= cached) {
+	if ((void *)hdr + alloc_size > cached) {
 		dev_err(smem->dev, "Out of memory\n");
 		return -ENOSPC;
 	}
-- 
2.14.1
