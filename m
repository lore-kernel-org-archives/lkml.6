Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE650C64EB1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 17:52:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 819BE20838
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 17:52:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="CDG64jxc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 819BE20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726207AbeLGRwW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 12:52:22 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44290 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbeLGRwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 12:52:21 -0500
Received: by mail-pf1-f194.google.com with SMTP id u6so2267480pfh.11
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 09:52:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZLG0p6pOlEKJqG/ydnT1Alp81sx/m3rHMuhpQtuwbbQ=;
        b=CDG64jxcm0aKiEOo/CvP1uys/yXY2smXYvbDa0wDPtM8KyZzjnrpE98lu/weu2FH6H
         MwV/wzmSJuWzFMvVdd89RVDLduEi+Rlt7hzCAxh4V2PFzY3dnAoM6tIK5ZU+tJQAjGYV
         EzMakTWhCKQ7hwc9EM1KhNOp/rB1+UwEUF9fY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZLG0p6pOlEKJqG/ydnT1Alp81sx/m3rHMuhpQtuwbbQ=;
        b=f/U/p3XNajZiuiiZ+pLppCa+0/mjgnHJlTdK1+H5Rq67Hb3LRDwg2DSw5VXO1hOeLu
         Q4jkA/fLF464FtYkOVc4znxTio2lK7EiD0edI6Khj45TYw2ADBI2A4FaUe8Yl7Fu/Ro3
         HH96KjwtSQ8bKFihXcUpKEuajVmL6iaQpl+tSX6kIHiP2cBiwji9LhXJz+wrcMKmnV8M
         B0blqNRWS9CP9t+rhzoGN2SKjXSS7RLrwql89NztM/uRb9hYjvKVZnaayHkVc7i4TWS8
         VHNi2/bgTp/p3lzAO5OUBGyGuHuxVJh0rZkH9IT0hr7d5cuXwSducyHdw96vFrfoWlAx
         RTtQ==
X-Gm-Message-State: AA+aEWaOt6g/gCTKefzDKq8azVLAs/mxIZTYRV6DYE2i4K+JQFOVTAPR
        hMuijQbBWfQ5baoXo6GmsbpM
X-Google-Smtp-Source: AFSGD/VzMNVLNw2VZZmWenDDUu43Zs75mxhPnrEjxhbOhafCsKCgmkJ2hvoGrzoXDAy7oNYg7sPrMg==
X-Received: by 2002:aa7:824f:: with SMTP id e15mr2487484pfn.192.1544205141034;
        Fri, 07 Dec 2018 09:52:21 -0800 (PST)
Received: from localhost.localdomain ([2405:204:7207:e9c8:7189:c4b2:429f:42db])
        by smtp.gmail.com with ESMTPSA id k191sm4611387pgd.9.2018.12.07.09.52.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Dec 2018 09:52:20 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     vinholikatti@gmail.com, jejb@linux.vnet.ibm.com,
        martin.petersen@oracle.com, liwei213@huawei.com, robh+dt@kernel.org
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        john.stultz@linaro.org, amit.kucheria@linaro.org,
        guodong.xu@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 2/3] arm64: dts: hisilicon: hi3670: Add UFS controller support
Date:   Fri,  7 Dec 2018 23:21:50 +0530
Message-Id: <20181207175151.8969-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181207175151.8969-1-manivannan.sadhasivam@linaro.org>
References: <20181207175151.8969-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add UFS controller support for HiSilicon HI3670 SoC.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/hisilicon/hi3670.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3670.dtsi b/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
index 6ccdf5040ffd..285219dd657f 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
@@ -654,6 +654,24 @@
 			clock-names = "apb_pclk";
 		};
 
+		/* UFS */
+		ufs: ufs@ff3c0000 {
+			compatible = "hisilicon,hi3670-ufs", "jedec,ufs-2.1";
+			/* 0: HCI standard */
+			/* 1: UFS SYS CTRL */
+			reg = <0x0 0xff3c0000 0x0 0x1000>,
+				<0x0 0xff3e0000 0x0 0x1000>;
+			interrupt-parent = <&gic>;
+			interrupts = <GIC_SPI 278 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&crg_ctrl HI3670_CLK_GATE_UFSIO_REF>,
+				<&crg_ctrl HI3670_CLK_GATE_UFS_SUBSYS>;
+			clock-names = "ref_clk", "phy_clk";
+			freq-table-hz = <0 0>, <0 0>;
+			/* offset: 0x84; bit: 12 */
+			resets = <&crg_rst 0x84 12>;
+			reset-names = "rst";
+		};
+
 		/* SD */
 		dwmmc1: dwmmc1@ff37f000 {
 			compatible = "hisilicon,hi3670-dw-mshc";
-- 
2.17.1

