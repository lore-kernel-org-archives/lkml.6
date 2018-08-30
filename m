Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3933C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 02:19:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A060205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 02:19:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="EGEvzWlX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A060205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727305AbeH3GSy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 02:18:54 -0400
Received: from mail-eopbgr00069.outbound.protection.outlook.com ([40.107.0.69]:2481
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725844AbeH3GSy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 02:18:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A9zwaQqYOI5aC96HxltlL2L4ohj4RI+vM22QY0kSCSw=;
 b=EGEvzWlX1r2J2i81YYYyN9a0+Gk5bFO8gUHI+hmFU6Yl+nJaB1R1lvOaBQYLnupIQh+2aKjmaqsIizXjlAGV1YN6KQ+3Z4eUb9p8UXXLBD8QHkXxrfVtnQoGUJJMe/VPPfpvxq+uSzxaRAj+iESj2LwKW+ZTGSbkSumCNeBRiqA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
Received: from anson-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 AM0PR0402MB3908.eurprd04.prod.outlook.com (2603:10a6:208:f::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1101.13; Thu, 30 Aug
 2018 02:19:00 +0000
From:   Anson Huang <Anson.Huang@nxp.com>
To:     rui.zhang@intel.com, edubezval@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH] thermal: qoriq: add i.mx8mq support
Date:   Thu, 30 Aug 2018 10:14:46 +0800
Message-Id: <1535595286-18371-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0PR03CA0024.apcprd03.prod.outlook.com
 (2603:1096:203:2e::36) To AM0PR0402MB3908.eurprd04.prod.outlook.com
 (2603:10a6:208:f::28)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ddf16079-ecaf-48df-f82a-08d60e1ef49c
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR0402MB3908;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR0402MB3908;3:GFhWG/m35ZzNRzk490dsmB4FA3qH/eIA/5cVGuYwyyawrgNV7FPV/vaNV1nVHQp0AthkHDwRSaP6M0u7/g6aKVj88CnC8qeLCZvrOOkQX0pEKJP0RXxV4ih2zQ9Ra1tlxErCo/2KC9p9JSgd9Htu+/fdX4PyQjUIRyb6ZNu4N9WwC5W5gAwgHMbIDI/UWD51du9DoXnFH9ilI9PjqTueVyH/CA9Assv7rNDioMgg0XdN6jcFqXs5t8Ocf+R2xvHd;25:TEMA6sBcWhbq8SL9rynC6Z0Gb/RjigR+dykdK3DxAqik77XTrc5e+862iU2YhGYrzowPa7eo5qHEDf9QQgN5DGPwLL1uRnEL3aSrqbiG58FOoV9Y3DE4G7d1YIi/PUcdIFhjum2aAUqmg21wRpP1ic69OC3Y4MeDWbHSEorSmIyjLLHSbptyBxQxclKYjlBplCHEwIC+H2THOkl7EdQkYGiDHtPBU5wmoOjjtoXvnaaKf21m2u2lxc6lsVPwIIg1yPUWLYtwioJHPLxPdSlswVUNEbvEosj1ax8lyCLnVXFLy/nV//pnXqkjHECwgrxOCks3SqWSN8TsXO4ZMgaQHA==;31:SzPWJrjXXaKZDsnjHWc5x+eo1URIdiS22REWoWGEsAfd33ebCKkDx8zOvrKYYoUKv0CXZXOXgOQbP8xmrA22omtk34OaIDpPwJuQieUe6KQ7d35HzfzKSo1ltM40EL7AXTy9UFhIoRaxDht/evhR0125Hb9SrjZX/v444AfIIUliNjTs/ixM7GDJrwo07HWeQflhoN4Tq38tB9yuyJd1IEgIn4uIozeElIIaQWpbk0I=
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3908:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR0402MB3908;20:cvs+lW0Y86txRS3rMqHTbTkg5xExIGGsaZvmRMqv/Jimes4J2StJbsoQOevFBe60YP7O1tyhvipzXESHnGL3oYCrowRLCI3BxIFSO7787kvz7WcDDdvf6tiFMD3e/FDjBIB6ot7Q9y5dl5FRN+QDBVTwG3xR9BER5MxAin0WR50yAQkFOoUOlXt1RoUNK4ybZFCROWs9rMDEjhZnp71EjrqgKro1hyF0o1IFD3kNBu/flwR1pIe4Pa9j0eo/E5dIf5Ucu0mdpk+cGiw7ee7HxT+HwtKk39ateRVanqkzeLJky1E8ACts4/6oYvvGnMkoY/BnDqDRVQQ9F8goz4ZQrjbie+3xFO8lOf0We0S3cQnWdQYNkHwPp0tKtOEwA0vXCtdGtjw5eAbTGSyu2lLp+b/2fGYbK5Tyg66ZPOuiq1/D3PZWTXA9cDN3nkVXus1ZsNSreCwMt/UBs6rNOfZB2E4tNjVuph7G3SivCjROesyELSU3lukNSdOlywqxVhJd;4:rQ2oY3BqwfnyQjQv2tddhaBjxJdtEIyuHN0QAuRnKSm2UBsBBmJVT91ZRxXZTuKVZDetMTzFmekV3E4NHZEqnh/nu0MK2faQvu3gqSFGfqn6yTDjK8BgbR3xuxH0HXZJhmrpJNTCdZW25JxTvxdv9rACrZ1eeDMsJeJTrYXK3CpZa8/L8o/FF/uC1YLc/s4IFdVo0742bLE2JSXBOBZQgir9UaO8Z8J5l9KD2saA9fsz+kfIFU9USd98goD8/PVE6ZyoKw6kQPFEM57A5GV+ruso+4we1YViOH+vITwyPg810MAha1JCjZxHjRyz/FPHtfUwQ95yu2ShGfPSyOawKqdtlwzVf724VohhwG0aLH0=
X-Microsoft-Antispam-PRVS: <AM0PR0402MB3908543424691B73FA015A3CF5080@AM0PR0402MB3908.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(72170088055959)(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699016);SRVR:AM0PR0402MB3908;BCL:0;PCL:0;RULEID:;SRVR:AM0PR0402MB3908;
X-Forefront-PRVS: 07807C55DC
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(346002)(396003)(136003)(366004)(199004)(189003)(86362001)(2616005)(575784001)(956004)(6666003)(486006)(26005)(68736007)(53936002)(16586007)(316002)(3846002)(476003)(52116002)(6116002)(51416003)(6486002)(5660300001)(97736004)(36756003)(6512007)(6506007)(39060400002)(50466002)(8936002)(2906002)(386003)(81166006)(81156014)(4326008)(105586002)(25786009)(47776003)(478600001)(66066001)(1857600001)(186003)(106356001)(7736002)(16526019)(8676002)(305945005)(50226002)(48376002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR0402MB3908;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM0PR0402MB3908;23:Eqr/hE762mGIKJ5R0InvFN4Af7VKbXEiEg8BAeQ?=
 =?us-ascii?Q?KZYaf3OqmkNBaY1AD0U1YVP/pJjsst6sq5x20syrapFOIMSyxDm46V7vKb3k?=
 =?us-ascii?Q?8e1GInwDn5TWhPn9TE5/Vy7QdAM8bS3tP9BjAkjaVmNTTyEbS4/NLIoKQHmi?=
 =?us-ascii?Q?wisF7wzSS8glfsTj9Ew8bIfIp9gFSxtpzcYFRuQ1bvXBg7zI38rJIh5S7Z2A?=
 =?us-ascii?Q?SOHyR0cokK0EwcrDXP+EzMg6F6chnK2tfr4eDLT3OQp1C1j1nkRCHEdy0QoP?=
 =?us-ascii?Q?FOsyP9dD2HbdxGSwRbsLDXI+xZicD9x6ZWuYxgtT1M8mNNICtHWic7KXGmgI?=
 =?us-ascii?Q?KKQ7UI+sZx7d9hVX1erTmis6KCpCUhXC8WzjQJm4reYLcbmZZyut0NGrSQWn?=
 =?us-ascii?Q?HK2UcqiAhAE443W6PBEw4jmvzgzBmt132/e60wpFB1G4bBDor6ZKzPCEOjrl?=
 =?us-ascii?Q?spgv0BDxYUM5lcdcnGYr+PU4iyqeeWNQ/BK/TtNvJO+HpnSYAFgDn0nwyZeF?=
 =?us-ascii?Q?po2Yo9K5qGX4cPCJOO2Rys5QdE3vcfBp3KsWxZvZ6ry2/uvWqVgI+8AHhL3Y?=
 =?us-ascii?Q?1HCvcKbHDEWiv2DfiJBDNVZkBrBhTtTLrQ2xV25kD3S6BCc11HKVf4h4Uukp?=
 =?us-ascii?Q?WHs6HQn2zkrCK6R7XPU8q4iLyx9i8xN1t1vWRn8s4Kfs/W/oA/LnozYMtldM?=
 =?us-ascii?Q?YDy3zRj+nzddISati1I6pVuahrkbHwTgb23Sz4L/8KQEC49nsZp0P9Th/Lva?=
 =?us-ascii?Q?tTf9eWfLxzLLrONFI/31cfJ79pGIhVwVriNM7l0ZkRYmi1M6mTx6OMswDkOL?=
 =?us-ascii?Q?PRmjtsDCVVozEFPawT68qcHSugGIWikrS9RCk3iFj9wrZc92uUhmzpVinPxL?=
 =?us-ascii?Q?asMTaj138g8fLIDIrrgX62MnFg+1eQQeaQWVJVk4A3wOnFoQNPP51wnLZgQX?=
 =?us-ascii?Q?DC9DPOfj0AEKCo14wLa78hz+ag4wOnQ/3WLz5hEXAZNL+1LkWKD+OIFmn2bE?=
 =?us-ascii?Q?TiCHT7eAYB6XFeiNyvfb/KTlah4Z0M3gB+GBm2wPy5wxYHQs4iIFRAIK9CB3?=
 =?us-ascii?Q?uUgU95Lsr/XBiETrKtB2w42qxoDhSQJHCfYdRPjy5s2dMrlQ1HJTGMz4aV3n?=
 =?us-ascii?Q?w99WX7O0iEjwNBK5dObS6jAq2fkeL91K6VJ5FM3TftfF8DXvZwPTnrA=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: JZF4sb6yPomer0re3tE+1eAeuoOb6a9FM8KlcxYRH8SfVTIsIVGEbRxqn2ZoU+4PCLOfPDTr8aRZ5uFVzhcj9f1tBtxNgNvZkIAa+T1cjXx3+LSx71NVQ9oVrVmclN3gARkdpYPDA+FgXMUbAYd4ad8uWaw1AhvTrry0uXJS3TgNP4K1sl3IeqfIpCSpoCKdtNvrLeOuddBM2CQLRKOyqGtWhk0eoJhQ40FsL5XOF6B/WME5KZxWIFU624er5Z1Mj4ihbAubmbvVuuDWruUF4Goct8ZW5cPqI7FcfpYeMSLQjxlSwdM4SLs1H1IxzBZTSQOOtRNQbrJpm0j1Q8jm5plmnYL0a61dOc4Svd2SHU8=
X-Microsoft-Exchange-Diagnostics: 1;AM0PR0402MB3908;6:XyCKFsJELj4tN2k0DsvPktz+voonEv6qf3HjLvbf/8QDkoXUlP0YUHJJOPam1KGvc65XH29yjFtxISTvkKIcdXVx/w+EAW4GGRAi5zC1VZzlX0symlLyT8ZYq4q86ME/zunPgiNLrFN0eSUAcEtngpuQg8uPTrl9HOM/jrCwX9bVGiT5sbDhml7NWAA9Ru5wWsq0SFG5xC6fXVSh29QromZKdH4fFxAjfz6bHv/zQA0RpmqdvxMrps3EKD/E1m0oarUZPrcgn/TZ40TGdF5/GLDIcslaE+hVhJFlQXIoxJOW4qVyNyZuO3sCb3GOnkEs07IWHFa6caeN8pJHxxHLZn5uFSz0P04ZRSbtH9aIpGvFC8eTqMuJ/dHd8Q1xUarhVhu1arDgGMH6iN3Wrt/LSU09kTMDIcbqD2xLAOHm/iMrwNJwfQBDsXZZHvCdUhF6npm9PAn6NQcV1rGntlgycQ==;5:RQrOWJFU+MHBg9ACWWV2GlMnrtMobJOBx05DFJRmek1HbulWNDujRvUXahRRbM2zlR8wyM84LiYkqUuFCIjB7dAtrjp2+p3RzplVIf4+eTGXCX8BGsKWKVcUXerYEkpS9H78pbkbFNZhQ5u29LVGv5qvdAkLQ96j1TnHuCDNBSE=;7:7ZHvlI4AifjZzQrhwYRJhp6joUt0T0O3nIZnwrAmSwIoIZ3hFO5lEh8NbRaCNE1Hv66V7DjXcSCtJzLNyat+VV36uMG93TPYhUqkJsZiMcvLNw32uUSvPywCZmgii0uFQ7LBW14vf94nSbQJIlqj6ahJWG2/KxrqOoQ0eF1OCmQle3CjEGiwVKyr9ZuM0gGlcPlLUK8Gs824/AOXEgAE8NbU7UDty7RKx2zyLwg5oOzNRUaAPt51oQ5NOnOjxQcc
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2018 02:19:00.9145
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ddf16079-ecaf-48df-f82a-08d60e1ef49c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3908
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add i.mx8mq specific compatible string.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 Documentation/devicetree/bindings/thermal/qoriq-thermal.txt | 6 +++---
 drivers/thermal/qoriq_thermal.c                             | 1 +
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/qoriq-thermal.txt b/Documentation/devicetree/bindings/thermal/qoriq-thermal.txt
index 20ca4ef..04cbb90 100644
--- a/Documentation/devicetree/bindings/thermal/qoriq-thermal.txt
+++ b/Documentation/devicetree/bindings/thermal/qoriq-thermal.txt
@@ -1,9 +1,9 @@
 * Thermal Monitoring Unit (TMU) on Freescale QorIQ SoCs
 
 Required properties:
-- compatible : Must include "fsl,qoriq-tmu". The version of the device is
-	determined by the TMU IP Block Revision Register (IPBRR0) at
-	offset 0x0BF8.
+- compatible : Must include "fsl,qoriq-tmu" or "fsl,imx8mq-tmu". The
+	version of the device is determined by the TMU IP Block Revision
+	Register (IPBRR0) at offset 0x0BF8.
 	Table of correspondences between IPBRR0 values and example  chips:
 		Value           Device
 		----------      -----
diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index c866cc1..e0e7356 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -305,6 +305,7 @@ static SIMPLE_DEV_PM_OPS(qoriq_tmu_pm_ops,
 
 static const struct of_device_id qoriq_tmu_match[] = {
 	{ .compatible = "fsl,qoriq-tmu", },
+	{ .compatible = "fsl,imx8mq-tmu", },
 	{},
 };
 MODULE_DEVICE_TABLE(of, qoriq_tmu_match);
-- 
2.7.4

