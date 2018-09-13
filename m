Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 825A1C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 09:18:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2205C20882
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 09:18:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="poTs8v1m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2205C20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728073AbeIMO0p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 10:26:45 -0400
Received: from mail-eopbgr70074.outbound.protection.outlook.com ([40.107.7.74]:31552
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726509AbeIMO0o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 10:26:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hbBOAhrbqBzQM0KfAcDitE3AaP9j8N8Ylq+iXKGTDg4=;
 b=poTs8v1mPWMCSPXAv3PtnNIxfmPWaJrKuXSyuHXqXGr39CdkDqg8737sKjq3abdvqOstWNoMDgIONo8z0djZmGiqr513Mi2op78oitzHHMFE8L7wjCmmtCaTGz7zG36gldNv8cL54PJxJWVxdULTYPyAZY9qukfdso6iYB7EK64=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
Received: from anson-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 AM0PR0402MB3906.eurprd04.prod.outlook.com (2603:10a6:208:f::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1122.16; Thu, 13 Sep
 2018 09:17:49 +0000
From:   Anson Huang <Anson.Huang@nxp.com>
To:     rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] thermal: imx: handle error path in one place to save duplicated code
Date:   Thu, 13 Sep 2018 17:13:06 +0800
Message-Id: <1536829986-23702-2-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536829986-23702-1-git-send-email-Anson.Huang@nxp.com>
References: <1536829986-23702-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0PR03CA0090.apcprd03.prod.outlook.com
 (2603:1096:203:72::30) To AM0PR0402MB3906.eurprd04.prod.outlook.com
 (2603:10a6:208:f::26)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cda5ef4d-e1b3-4922-1faf-08d61959c7fc
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR0402MB3906;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR0402MB3906;3:wro+LL+4GIYUjg6owVzSjXbgJ33QV8HNEBSV2uA6AKVPN0cZmOLJFeKdNxGSidchQofgoFYs79OWAdDAovr2OoYj7SadI8YtoRARACnsGZTlUvIp9ABIgreH2rMyf/mo3/KujVrMthddPheFbrqy6UIsknrPMXNT/6sx0+K5q96NR4TLvcV1rAqoAEn/PPg+3ANyyfaUd3LVDvLLcs5gJgUqIWXZvRlmcW74PZZjq2H+qUjqrJGXq3bbMiKGYwpt;25:YgTXwOamC2mnXEUTkVxJfOtQKsOz3miKA13O9rzlYx2+JJmNHW+6G+cSG4lPRvWdsTNK3bqLhlxutgrWldoPWOXBySr5kIGLHm0pBbAcpMo4maAjVkzpGxI87ExS5mJj0nhdHHZkxWbJyhLhIO7vmq753Z8nANj9MVh/UoOnPLyBJGroVqpy79GT4buwLfT3ShVDxFXzcfSq9y6oXqxPzzcUUnJtaEE18fIc3dr9JVyzq9AyXddJMN0BX5NT0LuN+mDDVSO3EwVnha65v22CkNxEqltyEKEUMmIRpobpG+TADCuMKIeryefo/qArpZ/8TBhLj7GVKihpaNJ2ZgbZ4g==;31:MxNQfBdP1ZVnMrqXpxa2Hy+yO5Uq4FhldN5Y5TRwNytnoF3O8PaABWNhArByPLAAKnrYYnAKdfdSYOE09mSCTd++fUeSIJ2kQyWeUucewMLssE8NLZFpXI7WvtjJJ7hvZLMyB2lA6CaNzWt9H0Fp5PqFW+4JZ8LhqdejkVNWMK0xyHEEWHLsn2QLy9snJWQP8quaODYz9yieS6S9jKoWkEh8k/zg2ntgqsQ35gWV+WM=
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3906:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR0402MB3906;20:ebCxeUHb7fuKT90SFy8qU2KU1PqcbGcb8F6rsX3XhDkQuXZDXFRSk3GP6gu71nTcZnjrbzcyj1VBJO2Vev31olTOngQhTcbNf0TtBPTZZmjzx8Wq5F4BrIe9XDI5k0ArcCNqWm0+p11Og1sakHPhvrViJH0pyzrV4s1a/uZ8R/Og1O3FrD/VFI7sGy8Do6V8HKkpGenPQjVoScOmoXDWkV6rEVbf7zGiXpVyPonR9ZYevMi0LYAJLXoFRoIA0Ys9HaE/bfgg2DhVo0KNWmu5aWrPBqWhmi6ZtIgpGpWmxQ3wieJZFp9a7vo0I5gxSQO4Pzu0MyCMQIumXj59KKKJRfPtBA4xLMuq3jhOVBpruiPP295nuitqbXlSPv6zaCQkWBhCfV34V9lBJ00MTReNQAxKmD6Vn0W7ufz9xygpJql1b9sg5qmzRkcC4L+6+IeB7ru8IxkZpGOW70Hc+433uvYRZIMgt8jTSzdpuhd5eKgKudU2yNGv6/5+yqEFEOM/;4:YF0CEptcwMcQv7/biO1701mubC8BHEWEZvAzuWldC1X/pPatwfYZVYY5WbJuRIi8TLP1+5ecLsSMPDMEv3VgfIdHIHDi+HW7OgL7ObOJm6GVNcCKgkbMVlwaQv0u+403YvRgnrvcq0xUUUz++IGMNwB7Orb481EEIcWqC7r3fU3s+1GpJEth3XjAE09j+XzfUO2Y3br2SSqDNTsTu5cJb/1olpTYI+8LgYZWX8MAyPdoeKd3ZDHpfC6d62VoHgmr0lXGDOTRWWQJD2fZN5SbU8FkVogfEfRYmBASU0sjVqljQxuzHhqzeQGxEAvwwDHc
X-Microsoft-Antispam-PRVS: <AM0PR0402MB390688A75151692B8166B971F51A0@AM0PR0402MB3906.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050);SRVR:AM0PR0402MB3906;BCL:0;PCL:0;RULEID:;SRVR:AM0PR0402MB3906;
X-Forefront-PRVS: 07943272E1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(136003)(396003)(366004)(39860400002)(376002)(346002)(199004)(189003)(16586007)(2616005)(5660300001)(305945005)(316002)(7736002)(52116002)(106356001)(97736004)(6666003)(76176011)(2906002)(105586002)(51416003)(6512007)(8676002)(8936002)(50226002)(39060400002)(66066001)(186003)(36756003)(53936002)(81166006)(3846002)(478600001)(6116002)(47776003)(486006)(25786009)(14444005)(81156014)(386003)(6506007)(26005)(16526019)(68736007)(48376002)(6486002)(11346002)(476003)(956004)(446003)(50466002)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR0402MB3906;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM0PR0402MB3906;23:auWcr3OnYApnkqGgDvgbV9kLTe8hQ884okVEeXh?=
 =?us-ascii?Q?3XcrlDldIMvXBoyRiwD7XVEAxIhag/YWGqDc9wrbzbPKmdfiU9g+/TFEVazl?=
 =?us-ascii?Q?n8NrK3gyZjNHWGPlX1PUOrQ3kL/uKZIjpUh/DWgwKsqW8oNEjWXdUIh1YbMG?=
 =?us-ascii?Q?nAojGOcLUTJrbZ6MbhJHQxjCPxsOK/HPN/6llh9ZGblw+RfdQBzelD+Ma7CI?=
 =?us-ascii?Q?gCqaz9MSi1QapbQpA1eJl0YrJsJjJjdlqEToQUQFkbx47aoQUZ/HrxLlAYsD?=
 =?us-ascii?Q?C8IK3TsO7ETLQEHAa6YOEd0YF66sKC3kkWqeCWRUfiG+n6Hv7W93iGJdA35O?=
 =?us-ascii?Q?qenS8MeuHOs/7dySa2pbk+aN8lBjGq95fxg+QHcIu6yVc3FF4AWnuLdoMeKi?=
 =?us-ascii?Q?GMg8kc7DBcCxe08E94QVP+WkIQVLsn1N4cmkRt/tqBRqMe9B/Cvfe6L68gsY?=
 =?us-ascii?Q?DjIIL93UYsW/Cwy1w1cbv76VM28E4xZQ8mf+iyRQlIw/X33OMSfUi+zpKkf2?=
 =?us-ascii?Q?v8fxBOowxRZXtsV7fxAbXHJHiaaqAwGjCRgCxLkVoEw2kJHUWJLG6Reuer4P?=
 =?us-ascii?Q?boR86mULKxuET16lBIOWfqfnNJAlpRhL+jwnBVW0tR43fzu6MN7JSSqFs6ul?=
 =?us-ascii?Q?Jt4mL+L/emQqavaixnG8lR6IFq4KfEesUzircDJhnsSHzq+izSXS+qmJ9fwI?=
 =?us-ascii?Q?7vu41BdfExXLTSdVLb99dWd4Ha6ynnYFnWqJ5J+PEywLQ9KvsPdGpnLTqEfI?=
 =?us-ascii?Q?GUMVTc0OhHxrM0QePPfCaZpx2PWQtwZQS+5tKlZ2wKqtqGW4ujR5mMDZovqA?=
 =?us-ascii?Q?jH9LnYnQxOdgsdD2wVX07kIvAlEL0CfxYymprIU2N5mr1yVqQvhxbGlXZ/Vu?=
 =?us-ascii?Q?TvVoH3jHR4rLxr5IHONhuiqEW2bws5grhJjgmyY2Ubvab5o+EGXBW0CyW69E?=
 =?us-ascii?Q?5FPFBz1b7/1NS7mWNimJWxQRwelLdRfl8LJ1UObeuaatdmRBoqv/BQ6VF0gu?=
 =?us-ascii?Q?B/z46+ha+rbU1qbgso+1gTBXcp3WMqUuug/+R44m68y1vmF+cQVzDoPchJi7?=
 =?us-ascii?Q?B1dwxNpO7QOyJD9I5ce9e7SJVftsR6srXqeO2BYfl1PfpLDLfhhAT+p/tWBO?=
 =?us-ascii?Q?mOYdjjTHIK2xI34Ww5/91q+3HJ7wgx/x3Er3cqE1kti4kHerBdEYmfMmhpMz?=
 =?us-ascii?Q?yPhOOpZwPZZIeTAg=3D?=
