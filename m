Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58C6AC67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 09:52:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9F462089A
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 09:52:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="rtF5EN8Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9F462089A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388868AbeG0LNm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 07:13:42 -0400
Received: from mail-eopbgr30053.outbound.protection.outlook.com ([40.107.3.53]:24435
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388679AbeG0LNk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 07:13:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o56NHduQ9WsFeS4mVKSPkKaXoRxec7Sgi60hYE9M3pI=;
 b=rtF5EN8ZiDapSvl0r781btoWA7d6ZYNLpCcSoFPyM6ml17I7y+Gsb01QVTcnGW5NyhCo9heSteieNq3stWcMgQnHIZckOXN19jDykPMZ80OZcUP3e/K4o5ivOK8rRowAh6vnvUzZ+9zzwfrzchwE+TwZz4x7O01R08A65lieWeg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=bharat.bhushan@nxp.com; 
Received: from localhost.ap.freescale.net (14.142.187.166) by
 VI1PR0401MB2557.eurprd04.prod.outlook.com (2603:10a6:800:56::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.995.17; Fri, 27 Jul
 2018 09:52:26 +0000
From:   Bharat Bhushan <Bharat.Bhushan@nxp.com>
To:     benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
        oss@buserror.net, galak@kernel.crashing.org, mark.rutland@arm.com,
        kstewart@linuxfoundation.org, gregkh@linuxfoundation.org,
        devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Cc:     robh@kernel.org, keescook@chromium.org, tyreld@linux.vnet.ibm.com,
        joe@perches.com, Bharat Bhushan <Bharat.Bhushan@nxp.com>
Subject: [RFC 2/5] powerpc/mpic: Rework last source irq calculation logic
Date:   Fri, 27 Jul 2018 15:17:58 +0530
Message-Id: <1532684881-19310-3-git-send-email-Bharat.Bhushan@nxp.com>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <1532684881-19310-1-git-send-email-Bharat.Bhushan@nxp.com>
References: <1532684881-19310-1-git-send-email-Bharat.Bhushan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [14.142.187.166]
X-ClientProxiedBy: BM1PR0101CA0059.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:19::21) To VI1PR0401MB2557.eurprd04.prod.outlook.com
 (2603:10a6:800:56::23)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 93aedbd0-027b-430a-2b90-08d5f3a6aa89
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4618075)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:VI1PR0401MB2557;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0401MB2557;3:79cM1AzbVA39B6bpV5+JtQXXvp7NJYtqkvuOkWyynv//xioEfqZxjwLFo6TnI99ZCes4UHE7lzZWpVcTtLdxY+cAQ7q4nEWvv09qgjCWOICy6gf8wm4u0tzqUSZeIL4bb7Ml8mkb/zdblIcLsJLs2MMhnGb0uhOtDufg51Rwi0NCFnjWVU8XkBg+d3ufnSyrWnva1ECfccjGMGSZDvqxu938ZgmlGfs+ViPQP2BYdudUIk1iC3UT8V2zJnTozW+C;25:o8ExDMFtYtXJr1AnC2uF9GY2isNwW32S1SG/ulfLdXKbmJBhkqNgEaA77M8P6XUYUQCTjz66oSAm9bJVXcAe/rWZjvILoASMausxCzm8FVGESEXiAkDWAWYzttErEyk9G5sCpo/DSAcKGf0tr8cK/7zXcjNeexd61gvODmWAl8xXKRdGxsHBQv+eGe41NUmvpIwJFuu28M18LxOiYa2mpIs3YZScfNmdn3M2xaVIFRQOcLPTRPXeMozRxI+9FPhoYG9Sh2iDCMXe6u27QbiX6YgD26xwDyiG1KGyA9/9Z7kepzMqIIAonwLMrBcR7i4DkJhvx8KBBXs/VFH9OgHGlQ==;31:AW848qJ9e9gLtf/+kBffR2rV8Mbi3OHgLgEYO/vKrI/s4pxX8wYaUxHnOETk+q0MzpqdUrI9a4YQbfDpdmfRGgoUQFo8FLVD3FGVd2rpu1R2Gwj2ZtcACHKfBTPNZn9dK8Ug+YIOf6C7IRT8dcahRJj7AIymTS5EAEr7o1yLccYuw/umqHKO+3m662QNjZLZsPFeA/T3p6IllnnE+ZpCECsNRL/hkNMo7Wj0e5TAWyI=
X-MS-TrafficTypeDiagnostic: VI1PR0401MB2557:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0401MB2557;20:VDdPwR6aipoeIpiNZWPWElsX4mgvENzzCtIDlOZMIvGoPxjITJw6NMAzujH6QryybQRPDLdV+lNh5flWYKo3ppgMlGeGTrpml1GFBibzgJye0mo65XSfPxRPvNwENnjUN49jA7zGUQG8Wc6cg4HjgBdSNk/cBg8RkJP9DKFRn+BftV4vvUVMrdTPEkBmLbdvV5bPAmkoO5P7k5kcolMHhzdaNbDvmYO7llVpE1vKetqCAbjnrQ5dzXnzJsa7YsdvbBBslif4rlEaG4BBox18fIck6McTrk8TD9TtTC2HBm8xaPnjpRm6uAINROtrk1riY4IVs1l2E5cKeHNAgCT4T4wfjJX02vffzH1/7n9Qn18w2l5f9FMVEENT+sq1ovo2+y5VkHdS3EjcF0vPoTVkSxxh4nFMz2SLS1iTNCKO80ASiaT1w6INDOKZ6I6fcp43RiywvGGquHb/7QQfunZ80XcGHmFolWnFMidGV9KDBh1WbufgVFWgYbwDM755s1kq;4:ndfpzlqjITjjt5RJUV4+0gJcrMsU4io1adOi8Yos1GIDlDJ3o/ZNRs13rfNiMq4IaG5tvKUSOh9GKZY0nNLTOMpIIIW51J63XrPdc3So8GsVH5qfJayfiKCXKJMEfNJYJp8Uo55bnpj0lSngupfrseyc24FDxmvpgez4zAzgd74MjZmFc+prvas+LwL6QNHwqzB9ll+34v215EBoX0qONMMgtSNMrdAAs2gUj7u5yMIB9stsHP0kQGkzSRC/Leluy2ezviTd8IhN7vbP9mvTcChE02vSm/JzAsOW7t+grINN3/7dNWDcjKjHds0HFGy7
X-Microsoft-Antispam-PRVS: <VI1PR0401MB2557E2CFB0CB596C3E1CEF1E9A2A0@VI1PR0401MB2557.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:VI1PR0401MB2557;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0401MB2557;
X-Forefront-PRVS: 07467C4D33
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(39860400002)(346002)(366004)(376002)(396003)(136003)(199004)(189003)(14444005)(6666003)(48376002)(68736007)(5660300001)(3846002)(6116002)(76176011)(36756003)(5009440100003)(53936002)(25786009)(50466002)(97736004)(7736002)(2906002)(305945005)(7416002)(478600001)(81166006)(81156014)(186003)(6506007)(386003)(11346002)(55236004)(26005)(446003)(16526019)(4326008)(956004)(66066001)(2616005)(476003)(47776003)(316002)(50226002)(486006)(8676002)(106356001)(8936002)(86362001)(6486002)(16586007)(51416003)(52116002)(6512007)(105586002)(76506005)(110426005)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0401MB2557;H:localhost.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0401MB2557;23:I5dTGlEHiNDAzr/6tTi2DXT8MDmwvnKk8+CaPcF?=
 =?us-ascii?Q?RQid8xDYzE5g1Aowe9+iCsIFaz3wq8JyOdNjsDDB+fF8ov+BIzFlVMFHhYFo?=
 =?us-ascii?Q?Dx+cyR/TvlHUcd4qZrdvCCm6POen6+CPnIJaM5IbyrXMTCLuEG5N392uoL8z?=
 =?us-ascii?Q?LuDzEifvY7rFqcF7fyoF8g+rv32Mbf5go6tnEv/IPFBSMKO1ryg/YAbgWsye?=
 =?us-ascii?Q?YUdn7VQxFlimNSG2tGgPAUzRlkgloknSPhCB8lml3JvsPRxtVgwu1U/y8OEk?=
 =?us-ascii?Q?QuGD1T5p5V0zj0nGcpnWJaVWPiuTEyABPN/ijqrLVCfxc2cz9hq6iXYE6ozf?=
 =?us-ascii?Q?5sMDzckEAfwsEaG0deL3eV0jVq3zuKF0rx8queuQp/dH785HhOLHdrE0TzSi?=
 =?us-ascii?Q?ci1jNW5j5FJbm5jFn+6utDVJyPCLX4imgMavznXDLO8Nnpaax3+t9XuZHyM9?=
 =?us-ascii?Q?wFUfZtRouxD6xZJ3y+CtSuuoNCJBPEwDPajgsGGggro5hBzPqQjgpLEDNZU/?=
 =?us-ascii?Q?f5eiHAQf/+lRWBKOD/1A66klAJ4CFfNGgfAXAyEesqgl2Mw8JMhf2NwQGO5B?=
 =?us-ascii?Q?Kx7AKxV1kzZIttbJTOgiL5x1GoAcVmWEDSP3ny5E2g/s2gLOs6eMhcfuO08a?=
 =?us-ascii?Q?aOvvECX4wvQDBbdCTor6toWKuW4haFPSMIDv8A54BsggDf2ngSlGGT+QIMBj?=
 =?us-ascii?Q?Y46Kt3qm4BPamtaheFXAdPq6ak6S58/e41S6VS0uTEuXAE3PI0/9Ze/Gxr2A?=
 =?us-ascii?Q?5hoBxCqJh8+2F557/Rvg53PEGvacU29/PlpVKBPo2ShYFyvKcElnleryOiMW?=
 =?us-ascii?Q?13uvjQ1ZeXAMTjZW16EzgDjEt5XR1u3MjmHvO0qbsaVd6HSfGagN9727fDNf?=
 =?us-ascii?Q?ppAdzuJEnC0J8vQRpdLdHydW2FKukK16a+9smrg03gsAxaxho3l+Lbr/YNgP?=
 =?us-ascii?Q?0rwArzEFkhHaXSE+tBdNw17JXt/RaJMIkOoL+hH8REQZs1x0qCAJbLvAvvC+?=
 =?us-ascii?Q?amTeN+oqtD2pbr5HbMiUHNn3SQBJKEHj1Yj572+Q4IaFs2QFMLd2tHQBMZ0m?=
 =?us-ascii?Q?wekEPzqw2smuOyiRP9TeyxPHEYd/IG43aT7vuWpO2/tlwQQblviXNy2Vq2Ll?=
 =?us-ascii?Q?GmbR9P1lU3K2TFS8Dm9wIqat57t5nSAL918cEpVZy4h/1PJVUdwMAOXg1T81?=
 =?us-ascii?Q?aXm11K5/pUs19ieKeJg7RXzlFKVS9ZczCdgmLmuvTnS8Khf+lPObflMd/4IM?=
 =?us-ascii?Q?WPAghDfV3i+AWGzW7DWbTJHB4IJstB/dp16T4z1NarJsBUbB1Jc7ogS07EvU?=
 =?us-ascii?Q?A2O3nQ3W+29enK9KzrBGlx7DV0IU52LPP2R1XShIYJeT4?=
