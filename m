Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63A5EC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 09:05:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1798D20877
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 09:05:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ewS1y75l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1798D20877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728927AbeIYPLa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 11:11:30 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39806 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727550AbeIYPL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 11:11:29 -0400
Received: by mail-wr1-f68.google.com with SMTP id s14-v6so22457168wrw.6
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 02:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xaKoq2Z5i+AH80JWe8GKSoRR6ISgaXZtO2Gfftl5H7k=;
        b=ewS1y75l1+/fHRqN/ts2a8WT3bknw2zaVcpHBeb2sONr4psMZ1KR2jC/1E204J2bpL
         S/QO/x51Ws1NGos9hHrjUx4/n0dJa3KuNN6u68uOALxcth+qHAPDFFfKN19QejfUDfn0
         L6QMSU13bwzIrbYBsKJFjqM1OQ01k67v/XA8o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xaKoq2Z5i+AH80JWe8GKSoRR6ISgaXZtO2Gfftl5H7k=;
        b=OMm2WqwMQj+XipulWS2umt0uO5WAHzgcNb+p1IhgflLQgqpzQmQesXEBP2OtcvyIsG
         ZyfZVk77FenUHm4nGo+ifmvN4qaxKu6mn5j/+7ISgnWfUW0tXBz+cCGDBFHLaPWWMsmX
         7WHV/EBCQUDNA1Sxs5SKbxGAlgOZiz3WYAWTvKN2kb+AfQrVgLRUUBTqavKIAB61Hnom
         W5FuBP8ctzCrcpPe5zjJISW1pCIn4IhW02hrgmMrLdtLPtAbx7JsNpUt1s/Q1EBkitQC
         Cc2BcrZTgfsde5ownN55/d8qrbEUrGeTrFUfaU7rFQqNzZpRrxpddRIJLFO9FaSdJBam
         lCzA==
X-Gm-Message-State: ABuFfoiYt9kMJ27rAfmvDacIim2e/waMNHfxM2JyWfX5aaCR0MGEH22F
        /yvUjEHr+WCmW51VbtsGW/12ig==
X-Google-Smtp-Source: ACcGV60DSO+4ufxrVn78qtJyKBJTRYz+N5GtL2nJ+l2UzA0ZVfx8IWyPHlvtx9l7kCRbqF7xM4YsVw==
X-Received: by 2002:adf:a599:: with SMTP id g25-v6mr90065wrc.88.1537866295905;
        Tue, 25 Sep 2018 02:04:55 -0700 (PDT)
Received: from localhost.localdomain (251.150.136.77.rev.sfr.net. [77.136.150.251])
        by smtp.gmail.com with ESMTPSA id y206-v6sm1523828wmg.14.2018.09.25.02.04.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 25 Sep 2018 02:04:55 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     edubezval@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        daniel.lezcano@linaro.org, leo.yan@linaro.org,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 12/14] thermal/drivers/hisi: Add more sensors channel
Date:   Tue, 25 Sep 2018 11:03:10 +0200
Message-Id: <1537866192-12320-13-git-send-email-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1537866192-12320-1-git-send-email-daniel.lezcano@linaro.org>
References: <1537866192-12320-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the sensor channels id for the little, g3d and modem.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/hisi_thermal.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_thermal.c
index 87d8a13..ba89cb9 100644
--- a/drivers/thermal/hisi_thermal.c
+++ b/drivers/thermal/hisi_thermal.c
@@ -56,7 +56,12 @@
 #define HI3660_TEMP_LAG			(4000)
 
 #define HI6220_CLUSTER0_SENSOR		2
+#define HI6220_CLUSTER1_SENSOR		1
+
+#define HI3660_LITTLE_SENSOR		0
 #define HI3660_BIG_SENSOR		1
+#define HI3660_G3D_SENSOR		2
+#define HI3660_MODEM_SENSOR		3
 
 struct hisi_thermal_data;
 
-- 
2.7.4

