Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751879AbeEQJ71 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 05:59:27 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33453 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751274AbeEQJ7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 05:59:24 -0400
X-Google-Smtp-Source: AB8JxZqbF2kQ2eoS2+MeSUzTLrKCQXxsunC8JJLFZKvWIqZ4svrEwLMJoNuCa79taXVVV7HFI62zkw==
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: agross@codeaurora.org, vkoul@kernel.org, dmaengine@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH] dmaengine: qcom: bam_dma: fix invalid assignment warning
Date: Thu, 17 May 2018 10:59:16 +0100
Message-Id: <20180517095916.11362-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180517095916.11362-1-srinivas.kandagatla@linaro.org>
References: <20180517095916.11362-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Building kernel with W=1 throws below invalid assignment warnings.
bam_dma.c:676:44: warning: invalid assignment: +=
bam_dma.c:676:44:    left side has type unsigned long
bam_dma.c:676:44:    right side has type restricted __le16
bam_dma.c:921:41: warning: invalid assignment: +=
bam_dma.c:921:41:    left side has type unsigned long
bam_dma.c:921:41:    right side has type restricted __le16

Fix them!.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/dma/qcom/bam_dma.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
index a05fff8a1447..fac1ac910d75 100644
--- a/drivers/dma/qcom/bam_dma.c
+++ b/drivers/dma/qcom/bam_dma.c
@@ -673,7 +673,7 @@ static struct dma_async_tx_descriptor *bam_prep_slave_sg(struct dma_chan *chan,
 				remainder = 0;
 			}
 
-			async_desc->length += desc->size;
+			async_desc->length += le16_to_cpu(desc->size);
 			desc++;
 		} while (remainder > 0);
 	}
@@ -918,7 +918,8 @@ static enum dma_status bam_tx_status(struct dma_chan *chan, dma_cookie_t cookie,
 				continue;
 
 			for (i = 0; i < async_desc->num_desc; i++)
-				residue += async_desc->curr_desc[i].size;
+				residue += le16_to_cpu(
+						async_desc->curr_desc[i].size);
 		}
 	}
 
-- 
2.16.2
