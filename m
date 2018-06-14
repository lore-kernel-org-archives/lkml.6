Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DATE_IN_FUTURE_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 9CDDDC07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 05:36:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47B5D208D8
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 05:36:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="JARlLrKk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47B5D208D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752807AbeFNFgl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 01:36:41 -0400
Received: from mail-db5eur01on0058.outbound.protection.outlook.com ([104.47.2.58]:26240
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752664AbeFNFgi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 01:36:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NYKguABsBJV90j9dFIS0EBmc1vmQc+44AXvbrZ/moZ4=;
 b=JARlLrKkxVpcmH6W1fH/7jO+jHL/ZevZCH/GeDhg/AfUJgDLuaeOcKw2mA0nl04baGUXNs+zaevR3jvaEjOuD0iFtwX4xK90Y2Nf0FjDcqHzk+vOqJ8IUOOZKX/1k46c0bXpRAR8LL96iUt0OJohuawJTvYAaje8yukTUmjY3Xw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 DB6PR04MB3222.eurprd04.prod.outlook.com (2603:10a6:6:6::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.841.14; Thu, 14 Jun 2018 05:36:32 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     vkoul@kernel.org, s.hauer@pengutronix.de, l.stach@pengutronix.de,
        dan.j.williams@intel.com
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com
Subject: [PATCH v4 1/7] tty: serial: imx: correct dma cookie status
Date:   Thu, 14 Jun 2018 21:35:31 +0800
Message-Id: <1528983337-2726-2-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528983337-2726-1-git-send-email-yibin.gong@nxp.com>
References: <1528983337-2726-1-git-send-email-yibin.gong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0P153CA0024.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:18::36) To DB6PR04MB3222.eurprd04.prod.outlook.com
 (2603:10a6:6:6::18)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 682b847e-9c58-4a21-09ff-08d5d1b8cb5e
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB6PR04MB3222;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR04MB3222;3:3xUyOoZn69/ZttFGgB8TZ59YrIMemFpGkjclLd1F0nRrWfaJ+kA+xuAgA25YV23DvFwdvXkP8ILZDdYMZQvgTifH3e09YZNHyc/DzILjfTMQP4sYwm0MgvBgQVQ44Vtia3tzJDNsri3q51vk9eMQm3OQfWAwVxDTXCBc7A5R9MkMPCmwiTrOiwKQj3t0ot/nxoo+CGHtdyKIzt9xi08JfO/YFnfkqpfkstl2z74GLDpWMOE9IZjtcr3M4XeV6z/4;25:pbBXeTqjNTcpKmBZlNqx5Rn3P6ZuEDPKhnNgeyqdDuc9wD3vQhiiBFWjq0vmxd5rsVt/8TSSDI51Y7WLLn7q8LhMY4jBDKGpy2HUQrSXL+DJ7Csg6VSW1RcDPpwsWdELwicKs900xCh78oyKfDODpRDZd7Q9gcfTabXF7ul2vk8wWqbF1RceSQR5n1hCHKRc0/ONAaKKGASSV/ZvpvNzssQuX5EIUdie0gZEfMxOD5fuNvRxQ0MF/6Uz6+znDQkJ7wW/8zILDoXIqLqo9fmyBOFMTeLDQcwzohyxFbJAxIQvp2pRwNKz45X9nnEyPGzL6/sPH53sUlX5IZor9uOSAQ==;31:Jusm3xci4x/4oJdwZCHbOa9kRlvJLK6yYilG9feKSPlIq1toLmU5M7wRC5v3fC60aWT/58dKVSCyu6ByBDoKBpOCQ4qokhi2vwy/EyILbRczmB4TOX6J2j5pMy2uI2SGXQjsGgP6mFNM8W3hNkSI7CNltjS7f3el5b//OW7gXPtLBxM2DWJw+yYWPo5Rqlwuc3xnYeO7NhJv332qzdOTGUMTVhx+rQ8HZL/1Cjxf08Q=
X-MS-TrafficTypeDiagnostic: DB6PR04MB3222:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR04MB3222;20:P4bL4JByyBa6xjuCkXTu/NumOAWIp/pcN704oiJIfOLnGnsLwdnJ/F5s88XvFyN57WhNJnIZ+aqlP+PiGXeGR70+T/G4MitXgFw460Wg4QoIcmSXOTWQ6PjE787d1XKVNezMgrQ2wpkbIhunQaxLJBduYTujuga57+luDZFTayV5XWE59cQg1etj45BwQN0TMEFt8ZopcMXFct5pcUtfraKp3PnHUEnPydIP6fQYcrU/BgWf8fkvTlbTZs/7/M0n7Sid+zColn6EYIvH0P7x/CzIV1PsxCERnk5eFxmVG8s4dI5G62DQ8xs13zdv+YWAWU9e1H0LWdmutyadqEerVDlnbtaODMS3A2ySIlvDyGKLXMGnZDiR4FtKV2eUzqJ64su8uGT8EVnDouydM3AXZU6979GdOkgVuxK1Pzv5lD02GBUET595DRwSyMf6n50nn8HP0Jn6tGipBZ9C4/aEmyHGkLfsdgD+WoJLBsK2VLPMdgR5ZREqk3gkDjRZGmzF;4:Qz0VGxAImtHRSb5Oi0RYUFROPBWhI6sDXCzvipwg0siresz3/QPUqW1tmkZDCJBXm2wx51/Qu/CCNzdbnJJWTXV2GrsWLVEb0Zq4BZtzyiOEh6PBp8YxZYkqz7eVm45CzzSPeNWBKtf/DGL0zDGeQzcoecC3D5AR/+FTL3ZnVx2AUBdxmVB7c/KlT7GpTlMX3zq+/qoC/k2ilMH6VohMdQHQYwdkV/MixaMYBsvzGyzbnSlOuuv3fBmRk1g1w3eQJlcmeMKYijAZSd6y+3qCcZ+e4IumQ/Y+BXojO3C1I6mqtONq67T37jcwGcz5fr4Y
X-Microsoft-Antispam-PRVS: <DB6PR04MB3222B4E73D75AF3A9C5077CE897D0@DB6PR04MB3222.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:DB6PR04MB3222;BCL:0;PCL:0;RULEID:;SRVR:DB6PR04MB3222;
X-Forefront-PRVS: 0703B549E4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(979002)(39860400002)(39380400002)(396003)(376002)(366004)(346002)(199004)(189003)(476003)(6486002)(11346002)(86362001)(16586007)(50466002)(48376002)(446003)(25786009)(66066001)(305945005)(956004)(47776003)(97736004)(2616005)(59450400001)(52116002)(51416003)(76176011)(6506007)(386003)(16526019)(486006)(186003)(105586002)(106356001)(36756003)(81156014)(68736007)(3846002)(6116002)(478600001)(53936002)(26005)(6512007)(81166006)(8936002)(2906002)(316002)(8676002)(5660300001)(4326008)(7736002)(50226002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR04MB3222;H:robin-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB6PR04MB3222;23:dsghYi59TI3BOc1038bZb5xPpSmv7mdB6FfWgzOpD?=
 =?us-ascii?Q?qdSEXEuyp+LZiJJCbZF0B4wg6kJZS92o2SPGXPIwKzm6vB4k+T2gfOKIvuzH?=
 =?us-ascii?Q?AXG7jaRAPIszIh1Son0kzJpPVtVdfi2IHxIadKKj1Td65b/iCiKDqFDd4nxb?=
 =?us-ascii?Q?iJWz5NatXTV2JjcrY7y80Sy7JwC10Gd5GfkOOg6MaPKD3+ILp07FM5E3fHes?=
 =?us-ascii?Q?BhmZLmLB/6bMkFpFCREZ74/TWhMsHAqhu0IWZlhZBvMMOf4bFz94DCrhRa/+?=
 =?us-ascii?Q?PmAj4L1BYEWcQO/hb8A0+m8h8OJODUR4RgtEMqs6BI4vEfetXMwDoj9K7IpI?=
 =?us-ascii?Q?OyQDPdhCEjYojYdhFGpX6zRwbJcxnWIa9xU4gHffBn23f6vRFCGtb+9zay1K?=
 =?us-ascii?Q?1Lj6GyhzSU5XRul76FxGFR4YCWuTzNLbQ7OG120Ns1y4LLvfurbi2hka/109?=
 =?us-ascii?Q?3kKRKsn0UPbIwA0wzQE4KicZF+hcZFr5Pz4m9fIeZILy79EQ48ik34j1T09i?=
 =?us-ascii?Q?e6LnuVt4EvY1p3wYT6Nwfu3G2YvxOHTYqifBtpyI85yobWwmtmJdAOFOntsX?=
 =?us-ascii?Q?0/BICqva88a8jJQpl2as+KzUONRSlnOsJ5kPlWjwpROR23JCPPCeR5yKJXHn?=
 =?us-ascii?Q?05Y3zK5HmaCYY6NCUWKBHSaN654wItXrfyWgHpVbGoafC6fH/SD6Sy6p7YQR?=
 =?us-ascii?Q?HewnsHRprK1rvN97vu7ijFwEoXeql99TTXBzOmMJnsb898U0FmQfoOzICBgt?=
 =?us-ascii?Q?30v8HCDfKulE1XHlYCph6uRMpp5HTHCYgrVQDUm/cqyHc2GE2TDKiaG58QS7?=
 =?us-ascii?Q?Qr2dwpBi1GtE6c6xQYj9BMkYuju+9RHPNoQHiFRQPRUPiTZI/KF3Hm3TOloU?=
 =?us-ascii?Q?EjU4KD4w5ig+sXxoao4/1qBQEYu9EoCtJ03XlK80bZ+sjNGHRvMD1mNfO8CY?=
 =?us-ascii?Q?loMUIOHy2gP3Wm7/bdIiNddNnH1w/jqyht4FaKY9Y+VZt8b9gwxHmNEoHaV7?=
 =?us-ascii?Q?KhpIOhrQp9zr1OaOdLiwRU6h3YB0UXIn8ILgXqZVHu6VGJ5Yh0WKLo38LKqj?=
 =?us-ascii?Q?PaNVsTMxzTdw58RXou1pqc2qlKTP3tF5sMKBVoeRb4gwIB+GDJ0HSbKpxQ8r?=
 =?us-ascii?Q?gRI2m+aUYVRNiT5FfwI/A5NNITRxbekx3ZotM1FEcybM7PtuBCP83ULWkcbW?=
 =?us-ascii?Q?bPgzIHpR1JPEzjIjTlIRacEIe0QCAiZBMiasxlC97vDopt4Xw2jdmOHqhKiN?=
 =?us-ascii?Q?8NxamXSopuI1lKZM0ktYcka9Dk+6nCDHILLLu4Q?=
X-Microsoft-Antispam-Message-Info: NmECTQwXhOajPn+gMHw4tR8pPXMOLeK8Ijfb84GuZ0VmOKelWfNqHZn+4zFcVOkruah9roOdP9sxWDHGIaoXF3GjjvPtbMeJd6HOTm8g5iQ/VEQE446MNGXg2bxXLCGXAYfQdq1VHCuUedWUSPcAA56Ge91Ha7fz1MeaEPqUTCBKUGX9TNHTWGlrgUeGSvBI
X-Microsoft-Exchange-Diagnostics: 1;DB6PR04MB3222;6:8f1JjB4RBl1G5pJfgfj7HSaVPbYi5h4jZj6Kp5Ii9jMArzDx5XDQBySO3XLI2NyKL4lPOpVd/TmesKqfgv/p33nuBMlHaPdMA1obF43pYcBKlX2027xBIOJVHTIEDGfFx6Pm00t1w6NUTeZgcwxvAbFlawzmBgM+nK3JgNAEIdQvvvwnWJ/TTyAShVC+Zzpf4U41sxJW7bwaRXFZhcTL6o0tXUVa/lQOo1XgBIs8Pz7lCcgPLjnw980ovp5Z2Vte0PEHIo26ZZOB4+vypWqYFtyK96ieGEpSbO/paSc+ZoNCXKkgJPJQDGQB04yxo4k70mI0Tw3n5Tkt3C8nuVF7KHpnquXebkkoICd0FIrdCTBV5f4NvKYaPLXetAE5+/BXs1o/tDnJMGT9Ke6hAssg3neHwRzvn50e7JhAdHonomXuJDuFAjUQr3P9k8KEHMOaP6tN1Sea9zeCLq6H4Dhk6g==;5:iVQt+L9lxwn1HpmKQF6WygaVlMzTBGkDFUjO5aBspefsQIO58ei0Wsf5fgxo6WSlPqV8VFbzhzPVJBiOwhLFGoqfpt6sxSwMyLfrFZOS1kt3d8n0+T22Gj/pTIINkBYN0qM+880fdzR59TBNrde6/p6euMMlTGOVlv7wy3pLf08=;24:vcwtt6PubnxoUtmswGs4HO3+tOcgWvbj7M2X7UonbBQgAXhzjOBZ2ikuYFXUN24Ki0u5+DfBcWfl2H2XE31VLQA0mNvzbCme4O4RaYxBt4w=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR04MB3222;7:9wAtzJR7o5dIuCVTF3iQ2lM3Gi2SwWuDytEZxoY/qozX7xp7R7UVP0pFSAw42Q/sLI9yZ6ccqsT92mSVB6CAq+rHQYeL/ZTMZhP4unRdSWHVRyNhbCfE2Uq93YMiggJvyHGoJTPpPqsmeQyWanD8HTb/qYW3MEwL15ceierbohEqWaqXrAMykzcFTRW72yBBqoAV4Aa4wTs5snZ/kHeaOi2OHEt++mytTqOeOWhzNpxdhGcJ4YFZvoYEyod1MYgb
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2018 05:36:32.8137
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 682b847e-9c58-4a21-09ff-08d5d1b8cb5e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR04MB3222
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct to check the right rx dma cookie status in spit of it
works because only one cookie is running in the current sdma.
But it will not once sdma driver support multi cookies
running based on virt-dma.

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
---
 drivers/tty/serial/imx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index c2fc6be..b83bc2c 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1051,7 +1051,7 @@ static void imx_uart_dma_rx_callback(void *data)
 	unsigned int r_bytes;
 	unsigned int bd_size;
 
-	status = dmaengine_tx_status(chan, (dma_cookie_t)0, &state);
+	status = dmaengine_tx_status(chan, sport->rx_cookie, &state);
 
 	if (status == DMA_ERROR) {
 		imx_uart_clear_rx_errors(sport);
-- 
2.7.4

