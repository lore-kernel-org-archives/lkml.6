Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4A46C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 13:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4FFE20657
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 13:46:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WYgKve76"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbfANNqD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 08:46:03 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38791 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726470AbfANNp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 08:45:58 -0500
Received: by mail-wm1-f67.google.com with SMTP id m22so8937025wml.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 05:45:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wcq/BZjA1FXBmfYxzVF9/4lLVBugXEKEif9lDq84KTU=;
        b=WYgKve76AQapL96P//w9NBFMjzVpCPuV8TxBk81O+FXe5c9IK/zBEFrQmR4S2O09UR
         6OqbSicCV3seQTILK21YiaU4XHBsbTV82pUDQjCB5AObNHnfxuBde8YbBvoZBhRgVhnw
         xberplgt88Z4je80I8tlQZ7v7o2XE7iOFxMTY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wcq/BZjA1FXBmfYxzVF9/4lLVBugXEKEif9lDq84KTU=;
        b=pdDRiwDwBuut8K2MuUqcMCKXxSWg0wqJDJFVyU02iOE/NzqE9iTBwelzaIvEWJpQ3W
         XGiWvSf3bUxZCHeCsFZa8W29KFINpkvLrWRMoY4q3PvBb4RA3YpmJ7YvAXbq0Cys2IKg
         z1TRKqPc+TUAcx+MxuWmWtrNOrj7xi83r3BATg3QvsvwKyM0d7IzjxZZ/EQ+lhQDLvuK
         CltWLapra5kW5CpSe4QPaWNLRSaoBRTmwVORDvblA4nR9UzMcXBioFqNPt2MKnijKFIs
         I3C7G0uRvvkJilerMI5o/NulAcS7rr+OwkuHu0XONkbXFxXDxzTnZz63NXhZfzrT8i/0
         yyzg==
X-Gm-Message-State: AJcUukd3jK52rER5ffrykAn8WJW/lNQFs5fEFMqdMdazuOcNWPn6aqwp
        LNU6gdgFOxO3/RDveR7YUOugNw==
X-Google-Smtp-Source: ALg8bN64kMU4Zn8sj96BtI9KdISTw1k7FD7k6jTQSUEXSzZQv0Ihl1I4aNOOo+S0/qTxrawQKPLjhA==
X-Received: by 2002:a1c:bdc5:: with SMTP id n188mr12588988wmf.69.1547473556520;
        Mon, 14 Jan 2019 05:45:56 -0800 (PST)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id x10sm86766472wrn.29.2019.01.14.05.45.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 14 Jan 2019 05:45:55 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        broonie@kernel.org, linux-arm-msm@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 2/4] slimbus: core: do not call device_status under a lock
Date:   Mon, 14 Jan 2019 13:44:47 +0000
Message-Id: <20190114134449.15367-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190114134449.15367-1-srinivas.kandagatla@linaro.org>
References: <20190114134449.15367-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Calling device_status callback under a lock would prevent drivers
to do any slimbus trasactions which would invoke this lock like
get_laddr(). Remove this unnecessary lock!

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/slimbus/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/slimbus/core.c b/drivers/slimbus/core.c
index 9e4f3b21ba8c..1ba08b5f2e78 100644
--- a/drivers/slimbus/core.c
+++ b/drivers/slimbus/core.c
@@ -466,6 +466,7 @@ static int slim_device_alloc_laddr(struct slim_device *sbdev,
 
 	sbdev->laddr = laddr;
 	sbdev->is_laddr_valid = true;
+	mutex_unlock(&ctrl->lock);
 
 	slim_device_update_status(sbdev, SLIM_DEVICE_STATUS_UP);
 
@@ -473,6 +474,8 @@ static int slim_device_alloc_laddr(struct slim_device *sbdev,
 		laddr, sbdev->e_addr.manf_id, sbdev->e_addr.prod_code,
 		sbdev->e_addr.dev_index, sbdev->e_addr.instance);
 
+	return 0;
+
 err:
 	mutex_unlock(&ctrl->lock);
 	return ret;
-- 
2.20.1

