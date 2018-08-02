Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9C16C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 06:43:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B35C20BF3
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 06:43:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="vdvEjB7m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B35C20BF3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726941AbeHBId0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 04:33:26 -0400
Received: from mail-eopbgr680063.outbound.protection.outlook.com ([40.107.68.63]:34816
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726021AbeHBId0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 04:33:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PEYwv5MisgYqj/po7Du2okKIvCQFnsKAvdHI5z46hxA=;
 b=vdvEjB7mk8CQxtA8jrDqOmuWqI3mxKpQRLjiTZOZAAGEJ+S4MXiBjDwGf0bmIPTjkOxw55LBv0wiN/oMhLFVfsiw8IUEWSb5yH9JExzA1YyOmMGkUKd2PGtRSQU6mZC276uJ9iiTOINuIpB4Sc4+ZD2nh+Epr3wNzF7kXMN5C8Y=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Akshu.Agrawal@amd.com; 
Received: from akshu-HP-EliteBook-745-G2.amd.com (125.21.194.1) by
 DM5PR12MB2359.namprd12.prod.outlook.com (2603:10b6:4:b4::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.15; Thu, 2 Aug 2018 06:43:32 +0000
From:   Akshu Agrawal <akshu.agrawal@amd.com>
Cc:     djkurtz@chromium.org, akshu.agrawal@amd.com,
        Alexander.Deucher@amd.com,
        "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        alsa-devel@alsa-project.org (moderated list:SOUND - SOC LAYER / DYNAMIC
        AUDIO POWER MANAGEM...), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/3] ASoC: AMD: Modified DMA pointer for capture
