Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80955C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 00:02:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B4C520874
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 00:02:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UvuWE7JY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbfACACk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 19:02:40 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46390 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727204AbfACACi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 19:02:38 -0500
Received: by mail-pl1-f195.google.com with SMTP id t13so15116105ply.13
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jan 2019 16:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qvGpSFvsCqzZseERB3T3u2tb8jVF4wW/MgWIXQNMIVk=;
        b=UvuWE7JYujcbQg8Q6cQ1/RLkl5EezdI3Of1cQv21SLRpaQxyOLVMjlVYQOFYGhPIAr
         DVejTCjSEoZ7vIWMJQMxjP6Avft1ZPFnqQo1gADfBoQ71vIfXZ62BiNvPx5XNhuAnP45
         HlNbC4ZC9Du1Pisi5RKUN8wo2pS489xBgvpJU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qvGpSFvsCqzZseERB3T3u2tb8jVF4wW/MgWIXQNMIVk=;
        b=DiN+9oqVBqH7I0J6GTUgeGGvfhbxLf8CWLOTP9ubfybdm9bhEpeWLWpWFIBFWMQy4w
         FpswklJ3TZW432gJ/GT9vxSVzoGSVBifWYJQ7eSO6j4XRTguLWwQ/5+AJik2SOPMPr9F
         Sz+CctYzdoBKywNIuLeIDvDhGWYyBjdCVu5fae2cRoiKiwraG7wPVEMOOY+AqX54DE4Y
         oU5Hget10RDv/QCgUqJ1MkqfaEG66AogGEeX9oPNIQPXXMZIAwk9tWlQLeotZv69vIWt
         iVpUlWLA6vFLHCSlSRhSlWBhMJjlEIZXocPFT2KC+GwJpv19ocepfEd0COamVFD59I/8
         Xetw==
X-Gm-Message-State: AJcUukeKp0tTm9DcO+roIA36yatRAlbGkNzwEY3zMrSRekTSwSXLwHA1
        69k5IbcSPiF7hcBfgYpjgU6H8A==
X-Google-Smtp-Source: ALg8bN7mdBxCjdkX0G2u8OuINYxJcWasDEVQsvDwhnr3+YYhZLN9P2Tlv7je2kX3McLmLxdoarwoTA==
X-Received: by 2002:a17:902:f20b:: with SMTP id gn11mr43437149plb.274.1546473757673;
        Wed, 02 Jan 2019 16:02:37 -0800 (PST)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:ffda:7716:9afc:1301])
        by smtp.gmail.com with ESMTPSA id u6sm60291199pgr.79.2019.01.02.16.02.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 02 Jan 2019 16:02:37 -0800 (PST)
From:   Evan Green <evgreen@chromium.org>
To:     Andy Gross <andy.gross@linaro.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Brian Norris <briannorris@chromium.org>,
        Ben Chan <benchan@chromium.org>,
        Evan Green <evgreen@chromium.org>,
        linux-arm-msm@vger.kernel.org,
        David Brown <david.brown@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] soc: qcom: rmtfs-mem: Make sysfs attributes world-readable
Date:   Wed,  2 Jan 2019 16:02:13 -0800
Message-Id: <20190103000213.230652-3-evgreen@chromium.org>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20190103000213.230652-1-evgreen@chromium.org>
References: <20190103000213.230652-1-evgreen@chromium.org>
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
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes in v3: None
Changes in v2: None

 drivers/soc/qcom/rmtfs_mem.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/qcom/rmtfs_mem.c b/drivers/soc/qcom/rmtfs_mem.c
index b2fa8fc8016c0..7200d762a9510 100644
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

