Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5489DC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 22:23:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29AA521916
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 22:23:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbfBHWX4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 17:23:56 -0500
Received: from smtp4-g21.free.fr ([212.27.42.4]:40342 "EHLO smtp4-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726788AbfBHWX4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 17:23:56 -0500
Received: from [192.168.1.42] (unknown [77.207.133.132])
        (Authenticated sender: marc.w.gonzalez)
        by smtp4-g21.free.fr (Postfix) with ESMTPSA id EAC4519F58A;
        Fri,  8 Feb 2019 23:23:18 +0100 (CET)
Subject: [PATCH v4 1/7] dt-bindings: ufs: Fix the compatible string definition
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
To:     MSM <linux-arm-msm@vger.kernel.org>,
        SCSI <linux-scsi@vger.kernel.org>
Cc:     Jeffrey Hugo <jhugo@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Pedro Sousa <pedrom.sousa@synopsys.com>,
        Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham <kishon@ti.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Martin Petersen <martin.petersen@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <09ce9c20-c47b-f936-a8a9-6c8ec8f0f867@free.fr>
Message-ID: <be362056-2a34-f2fd-0495-1bc7524c67a5@free.fr>
Date:   Fri, 8 Feb 2019 23:11:00 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Firefox/52.0 SeaMonkey/2.49.4
MIME-Version: 1.0
In-Reply-To: <09ce9c20-c47b-f936-a8a9-6c8ec8f0f867@free.fr>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Douglas Anderson <dianders@chromium.org>

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
Reviewed-by: Vivek Gautam <vivek.gautam@codeaurora.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/ufs/ufshcd-pltfrm.txt       | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt b/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt
index 8cf59452c675..5111e9130bc3 100644
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
2.17.1
