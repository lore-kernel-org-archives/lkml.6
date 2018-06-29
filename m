Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE7E5C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 10:28:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AA3A25504
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 10:28:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="dPKf7YPz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AA3A25504
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754756AbeF2K2x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 06:28:53 -0400
Received: from mail-eopbgr60081.outbound.protection.outlook.com ([40.107.6.81]:52128
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751114AbeF2K2u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 06:28:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gDfgUc40JpCG32aJ2itx5FiLgem0ngiSaf8yT4d7g9o=;
 b=dPKf7YPzd0WCfEKqDPASU9i/QUBdZbJV3+8eks9E6NCU061jcJEQrZNxCOUI0qwOBMKXimH/hC38+fsomLldw+SHx0RggRil07r1eFnM/oggIIc87gdkb73k46y4dHqJacUN2Azr/XUa/SW49WBf3PWpqIVA9HWEVbSP0XNVqNA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=bharat.bhushan@nxp.com; 
Received: from localhost.ap.freescale.net (14.142.187.166) by
 AM5PR0401MB2545.eurprd04.prod.outlook.com (2603:10a6:203:37::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.884.23; Fri, 29 Jun
 2018 10:28:46 +0000
From:   Bharat Bhushan <Bharat.Bhushan@nxp.com>
To:     benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
        robh@kernel.org, geoff@infradead.org, tyreld@linux.vnet.ibm.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     Bharat Bhushan <Bharat.Bhushan@nxp.com>
Subject: [PATCH] powerpc/mpic: Cleanup irq vector accounting
Date:   Fri, 29 Jun 2018 15:54:32 +0530
Message-Id: <1530267872-31244-1-git-send-email-Bharat.Bhushan@nxp.com>
X-Mailer: git-send-email 1.9.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [14.142.187.166]
X-ClientProxiedBy: BM1PR01CA0107.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00::23)
 To AM5PR0401MB2545.eurprd04.prod.outlook.com (2603:10a6:203:37::8)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ef5c74fb-f9c8-4ba5-9625-08d5ddab1993
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AM5PR0401MB2545;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0401MB2545;3:JcaaJdMCboSFJoeyPp3D1X7Y2D5LZ2NojTk2HGDmPVxjlqL4cfoB4Abf+vgpcrjvIK4fi3z6SW4gNtnEk0OjPY7Zn4McMBv7LNk1Vu0rAhvzF55eIfyU1YRULKEIrC74YUZW6HPU6ht6yaYKnfjtI1K4lDqtn5xbUbyLI7p/AAenkboXINoAktnsAca+2h3hzl8apkt667XhcqOoImqhcVAX4bDLiWkHApgBnkmobHke2c5cxnLlCRaue5H3wpHP;25:En/EWIgCK7n+W4cALHp12KXJ8C9OlfcgPxjvEA7DWc5UhSUN8U9boMPLOOR3gkPAOjc3EAtGWZsWTGe79+l9NEfPl9zEVka8cM1U9WBF4FEp1HhBMdiocrK2UitYHOEva/g9s/ueeicz+P8OvWvQy1qXQRRrLWpabUY6/K6bX3IZVftwQnsk/FdTZmkW0r70PqirfHPzc4C5T+Izhm2YgNIn+PnqO3xyV08/L/NwO4UpyH/96Am6eaNHqgcYB00ME4EPvpnK646IGdkOMtfKV3ETEQL1Ms90MSKnlYxAwmE2XPA+QVbkrCXuRucsmFXo0V0uhCe8HP1AZIlXL9J5ag==;31:ZrvH3VEn9LkoTHgRCce6KWY0Lih7i9oyaQSAHUeFyE9pNaLz/tvXfcgk6NiHcRJQNFjG4DqmNR5Aml94MYUb6XlQurEphYldY1WbrH7BRDzYWM051fgTLIluw8h8pMTgXrpcAZ9So8zsknBd9DhLyDFsUtPY4I6JmPBvqSXpLRUsgHWyKFzn9mV01zyZuDc8oM19pPN0L5jujjsjwf4UhLocJ4oWOsn4qJkaOCv9ooQ=
X-MS-TrafficTypeDiagnostic: AM5PR0401MB2545:
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0401MB2545;20:TK6UR/cu76mMhj+8UehShh6s4uNHdNJwl31zl17Is+jfd9+Ohy264VHHXSPMUsFYJEnx49wWx3gtqkGj37EUJYz01TyRKybdKI1hQAXyk/MJWsyB9EPfFoW0NkzVHZX06j3E2cRl3NAYhC0aBEfrX9eR3mga31wrxWAC7U/hxldn0POkCRuQPKEO8ra0fFtMLQ93SB7vnYIMAVSMWx/OHMDMnrQCX2pmTLd6qrU7iClmiY6a2rNiH2vxEtsxH8FpN+RDuljvCUrv3Okoe844qDHRMmP5Eqcoo96YaVo987AWYODcFp3VIkx15exdRKOZSuAF0GSf1Hh/SaySFizcMNmi6xdV6IQ0GJE2Xp8DTA4ZzxFcdgNTVcIL5Xm6LzInu0lTJ4/6SQHHiBwgoha2JhfRYLTIZXDcqNOA3t0Ua/Ab4u0pilAqmYPyxzbjZz6EBodC5b4UDn66q8D2EUVyYT8u/NZyQ1mq+ej4/hbn4HZN8jGrbDNH8JAjyNVLn1c0;4:531bDNwDoD6IZIeSDEaAAzoWtNo7zNX6z5BFU/Whx7J2TEodOPSSCg5UqD3L0Fe+AOeP/Q4dSX+NnIvciCbRaszLYTUzIlmAjOlbiei00KiwUdYHLh5JOiVN70uv0eZdFd8PSZrHE9DycwvO/lDXsr0trSMdkr1VsyOz4EmTAV6EdHX1E2Wwz4kuuBl0NwSRyekH2fLWffIVPkq/fLCjNuhIfHIJM7dK0JbgoxVa/IdXkaCxqVnK0+ulnmBciOsIGPCMXPfW4Kx2FJe+Gs1/BdTs68fZl5MzcMF/00Igk0OjquVlfYb7cIVAqUDxxjiv
X-Microsoft-Antispam-PRVS: <AM5PR0401MB25453A80AA506073EBB348669A4E0@AM5PR0401MB2545.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:AM5PR0401MB2545;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0401MB2545;
X-Forefront-PRVS: 0718908305
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(396003)(376002)(366004)(346002)(136003)(39860400002)(189003)(199004)(76506005)(50466002)(478600001)(36756003)(6486002)(8936002)(66066001)(51416003)(16586007)(81156014)(8676002)(6512007)(55236004)(316002)(5660300001)(97736004)(48376002)(575784001)(86362001)(386003)(47776003)(68736007)(2616005)(476003)(53936002)(305945005)(4326008)(956004)(186003)(15650500001)(50226002)(6506007)(2906002)(6116002)(5009440100003)(106356001)(81166006)(52116002)(6666003)(16526019)(105586002)(486006)(1857600001)(7736002)(26005)(25786009)(3846002)(110426005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR0401MB2545;H:localhost.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM5PR0401MB2545;23:Q25Q8D/GOhRtzZ/jcihr+k/ujKePJu1XFL79VXc?=
 =?us-ascii?Q?8wQbqdtkDXfzNz3zCsetz9xiUPAMEEELAEzCNsRhGo8Moq2JqsICPoy9m22U?=
 =?us-ascii?Q?S1K+XoIXMvusjVBnRSuW2HEEOufskppLD0bUfQEkh7ppfvtqschP95yMEq+s?=
 =?us-ascii?Q?bUDW6i7k5E+3BcwPGn99/EDFWEy8844WdMqbwEfPVg+H+Wyp5EbAxJfvm6dx?=
 =?us-ascii?Q?qeGo5/2B/RVR49sHbU1408uEHUeKlSMHn18vCZ+h1NfGrvB4nLcFZxlbI/Tl?=
 =?us-ascii?Q?IK3n/LIgC6JrACQ7FJGxGoYoXyOXNDjyQnN6PxtEsrTGo5913I0vuFRY2EBD?=
 =?us-ascii?Q?I/pvEAzrq3CfGMWpFIIMWA/J0kuTMNF4nXByVWrAa+p6s4FWoHaxuj8F021o?=
 =?us-ascii?Q?1bxRGvtVt4Vy0CjuhiNDV9Gq7+xKWgBoi/6vad7ePVMf6hxi4NKaNncGMAsy?=
 =?us-ascii?Q?28m19Zj+zotj7n98cviUr+X1e1IQz+vJn62qmb412gxXvjTFpGRaHv5XcGlb?=
 =?us-ascii?Q?s3vc/BggHKZJFguSAdrzDhPHr7VJGNHGj5AU3cpF7i4omoSbmStXZx8XK88N?=
 =?us-ascii?Q?tcM8+GVOPlvmDumW/wu82MQstEAVC5+fiD6ykBqY1+KlVQJiIwW9O0QWQlYI?=
 =?us-ascii?Q?4WPwlNOTOFQ+Gnjd8I3fsh/wlp9rOj7631iUwLr30BjTfN/5mN1F9908GJAc?=
 =?us-ascii?Q?rx+KZM/Z4y1cXm2g3gTNXVQaCUYcS+W+3xjV+8j4CoXTjZc57bcWBUCbP4bZ?=
 =?us-ascii?Q?IH7niyCHI9VEDwN89hVavrMDIcWSALPwmTOMHoDFBxCHwPFJUuyfE5IaxoqD?=
 =?us-ascii?Q?RBkoTcgoCOkfq6F3zhfCCQDx/KWAL37cPA4afd6xmWNjV0L78sKDTDEi5TOr?=
 =?us-ascii?Q?j8L3ADTUkPNN9lrI8agOXl+iSVmwGEvVxL/yOT0k/nSOkNpfaXDqVR0cXjnZ?=
 =?us-ascii?Q?Q/Il9GbycAbsotvHWfubu0E7R1J6XlKYP2pfyxsypfjFJr902lZ577CN2LQ/?=
 =?us-ascii?Q?FzNoDXYHKfcnfa8LugelQxrHnCUlZq5YnvDJqrjPWYIjNWbyZqZBbYSEYFJP?=
 =?us-ascii?Q?vmPG6jCkXpMwur6OJFooTzMP3KLUP+SpHCDbgP1Nvk5bPKJujUS1ef8oBhSL?=
 =?us-ascii?Q?LAgMvK8VMAtoGPgxxn6oxsYXgR4CTCpi4LQbkxDYUeGCadeWgZHX9gj2EvHu?=
 =?us-ascii?Q?9AL3t6qSfWZf/UM1cmE0X1WnieLXijGj2bkIdORyrNar9BWyWLvQHbLgxElX?=
 =?us-ascii?Q?0RH0xMyur/OoFyWKNcAoOX1PPLrTWSotWwgKFucv2Ij+SKS8iQPEJINyKSSn?=
 =?us-ascii?Q?g+A=3D=3D?=
X-Microsoft-Antispam-Message-Info: tSFqzGlFPnF2gVsY3YugWZtgGvi/fBDREh0pFrCrH8fTZjY14tyO4YWdLJC8jGOKMttNKMAzeWv0wVNMcXW61etoyrRss3PCbKOziEVoBFqjpKsxL+vaUFwkVqhFdkIF+ws3ZFCgYOzB/PP6wFw6py4+eMCivXDYo14Y/0HE3LPDFcDrJPtjd5OiZgRpk2FRgeNQrDeN9bJx6QSk7Ukahy5go3ht+1L36pQHD/ZXGxnYE24Zo0k9mcJeZEz74x8YMcNzWddtZzAJonb24uKWIoL6HF7f2eCOmmBXsMTeLkepz/gwyaNRoEG6Dgs+yqD6/zh94V2C7t9hEXlFEsni+zcDSUtUdIQ/p4gWyltL+1E=
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0401MB2545;6:iCe3l1xKmD+TvV5z9ZEVH6l071+sZaN3QfaJw1yLIePnMyMBz5FfcajHROCwNQBVPRpaUz0ndbomSWvWFRqRVQ/e4GdWr2ReOjurpKIxyPSqmFaJrmvk43RH5WpqCm7nies6TgYgPQi0SnQayCG71FqAULcPbIPstK1BUJA2P6ySBy36zyxQUVHCA+gTa2vNhdRdmG8NZAGpSd387C8eI7nfz/AAU2hDv8AdNdVsbAjZB3GNFAlxLpHNJAU8qtuWyVQ86YsAXJkWfyu9xHu5LOJZcghGPEGryraYOxbGv1GuQw1ICaTHBPqCz2M78h0sLP7Vbn19CrZxUGbcsLAhFm1V+FhalWSYlcbQ8f6LM3VKtyzGOSlEx8AxWKyvm7rOHk1jihvJeMi9qmQhxBVkU/3SHVmIUpjjRxXg1lr273h78xjUPcXpsi2sQTyxpNHvSCcJsN28lVk6KAwvzg5UQQ==;5:pUI9QiPXwVvxa/aEqnLyE0ws9xwxt0R7eQmk+6FPqUT+MK3TVwnJ+6gae485SLOydrLsX3APQk0pjfuJMjJ+FaRr155DyIo18bhnGlwBdQd5RuJaOIliS4D3bZqm2uha3eWndEm/1gWyGikDbXimHi/TiI33/Not4i2qTXSXeWQ=;24:WLz1ricwNoQm7Vtwwz9xtj1CcNazgrLObuY0MrU4bgnqJZcWl3hVJLwhaGmooHqVwseWwl9zXzMXig4EVPnyOKmU2omixx8l6VUrkrW873M=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0401MB2545;7:lKgO1JPBW1i3SW2oHDImNdfXM6OXxZ2HSUAQERxrRGqfbA/0hXrwp3HxabKG+iP450pCHljwbiq2cp8oj3N33IefdVBvek4WsWrMTbftfLUxKBAKkBZ/NYZyIyOnV2zBtT499T++IgfbtsWT9rIb+Xi/SFRlqQgrAvn3Fns6hVmD0r+yh9T2wxIuQ0SU0RD6uIQiUmvA4zZ+KuGMn0opVF4Wz12T67VhZ+gQrhr1hBk0XE+WmifZXk/xhXa5t3qu
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2018 10:28:46.5008
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef5c74fb-f9c8-4ba5-9625-08d5ddab1993
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0401MB2545
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Available vector space accounts ipis and timer interrupts
while spurious vector was not accounted. Also later
mpic_setup_error_int() escape one more vector, seemingly it
assumes one spurious vector.

Signed-off-by: Bharat Bhushan <Bharat.Bhushan@nxp.com>
---
 arch/powerpc/sysdev/fsl_mpic_err.c | 2 +-
 arch/powerpc/sysdev/mpic.c         | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_mpic_err.c b/arch/powerpc/sysdev/fsl_mpic_err.c
index 488ec45..2a98837 100644
--- a/arch/powerpc/sysdev/fsl_mpic_err.c
+++ b/arch/powerpc/sysdev/fsl_mpic_err.c
@@ -76,7 +76,7 @@ int mpic_setup_error_int(struct mpic *mpic, int intvec)
 	mpic->flags |= MPIC_FSL_HAS_EIMR;
 	/* allocate interrupt vectors for error interrupts */
 	for (i = MPIC_MAX_ERR - 1; i >= 0; i--)
-		mpic->err_int_vecs[i] = --intvec;
+		mpic->err_int_vecs[i] = intvec--;
 
 	return 0;
 }
diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index 1d4e0ef6..e098d1e 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -1380,12 +1380,12 @@ struct mpic * __init mpic_alloc(struct device_node *node,
 		 * global vector number space, as in case of ipis
 		 * and timer interrupts.
 		 *
-		 * Available vector space = intvec_top - 12, where 12
+		 * Available vector space = intvec_top - 13, where 13
 		 * is the number of vectors which have been consumed by
-		 * ipis and timer interrupts.
+		 * ipis, timer interrupts and spurious.
 		 */
 		if (fsl_version >= 0x401) {
-			ret = mpic_setup_error_int(mpic, intvec_top - 12);
+			ret = mpic_setup_error_int(mpic, intvec_top - 13);
 			if (ret)
 				return NULL;
 		}
-- 
1.9.3

