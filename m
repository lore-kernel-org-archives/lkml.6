Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F3C7C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 23:26:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BFE1218AC
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 23:26:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZRWrc1MW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390150AbfBMX0U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 18:26:20 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39405 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389298AbfBMX0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 18:26:18 -0500
Received: by mail-pl1-f196.google.com with SMTP id 101so1979761pld.6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 15:26:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zVtYgVjd/xRzchJj83lLQZj8nZX16NvmAHavBWvuhDY=;
        b=ZRWrc1MWCe28Sf4cWnA4KkYW2AVIFLMTieUDT4B+cS52QenfIY3gKhtcFDpHwZS1na
         0oNq9FWPfgffRBHMNFwb8xjNdB39YvuZ1D/jKrB1v79DbpsWkuUynY6/8q3LWVEah5NN
         0gm+I9E1BXopN8kZZoGLwS7LtupMKUcptj1ss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zVtYgVjd/xRzchJj83lLQZj8nZX16NvmAHavBWvuhDY=;
        b=F5brmtv/W8hJT4ZsXfrZUgdP7ccBtIAugG+gKKeXWNjkhjP2q7IwdXfRAELVOHZCCv
         lTLqu6ga8BBFns3CrL1CRT8XG+4fAl2AiCwkAu42CSEhBI2uMAzgyUtqgeSQx4xCseng
         koIU2BpmOS9wU+AgUVE34VRFV4KXu7CseXQIzN3v2KMlJdYEUgP9nwmtYi3VF5Ey23SK
         v7DHgZdtonPQf5obU9PKduReGlXQsT/M6WUamue/8CZu1lBHf07lURpl54pZjvjqB+Q3
         GnWLIQ3+O5K5f9Asp8lxXeq1+WVJuIsuGHaWDengBULfD8sNn3uEPZddCZB2gUz3wOBU
         AaVA==
X-Gm-Message-State: AHQUAubcf2gWLp0mbbvKLOGLo8nwmrICHJOglORgW8dUR36Mwb0alr6r
        jSyFbKzGDUGyKOIMu+WOVb4HHw==
X-Google-Smtp-Source: AHgI3IZJoQOlHjdGf+UsBpTh6Gif7TXeZK7nMMGs8WkyFT4Kf0Obam1yseqPmfZ5ISVKGYWQ+pIb7g==
X-Received: by 2002:a17:902:9a03:: with SMTP id v3mr734284plp.187.1550100378255;
        Wed, 13 Feb 2019 15:26:18 -0800 (PST)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:ffda:7716:9afc:1301])
        by smtp.gmail.com with ESMTPSA id d129sm560660pfc.31.2019.02.13.15.26.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Feb 2019 15:26:17 -0800 (PST)
From:   Evan Green <evgreen@chromium.org>
To:     Andy Gross <andy.gross@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Can Guo <cang@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Evan Green <evgreen@chromium.org>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        liwei <liwei213@huawei.com>, linux-kernel@vger.kernel.org,
        Subhash Jadavani <subhashj@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v4 1/8] dt-bindings: ufs: Add #reset-cells for Qualcomm controllers
Date:   Wed, 13 Feb 2019 15:25:19 -0800
Message-Id: <20190213232526.26995-2-evgreen@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190213232526.26995-1-evgreen@chromium.org>
References: <20190213232526.26995-1-evgreen@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable Qualcomm UFS controllers to expose the PHY reset via a reset
controller.

Signed-off-by: Evan Green <evgreen@chromium.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>

---

Changes in v4: None
Changes in v3: None
Changes in v2: None

 Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt b/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt
index 8cf59452c675..e2460b666ae4 100644
--- a/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt
+++ b/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt
@@ -47,6 +47,8 @@ Optional properties:
 -lanes-per-direction	: number of lanes available per direction - either 1 or 2.
 			  Note that it is assume same number of lanes is used both
 			  directions at once. If not specified, default is 2 lanes per direction.
+- #reset-cells		: Must be <1> for Qualcomm UFS controllers that expose
+			  PHY reset from the UFS controller.
 - resets            : reset node register
 - reset-names       : describe reset node register, the "rst" corresponds to reset the whole UFS IP.
 
@@ -76,4 +78,5 @@ Example:
 		reset-names = "rst";
 		phys = <&ufsphy1>;
 		phy-names = "ufsphy";
+		#reset-cells = <1>;
 	};
-- 
2.20.1

