Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BBBEC6787C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 21:39:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DAA12098A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 21:39:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZOGAsLOd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DAA12098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726077AbeJMFN6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 01:13:58 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36852 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbeJMFN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 01:13:57 -0400
Received: by mail-pl1-f194.google.com with SMTP id y11-v6so6494951plt.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 14:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Vk5Yg+7wL+R/Po/ZLnSQfaZxah1u4gswNcqEQ2U4fwE=;
        b=ZOGAsLOdWRdec+6+BxtR4qnFuh/9HAlhGNJ/UXm01Rg34UByKT89clW7wfYxsw6GWZ
         DvT3ADfE0o0r9KvyskhQBdZhQbFwAUnj0N8JGlpSXGnbg4aIY8UGpG+CPv38rBVqki8S
         O9UuNV5nqQQm6uag6/QmYi17a213idm7WAvZU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Vk5Yg+7wL+R/Po/ZLnSQfaZxah1u4gswNcqEQ2U4fwE=;
        b=H1HCj56gsFydJ+4Y4OBh5hK/PkEkGJBnH2lA3w/th8JG88hrYV0xyiOjibqzdGl6X2
         JCpBiCm6WIPMGyXJ9TYYmkDj4Lya5ZZS8qUp5vGoqav70FxvMDleLLLyQMPWYrfKzd7H
         kJLMfbmG9/o1DTUj3Oag9AlQmCRWoVPU/BDkkyqJElnB85sSlHDLBGFj/A9s/xHvV3P+
         C+0Lw60q8w/VWJgkMAT842z8vq6OTn8FpOQ48sGztF505YHUHrLE3QqgAANT/CRsS9Dz
         581pW4348LWeviEElz92hxQnHZBIyggy9bXdHKHYEfqHPEqDrnXhv7HYjBeC+x33LM1U
         DwyA==
X-Gm-Message-State: ABuFfojKMev5TPiFcuj8wchnp8Q7JdOD0KI8d5Xm7WorBgWSgHhpuQTk
        i8DLlb7xNiV9CwcJI1h3NqOs/g==
X-Google-Smtp-Source: ACcGV60sW6zrW3Md3QoribPXFDoX/nvfj55hLHuTKkbb6/KOkyac71CrrxPxhfnzKosD9T1JZRJ5mw==
X-Received: by 2002:a17:902:854c:: with SMTP id d12-v6mr7407991plo.313.1539380372112;
        Fri, 12 Oct 2018 14:39:32 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:c8e0:70d7:4be7:a36])
        by smtp.gmail.com with ESMTPSA id g88-v6sm3975672pfd.181.2018.10.12.14.39.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Oct 2018 14:39:31 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Rob Herring <robh+dt@kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     Can Guo <cang@codeaurora.org>, evgreen@chromium.org,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, sayalil@codeaurora.org,
        asutoshd@codeaurora.org, Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, liwei <liwei213@huawei.com>,
        linux-kernel@vger.kernel.org, Mathieu Malaterre <malat@debian.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH] dt-bindings: ufs: Fix the compatible string definition
Date:   Fri, 12 Oct 2018 14:39:26 -0700
Message-Id: <20181012213926.253765-1-dianders@chromium.org>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If you look at the bindings for the UFS Host Controller it says:

- compatible: must contain "jedec,ufs-1.1" or "jedec,ufs-2.0", may
              also list one or more of the following:
                 "qcom,msm8994-ufshc"
                 "qcom,msm8996-ufshc"
                 "qcom,ufshc"

My reading of that is that it's fine to just have either of these:
1. "qcom,msm8996-ufshc", "jedec,ufs-2.0"
2. "qcom,ufshc", "jedec,ufs-2.0"

As far as I can tell neither of the above is actually a good idea.

For #1 it turns out that the driver currently only keys off the
compatible string "qcom,ufshc" so it won't actually probe.

For #2 the driver won't probe but it's not a good idea to keep the SoC
name out of the compatible string.

Let's update the compatible string to make it really explicit.  We'll
include a nod to the existing driver and the old binding and say that
we should always include the "qcom,ufshc" string in addition to the
SoC compatible string.

While we're at it we'll also include another example SoC known to have
UFS: sdm845.

Fixes: 47555a5c8a11 ("scsi: ufs: make the UFS variant a platform device")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 .../devicetree/bindings/ufs/ufshcd-pltfrm.txt       | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt b/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt
index 2df00524bd21..69a06a1b732e 100644
--- a/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt
+++ b/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt
@@ -4,11 +4,14 @@ UFSHC nodes are defined to describe on-chip UFS host controllers.
 Each UFS controller instance should have its own node.
 
 Required properties:
-- compatible		: must contain "jedec,ufs-1.1" or "jedec,ufs-2.0", may
-			  also list one or more of the following:
-					  "qcom,msm8994-ufshc"
-					  "qcom,msm8996-ufshc"
-					  "qcom,ufshc"
+- compatible		: must contain "jedec,ufs-1.1" or "jedec,ufs-2.0"
+
+			  For Qualcomm SoCs must contain, as below, an
+			  SoC-specific compatible along with "qcom,ufshc" and
+			  the appropriate jedec string:
+			    "qcom,msm8994-ufshc", "qcom,ufshc", "jedec,ufs-2.0"
+			    "qcom,msm8996-ufshc", "qcom,ufshc", "jedec,ufs-2.0"
+			    "qcom,sdm845-ufshc", "qcom,ufshc", "jedec,ufs-2.0"
 - interrupts        : <interrupt mapping for UFS host controller IRQ>
 - reg               : <registers mapping>
 
-- 
2.19.0.605.g01d371f741-goog

