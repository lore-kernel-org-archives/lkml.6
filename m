Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 013CCC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 23:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A225C208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 23:00:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Da5f2KPq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A225C208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729207AbeJFGBK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 02:01:10 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:46671 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726399AbeJFGBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 02:01:10 -0400
Received: by mail-ed1-f65.google.com with SMTP id g32-v6so12916516edg.13;
        Fri, 05 Oct 2018 16:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LEh7fVGWvU/5HBux9fy5ggYR5c2tR/qXQyYFAMPclI0=;
        b=Da5f2KPqI5XizCfUpl9s14gcFvHpzhHJ2bGuqZzdbRCuydU+g6HQxPQh/JnXENb6tH
         xeWQijNRXxrQbxKgs1gIIft8BgYhJ+Swc0ww0YPfMafi7SBwR3Z+jJky3yQ+SpOzBlMG
         /aneBTzoMjV+FQ75hG8gheO3ZYPNo+aRSWYSqUoN8CBd08E4PPRGQXmCo54azAjdK5RS
         hoY0cKeIVfbOEd1NPdgxixLJkXT4/OPXE+un0KKZAO2FO4FAlVxLaGAfJVjzWTQdQmgD
         wcU56HU9v3Pe28eI7l/RjVCslVo1BBKJWP7WwfVADOqnUU+MxMiRe8RAxA7+vVcx6+wn
         DsDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LEh7fVGWvU/5HBux9fy5ggYR5c2tR/qXQyYFAMPclI0=;
        b=fmVcRCuVdnxCli6eGpjl1fNBgs8d+hf90ihif0sXOuaB6uMCfTtcnpF3YqoDV/9XG0
         oWsUwtZTZqaOQHtYwTIhi/IY98x6MseRmb7kVZRSPXLnGBmo4UMfv2hFxI2pG3IKGNKF
         IUPHtlTAnhBZCBxrxrf+QCeisLyi0Bb2jzw2P5ZtubWGeWQcSvDLkDEWM650F/lAc1bW
         ws7tHz8k8ljFyzBNZKxNXuFwXu6YCljd51fz99vbOrsk0XvSlgxT+1pWxoSvHsczg8f1
         Qge+WH9f2ospRSIPFwRJOhsK/APRlhEpN4Y1z6OaB3nAhYiK8VQOk89KTC81Mv8ZDZ1h
         EgJw==
X-Gm-Message-State: ABuFfohEUmSX5fmmH254Bge10RhqzclxnfbjvcoHJmraxDXI04agIBEc
        p6durKhvRn82t+t2GF/sof/yA6dL
X-Google-Smtp-Source: ACcGV6217GFXnnXftdKVGo3qOdPGiZo1Z+kHcnd8vRVNM8ViNLCvO+n7tgsCsFk/CQFEmTLBmP4qMQ==
X-Received: by 2002:a17:906:9450:: with SMTP id z16-v6mr13070779ejx.201.1538780416748;
        Fri, 05 Oct 2018 16:00:16 -0700 (PDT)
Received: from piling.lan (80-71-134-83.u.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id v49-v6sm2808711edm.6.2018.10.05.16.00.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Oct 2018 16:00:15 -0700 (PDT)
From:   Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
To:     Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        jacopo@jmondi.org
Cc:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: [PATCH v11 3/3] [media] imx214: Fix range for V4L2_CID_EXPOSURE
Date:   Sat,  6 Oct 2018 01:00:14 +0200
Message-Id: <20181005230014.5952-1-ricardo.ribalda@gmail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Going above 3184 changes the frame-rate of the sensor. Without this
patch there is no way to change the exposure without affecting the
frame-rate.

With the proper documentation we should be able the change the
frame-rate at wish, but until that happens we just cap what the sensor
can do.

Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
 drivers/media/i2c/imx214.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/i2c/imx214.c b/drivers/media/i2c/imx214.c
index fe01a13f13c5..284b9b49ebde 100644
--- a/drivers/media/i2c/imx214.c
+++ b/drivers/media/i2c/imx214.c
@@ -1029,7 +1029,7 @@ static int imx214_probe(struct i2c_client *client)
 	 */
 	imx214->exposure = v4l2_ctrl_new_std(&imx214->ctrls, &imx214_ctrl_ops,
 					     V4L2_CID_EXPOSURE,
-					     0, 0xffff, 1, 0x0c70);
+					     0, 3184, 1, 0x0c70);
 
 	ret = imx214->ctrls.error;
 	if (ret) {
-- 
2.19.0

