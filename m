Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11DBAC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 00:09:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3CCA214C6
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 00:09:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GPIOEmkU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbeLRAJJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 19:09:09 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45677 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbeLRAJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 19:09:08 -0500
Received: by mail-pl1-f193.google.com with SMTP id a14so6895264plm.12
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 16:09:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CS3SSpVEoM1vQfMSMjWaDpR3zqnEl7pcEwBAFTqfrTg=;
        b=GPIOEmkULv0u3soaT0ebmmE/N7cgdEYFBVgtrTs2MG+IAkvWzh4Pbxqjkn01Nxzk97
         WwgX1ZbLTF/b3sy2sS6g2asTdJKx3Ca2lCQCrMc+yH/rkbkTs48pUu8Eo3TzrYO7W8r9
         0gGxvbOK10iCDQm90HKPNwtVndkIlxEf8/WW0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CS3SSpVEoM1vQfMSMjWaDpR3zqnEl7pcEwBAFTqfrTg=;
        b=VfOUG3bj9vH1wk7PwTb4vHY2LwlzqfzEXVDZ6HizSLB96J1RtgRhhDD//bO6l4meOJ
         T4/BZMtmA0xrCqazvSPJFxVzekqF9Vqf8xgFDBvPhTX36uiqqVBBlqAD7qQb7ZAll8Rf
         QWeBGLv79xCemescmaOAT8rMf8AwuNlvNJPcNwkYmoeYplvSzaB7peEV+KOmAMyM/pfK
         4dRPKQfacIxo5cq3J29/Bhy8hr1/MeJJ/gvipQ89VJblPLyuActk+pV09b+il3CGRDqH
         7bD7SUP//j4ocQO4pATYUkDUz3+GeFwI0AFsgKP8XIvu6mb5CX+cAHZ+GBssWEKaGIrh
         56ag==
X-Gm-Message-State: AA+aEWZTgXlXopcJ8p3yZHmMGQlkmerE/ZcAdAYlprxWT1TVv8LYsI5K
        3z9uHlYEZTZOJDCP1BuK78rMEA==
X-Google-Smtp-Source: AFSGD/XIQyKORhz9aSBPljWI4z0N+86LPw71SOkmnmGzbWsi8qz5OMu0cGlmcpFpJyO9PCQGv/BEcQ==
X-Received: by 2002:a17:902:1126:: with SMTP id d35mr13514187pla.1.1545091747813;
        Mon, 17 Dec 2018 16:09:07 -0800 (PST)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:ffda:7716:9afc:1301])
        by smtp.gmail.com with ESMTPSA id m65sm21734424pfg.180.2018.12.17.16.09.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 17 Dec 2018 16:09:07 -0800 (PST)
From:   Evan Green <evgreen@chromium.org>
To:     Andy Gross <andy.gross@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Brian Norris <briannorris@chromium.org>,
        Ben Chan <benchan@chromium.org>,
        Evan Green <evgreen@chromium.org>,
        linux-arm-msm@vger.kernel.org,
        David Brown <david.brown@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/2] soc: qcom: rmtfs-mem: Make sysfs attributes world-readable
Date:   Mon, 17 Dec 2018 16:08:34 -0800
Message-Id: <20181218000834.201748-3-evgreen@chromium.org>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20181218000834.201748-1-evgreen@chromium.org>
References: <20181218000834.201748-1-evgreen@chromium.org>
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
---

 drivers/soc/qcom/rmtfs_mem.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/qcom/rmtfs_mem.c b/drivers/soc/qcom/rmtfs_mem.c
index 0bf800ee2a978..4eeb9f02e7889 100644
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

