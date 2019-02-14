Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BC3DC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 02:11:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF25D21902
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 02:11:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R3lYUvOz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393989AbfBNCLb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 21:11:31 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:43567 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403926AbfBNCKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 21:10:39 -0500
Received: by mail-qt1-f194.google.com with SMTP id y4so5162994qtc.10
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 18:10:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WeFsULKehq8jGUkRqP49XwEy/ibmR7uFLb5YfBUBkPg=;
        b=R3lYUvOzi0+V8DbmxPIDUt1Dx4wG26aUxaGi4hDa/1pCCNVDrIONxfIgRzxE9Fpe3g
         DWgiPypw8lWYvB/vI7+5a1+CpsDxeOGtZInC8/JXrtr3sWx5Z6PThtz1jsIptgrnlfXg
         XqSo6pLz582sgBt85uVU/bmxPCLCU5682nsFQ182bIGROLIl+00I6pxEU2w2kpFOEcY/
         t5dc3c98u93YJbs2c9PQkAYPxVGx9/atVR6lt5sxJk11Yg12vsY+ndWehKQ7ndsRa4US
         /4/angB3m+fL2vTcIBlbfH2a9nMggpk2lIfSXo81L7KwIpJV9d4mkeQYFk1pWuBaD6yg
         S4RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WeFsULKehq8jGUkRqP49XwEy/ibmR7uFLb5YfBUBkPg=;
        b=P38T8zz84KjwxuW7IioOAWgX7U/NO9gtcXMct0Kyt9Ia9WVDuHDwcIvsY+0VFNzcNg
         4ijEj/zTwYM1m10uVDgIrqCBu0pV26NGHjURF2JHAMn0QK1HNzYS0XgInEzhmUHqTuTU
         Y2xD+Z0aUy9mkZc9cd5ikremBeq95rYdZ5K3055fBrRgb+AvP+JHCGTiKgMVw09R4UJE
         VzQj9wwuiEVIh89MOpqNkKiAIYVsKBVkJG+RvjGCw0a00dcCRY4XCHfM11wo++RiKrkk
         mC5XL7ne5k2LAu1oWUZVpj6iXGCkKE1b5rXFU5IbGrwlRTLlKt5L28IuOJsUryvdnH7Z
         jrug==
X-Gm-Message-State: AHQUAubJjaN/pi8fNOFZTn1adPdoq/cZINixiauSKjQ/nwG2LH045nqh
        H1QmqFClqykJ0hMEMSBL7fcaRA==
X-Google-Smtp-Source: AHgI3IY0+/3ScFqLVlOcwskHRQBCj3PjT9tL4yL6mLIQg/nPNZAA90sQvyyiFsfhmamPojLVrpuF4Q==
X-Received: by 2002:ac8:2de4:: with SMTP id q33mr1050917qta.358.1550110238505;
        Wed, 13 Feb 2019 18:10:38 -0800 (PST)
Received: from localhost.localdomain (pool-72-71-243-63.cncdnh.fast00.myfairpoint.net. [72.71.243.63])
        by smtp.googlemail.com with ESMTPSA id d63sm1091575qka.22.2019.02.13.18.10.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 18:10:37 -0800 (PST)
From:   David Long <dave.long@linaro.org>
To:     stable@vger.kernel.org,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Tony Lindgren <tony@atomide.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Will Deacon <will.deacon@arm.com>, Mark Brown <broonie@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4.14 V2 10/17] ARM: 8810/1: vfp: Fix wrong assignement to ufp_exc
Date:   Wed, 13 Feb 2019 21:10:15 -0500
Message-Id: <20190214021022.5313-11-dave.long@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190214021022.5313-1-dave.long@linaro.org>
References: <20190214021022.5313-1-dave.long@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Julien Thierry <julien.thierry@arm.com>

Commit 5df7a99bdd0de4a0480320264c44c04543c29d5a upstream.

In vfp_preserve_user_clear_hwstate, ufp_exc->fpinst2 gets assigned to
itself. It should actually be hwstate->fpinst2 that gets assigned to the
ufp_exc field.

Fixes commit 3aa2df6ec2ca6bc143a65351cca4266d03a8bc41 ("ARM: 8791/1:
vfp: use __copy_to_user() when saving VFP state").

Reported-by: David Binderman <dcb314@hotmail.com>
Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: David A. Long <dave.long@linaro.org>
---
 arch/arm/vfp/vfpmodule.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/vfp/vfpmodule.c b/arch/arm/vfp/vfpmodule.c
index 6bacd69c9e81..8e11223d32a1 100644
--- a/arch/arm/vfp/vfpmodule.c
+++ b/arch/arm/vfp/vfpmodule.c
@@ -579,7 +579,7 @@ int vfp_preserve_user_clear_hwstate(struct user_vfp *ufp,
 	 */
 	ufp_exc->fpexc = hwstate->fpexc;
 	ufp_exc->fpinst = hwstate->fpinst;
-	ufp_exc->fpinst2 = ufp_exc->fpinst2;
+	ufp_exc->fpinst2 = hwstate->fpinst2;
 
 	/* Ensure that VFP is disabled. */
 	vfp_flush_hwstate(thread);
-- 
2.17.1