X-Microsoft-Antispam-Message-Info: /aGdO3NxPhqmkL80PObnkJOvXg5GIHX0LPwhTuWsmvKdhazFyR06DPvQZEDryVZwtVY7stk1JJ/ecH0yGumCf1o3HiolfMKacqEbjgf0Zii6le8K0lTBdURHdBcLmZ2yTakhIIl1hhX993PEH1bL5Ol1KLdxJm/mIVMOTJcnKOZZA1id20eGsNi9eQAy/9mFvqYGwtO/pltyj0iuJ5CKoZ5y5RTPFcAiBUljBr+yY0H8QB3RAGHgiaMKoFiXHCWfPTE6A3Gf4x8LMLxuoV3ydMls3R6LWuSNyg64SS+v7PKuQGcU8qt/ppDfpPgbV8qhUCIqatAiCuwX3uTDJINfquSO8Mj/6z6zQ8+qkFU/6u8=
X-Microsoft-Exchange-Diagnostics: 1;AM0PR0402MB3906;6:l/pmpIiL6fDPha5DHw9Rqcy73muNpw+g6HagjrgfQ/CdQ0FPHWEq2XWMtXE6tYr1qWkKoXXe9efg42m1s2CWuKEPkX6MJThrcc2R81KXDoYJkgL+uLR2zzGe7e/4sw/hmhooMJ/Qr+7dlNzqkz4QBLq/AKGMTmgIOH7l5gcGGJGLOwSEi7rtSyBWBtNeZXHx+tlMllfU5a21DlAGqovx/UiFMJ0zItiMUf3nwg+oeJH/BGdyFgHGWXBOP4uwL6WjGQgEwh03IxnRwyfr+zsJjUqvYFIIWqsS91ALng3a3lQzs9ZDgKJ7WNcS40Q5k0S6M2q0h4MOwDJs3Zo+YBa1lZZqb2mz8+v83p2tdpKCK4NDlLVfumfup5CBBBRO2FdC+gb85WKOSzlIZTYr1V2BHcELNW8oT4tQbx7IJT5dfBNxArxtSgMRi87mLm2ye88GsPYfgQkJSvM489/lYXJyCw==;5:uMXf4tGq7scupapbpAYD7ICP/+v8lndtbYqaGvf4Y09+/EZO+3DU09ZcvGW9V/xuFMk75o6iNuQ+ldCn+mGv0op8HMpDPB6SHXo73SZwHhVfboBMpRJ3Q032pvy66GWBGe+zS0vvHw7HbRFgVvOrjrXockgLks4AxcIF3UyhHLQ=;7:3fSIfjnzJjJ0m3GZfXl7LPYq754MeSoyaBC5ENVVEPMNMuexOhW3xzY1An5Ajq/sba3uJ1Ou29hHm10/QWwHpujzqQvQRm/XhXQDjp9t/9gIxdv0B0+Ivo3wSuk5fxEfx9Ou0OWbAoqWyGh54hAx8PxAsMW8KktmRM+Pd//6OLDpQaGzgHHlFVbzce30814c8GMxv8HKVWa5biey9TqOQZ1DZNAD5fct/T34whVZxthxblwz813O2NAEEW6Rffg+
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2018 09:17:49.8983 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cda5ef4d-e1b3-4922-1faf-08d61959c7fc
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3906
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During probe phase, the error path can be handled in one place and
use goto method to save many duplicated code.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/thermal/imx_thermal.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
index 6cfa2a8..1566154 100644
--- a/drivers/thermal/imx_thermal.c
+++ b/drivers/thermal/imx_thermal.c
@@ -762,9 +762,7 @@ static int imx_thermal_probe(struct platform_device *pdev)
 		if (ret != -EPROBE_DEFER)
 			dev_err(&pdev->dev,
 				"failed to get thermal clk: %d\n", ret);
