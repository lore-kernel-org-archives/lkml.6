Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 940FDC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 08:20:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4339F2075E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 08:20:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="fT+5tDC6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4339F2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937497AbeFSIU4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 04:20:56 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:56018 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937361AbeFSIUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 04:20:08 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20180619082006euoutp015faabc82bdfc9ed3cc7c240216ef6e87~5ge2ccjFL0236902369euoutp01G;
        Tue, 19 Jun 2018 08:20:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180619082006euoutp015faabc82bdfc9ed3cc7c240216ef6e87~5ge2ccjFL0236902369euoutp01G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1529396406;
        bh=WAGeyVXjCfhIxhXHuAU/fQIrwqGl53gpMDpYdOvaSX4=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=fT+5tDC6H3fgxmAgmDzN2JPISGCUsKQeQgyc1wGDWdaM4T+AAyUbjDGgTB3nci7Qk
         Jw3VKX+WFuy4EpY7UJKlrTo2PN+eXtih8naYu9ExozHI4NMASSZ1O9Qoby3JBFXmwd
         HPgAwyP8k2A7dSlDeBOoMJT+rusa0vSj3cuQ9i6c=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180619082005eucas1p26100ce80ff2ee207aba2c96d8a60c2b2~5ge1ji6Ut2285022850eucas1p2f;
        Tue, 19 Jun 2018 08:20:05 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 4D.88.10409.4BCB82B5; Tue, 19
        Jun 2018 09:20:04 +0100 (BST)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180619082004eucas1p25ccebb3286e978645e3e09ebb8cb65f2~5ge0yPC5L2076520765eucas1p2b;
        Tue, 19 Jun 2018 08:20:04 +0000 (GMT)
X-AuditID: cbfec7f5-b45ff700000028a9-e8-5b28bcb4b3d9
Received: from eusync4.samsung.com ( [203.254.199.214]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id D9.E3.04183.4BCB82B5; Tue, 19
        Jun 2018 09:20:04 +0100 (BST)
Received: from AMDC2075.DIGITAL.local ([106.120.51.25]) by
        eusync4.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
        (built May  5 2014)) with ESMTPA id <0PAK00EJ59T2RV00@eusync4.samsung.com>;
        Tue, 19 Jun 2018 09:20:04 +0100 (BST)
From:   Maciej Purski <m.purski@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Cc:     David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Inki Dae <inki.dae@samsung.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Maciej Purski <m.purski@samsung.com>
Subject: [PATCH v3 9/9] ARM: dts: exynos5250-arndale: add DSI and panel
 nodes
Date:   Tue, 19 Jun 2018 10:19:30 +0200
Message-id: <1529396370-18761-10-git-send-email-m.purski@samsung.com>
X-Mailer: git-send-email 2.7.4
In-reply-to: <1529396370-18761-1-git-send-email-m.purski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzVSeUhTcRzvt/fe3nO1fE3NXxYSo3BIadHBr4NIMHogdCEkWtorH9OaU/bU
        ssBUMjfNIyXv1MKr4ZHzSM0U1JoiOcdM01haBt5FmaUU2eb0v8/1veBLYRIN4UKFKiM5lZJV
        SIUivOnNsmFvQ5ssYF9p/R40WtNPoNT+XgFKUM8TqC63lkDF3RZtcPGbEGWOZeBo6qMRR+kT
        sxgyGJ6T6G3CHIk0D0tJpJsYIpCptVCIcg3tAlQyPYqj6m4zicqGjQKU+KqbRLlZ00K03FqE
        n3RiqoqqAGNKSxUwLflmkilQ5xGMTqsRMi9+jRPMWIpewNSX3mXSGrSAWdC5nhP5i44Hc4rQ
        aE7leeKKKKTvQQcW0eJwa2ppHI8DtfbJwI6C9EHYm/mVSAYiSkJXAphUPYzbyAKAmqeD5Hqq
        TPtaaDPKAXyZs7RGViypkS5LCUUJaXdYlRRk1R1pLYD17+eBlWD0IwIOFM8S1lYO9Flo7Pi+
        inF6N1xu/IRZsZg+BY0/6gjbOFc40q9Z1e0sev7j3wJrI0ink3CuoHJtJ28431O9hh3gjL5h
        De+ApqwU3IbvwGfTFbitOA7An2YTZjOOwS69cXUaRm+GmU05mPUESIuh+r7EFmFgnnmAtJ2Z
        C+CHoWQ8A2wrARu0wJmL4sPkHH9Ayd304NkwPkop97gWHqYDlgfp+6dfbAbtf692ApoC0k1i
        Wa1bgIRgo/mYsE4AKUzqKG4skwVIxMFszG1OFR6kilJwfCfYTuFSZ3GgLNZfQsvZSO4Gx0Vw
        qnVXQNm5xIHmkj9OvpdSDPERR+omuxUNFZN9sRPlCxVDjga3FarHyVs3seLn1DvOn6+ZaWuz
        89/q2O4bKy/duSsplGjaWRL4ZayvyvOw5NC9xnihQp01KMvr3xJpSrrM2g8HZBeCtDifxCez
        2Ue99Ite8xsrfJoC/d6xbmeUF09ntanl1z9fkOJ8CLvfHVPx7H8EHDtjHAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCLMWRmVeSWpSXmKPExsVy+t/xa7pb9mhEG7Rs47a4te4cq0XvuZNM
        Fk0db1ktNs5Yz2ox/whQ7MrX92wWk+5PYLF4ce8ii0X/49fMFufPb2C3ONv0ht2ic+ISdotN
        j6+xWlzeNYfNYsb5fUwWC17eYrFYe+Quu8XS6xeZLFr3HmG3mDH5JZvFz13zWBxEPdbMW8Po
        cbmvl8lj56y77B6zO2ayemxa1cnmsf3bA1aP+93HmTw2L6n36NuyitHj8ya5AK4oLpuU1JzM
        stQifbsErozTPfuZC3YKV7z48YClgXE9fxcjJ4eEgInE0lVH2boYuTiEBJYwSsxd9I4ZJCEk
        0MgkMeVidBcjBwebgJbEmvZ4kBoRgVWMElP/3mEHcZgFZrNKvHo0gRGkSFjAV+JHAxNIL4uA
        qsTPrQ/B5vAKuEpc/LSRFWKZnMTNc51gcU6g+Ky535kgdrlIvFh9hWkCI88CRoZVjCKppcW5
        6bnFRnrFibnFpXnpesn5uZsYgWG/7djPLTsYu94FH2IU4GBU4uFt2KgeLcSaWFZcmXuIUYKD
        WUmEd+tSjWgh3pTEyqrUovz4otKc1OJDjNIcLErivOcNKqOEBNITS1KzU1MLUotgskwcnFIN
        jG5VBlMm/vA+ktnSrHjo+d4gl8fO3xW9/9z8n+fw8yMb+5Ef/+9MfbqIOftK2rNMtz/W7+R1
        lm91CbQqLuN1n/Tuw/Nr1pFcn3rNVXlMyny8lnNZJB/yWS9c/eymS9QkawnzLTqW558ZiTyI
        rrXUWWJ+166ycWLlDdMrv80a3/98fZvD/THvMSWW4oxEQy3mouJEAN8Vb6V3AgAA