X-Microsoft-Antispam-Message-Info: a5lpTXV+Chh7tK4YJUTaR6+oywtbN913jgbvMowb5WBZVcs8LlgVM4YWflaf+Xyo5BJqBhXhV3UIBi5QaSqDbNRlv4BMjPjA160BZCNgP6VGDTVu1a8sZcZ+wWf7/wuHHAL3fbbza8swtZm3CeHomsi0/dMPVhNFsqueBH21OoYjIJnHM/XmwhdAN4H2ORm4iDnweNnKPpqJAQ6FUezRiiPeDWDakdjOp7tgt1gUAOl7zlC35m5jOOxaGiMDEGoUTYnub5RpMZQxW/xoYzj3jwsOPZqjS6TAOXHyXMK6iUPJ0ZKpeCU4H0y6cVFt8iYMeXzynBf2oImI3RLTYvo+DqV4WxL5GPGaXGi4KfJ8/h0=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0401MB2557;6:2/REROP7nUHvZ2zPNSwXEre8vKowTJL5rNVCambNktBgAEmfMRq7PO0Fa6CQ6bKfYU59XG0LyMhlFikxyv+vFysdpsT8QEEGOOdNwwipNyK1C81WcFkRYWrwgcK9iTTNs4bVhouQSuEH3MBuXtk8P4Nf2Zornq5CgqxByHfN6LwI3vheW6hGK9Olv7TokaGzRAOW1Qp3ghOtP7iJGwhYiigGx3dMsV/u+3CB7s0oF41/eTwxOoovSaF/HlITT32RrPAdV4weViCLwTkYr7Q7h91qPdh34W+9GE/keKA8xj3by2fjiXiVUltN8RPzeT56JTiY2xKOMOpGbMoSbVe+Sh+vJBOWGTG3uXsGFuGzaf/3ifTRVnTwvRo7zZtlV0YwV+hDwHm1aePw2zOMehynSLNA/iC3OdLmHJZHhXSJ6X5OjCBRTLg4GJR5Jp5+2Uuq5f9e3drxY4ZYSe68YiDmKQ==;5:le9LK9oMSfrsPUzRnW9MkKgylOMu7MlijBbjmDkuqHZNUBgwoHqIl4lpN2jRM8F1V97lR46BCl5DQjuJW1abEavKyQRl4ZVLrX5C66S13PrVobKIZQ0uX3RwY4jT7OQRyajp+OcvlRAPpzU7X7ONJuxoqANwRtzpdYLyGsY/NcU=;7:sJUBKWTKHSu3jK08SKwKDB2P+hXcb3G6WqfvhiGtP/mZQsS5kmOdpkTApfodfsd1lf+OxPO4Xr17NJGYyrjMJIUGYJxN4gK2I88CbnjM0bFEfvGvjntOmOqqzC37ZzH8cqZt1ch0R7bbNAhAEoB+viDUc6OO2A4l5U08fyuu9oNLE9eDC6iZeVN+6EZEQ11vezlUaFknJZFhrtgSIZ0ueVyVot3UhEVrKTPSU3q3t8ltDGUzVLQ0IzeZcBzWaSJ7
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2018 09:52:26.6998
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93aedbd0-027b-430a-2b90-08d5f3a6aa89
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2557
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Last irq calculation logic uses below priority order:
  1) irq_count from platform
  2) "last-interrupt-source" from device tree
  3) isu_size from platform
  4) MPIC h/w GREG_FEATURE_0 register