-		cpufreq_cooling_unregister(data->cdev);
-		cpufreq_cpu_put(data->policy);
-		return ret;
+		goto cpufreq_put;
 	}
 
 	/*
@@ -777,9 +775,7 @@ static int imx_thermal_probe(struct platform_device *pdev)
 	ret = clk_prepare_enable(data->thermal_clk);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to enable thermal clk: %d\n", ret);
-		cpufreq_cooling_unregister(data->cdev);
-		cpufreq_cpu_put(data->policy);
-		return ret;
+		goto cpufreq_put;
 	}
 
 	data->tz = thermal_zone_device_register("imx_thermal_zone",
@@ -792,10 +788,7 @@ static int imx_thermal_probe(struct platform_device *pdev)
 		ret = PTR_ERR(data->tz);
 		dev_err(&pdev->dev,
 			"failed to register thermal zone device %d\n", ret);
-		clk_disable_unprepare(data->thermal_clk);
-		cpufreq_cooling_unregister(data->cdev);
-		cpufreq_cpu_put(data->policy);
-		return ret;
+		goto clk_disable;
 	}
 
 	dev_info(&pdev->dev, "%s CPU temperature grade - max:%dC"
@@ -827,14 +820,20 @@ static int imx_thermal_probe(struct platform_device *pdev)
 			0, "imx_thermal", data);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "failed to request alarm irq: %d\n", ret);
-		clk_disable_unprepare(data->thermal_clk);
-		thermal_zone_device_unregister(data->tz);
-		cpufreq_cooling_unregister(data->cdev);
-		cpufreq_cpu_put(data->policy);
-		return ret;
+		goto thermal_zone_unregister;
 	}
 
 	return 0;
+
+thermal_zone_unregister:
+	thermal_zone_device_unregister(data->tz);
+clk_disable:
+	clk_disable_unprepare(data->thermal_clk);
+cpufreq_put:
+	cpufreq_cooling_unregister(data->cdev);
+	cpufreq_cpu_put(data->policy);
+
+	return ret;
 }
 
 static int imx_thermal_remove(struct platform_device *pdev)
-- 
2.7.4

