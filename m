Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C08DEC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 09:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6348B214DD
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 09:19:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="U79PE6Iw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6348B214DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ysoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731160AbeISO4K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 10:56:10 -0400
Received: from mail-eopbgr30087.outbound.protection.outlook.com ([40.107.3.87]:52824
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730863AbeISO4H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 10:56:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SugdsQJCy9ufICdfFHxCAsXirR948j3vi9iZcCuwFSw=;
 b=U79PE6IwNLMAC5/RPsGDe8lyasbkI3YX8K7Tuitq6PGLNwoPzRmsJRmzISWNTcYeKSiM9lSIV7/WhnJ+54vr26F7JuxzEShdl9LZXuCpFTP2LV2MPR2bXxiufZOD7d2w/oYCMq/n4oADoqqW+ufyq6v5HeAmWPqiYF6TYr6TW1Y=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Michal.Vokac@ysoft.com; 
Received: from iota-build.ysoft.local (89.24.100.190) by
 AM0PR04MB4658.eurprd04.prod.outlook.com (2603:10a6:208:75::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.18; Wed, 19 Sep 2018 09:19:02 +0000
From:   =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Fabio Estevam <fabio.estevam@nxp.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
Subject: [PATCH 2/2] video: ssd1307fb: Do not hard code active-low reset sequence
Date:   Wed, 19 Sep 2018 11:18:44 +0200
Message-Id: <1537348724-22976-2-git-send-email-michal.vokac@ysoft.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1537348724-22976-1-git-send-email-michal.vokac@ysoft.com>
References: <1537348724-22976-1-git-send-email-michal.vokac@ysoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [89.24.100.190]
X-ClientProxiedBy: VI1PR03CA0067.eurprd03.prod.outlook.com
 (2603:10a6:803:50::38) To AM0PR04MB4658.eurprd04.prod.outlook.com
 (2603:10a6:208:75::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 993a2ca1-0ae6-4d41-49e3-08d61e10f0b2
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4658;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4658;3:UPxWmmP4c6PZtYayMsD2WQxt+bVsamMtKE6wlw7Vrudix1YVL35QV/OYxZBL9ZAOaLJn0WJr/RnHZqzho0124RTyjAws2Klmx+Lg9IZNhwEJ9NL2UWVKt4Z3xy5BaMhyzftzj4/eHMJwxQ4ieKdR/GoxA81ESEy6p+QMP4mb6hCDPXTfYWosTmPqphU6mtgahO+2e/cXnO5eAXjmcoJt56H6pjLwQNAluHLuHb15SujF1jI25OCQBey8IYhCDiaF;25:k8rHdLN/TlkC/G0CFvLTkkmOzaQr32vwRFhyBI+xwYZYQQZOz2ILc2bDx+H1E9uiqWgTj2c2nrrNfYHc1NurAS5gDcu2bvDz5y/da4TRohLjGT0WahOxr2SkM1tFnOQ6xcjc2mEjgjURdRyLJO+hFNSd89favDICwCNrf/Di2tYxt4o5OlbsaF+l9Eqv0BhO34xYZvhU1pmXYf94gL3eis5s4O78u3Cb7rufDi+a38bU88l/toDD6fTBbKPMOsnwQq8vWn8Nu3R25yRX2X/wxJjuOz+lMtxPdsz357yZ0kHcpDyXHw0ZPdZ7Yu8AjFMbH6kYTp78W1OZ/CKCptuGjg==;31:ToKYHngSdt0ZWWuezAZUGEZIK1TRYJH9Bs1Q3G3v3hH+ndeT6U3o3+bv/JYwZsfIAEr462fwh7/XtESjMtcZK3xiLTka62mh2whxae/rv3DsM/hG63mayVYZ0hFiX3wcbniXie1lZe6pHQXfmrFCGaKBBHSmIWwnF3CWs3Txw/fDnYG8DP7XHxoI+9NrtP1oK1BUOFA+RJo8Ac616j6zjnw6ZDvUm96BANw5s6l2AhA=
X-MS-TrafficTypeDiagnostic: AM0PR04MB4658:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4658;20:oipSOv6v36eTl/jHbkhruwWE4SrRg90MKDbvxyk/eFvbjjtZKqytd5Sig+0QvVQNTUDCaT62fi4LTvITt5Bsjhsy7mpY1Tmgy9jnty5uKHZ7gPyiBTOzw1rm/F5F53RC/dw/rG06U8RLubtaZPCA5tjR16KVoEUsv8jdcEdLvZK+zqnjHgkP3ZBaSnCSlb9U8euamJ4Pd4OrgqMf/F8jOETxIdtgNiY+z2zGC1jUuR7J8Gof+ehrND4dAyd601ig;4:D/IsaVJwq71DcVdiTENtOh9qbB6d7KNjlKmZxkKETslf/P4I2iuW/TfXu/jaxoAAU28mKXkFG0WivsUyb+uSr5+mRlBcPS9iK0vwP9BkWfysanUgW/NoeuCHRcT2qURkHZY8pJnkrAW6tBQTkBE7uxuYxmAO1J5jIQbeGnCnM0szElUK9nfqM0uMCwk6l4OBZMemZDDq0yvBpICmTkJemQVdsPJ/eAJNuY9GuOeqGPYNlblu6M6a+6nrWFT94lACIExuXsrYs9Bj1oZcwzHpRg==
X-Microsoft-Antispam-PRVS: <AM0PR04MB46583312EC4DC4EA3565E0709E1C0@AM0PR04MB4658.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231355)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(201708071742011)(7699050);SRVR:AM0PR04MB4658;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4658;
X-Forefront-PRVS: 0800C0C167
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(346002)(136003)(396003)(376002)(39850400004)(189003)(199004)(66066001)(110136005)(50226002)(476003)(486006)(68736007)(23676004)(446003)(956004)(72206003)(2616005)(26005)(11346002)(6512007)(6486002)(53936002)(54906003)(2906002)(186003)(81156014)(81166006)(6666003)(2870700001)(8676002)(7736002)(107886003)(6506007)(386003)(105586002)(36756003)(47776003)(16526019)(5660300001)(305945005)(316002)(86362001)(3846002)(50466002)(478600001)(52116002)(76176011)(97736004)(25786009)(106356001)(4326008)(8936002)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4658;H:iota-build.ysoft.local;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: ysoft.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTBQUjA0TUI0NjU4OzIzOkEvckI4ME5zaFIvalluZzEzYllzcXZ3QnBK?=
 =?utf-8?B?TS8yZWFtQ1RkNnk3eTVIMTMxZVhHUkxiR09pRU1DVHlWNWI2dnY0a2VIN2pG?=
 =?utf-8?B?OHAwMGttMXVaTlBQR0tsZGRjMnY0MHcyelpia1Q0cWgwemlQaVBhUGNoWVUr?=
 =?utf-8?B?NWxhaCt4VW5EeXJpQi9vclFyVWYwS1BUYVo0MmlMUVg4bUN5VTA1Z1VHN1g1?=
 =?utf-8?B?UkJTVy91azUwcncvcDNaaFpJVC85blFBTGU0OFBURjUwUk5aeVNSZWczeGgr?=
 =?utf-8?B?NDVFRjQxY1RqK0hWa21RelZvNEljUGUrUmMvQXJnRDdqdjd1Sm55ZEtFTW9W?=
 =?utf-8?B?S1ZwOU96Ry9OeTgvRFYvMUhJQ0ptNlJXdE04azhzRi9iV0E1dDBiZHNLNjJ4?=
 =?utf-8?B?UGl5Rm40QXV1NU5oRSthZmhQdDFWSVBVd3M1ek5sbTdSVUlDcFB1L0Z0aUw2?=
 =?utf-8?B?SFc2NEtQL2VyYmJ1Z1hhSmRRU1I0a1lUTklhN2lpcjE3OVE2TURZM1hVYzY5?=
 =?utf-8?B?ZjQwYVpMS2MvTFRMd1RiTEpXd2VXbWQvWmY1dXY4dmtrUTNmU0hKNVFQZXRr?=
 =?utf-8?B?eDRtb0NVMzJ0MUVHYjZuMUY1ME43T1lvNnBTeUlhTnpFSThRWDczc0hmY0VD?=
 =?utf-8?B?WWFjY1FwVUZmQWlWeGhld2hJMmNBNno1YzNzZVlWS09sYVhQZEM5YnhMYWkz?=
 =?utf-8?B?UVBpeUplVjJNdmlscnJNS0R4NEpHcHcydzJFSzkwSzBDMzlobUMxK3RCNjhi?=
 =?utf-8?B?QVUvUDJxcERjeWVNNkxBSldsYk8vNnhNQ29JQmRXWjA5amZmVHBLLy81VXky?=
 =?utf-8?B?eGRZeklxajFOSHRUMWd2Y0M0S28zLzk4VjRZTXIwbGlwN0wzR1FvcWs1Z1pv?=
 =?utf-8?B?b1hLMXF1c2lTb0VBM3JETkFzR3pPTHlSUGQ3eHEyZWtoVVdXSmh6ZXZLR2FZ?=
 =?utf-8?B?Q0RmVGpldXI3TnhrSGU3Uk8wMUVnVEE2KzNBK1IwUFpCbUJNVkpXRk5IcXNT?=
 =?utf-8?B?eWJiOWowWE9kWitFakZYb3craklVZzV1Nk1pTVBpZWpMQ01zYThTMzhlMU5V?=
 =?utf-8?B?WTlEeFBhcUVDZTRpMnhPN1l3ZnhyYVdqVVN4MnVPaEtkNmVUcDFqcXRkZ3Fs?=
 =?utf-8?B?L3I4MCtadHh0aHRDczRsdlVTRTZUWFZGdVF1Wk5uZ1ZDMkZZcUJJNU5ROXdt?=
 =?utf-8?B?U1V1Yks4bEZtUStrcFc2eDJLYkhGdkNFcHBBb1RJWGN6K3UydE5lOE9pWVZ0?=
 =?utf-8?B?OTMwZ2dMMTFOTmU2YVZsTllJNEgrQUJhcUw4YjN6bDVFbm9CblFVdkVUN3lQ?=
 =?utf-8?B?Wk1yNzgxb3pMaHJ2b2FyeVVaTEdSUlJmVFc1dCtjQnpQMnVtbzVHdU1oUFFl?=
 =?utf-8?B?RVptVkJMUFBDMERCNTFiTE5YaGl1aHJYbnp5bm1tc3pDTzJ1NXppb1o5OVFT?=
 =?utf-8?B?a2VwR1pZZ05NVGIxUnJEaXJUYnlPUk9GbzdNd3NWOXBpQ3kwcVZVb2pNcVIz?=
 =?utf-8?B?eHNsY1RuY2krdlBvTjFKcFd2UnMzNEwvZC9wTTFpM1hDMVROYmVxc08xMTNw?=
 =?utf-8?B?NUlFd011QXJ2eFlFYldBc212V3h0c2wydjFOWG5lamNOcVRkMVJPK3ZGcy90?=
 =?utf-8?B?ZlFQbmNQd0RCemRGMzdXVEpNTXlJQUNJa29sbjFtb0pCenQ3MmlxT1h3PT0=?=
X-Microsoft-Antispam-Message-Info: E4THhC/Vg+RJIF13xKjNKLij82vLatAru+KSjo1DUklbtB9tRBguu3/rBTssKTBPKZiGea4jdZJE4Nikj2nZr4h+Bh/gNL7IW2jjaMGjFqzst8oSHt3hrgggTJUhUVmk+jSoZ3HlV1SUjtFfVErmC8V5uHeWKXDigWGIAXM7vIWq+dGTraUcd1Y0gUF3OPn+UyUCFfJRY1U7Y2wlvcI/kcWkWKAuVl9R1SJb23i4wv8qNUCvu5LSy+InlhNhA+26qYN6ndPmaIDugjPDnEuW9s06Rj/9QVBboxb79kpCEmgrcyur/3/qXJpQGismP2mSF+mIgISP/S3MmBZHnZqkR2dY8GkJOnckLVD2RG4pgRY=
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4658;6:38D+93xR+PsqOAb6N187ITTqgqT/PdMuGp6LL9mAk67YkR7Lg5C8pgAZYh4pMMJeFKaSYW7Rm58BhcrtYkJwIWn4yr1Oy7jk2gkULiHDZVa9DzNgb2TuqSQmz9cBMDq62MHp/gu+t7Wt1MHZTDx9qaJArL6NyVkDyW7Wgt+8hDOVPQLIvIQnQ5HkoRgVOP8vhYY/1LgitCIp5YuABNYH0LdFZ8nxkvx3SR2bXGepmZMSKGMEsZdqQBzmwdaBKuMNz0zUc590dmqKZOYHNWAGYR8/ipB/TyEgL4lqj+dKKmEh3Wd5R/whn8dDoVKUnGoz2M8x7XyB7wk3zeA/AR6ebkMOO7ILXnuLMToSOc1Ida6AluuIJ5FIKKrcKPMQG292ZzABqWqoWs++aqJ1ZALzu3LrQLKidRMdTa0tVmoM42+b6cyIbPl3EVsZPB2xasmOsYORBGqMXbKc1IN3EA20dA==;5:/exaBvQoSz363leCg6kd12dMGLwDvbO2165g/NDKNjrrihPi2yMW1iiLGu/S+umVrjqr/MMnoiZaPQUs1Y6aN/7F69qmrTbBzWJSmpjn7UszGqBwYOApgV9l8wfuVq2ZDKiHWSo8fMM8UlLaM07BjkVawh8+/VWKjIbzYlfk0ps=;7:qqiyVY9+KaR33WcAEiRvjGSajNTHFM2KQtm02oIwppjKezJmSQAAwaOTHTkooiDwU+6fpX/gS2vEqfVkJ+csWMwZTi7KEjp2GamkSGw9s9BGccUKMLDoDtJwsxdwWIl25ptU89cQxbAtqi7+M7V9rK2Kb4tSYOCTwDRSMZjCSVY7ruAjdWvmJm7Sn+Ic/gJ0uVUycFJN2c1cCH2Ml3C6BglGKGPSmE5iU4z8C8+ksmgo6LgIswWzJMOH0uHDjdOv
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: ysoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2018 09:19:02.1811 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 993a2ca1-0ae6-4d41-49e3-08d61e10f0b2
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b5839965-430f-4be2-b282-d7a3149f2b37
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4658
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SSD130x OLED display reset signal is active low. Now the reset
sequence is implemented in such a way that users are forced to
define reset-gpios as GPIO_ACTIVE_HIGH in DT to make the reset work.

Do not hard code the active-low sequence into the driver but instead
allow the user to specify the gpio as GPIO_ACTIVE_LOW to reflect
the real world.

The only single in-tree user of the display is converted and builds
fine.

Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
---
I am not really sure wheater this should be in one commit or the DT
changes should be done in separate commit. Just tell me and I will
split/merge the changes as you want. Thanks.

 arch/arm/boot/dts/imx28-cfa10036.dts | 3 ++-
 drivers/video/fbdev/ssd1307fb.c      | 4 ++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/imx28-cfa10036.dts b/arch/arm/boot/dts/imx28-cfa10036.dts
index e54f5ab..be3406e 100644
--- a/arch/arm/boot/dts/imx28-cfa10036.dts
+++ b/arch/arm/boot/dts/imx28-cfa10036.dts
@@ -11,6 +11,7 @@
 
 /dts-v1/;
 #include "imx28.dtsi"
+#include <dt-bindings/gpio/gpio.h>
 
 / {
 	model = "Crystalfontz CFA-10036 Board";
@@ -95,7 +96,7 @@
 					pinctrl-names = "default";
 					pinctrl-0 = <&ssd1306_cfa10036>;
 					reg = <0x3c>;
-					reset-gpios = <&gpio2 7 0>;
+					reset-gpios = <&gpio2 7 GPIO_ACTIVE_LOW>;
 					solomon,height = <32>;
 					solomon,width = <128>;
 					solomon,page-offset = <0>;
diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd1307fb.c
index e7ae135..7b5bc42 100644
--- a/drivers/video/fbdev/ssd1307fb.c
+++ b/drivers/video/fbdev/ssd1307fb.c
@@ -728,10 +728,10 @@ static int ssd1307fb_probe(struct i2c_client *client,
 
 	if (par->reset) {
 		/* Reset the screen */
-		gpiod_set_value_cansleep(par->reset, 0);
-		udelay(4);
 		gpiod_set_value_cansleep(par->reset, 1);
 		udelay(4);
+		gpiod_set_value_cansleep(par->reset, 0);
+		udelay(4);
 	}
 
 	if (par->vbat_reg) {
-- 
2.1.4

