Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32790C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 22:12:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE5792184C
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 22:12:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JC2LKH6b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbfAWWMG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 17:12:06 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43418 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbfAWWME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 17:12:04 -0500
Received: by mail-pf1-f194.google.com with SMTP id w73so1867363pfk.10
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 14:12:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QnBy3yFqLwRX55WY/zVdCOpm+/+wmQpglkGG4K9iWAk=;
        b=JC2LKH6bgY/tersTa9GmDGjmtc3MQzAiSCLBE4pWPCmurqPXT+MXVDkzuRODzqCD+m
         /gREHqEs30sFQ4E4ozamLuas3Lirbca6RlVG5nh38+sS+Apn0NkmBapRfTTX2Abb8l9z
         X+lPkWyIy0mFQyAUryrMCbOHS5jUwR4f8NeKE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QnBy3yFqLwRX55WY/zVdCOpm+/+wmQpglkGG4K9iWAk=;
        b=Py6ZQxCsbxA5smrjI0pDa/6Hs9jWMKL5LX7uh9UVFTCBwQyHIq1CBWqUN9/PxYOgXR
         D7x5d+ArDAXwOB/cbMpbypfsb5/8O3gJP/F3ZMTqFNPgtFmiKYXCn4OVbCU/1JJBy7pQ
         7+bx9uvJv1rw2RD2WCHDPfSwholuD9Ea8Mlrt2kANCYsss59AYtk3lbLLeHV7aLvKT0m
         M+FSrt/XlHpUNmkz2QXqA5P2ONk+s5cqnFPWpx3GFx85LoXOJNenPgZ5dhwaFKsVvx37
         Htb/VHr6sYVo58tPKZ2Ozd6f1mFOFE/NjRxUkJO2lLmGgKqLp3gdy/Zj/yaZlAmdaWQP
         23Zw==
X-Gm-Message-State: AJcUukflP7zF6xoV8zihX/DcHztv0ADE5fh56ow0YKAYWLpPRzqJMEWV
        r8c2ztNQIRPDUBQmweksEeWsuw==
X-Google-Smtp-Source: ALg8bN776wtxE68uoxKfmS+B3PdjVJDjmggLUklOUYvAwvjGD48uEEADg4TZR1SIe0IaELhQRdjUQg==
X-Received: by 2002:a62:4e16:: with SMTP id c22mr3760419pfb.167.1548281523456;
        Wed, 23 Jan 2019 14:12:03 -0800 (PST)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:ffda:7716:9afc:1301])
        by smtp.gmail.com with ESMTPSA id d18sm27927943pfj.47.2019.01.23.14.12.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 23 Jan 2019 14:12:02 -0800 (PST)
From:   Evan Green <evgreen@chromium.org>
To:     Andy Gross <andy.gross@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Can Guo <cang@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Evan Green <evgreen@chromium.org>, devicetree@vger.kernel.org,
        liwei <liwei213@huawei.com>, linux-kernel@vger.kernel.org,
        Subhash Jadavani <subhashj@codeaurora.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 1/9] dt-bindings: ufs: Add #reset-cells for Qualcomm controllers
Date:   Wed, 23 Jan 2019 14:11:29 -0800
Message-Id: <20190123221137.41722-2-evgreen@chromium.org>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20190123221137.41722-1-evgreen@chromium.org>
References: <20190123221137.41722-1-evgreen@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable Qualcomm UFS controllers to expose the PHY reset via a reset
controller.

Signed-off-by: Evan Green <evgreen@chromium.org>

---
Fixing up this aspect of it made me notice that this patch [1]
hasn't landed yet. It really ought to.

[1] https://lore.kernel.org/lkml/20181012213926.253765-1-dianders@chromium.org/T/#u

Changes in v2: None

 Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt b/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt
index 8cf59452c6756..e2460b666ae45 100644
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
2.18.1

