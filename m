Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39C85C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 01:29:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D952920838
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 01:29:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="kzTJgPrx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D952920838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbeIEF4u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 01:56:50 -0400
Received: from mail-eopbgr60050.outbound.protection.outlook.com ([40.107.6.50]:49819
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725908AbeIEF4t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 01:56:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lj+tMUkl18/lCp77UPKi4Ys9wN0oXbGUySfOP0V+FqE=;
 b=kzTJgPrxWNsQ23gb96vJJsDvNjiUCWqe0SUBDE678JBIM4wGAfSSXCnmawQbHM6Oji4x4VBNRpU6GCjP+fQ9ma31GY1Y7W9Cb2fV+HDSfUdpBcmFDTJbVWihQnG+MJi/B9G06Xr+G8u5FQgr87elVlFyZ9eFwc+T3jzVsVpAvL0=
Received: from anson-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 VI1PR0402MB3918.eurprd04.prod.outlook.com (2603:10a6:803:22::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1101.14; Wed, 5 Sep
 2018 01:29:01 +0000
From:   Anson Huang <Anson.Huang@nxp.com>
To:     gregkh@linuxfoundation.org, jslaby@suse.com,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        u.kleine-koenig@pengutronix.de
Cc:     Linux-imx@nxp.com
Subject: [PATCH V2 2/2] tty: serial: imx: add pinctrl sleep/default mode switch for suspend
Date:   Wed,  5 Sep 2018 09:24:27 +0800
Message-Id: <1536110667-23530-2-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536110667-23530-1-git-send-email-Anson.Huang@nxp.com>
References: <1536110667-23530-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0PR01CA0006.apcprd01.prod.exchangelabs.com
 (2603:1096:203:92::18) To VI1PR0402MB3918.eurprd04.prod.outlook.com
 (2603:10a6:803:22::31)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8ea2df92-27d2-4034-31e9-08d612cef6dd
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0402MB3918;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0402MB3918;3:Og6T0YMbDdGKbby/2AsUzy3x9XNnuHGp3jqikc2nhP0K0scQ1EVxGEXp0RPx+Su5w3oRojfYhqdKB1t0XpVr/BMuRrp0YT7v44Q7HEC6vBl3KidulD3ZzEgcjh4xh9vFyPJs+PMLGqPQ6tIPe0TmQaUmJmvV9++7WDpeWodoJNoxg+ziN+MepjnBEWtxt6D/96RChzwaCaZI01UyAi3F5DmBUbzC7KVgjkXOHwgGPWtugSV7MbD9yilC2zE+T0v3;25:KXoK16ypTRIIc50CI9m8mWf4jwu8YmCnx/xTigLgVr9tLNNYtwZmH9MOBTeYgVwlYeiEMCIuK0G93H0TWWzng4UbzJSSZm7aFczgMod9KtVjtDhIv6dEsipaqshDy2Ss4yLOK6v2w+TGe9W0aNmllrQkXUJfFAoTqDuqWJsjssa0K8KrvJXYTLkLt6yKv+BMXDNgwRYDIYL9ENmgjhh6d1CRdbAPCQ0lacGfJ2FZHR+u8W8CT9dL/o7jPW0/X2RbeGOkw0JVj9btxkqSighxOLXk5mZzY7lYkilXef7ZNzoJ9eXKm8VATSwaCS03BLxnx2JHB8xObPpLyGi43+ViRw==;31:7bjg/Ggi9ret/uohjMRVUOxXG19xDTQHdN272PRdF+QYumtOA1fpfgetgz1CxwxzcRwc8bQmikBJp7ZVaFPPaGOWDiJ1YsJcOVREqwV6dz9On0QRKa/0Iin5Vh40ivTJVsJbGU6H6x41NL1V2Ljk8iAtS+M6AN0OsWvbebEFjtVYnuLE+o2gxbpyOFmgrL4NqIEAaJgvLt8gdosyVifdrRU0ML5M4FHkqhnkHNIRczc=
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3918:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0402MB3918;20:ZLKnDmTTVma8YncfbzGnR8EdTnqE90vjNO5f8HK1sZ9JAG/lznD1KCKG2rJKJIy91g7XCqGJn6yyb66THmMknTohVnJOwtaVftt6LpOBoSWFOZ8XOcn2QMhNwBUrZjw2kONjGj/llXvZyOXR69+aEf/4a1O8vLv9IKz340hkA9YaEPkDij4aSYnlu4YuLkyaQI97f07PJcafckPiGn8LTRPeTJCX1Y+ZuhnPfbrzvKPf1aHoVJK+FokelR8p3PhPv7pIeKkA06XrFWkYjJjLt1g4ehSIjW0Do517CVMXGT1X75r0S0MLRuXFoaTJiH763mAspx2NRDwmO5IGWIC6KumuosBL4zsEhh9SLCpt8Es6/OVgIKpryWiTgDigWmMr05KFU0lKrTjoCgUa4b56BxvGtbT6D1xyniGRb8B7SjUb3fRTcfUbj1ECTuLFOarRGF8fEyLIsAEIeVx293Vn81Dll/kUnsy++eP32wjSAIm8u6gDcdtmrBwonGDi9tBW;4:b0azRt9YU2FfqyePD57R3vtXZX9+M2wcY8XuZVxQDda07lEFXVWcCyyia3zAgRU1HRfHl1hW3adjrQfS3uZ32aFqNv44pTe1uzEg1y8zPLLWAIKUPctcpgOJoWnKFrJCXYzBkZLoPeFutKKWc9HXIS+16lq6uv0VYwAukybWZZXPEvpIOkKOXEI9qXYv9o0NCcr6wYdDfCS0dcEwj0ZqVX2D+VaB+zzpmckt3s/ShMkrk3Wf77twi/R9MfBfAB8usCE0CwKkvl2RgPQylBUiKfBAI9SgYahNvq/CycGKvFD+ncIRqzpuJaVhEf6XWbqR
X-Microsoft-Antispam-PRVS: <VI1PR0402MB39182637D3FE01F92648DCD7F5020@VI1PR0402MB3918.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(3002001)(3231342)(944501410)(52105095)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201708071742011)(7699016);SRVR:VI1PR0402MB3918;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0402MB3918;
X-Forefront-PRVS: 078693968A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(136003)(366004)(376002)(346002)(189003)(199004)(66066001)(106356001)(47776003)(105586002)(50466002)(48376002)(8676002)(7736002)(81156014)(36756003)(15650500001)(6666003)(5660300001)(68736007)(50226002)(2906002)(8936002)(81166006)(476003)(11346002)(446003)(956004)(2616005)(16526019)(186003)(14444005)(486006)(316002)(52116002)(305945005)(76176011)(26005)(6506007)(386003)(6512007)(6486002)(16586007)(4326008)(25786009)(53936002)(51416003)(3846002)(6116002)(97736004)(478600001)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3918;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0402MB3918;23:lIP+Ig/1ASRqggMwO1M65wGB5Y9TgOC5aOHsE1Q?=
 =?us-ascii?Q?58hRA5b49lv/edxTGh1D9KxycwDaeDALb3fUJusCwjRoOPt9GYvT2//1t3RC?=
 =?us-ascii?Q?j3/NpRdvtJ1AowhKWymY2xGJpcO4J0e4I7F+uL0LH8Sm1UHZejzl36GX3m7h?=
 =?us-ascii?Q?+ozstqUBjxn6K6wwN6SMSbvEJVBsciXIpDPqrpeV7Q7jbI281vWamX1xFS9p?=
 =?us-ascii?Q?xJp79HCibK7wGnNxZvM6PYObQpHZ/EpVwcHI/5DYAlAJZC5/eaOcVYlJH4Pv?=
 =?us-ascii?Q?l1Ng5lu6Wr1hq5KrISENPDeeKVVsHNw+zhRB4owzF9fGzMKP9rHksBaTjscu?=
 =?us-ascii?Q?ccLuI7tHkEIfj1SR0tFlEgHdFKHYCfrJth/zelnfs1J2AsF5I/jhKboI/Kaq?=
 =?us-ascii?Q?FTY3cX0phxydopdkvtiPf+4rGGZYc9GRRTrdhv09kjYDPbnzdJ/Z8sJUaWJf?=
 =?us-ascii?Q?silJAdej66ccmgGcD90aTiPe7D4o6nz9mHjFOczFRLrFQvVm5WCSqDvsSX4P?=
 =?us-ascii?Q?k68oQaWIuREOMOum4mdjlGrORom2A73PlQ2G/IKuIa5lpKkqVWl23/eOKGe0?=
 =?us-ascii?Q?hIHzmUdxLl0HNHe8dDMjYfkGLsKraeAC2O6Y9Iw9q6Gu8CcDsJ5f70sz/bAC?=
 =?us-ascii?Q?ybDVRg4a4CZzjgyCXYKdTqdtX0wHJc7wdFCquoyEX1D3q2j9viau13YZ+5A9?=
 =?us-ascii?Q?r/w3fO2WPHvC7V8YdpHLUo9Al3l0RMwW1NEnjh3ZQoTAl9e5j4mZ5Dcfj07c?=
 =?us-ascii?Q?5khyuUBRar2RaSlzzzOxlMIdeb57fgXB0AL2B9jYC/V857TZxzfBEwHzQc7j?=
 =?us-ascii?Q?ZIvBhVQeWrI0Gz93l0BCteDGT/H90MRkTBtvpMBc8tykd+I0/ZGJpZhD/6/s?=
 =?us-ascii?Q?jEd5aJvy8tBxmYFE4jbmWZWeOzWK8tcNyXgSH7qCOM7qSJZbGV3/weevRMoT?=
 =?us-ascii?Q?WtnTMJc5HcSVO9c1vVl9T+WmQ5Wi9l6wxNTqSvSlhn5OKoV5f9SDQmNvjZMP?=
 =?us-ascii?Q?E12efOwzhPnrq2V0meqlHj70ca3agWrVT0dhTQvc3euaAikI3vhpIS3UMOb1?=
 =?us-ascii?Q?5E0TH/7p+b7isFUdHRPl12LSa5d+QsOBlSFvTOGbCNHA5tfzjB2+G4wBZO1q?=
 =?us-ascii?Q?OShB86ieWQXd2/KQw/sd/BbfMQBjThXzj0y0wQhqoTVRBE6DcJLAggyYrIKV?=
 =?us-ascii?Q?hgVWqKkaCfnJ4dyc=3D?=
X-Microsoft-Antispam-Message-Info: xZpyxMxDWsC3CQ/qLQ/yJdrMaldnS5T9zRVu3dCHjpuNSQxukQioSUb5NXyMI7DfitWLa3fPQhldxFM0zmV9uONMFOlE1M5ra16SjDn1V16cse98ru+RQA6YvePnGHuw8dDV2LeAtXznafRON1kYoNnBlC4irw0uRZDDxdB+TP0n3ltiS0SaUvZHqVoCYCadULE2ZeYGS/soXaFl8RjctLdmyqfODlAfq1dMuKidpyyEdTiz3Vnd+76Y7NkN16X6tAwC9DU2scjrY5vAJmlO8cVIWLIqbQ1Y5d4jdjAI7ZMXuS4JKsYN35OyRIKy+KkePJcaWbnOHTYBNlhf06vr2dFQ4L2rq0WsYydV+XE2czc=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0402MB3918;6:V0voXtBIe04Dlkvum2Bfu6ZwoDlQIMRKWVNUUeoAnUeoA6FgxhZRVUKlLACwbXz9u1oZR7LQxlM3DMcEXb3CSBdxgBnKS7zRvN6Wungh7wDsKW7YZeHnFbkrIWSYKxXQ+pZLE3kcRH9KyQOBUHTMTJVgVl/7iq2PSVMNuVboySwz4tySNpagT/gq/mc95r/YLcWNIvB9BA8nEi5/r89kM8j1RYSsmr6Jc/XQrDwZV328vzJ1MyR/MnLyUH/BzcRxtPgmKuOewOpaqyzwbc9MR4XnvvczSK2t9ckomYussMXA9oSBZbtlo/cs2K4xp9icMJCw4O765lRXRHFCBGAzaSpOGjLkgO699GoL/Ryhkwzxi+twJT1EAx3uj4ZIlhBtJNx0uXCGGVKhKb7PENxcHxvTDhtqFaVsXucV1I9c/uVu/AGbohiDgvcJXqph2gi99q7LmKVPwn+VZ/9S8I8tgA==;5:Kjz2HhNEoeQuvBVC0fLZrpvPCniShOw6oYGmAeoEI61bSLdDHuVafI5lxyOo/qZZ3RdMKZm/OoOEKryJKstTwpNX6unLExry8QGnBmD4ykjaBjdJI/xtCK6LlSCpFg1HiVzhC+IOZ3kJ5Ip6gZaT9VdLAdyDxiUSTKkBLJTaLlQ=;7:p8Xp6KoWaGKgoYYG1iqtLCyxrbItaQ7gCFO/eQISpcDuFgy54+qh9e3pyBPZL6pjVMSRdx6V+Crn2Nm9FrPX0ovOnA44Bpcze4VhqlNsjVwyhBX121qlykjOhHsouLYRZa72a539JgCsbz4Vi4muzbacDZTrXOLNyiUF9zHHRg+MSe9yKlivtozNi+6sBPhMl91bSAI1pD4l7Gp/Ct65s1R1Pms2ujGfZjuA7nbJurb3gfvJL1GVO8ipgCcF/pXg
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2018 01:29:01.2153 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ea2df92-27d2-4034-31e9-08d612cef6dd
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3918
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some i.MX SoCs' low power mode, such as i.MX7D's LPSR(low power
state retention), UART iomux settings will be lost, need to add
pinctrl sleep/default mode switch during suspend/resume to make
sure UART iomux settings are correct after resume.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/tty/serial/imx.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index c15332d..6ccb5c4 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -24,6 +24,7 @@
 #include <linux/serial.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
+#include <linux/pinctrl/consumer.h>
 #include <linux/rational.h>
 #include <linux/slab.h>
 #include <linux/of.h>
@@ -2449,6 +2450,8 @@ static int imx_uart_suspend_noirq(struct device *dev)
 
 	clk_disable(sport->clk_ipg);
 
+	pinctrl_pm_select_sleep_state(dev);
+
 	return 0;
 }
 
@@ -2457,6 +2460,8 @@ static int imx_uart_resume_noirq(struct device *dev)
 	struct imx_port *sport = dev_get_drvdata(dev);
 	int ret;
 
+	pinctrl_pm_select_default_state(dev);
+
 	ret = clk_enable(sport->clk_ipg);
 	if (ret)
 		return ret;
-- 
2.7.4

