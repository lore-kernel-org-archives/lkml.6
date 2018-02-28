Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751795AbeB1Apb (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 19:45:31 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:44175 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751689AbeB1Ap3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 19:45:29 -0500
X-Google-Smtp-Source: AG47ELuAeMftUoSv+X1/a6loEIonjLikSfHglzxLJpT9HDRCS/8I9uniVdDpSw+Q0yXIwfr3lgOboA==
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>
Cc: Will Newton <will.newton@gmail.com>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] soc: qcom: wcnss_ctrl: Fix increment in NV upload
Date: Tue, 27 Feb 2018 16:45:25 -0800
Message-Id: <20180228004525.5156-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hdr.len includes both the size of the header and the fragment, so using
this when stepping through the firmware causes us to skip 16 bytes every
chunk of 3072 bytes; causing only the first fragment to actually be
valid data.

Instead use fragment size steps through the firmware blob.

Fixes: ea7a1f275cf0 ("soc: qcom: Introduce WCNSS_CTRL SMD client")
Reported-by: Will Newton <will.newton@gmail.com>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

It's worth noting that the firmware does not complain about the broken NV blob
nor does fixing this seem to alter the behavior of BT or WLAN - perhaps because
the WLAN driver uploads the NV blob as well?

 drivers/soc/qcom/wcnss_ctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/wcnss_ctrl.c b/drivers/soc/qcom/wcnss_ctrl.c
index e968559b0fc4..5429c91440b1 100644
--- a/drivers/soc/qcom/wcnss_ctrl.c
+++ b/drivers/soc/qcom/wcnss_ctrl.c
@@ -249,7 +249,7 @@ static int wcnss_download_nv(struct wcnss_ctrl *wcnss, bool *expect_cbc)
 		/* Increment for next fragment */
 		req->seq++;
 
-		data += req->hdr.len;
+		data += NV_FRAGMENT_SIZE;
 		left -= NV_FRAGMENT_SIZE;
 	} while (left > 0);
 
-- 
2.16.2