Date:   Thu,  2 Aug 2018 12:11:55 +0530
Message-Id: <1533192134-11626-2-git-send-email-akshu.agrawal@amd.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1533192134-11626-1-git-send-email-akshu.agrawal@amd.com>
References: <1533192134-11626-1-git-send-email-akshu.agrawal@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [125.21.194.1]
X-ClientProxiedBy: MA1PR01CA0086.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00::26)
 To DM5PR12MB2359.namprd12.prod.outlook.com (2603:10b6:4:b4::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bdb49dae-18cd-4666-b5ea-08d5f8434903
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB2359;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB2359;3:7Nw12Gr0AmYqBWv1HCLp1BNFIpcyucfHHUuYZA1r/Pi7/e6tw60K8fjbapUixegGMfVyMn1JkoEfgHdpstovGS7Kf5/N8V6mTEw01YY/utUKAGGc7yXryMnU/Q5JuK6cEcacbpJCKRQUgNUhMh6+O1Gd0sCzHaIim2ZmldU8nvYNJ62sQtazDlNC4xOrs+NNpmcl5Hx/9oaCHgMlsOnXViXhC/0IpJP0W5FIh6G2N3QBAB7htxLejdGm3+K/PcCL;25:F2mOz9eNLmbUOGGM8NNkxwPHz7/gP/vfrocw3W0MeUb8Do1d/2/tDfj2Y4Jc6dYEmjz9n+3FkNhrJHBkBQ1o+XWQXESsqpiU7NqdiHSIY4BmBm1odNbD1uRuJ19hmI/zDg9J0pY83TqA+LM1ykEdFGtZnCNaVVfWP/sVb5u/4kcflg+OV74WZqgHs23su3fSMuCz5SkINfTb5CIOtMwLFpUQRCNYtdgT1TbkTezVgPRU5dn24xqF1ZUEppJdASIgvA5cSNQs1Uxw0p41pF4nspGqimGfhkqZw0/ih9rWFtBeUE9rXa42J8epLhtcNib3Kh1UzAIfDT2Z7WUzSJiYrA==;31:FWg/JKkGqBSqWZ20+fSY7QwanDn7gY/OR8lbjtpWO55oJ/8nAjEtKVLwEq4w66bg6nu1Lk9lmuftkr4v4Ex9L7J/x+ET+fU01TKsEfTQ+R9qlg4PmO3hYaWwGKKr8s4YaorvjzTd08z5nQo5NV9RPyeRvrpO9vGgPxp+JqCjk1PfBYImlos+VTdG4pgtQDeFhD2yBjKA/mL3hH/7timWhrTWfYSBdlM/3o8MlnSgX3M=
X-MS-TrafficTypeDiagnostic: DM5PR12MB2359:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB2359;20:wM9VeVX+mzdE5aIx/2Qo3QGQ0DkQeWI2LtD6Vb6AkPG2Pozfy3wMX0GnTlw/nR/JR9m0l15vqgHbqtOrjpfEcFrUpJe3whQRZsEXmk6V2m3fU0zOqt81WdAdZHliu6SQnFlCo/ye2jesF+WhwyCTp31kHXC6Pg4s/tvWARZylaV0TxqiffQYGINtI8YV+yoALns8V6q9Ugq+yseF0+qlprbWrj4djCNHxhGtobk1W/wy9C8zPmcRQcHmnpS4MjKPPnaTRtYCRT6wSFRCxL7OL0M7gkA8znnDV/BMJHFEHpPK0cnMAdDsjb+hPdYQhmXiRRNA8IZsu2IeA2BLO4qaCmNPiF7gAUZreUU1Xi0h/WG19ns4jTJQv9GG2+L8DsYBKDjp9wHjUkiEt7o06AD25cysH92IQzzgLEDSCU8DEpKpEpPW34BxndcoqA0WUgoHKBxAR21vngZCJGHlcptSCOD/mo0sNuAB3tG559aQ+TULV0Cl9o0m1GZ5LuBQOmvO;4:50TaUZhQBn1892RpWLkHZwR3p/A8LJep6vqbo4rPT/13EN1ZSzGf4Pqrt1pdf4lNh8uT4fNFCHhyEL9YsYfFbgdLaX54Xpw2e3qLm9SZ0ueKBa0S1fDL3wIMSLXtKTLw9GHTWCUmllL58ZfjgzJp0MZ2kHcbxbRYhfwYPqa/ViepcQKM7uW8xYu+Rv9fitzYldD8nxHQVBxpvVY6dbXdDEdCt9wFKWYM0mRGcPKRb1Bw6F64fK/kpkshGjZIVinbfaTwBIE8QA0MH0zDlVLGtlObyVZyDRL8DXPgmEX2UmIWWShn1FIW2LvYFdBnQ8UX
X-Microsoft-Antispam-PRVS: <DM5PR12MB235972868F4F1D35D8468311F82C0@DM5PR12MB2359.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231311)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:DM5PR12MB2359;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB2359;
X-Forefront-PRVS: 07521929C1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(136003)(376002)(396003)(39860400002)(366004)(199004)(189003)(51416003)(50466002)(2906002)(6486002)(8936002)(8676002)(39060400002)(3846002)(81156014)(81166006)(109986005)(4326008)(36756003)(48376002)(44832011)(486006)(575784001)(1671002)(25786009)(86362001)(476003)(50226002)(6116002)(68736007)(66066001)(6666003)(446003)(7696005)(26005)(105586002)(106356001)(16526019)(53936002)(47776003)(54906003)(16586007)(2616005)(5660300001)(956004)(53416004)(7736002)(11346002)(478600001)(72206003)(76176011)(305945005)(52116002)(97736004)(186003)(316002)(386003)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB2359;H:akshu-HP-EliteBook-745-G2.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR12MB2359;23:8b3KtB1FfT52a3zpb8whgkZvEC76tlFF49vOaRljU?=
 =?us-ascii?Q?t5HPxZfDASckp5HLkLfHfXllDiSAMWC6BvtmANXoy2/Rbj6zptmssSsydOXd?=
 =?us-ascii?Q?7YYLiJ3f/IcUFiIVNoysfoG1riYPZTGPTbyT4nNQa54FtjC9H+QUq/zmvRp9?=
 =?us-ascii?Q?IF1gixJLREYVDpXgHSL6kWiA9e0G9mYRaezEKDubRAmvm5eqISa+E5mlsQJs?=
 =?us-ascii?Q?oavU/yqKiEcIpYPvcu06F8qJBCAdguvXbb2jnZtvUVnEXUId5mrD2qI7a6RE?=
 =?us-ascii?Q?kRW4SSlBgFzvEavNCZlVvIyuC2dpc1u12sYNg2yubrvXHVdp5zxai8+VkwEB?=
 =?us-ascii?Q?JAQn0OBe0MPv3ZgeC1pi1bDDgKwUX6KyoGWJfuWnYSxp76h6HKmAisAJVRLv?=
 =?us-ascii?Q?a4f/VDXlyhJSeIvaAXFK7BhQKl2bT79dxNObc/BEsgf7vidGT0VzH8t8n/03?=
 =?us-ascii?Q?U5PblwL0QRpasaeehEbhQAsUZPtdiGr7uNwjQre2rA9yJQhZDZiX3jd6XQl8?=
 =?us-ascii?Q?oDVDIIMRvrpKFDdAuGCpMNQ7mFZlXcrRSycWME/vfC13RaFUu09xiN+C85vP?=
 =?us-ascii?Q?M07X/V6eLyUkBgnvQpS5GDLXzdiAWKJKVSM3rnrQdWJungessIm7a4HKVqWT?=
 =?us-ascii?Q?Mmds+M6uFI/JAI+rgXUat5h6mgq3m+7lCX0rBNM16KjOsN7+6rtlEBlWzxNG?=
 =?us-ascii?Q?ZLJlpiveQcTnvl05NB6V5zFImEi2wl6h8FIyfe6M0wMSEDLrD3FKNicpr22L?=
 =?us-ascii?Q?1EH1gKdl3uLYu87e+8ML9FK/eUC42roaU1NU9NdKzmBCPJEjkUqaFKYmQT5l?=
 =?us-ascii?Q?vXW5jJ+NvM8LVzFFQleayvUEfYo7e62ltbPmoEjYmK9e44dXp0fHTuZ8kR52?=
 =?us-ascii?Q?8KX6+LwDgfwXYGXGhi1Y1C00MdGbgzxpcOF3Skw4pY6dvNPVasISNDJabAvJ?=
 =?us-ascii?Q?5Znm3CBfrgUTXBPdx0SV7/m3z81y5K2Xz9rFLjREQhrn5ZzKVPknOz4+PkZn?=
 =?us-ascii?Q?MCV4Y6aSas0VXZeSsivBItC52G2Rjf15PIIqUextlRKeXMSLG/WF1T8N42DV?=
 =?us-ascii?Q?qW0ub0dZZL+euNsObtf5tkr4eaT++oltswPTLVw0Eu39yDQvspYYhkC5Y+Ng?=
 =?us-ascii?Q?4WUTXbUnHN/2c25AesjrT+HLPaHKtkyGlKJ4CdFhgkv5E6E4zK2vxSW8H52q?=
 =?us-ascii?Q?dDmQw+fxoimAcLKcMkCYVuZjaOLXUTI3FX58GaKhwOZLBo3OJZA54zuBpvFG?=
 =?us-ascii?Q?nBaWlbR/aK39TzcYn3lO4MxQSSxnWH28vrTMI2LHHnf6BKCd/kCMbRsEl+ik?=
 =?us-ascii?Q?dpZ7IjfVFIpLBd2HOMpaf4=3D?=
