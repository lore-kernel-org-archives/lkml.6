Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECB23C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 11:38:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B34BD2089F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 11:38:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CdBHya0x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727161AbfAGLio (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 06:38:44 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39156 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726893AbfAGLio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 06:38:44 -0500
Received: by mail-pl1-f196.google.com with SMTP id 101so24310pld.6
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 03:38:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ePJe8cVSRqtlaGA7V9EgMDTzK24IvCXYylFk83HfJes=;
        b=CdBHya0xIV2o7rasb5t+gJ++qxMpDpd9XQOHA4HVSq2yhLq1m3OKjDgFWqproXlg2B
         57Dozefo2H/3agSacTurbXzfemDjZSNVS27uIumyFWd/OSpyPcq/YLbutddlsan4dOgf
         A88dn/pmXnqA3BNlDUmkhps6E4PBlyiSLxS/w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ePJe8cVSRqtlaGA7V9EgMDTzK24IvCXYylFk83HfJes=;
        b=BLGUz3fSgZEP7r2acq7ZlHz6xsHYcCx4CSJlzlvujale9BWPrGKb76C/UG084gps5H
         Lds8uaCBoV34ePxh27H30rRiJue5DAL2rRt/IGNtAHeWkEyDWBtgZydh6Yf+rIV+Pojv
         RqR9QfShqACJMoAQ6M5a0pIlxOmgT1uUflt2hfh0FcTPd839cpGpw1CmkFdScZe+zqDa
         mwZC4nMyBVtlJDkmUmMcG9jJCqgX6cPa05GFsWEj8IvWrA+MRhwEv54w2qjKv761oMEk
         M5d1Go3Tahxr7BZffCWLuGchjywhMaUblxnlEpJTnyGjMlBXuKLL5iiwu14ssCB+hU2O
         JBNA==
X-Gm-Message-State: AJcUukcSyNheHCkotZ3hMVnHgEjPUnFKGgzJ+lYFpJUxD4wFpn0ebxZq
        VVmwk5spdaiBbDh2s1VVPEGDwA==
X-Google-Smtp-Source: ALg8bN4X15OWjP5RmXnsZlO2WWFXs1xpmK/dF6kMe3mQa8vwxbBbhyx7nPAgh/ASeVp2+Mf4V9P9kA==
X-Received: by 2002:a17:902:20b:: with SMTP id 11mr61093325plc.57.1546861123595;
        Mon, 07 Jan 2019 03:38:43 -0800 (PST)
Received: from pihsun-z840.tpe.corp.google.com ([2401:fa00:1:10:7889:7a43:f899:134c])
        by smtp.googlemail.com with ESMTPSA id m3sm109338783pff.173.2019.01.07.03.38.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 03:38:42 -0800 (PST)
From:   Pi-Hsun Shih <pihsun@chromium.org>
Cc:     Pi-Hsun Shih <pihsun@chromium.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-remoteproc@vger.kernel.org (open list:REMOTE PROCESSOR MESSAGING
        (RPMSG) SUBSYSTEM), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] rpmsg: core: Make remove handler for rpmsg driver optional.
Date:   Mon,  7 Jan 2019 19:38:32 +0800
Message-Id: <20190107113833.243672-1-pihsun@chromium.org>
X-Mailer: git-send-email 2.20.1.97.g81188d93c3-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most other bus (for example, SPI, i2c) have the remove handler for
driver optional. Make remove handler for rpmsg driver optional too.

Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>
---
 drivers/rpmsg/rpmsg_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
index 8122807db38094..ea88fd4e2a6ecf 100644
--- a/drivers/rpmsg/rpmsg_core.c
+++ b/drivers/rpmsg/rpmsg_core.c
@@ -493,7 +493,8 @@ static int rpmsg_dev_remove(struct device *dev)
 	if (rpdev->ops->announce_destroy)
 		err = rpdev->ops->announce_destroy(rpdev);
 
-	rpdrv->remove(rpdev);
+	if (rpdrv->remove)
+		rpdrv->remove(rpdev);
 
 	dev_pm_domain_detach(dev, true);
 
-- 
2.20.1.97.g81188d93c3-goog