This patch reworks the last irq calculation logic but
functionality and priority order are same as before.

Signed-off-by: Bharat Bhushan <Bharat.Bhushan@nxp.com>
---
 arch/powerpc/sysdev/mpic.c | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index b6803bc..d503887 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -1217,25 +1217,32 @@ static int mpic_get_last_irq_source(struct mpic *mpic,
 	u32 last_irq;
 	u32 greg_feature;
 
+	/* Current priority order for getting last irq:
+	 *  1) irq_count from platform
+	 *  2) "last-interrupt-source" from device tree
+	 *  3) isu_size from platform
+	 *  4) MPIC h/w GREG_FEATURE_0 register
+	 */
+
+	if (irq_count)
+		return (irq_count - 1);
+
+	if (!of_property_read_u32(mpic->node, "last-interrupt-source",
+				  &last_irq)) {
+		return last_irq;
+	}
+
+	if (isu_size)
+		return (isu_size  * MPIC_MAX_ISU - 1);
+
 	/*
-	 * Read feature register.  For non-ISU MPICs, num sources as well. On
+	 * Read feature register. For non-ISU MPICs, num sources as well. On
 	 * ISU MPICs, sources are counted as ISUs are added
 	 */
 	greg_feature = mpic_read(mpic->gregs, MPIC_INFO(GREG_FEATURE_0));
 
-	/*
-	 * By default, the last source number comes from the MPIC, but the
-	 * device-tree and board support code can override it on buggy hw.
-	 * If we get passed an isu_size (multi-isu MPIC) then we use that
-	 * as a default instead of the value read from the HW.
-	 */
 	last_irq = (greg_feature & MPIC_GREG_FEATURE_LAST_SRC_MASK)
 				>> MPIC_GREG_FEATURE_LAST_SRC_SHIFT;
-	if (isu_size)
-		last_irq = isu_size  * MPIC_MAX_ISU - 1;
-	of_property_read_u32(mpic->node, "last-interrupt-source", &last_irq);
-	if (irq_count)
-		last_irq = irq_count - 1;
 
 	return last_irq;
 }
-- 
1.9.3