X-Microsoft-Antispam-Message-Info: ZN+qHhytJAOiE3tReYeEp7qdVlMdP5Wj0Yq2EnD51C/vGCF2JDSimFQ/NkiXSRT6qbhoh3MFtypIRijolCA+AwnHOaftuFJXWUmF4aod5+pc1F4//WhmVszkw3wVNy2DRNDOvTc+YfgqUrieyoxxwvDp34+YFpSDx/33/ysr144MwdkbDEwDCSCeMFiLtE5u7+Tg70q0uSO100jXm68HnJNsIxD708qbjs/gdniztmhUF9TYzOYkpqqoZ+oj19tUQUI0eJ1p88JMw7ZCr6Oh7+9j0Wfwgemo15g8USUzjX50PIGI3bTmq9K97jULkpIFKMrDSSc8iwgZlxcePIgRSzLkr+qHZFluplSeJ0rX2uM=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB2359;6:ipmGVJBBwI+hC0uc1tP3UQMUjaOsDwpuelznmitJ3umA3hl1plpTs82Jy3UtbxZmmqfhlAmCD6QEnngg9ENJ/Svm0Zxg87wrLuCCwm1eBfj2CQ7vdVIUZqkiN9jk0FzosXVRwEToNo27OqPHQGXpzHqn74ARQCyRTzEUxRVTu/q8ZRJolCEI2wO77Wc5/2RCs9OkOLL5QM4dChRhEIh3ScoBP3el9nl6vJwO8Y8QlHSK7SnPzgg5n5TajMDnWzt/pfz8QTSZ6ak/DlaKicvNnkBYOLOo/lM/v8OpiEdmKiBnR8THiu+SygqFk/uCpI3jJq48gw0/sGKVgn6IISHpkq53Riv4VW/ePJlY0nxWAet1Dl7w7MxDH6gi0PbK0aQObc144m7Ck8xc+5bfiiIm/UaAaxUyvsG2Z/jVwrVxd5LjAgH0OUlAeZUAXBtLcQURVh5+3SECZNOxFjZ+77Mvog==;5:I+/FFMmVTOPvO4HYINFGu+QNfPDxr2QSw6Zb6fmPyxSjVDptFR+9oVsxBh2YTgXgpO0lPFuCJFdh+VkkI83L3ozXyIztsi+gcZk9QTjBTBgA1nTUyhBYI6YA9aKF+m/I1HfPkyuLBPRMTSKpmib0IO9zr/EzCsB8s4O2EQ1tK0o=;7:FpqBHcZJKw1yK+C1tPCHTq1rs9+mNChBpww6MnTOEk6NjIC35OJCs0tWMD4hvsKDL+Vazz6lV3DGZ+721F008n+nKQ2RZxBr0ZQlNnTqy5BWW9F43bCI7i+5/3CyMwYLtjq0fuUkirvWc2v7QcDkWCzYEU9DzEroWgXBm+giWEbc+2rTkd+5FCiIlE73NxadJkGrBKszMfSC3zQ8jGHNbvw/TODQloyZ7kYdXUhgtxWI44lAoyMdN1fqtd0pTGIi
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB2359;20:z/evvwropjGtQFtKw+JCAC1uev76tK3HDIcawUTeL5zEyudA4Hy96hQHNmGoumxnraH/EZBSl3EixIFLOKqu+48g9lidCnP/e1iVDlBH/p/h8CAoldrKtpCBdUz7ullShykioGXh1Ofqcpuxrixz861FFBEBLXIt8g/+xaLijjZVLJIFg+d8+P460ZUE0UPGZwQTuwJZgD5r4R0hZOIr1T/4tvMe3ti3pAowcCBl/Id1RWmN+NGZUPoNmGwP1OrV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2018 06:43:32.2164 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bdb49dae-18cd-4666-b5ea-08d5f8434903
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2359
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>

