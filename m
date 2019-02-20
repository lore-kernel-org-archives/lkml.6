Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B2FFC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 22:01:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAE862086C
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 22:01:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CKCzaaaB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727349AbfBTWBz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 17:01:55 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:34971 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727200AbfBTWBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 17:01:52 -0500
Received: by mail-it1-f193.google.com with SMTP id v72so19570027itc.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 14:01:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aRY9Z8bwkmS+lAeM5BAiZYJDctDSEgW8PfT6dR1Qzlg=;
        b=CKCzaaaBdJgK4/5P3YJtIKSxS+xM7Br1dn7iY4xv21H1Y1dsT2ACVQZlunHEX6rFX8
         ep+BNTX/OME9xgu+IKRgBOq8eIPNGOs07/OXlyb66qtgMdwVl/SrfJHO5tIbgVCBk6cq
         mtL/ncAdR6+vshjCxPWU+A1bXEMTIGYuTFwCE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aRY9Z8bwkmS+lAeM5BAiZYJDctDSEgW8PfT6dR1Qzlg=;
        b=BbTBJn1N0mkB2ZkeZ9B8lUbltx/6lez/Xkh8HXUPWTkHDxaLzVPbr/S33MkJo89gLh
         HRvNBRMzwSKcAIFvYP/uqIGMxhn/zFcXVEJNvGiD9GjjPowmy2tF9eCiTbw0S3//kwXC
         Qip8rbDTu3JsCRrfyzOiNoobz/0iqr1gun4y528BMD60v6pkEJevCX2BOlsf79NN01TT
         8qDJIYYN5qv/7y8YL87JKwsMztRWDeCxsuqPDyXZUMI/G9A2nt0GsOzKvEYC74hAKMVB
         /fLqxxpxvsUeaYYwWhnOvr1GAxAt23JzGNuZlL/Qo3Rkd8YKSBi/MWEqR/gBsbu2QZoO
         hGNQ==
X-Gm-Message-State: AHQUAuYNFWe71hD+tSz4ndFgslxil5bASXV5gD3kHgtnpPBuI1kVtjj7
        e+zmn3lbde532zXINyKK4om0iQ==
X-Google-Smtp-Source: AHgI3IZczD6QxPOImKmMUiYkZUm/6S/pfHLVNGq7Nzlebv+WwDuajxsIRWrDhB/BFNuKeOePqXHa2g==
X-Received: by 2002:a02:8a44:: with SMTP id e4mr20049236jal.13.1550700111519;
        Wed, 20 Feb 2019 14:01:51 -0800 (PST)
Received: from ncrews2.bld.corp.google.com ([2620:15c:183:200:8140:8e3f:aea5:bcdf])
        by smtp.gmail.com with ESMTPSA id 127sm3256789itl.25.2019.02.20.14.01.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 20 Feb 2019 14:01:50 -0800 (PST)
From:   Nick Crews <ncrews@chromium.org>
To:     bleung@chromium.org, enric.balletbo@collabora.com
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        dan.carpenter@oracle.com, dlaurie@chromium.org, ncrews@chromium.org
Subject: [PATCH -next] platform/chrome: Fix off-by-one error in wilco_ec/debugfs.c
Date:   Wed, 20 Feb 2019 14:58:27 -0700
Message-Id: <20190220215826.44366-1-ncrews@chromium.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before, in debugfs.c it was possible to supply only the message type,
and not supply any other arguments when sending raw commands. However,
this is never used by the EC, and it led to an underflow error. Now,
just don't allow too short of a command, we will never need
that anyways.

Fixes: 46c7fd06f8c9 ("platform/chrome: wilco_ec: Add support for raw commands in debugfs")
Signed-off-by: Nick Crews <ncrews@chromium.org>
---
 drivers/platform/chrome/wilco_ec/debugfs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/chrome/wilco_ec/debugfs.c b/drivers/platform/chrome/wilco_ec/debugfs.c
index 46ff3b6c46c7..c090db2cd5be 100644
--- a/drivers/platform/chrome/wilco_ec/debugfs.c
+++ b/drivers/platform/chrome/wilco_ec/debugfs.c
@@ -136,8 +136,8 @@ static ssize_t raw_write(struct file *file, const char __user *user_buf,
 	ret = parse_hex_sentence(buf, kcount, request_data, TYPE_AND_DATA_SIZE);
 	if (ret < 0)
 		return ret;
-	/* Need at least two bytes for message type */
-	if (ret < 2)
+	/* Need at least two bytes for message type and one for command */
+	if (ret < 3)
 		return -EINVAL;
 
 	/* Clear response data buffer */
@@ -145,7 +145,7 @@ static ssize_t raw_write(struct file *file, const char __user *user_buf,
 
 	msg.type = request_data[0] << 8 | request_data[1];
 	msg.flags = WILCO_EC_FLAG_RAW;
-	msg.command = ret > 2 ? request_data[2] : 0;
+	msg.command = request_data[2];
 	msg.request_data = ret > 3 ? request_data + 3 : 0;
 	msg.request_size = ret - 3;
 	msg.response_data = debug_info->raw_data;
