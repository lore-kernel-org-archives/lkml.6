Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751647AbeCLNcO (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 09:32:14 -0400
Received: from mout.web.de ([212.227.15.14]:51333 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751556AbeCLNcK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 09:32:10 -0400
Subject: [PATCH 1/2] crypto: talitos: Use common error handling code in
 talitos_edesc_alloc()
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: linux-crypto@vger.kernel.org,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        "David S. Miller" <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <ad256dc9-a064-37f9-fb8e-aea22ba40a2b@users.sourceforge.net>
Message-ID: <330e4ffc-64dc-5474-4c84-916561cf0783@users.sourceforge.net>
Date: Mon, 12 Mar 2018 14:31:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <ad256dc9-a064-37f9-fb8e-aea22ba40a2b@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:68uygeUx37NNbDOanPCW2gwb+FpB9ONHz8YH2stx/aZZ+tl7SMJ
 jz5mh9pglWZWVcml4Y3cdz7XCRmImqN3pHAX8Q9EHMeYTaWCvOpTMEjzXzfNnYU+xu9+3VR
 w5T8fKa9mjKFsYe+oLHqgiAhfisFtScrgIzu+fXQ1lMEp4cLaveOafB82EOTNW3l+XRjr39
 PeBUs8yE1qCPd+TkCy7Cw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:u2R8aP7g96Y=:IefXWQGFPOw4yIV1bvkzln
 7NSZX9oPCuRzDlN0YazzIgYDt/grNrEwBG8CxojpOSuiso+55jqb+pDGTmk/mQaIsmwmHRXxh
 gwCoaV9F5S9L9yBiF13NFTM2eHmMLPZlcKhCUcqc9NHDAkn9tMAK/bHG2ChCrUWRV7Wk9FytF
 sOO1q/D4DZJECtHsrq8yuxQYOlTKz/vqWgchS7sJfRwR06UhsvmfWySdAEVOa/59s1d48QvMF
 vnIn1kyIQF4SyFek8mjq3+O3TRbNxuk8UnuqZQotcBQlbbwbY/56bKb4MSiW5xAScSLEF1aaz
 T61leWjk5mjVzPOsTK1SIX7BrFoGZL1o6VoZS2mqeEPrpwsZGlXIG3YcivBy//wl8NJ4xo2lX
 yVC00Q1qr6cP9MFm5nMAGy3mk6Uq6hIw1uVHg9E0zYKortWqt33ZUSKqag6v1Ox1nzGs9FXVZ
 bup8GyV8ndA4sXVBbvzEebXlF3KA2pwfIM7Ao+phk8/Xm9Dtg3R5+niU/NUag+o/SPH6vdSHB
 K7cyCDPvhqBFkLFQJNClehNzlZQ9H/P/Plaw7/JRSLhDmvBkBjOJz2ZJd7qGHnRsYPFb9gj9H
 Ye6x80BLPgdURwRnPO+cKAl7XusuChh2S+kEsuKkjznqZT+EUF0pcFdsjteJXdv8HvTnpUQMf
 wU/oo76hPlxCxGzmmXsjTUr2pDu+pRqZ30IKhn01PrCBGVCC5NFwjRQllZcUKVW76w6kNQEwA
 JbNmW9N5nObnw5wlUCJsYMcmRcAw3Rcue8CyRs2dCyR83TIgFxhTjgec3WvGU9TzvDCFmvugG
 T+A/gh2YlTPUpilvdxwpwiwVMHX/u2JkiG0OQBzRlKXiQmf3G8=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 12 Mar 2018 14:08:55 +0100

Add jump targets so that an error message and the setting of a specific
error code is stored only once at the end of this function.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/crypto/talitos.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/crypto/talitos.c b/drivers/crypto/talitos.c
index 6882fa2f8bad..a2271322db34 100644
--- a/drivers/crypto/talitos.c
+++ b/drivers/crypto/talitos.c
@@ -1352,29 +1352,24 @@ static struct talitos_edesc *talitos_edesc_alloc(struct device *dev,
 	if (!dst || dst == src) {
 		src_len = assoclen + cryptlen + authsize;
 		src_nents = sg_nents_for_len(src, src_len);
-		if (src_nents < 0) {
-			dev_err(dev, "Invalid number of src SG.\n");
-			err = ERR_PTR(-EINVAL);
-			goto error_sg;
-		}
+		if (src_nents < 0)
+			goto report_failure;
+
 		src_nents = (src_nents == 1) ? 0 : src_nents;
 		dst_nents = dst ? src_nents : 0;
 		dst_len = 0;
 	} else { /* dst && dst != src*/
 		src_len = assoclen + cryptlen + (encrypt ? 0 : authsize);
 		src_nents = sg_nents_for_len(src, src_len);
-		if (src_nents < 0) {
-			dev_err(dev, "Invalid number of src SG.\n");
-			err = ERR_PTR(-EINVAL);
-			goto error_sg;
-		}
+		if (src_nents < 0)
+			goto report_failure;
+
 		src_nents = (src_nents == 1) ? 0 : src_nents;
 		dst_len = assoclen + cryptlen + (encrypt ? authsize : 0);
 		dst_nents = sg_nents_for_len(dst, dst_len);
 		if (dst_nents < 0) {
 			dev_err(dev, "Invalid number of dst SG.\n");
-			err = ERR_PTR(-EINVAL);
-			goto error_sg;
+			goto set_error_code;
 		}
 		dst_nents = (dst_nents == 1) ? 0 : dst_nents;
 	}
@@ -1424,6 +1419,11 @@ static struct talitos_edesc *talitos_edesc_alloc(struct device *dev,
 						     DMA_BIDIRECTIONAL);
 	}
 	return edesc;
+
+report_failure:
+	dev_err(dev, "Invalid number of src SG.\n");
+set_error_code:
+	err = ERR_PTR(-EINVAL);
 error_sg:
 	if (iv_dma)
 		dma_unmap_single(dev, iv_dma, ivsize, DMA_TO_DEVICE);
-- 
2.16.2