Give position on ACP->SYSMEM DMA channel for
the number of bytes that have been transferred on
the current descriptor under service.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
---
 sound/soc/amd/acp-pcm-dma.c | 34 ++++++++++++++++++++++------------
 sound/soc/amd/acp.h         |  3 +++
 2 files changed, 25 insertions(+), 12 deletions(-)

diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index 816abd6..6240a77 100644
--- a/sound/soc/amd/acp-pcm-dma.c
+++ b/sound/soc/amd/acp-pcm-dma.c
@@ -922,10 +922,9 @@ static int acp_dma_hw_params(struct snd_pcm_substream *substream,
 			rtd->destination = FROM_BLUETOOTH;
 			rtd->dma_dscr_idx_1 = CAPTURE_START_DMA_DESCR_CH10;
 			rtd->dma_dscr_idx_2 = CAPTURE_START_DMA_DESCR_CH11;
-			rtd->byte_cnt_high_reg_offset =
-					mmACP_I2S_BT_RECEIVE_BYTE_CNT_HIGH;
-			rtd->byte_cnt_low_reg_offset =
-					mmACP_I2S_BT_RECEIVE_BYTE_CNT_LOW;
+			rtd->dma_curr_dscr = mmACP_DMA_CUR_DSCR_11;
+			rtd->cur_trans_cnt = mmACP_DMA_CUR_TRANS_CNT_11;
+			rtd->end_dma_dscr = CAPTURE_END_DMA_DESCR_CH10;
 			adata->capture_i2sbt_stream = substream;
 			break;
 		case I2S_SP_INSTANCE:
@@ -945,10 +944,9 @@ static int acp_dma_hw_params(struct snd_pcm_substream *substream,
 			rtd->destination = FROM_ACP_I2S_1;
 			rtd->dma_dscr_idx_1 = CAPTURE_START_DMA_DESCR_CH14;
 			rtd->dma_dscr_idx_2 = CAPTURE_START_DMA_DESCR_CH15;
-			rtd->byte_cnt_high_reg_offset =
-					mmACP_I2S_RECEIVED_BYTE_CNT_HIGH;
-			rtd->byte_cnt_low_reg_offset =
-					mmACP_I2S_RECEIVED_BYTE_CNT_LOW;
+			rtd->dma_curr_dscr = mmACP_DMA_CUR_DSCR_15;
+			rtd->cur_trans_cnt = mmACP_DMA_CUR_TRANS_CNT_15;
+			rtd->end_dma_dscr = CAPTURE_END_DMA_DESCR_CH14;
 			adata->capture_i2ssp_stream = substream;
 		}
 	}
