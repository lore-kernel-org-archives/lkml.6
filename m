Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E085DC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 20:10:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A733D21929
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 20:10:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CWEbq7GP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391867AbeLUUK1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 15:10:27 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45806 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391854AbeLUUKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 15:10:24 -0500
Received: by mail-pf1-f194.google.com with SMTP id g62so3059843pfd.12
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 12:10:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TkQMS53u/0Pk1o6GD7eFKUQxD9ITUcTLmDsH4Ut9q0s=;
        b=CWEbq7GPWlwQ6iMgiHrhv3oxoSL4rtrKFfFP20c1/fSCEWVOZyoL6ew/vRpDLfZ6Vo
         Y/8G6dBql63+Xkf10aan42bRfUkR9RA8BabXmeHM3J/e/ftiOXIMJTl2f0zB952ofVbE
         S2BF1PNSVhcso+VlmW0ePiusNbMNAOmOnHFAE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TkQMS53u/0Pk1o6GD7eFKUQxD9ITUcTLmDsH4Ut9q0s=;
        b=PLXc0GVPCTkG/WH58UhgORRI63bKFOKcqBbFrTJ2wyEZC30r73B2qxONRMqDqme/kp
         aE9ea+jCKYKjrxs8QCbTHBwmjAavy4xW/nPdIhVIFkhe9ZwlbfnAyt/kIPno7zBlsIlB
         qIJ670BhSs4E7jKPEdG8eDT3WA6hs22AS4nA9fVW7xFDD61TSX1++rkL+hUAUlvPCJIs
         mO/dN/eI4u7nlK+MOqPPwvBBFcnnm940STfQrOgDxsZkQndVDsDVPC5MDtkPgU0JQcDf
         oP5ykRZw+Htzf2XHAsFUSfVTzyTTou3NyROxAYMeoV95RVGo3aINwmKs/+P/eIQ+VD/4
         rRGQ==
X-Gm-Message-State: AJcUukeI5/damnz7Ipvdb8ZVhXCLT5mds3cLuBnFtH5Cd4KBZYYhWMKH
        KLAMOCwzSuVt2sALyvjIb5pBGA==
X-Google-Smtp-Source: ALg8bN47i/VJhy6I/FBlTwf8bZAeg76QMXPRhxZHtwOZxCK0X+gbf9d0bVWsaSQ4ZWqAkwwFv/f+eg==
X-Received: by 2002:a63:9809:: with SMTP id q9mr3723532pgd.109.1545423024160;
        Fri, 21 Dec 2018 12:10:24 -0800 (PST)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:ffda:7716:9afc:1301])
        by smtp.gmail.com with ESMTPSA id o1sm35300406pgn.63.2018.12.21.12.10.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 21 Dec 2018 12:10:23 -0800 (PST)
From:   Evan Green <evgreen@chromium.org>
To:     Andy Gross <andy.gross@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Brian Norris <briannorris@chromium.org>,
        Ben Chan <benchan@chromium.org>,
        Evan Green <evgreen@chromium.org>,
        linux-arm-msm@vger.kernel.org,
        David Brown <david.brown@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] soc: qcom: rmtfs-mem: Make sysfs attributes world-readable
Date:   Fri, 21 Dec 2018 12:10:01 -0800
Message-Id: <20181221201001.160613-3-evgreen@chromium.org>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20181221201001.160613-1-evgreen@chromium.org>
References: <20181221201001.160613-1-evgreen@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to run an rmtfs daemon as an unprivileged user, that user would
need access to the phys_addr and size sysfs attributes. Sharing these
attributes with unprivileged users doesn't really leak anything
sensitive, since if you have access to physical memory, the jig is
up anyway.

Make those attributes readable by all.

Signed-off-by: Evan Green <evgreen@chromium.org>
Reviewed-by: Brian Norris <briannorris@chromium.org>
---

Changes in v2: None

 drivers/soc/qcom/rmtfs_mem.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/qcom/rmtfs_mem.c b/drivers/soc/qcom/rmtfs_mem.c
index 99a1363ece254..815c11aeceb93 100644
--- a/drivers/soc/qcom/rmtfs_mem.c
+++ b/drivers/soc/qcom/rmtfs_mem.c
@@ -45,9 +45,9 @@ static ssize_t qcom_rmtfs_mem_show(struct device *dev,
 			      struct device_attribute *attr,
 			      char *buf);
 
-static DEVICE_ATTR(phys_addr, 0400, qcom_rmtfs_mem_show, NULL);
-static DEVICE_ATTR(size, 0400, qcom_rmtfs_mem_show, NULL);
-static DEVICE_ATTR(client_id, 0400, qcom_rmtfs_mem_show, NULL);
+static DEVICE_ATTR(phys_addr, 0444, qcom_rmtfs_mem_show, NULL);
+static DEVICE_ATTR(size, 0444, qcom_rmtfs_mem_show, NULL);
+static DEVICE_ATTR(client_id, 0444, qcom_rmtfs_mem_show, NULL);
 
 static ssize_t qcom_rmtfs_mem_show(struct device *dev,
 			      struct device_attribute *attr,
-- 
2.18.1

