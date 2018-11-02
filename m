Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E161C6786F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 19:01:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06FEB2082E
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 19:01:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06FEB2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728244AbeKCEJu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 00:09:50 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:52061 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbeKCEJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 00:09:49 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1gIehD-0003nu-1e; Fri, 02 Nov 2018 19:01:27 +0000
From:   Colin King <colin.king@canonical.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chen-Yu Tsai <wens@csie.org>, linux-media@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-arm-kernel@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][staging-next] drivers: staging: cedrus: find ctx before dereferencing it ctx
Date:   Fri,  2 Nov 2018 19:01:26 +0000
Message-Id: <20181102190126.5628-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently if count is an invalid value the v4l2_info message will
dereference a null ctx pointer to get the dev information. Fix
this by finding ctx first and then checking for an invalid count,
this way ctxt will be non-null hence avoiding the null pointer
dereference.

Detected by CoverityScan, CID#1475337 ("Explicit null dereferenced")

Fixes: 50e761516f2b ("media: platform: Add Cedrus VPU decoder driver")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/staging/media/sunxi/cedrus/cedrus.c | 22 ++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/media/sunxi/cedrus/cedrus.c b/drivers/staging/media/sunxi/cedrus/cedrus.c
index 82558455384a..699d62dceb6c 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus.c
+++ b/drivers/staging/media/sunxi/cedrus/cedrus.c
@@ -108,17 +108,6 @@ static int cedrus_request_validate(struct media_request *req)
 	unsigned int count;
 	unsigned int i;
 
-	count = vb2_request_buffer_cnt(req);
-	if (!count) {
-		v4l2_info(&ctx->dev->v4l2_dev,
-			  "No buffer was provided with the request\n");
-		return -ENOENT;
-	} else if (count > 1) {
-		v4l2_info(&ctx->dev->v4l2_dev,
-			  "More than one buffer was provided with the request\n");
-		return -EINVAL;
-	}
-
 	list_for_each_entry(obj, &req->objects, list) {
 		struct vb2_buffer *vb;
 
@@ -133,6 +122,17 @@ static int cedrus_request_validate(struct media_request *req)
 	if (!ctx)
 		return -ENOENT;
 
+	count = vb2_request_buffer_cnt(req);
+	if (!count) {
+		v4l2_info(&ctx->dev->v4l2_dev,
+			  "No buffer was provided with the request\n");
+		return -ENOENT;
+	} else if (count > 1) {
+		v4l2_info(&ctx->dev->v4l2_dev,
+			  "More than one buffer was provided with the request\n");
+		return -EINVAL;
+	}
+
 	parent_hdl = &ctx->hdl;
 
 	hdl = v4l2_ctrl_request_hdl_find(req, parent_hdl);
-- 
2.19.1