@@ -1002,6 +1000,9 @@ static snd_pcm_uframes_t acp_dma_pointer(struct snd_pcm_substream *substream)
 	u32 buffersize;
 	u32 pos = 0;
 	u64 bytescount = 0;
+	u32 dma_count = 0;
+	u16 dscr;
+	u32 period_bytes;
 
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct audio_substream_data *rtd = runtime->private_data;
@@ -1010,10 +1011,19 @@ static snd_pcm_uframes_t acp_dma_pointer(struct snd_pcm_substream *substream)
 		return -EINVAL;
 
 	buffersize = frames_to_bytes(runtime, runtime->buffer_size);
-	bytescount = acp_get_byte_count(rtd);
-
-	bytescount -= rtd->bytescount;
-	pos = do_div(bytescount, buffersize);
+	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE) {
+		period_bytes = frames_to_bytes(runtime, runtime->period_size);
+		dscr = acp_reg_read(rtd->acp_mmio, rtd->dma_curr_dscr);
+		dma_count = acp_reg_read(rtd->acp_mmio, rtd->cur_trans_cnt);
+		if (dscr == rtd->end_dma_dscr)
+			dma_count += period_bytes;
+		pos = dma_count % buffersize;
+	} else {
+		bytescount = acp_get_byte_count(rtd);
+		if (bytescount > rtd->bytescount)
+			bytescount -= rtd->bytescount;
+		pos = do_div(bytescount, buffersize);
+	}
 	return bytes_to_frames(runtime, pos);
 }
 
diff --git a/sound/soc/amd/acp.h b/sound/soc/amd/acp.h
index 0a2240b..cf7c0b9 100644
--- a/sound/soc/amd/acp.h
+++ b/sound/soc/amd/acp.h
@@ -134,10 +134,13 @@ struct audio_substream_data {
 	u16 destination;
 	u16 dma_dscr_idx_1;
 	u16 dma_dscr_idx_2;
+	u16 end_dma_dscr;
 	u32 pte_offset;
 	u32 sram_bank;
 	u32 byte_cnt_high_reg_offset;
 	u32 byte_cnt_low_reg_offset;
+	u32 dma_curr_dscr;
+	u32 cur_trans_cnt;
 	uint64_t size;
 	u64 bytescount;
 	void __iomem *acp_mmio;
-- 
1.9.1