X-CMS-MailID: 20180619082004eucas1p25ccebb3286e978645e3e09ebb8cb65f2
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180619082004eucas1p25ccebb3286e978645e3e09ebb8cb65f2
References: <1529396370-18761-1-git-send-email-m.purski@samsung.com>
        <CGME20180619082004eucas1p25ccebb3286e978645e3e09ebb8cb65f2@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrzej Hajda <a.hajda@samsung.com>

The patch adds bridge and panel nodes.
It adds also DSI properties specific for arndale board and
regulators required by the bridge.

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
Signed-off-by: Maciej Purski <m.purski@samsung.com>
---
 arch/arm/boot/dts/exynos5250-arndale.dts | 61 ++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5250-arndale.dts b/arch/arm/boot/dts/exynos5250-arndale.dts
index 7a8a5c5..816d89d 100644
--- a/arch/arm/boot/dts/exynos5250-arndale.dts
+++ b/arch/arm/boot/dts/exynos5250-arndale.dts
@@ -71,6 +71,17 @@
 		};
 	};
 
+	panel: panel {
+		compatible = "boe,hv070wsa-100";
+		power-supply = <&vcc_3v3_reg>;
+		enable-gpios = <&gpd1 3 GPIO_ACTIVE_HIGH>;
+		port {
+			panel_ep: endpoint {
+				remote-endpoint = <&bridge_out_ep>;
+			};
+		};
+	};
+
 	regulators {
 		compatible = "simple-bus";
 		#address-cells = <1>;
@@ -97,6 +108,30 @@
 			reg = <2>;
 			regulator-name = "hdmi-en";
 		};
+
+		vcc_1v2_reg: regulator@3 {
+			compatible = "regulator-fixed";
+			reg = <3>;
+			regulator-name = "VCC_1V2";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+		};
+
+		vcc_1v8_reg: regulator@4 {
+			compatible = "regulator-fixed";
+			reg = <4>;
+			regulator-name = "VCC_1V8";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+
+		vcc_3v3_reg: regulator@5 {
+			compatible = "regulator-fixed";
+			reg = <5>;
+			regulator-name = "VCC_3V3";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+		};
 	};
 
 	fixed-rate-clocks {
@@ -119,6 +154,32 @@
 	cpu0-supply = <&buck2_reg>;
 };
 
+&dsi_0 {
+	vddcore-supply = <&ldo8_reg>;
+	vddio-supply = <&ldo10_reg>;
+	samsung,pll-clock-frequency = <24000000>;
+	samsung,burst-clock-frequency = <320000000>;
+	samsung,esc-clock-frequency = <10000000>;
+	status = "okay";
+
+	bridge@0 {
+		reg = <0>;
+		compatible = "toshiba,tc358764";
+		vddc-supply = <&vcc_1v2_reg>;
+		vddio-supply = <&vcc_1v8_reg>;
+		vddlvds-supply = <&vcc_3v3_reg>;
+		reset-gpios = <&gpd1 6 GPIO_ACTIVE_LOW>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		port@1 {
+			reg = <1>;
+			bridge_out_ep: endpoint {
+				remote-endpoint = <&panel_ep>;
+			};
+		};
+	};
+};
+
 &dp {
 	status = "okay";
 	samsung,color-space = <0>;
-- 
2.7.4

