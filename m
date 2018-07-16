Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C94A7ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:03:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FF6D2086E
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:03:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="xCQJCC5Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FF6D2086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728872AbeGPH3b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 03:29:31 -0400
Received: from mail-eopbgr730071.outbound.protection.outlook.com ([40.107.73.71]:21776
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727540AbeGPH3b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 03:29:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XaKf8CmuIcKS/zEqu7yu01cClrMy6LQdNF7ASVO4FW4=;
 b=xCQJCC5ZmKwMC+l0xB+EOSolhAMcRuQSd8xKZBflJ8VxShnA7bpMocaBz4mIiI3dtD9ae5AswygUdkT3/LGF0vnwG4Rkw1w3wmS9/b4OA9gVvZo5sitaKCysMCKl1WswLSa/BO17ojHAIZqJ4KNG16YGIMJMxnSNriUFkd5MDjw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Akshu.Agrawal@amd.com; 
Received: from akshu-HP-EliteBook-745-G2.amd.com (202.56.249.162) by
 SN1PR12MB2365.namprd12.prod.outlook.com (2603:10b6:802:25::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.21; Mon, 16 Jul 2018 07:03:26 +0000
From:   Akshu Agrawal <akshu.agrawal@amd.com>
Cc:     djkurtz@chromium.org, akshu.agrawal@amd.com,
        Alexander.Deucher@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Guenter Roeck <linux@roeck-us.net>,
        alsa-devel@alsa-project.org (moderated list:SOUND - SOC LAYER / DYNAMIC
        AUDIO POWER MANAGEM...), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/2] ASoC: AMD: For capture have interrupts on I2S->ACP channel
Date:   Mon, 16 Jul 2018 15:02:41 +0800
Message-Id: <1531724566-4019-2-git-send-email-akshu.agrawal@amd.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1531724566-4019-1-git-send-email-akshu.agrawal@amd.com>
References: <1531724566-4019-1-git-send-email-akshu.agrawal@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [202.56.249.162]
X-ClientProxiedBy: MA1PR0101CA0066.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:20::28) To SN1PR12MB2365.namprd12.prod.outlook.com
 (2603:10b6:802:25::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 22b12abe-4cc9-4be7-7f37-08d5eaea3f16
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(2017052603328)(7153060)(7193020);SRVR:SN1PR12MB2365;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB2365;3:T01dx/NqhLTADBolbYzaEcvtjW4KWFoSsjsph53nwVHqMbJ/qwapTaxauOP9d0W7CPDL5x4oVLTSP8WFcOCFTdrl4JElv09DeGA90C8ybthEbCO31TQCQmdiv7yjgJ/K8ANNldyXszcC0IN7JgcSaZ8h0oucyH3bZRQ7yuoUBMK2CDzERKxnqxueZVP9Dt1jKV1+5YujelpD3fym8Q0MKPTaEy/jY2t9sgV0kJgaiCIjoBtZtgZVXN5b4dVaY/s4;25:VoeYUsydMrX6kO10IW0Sd93tta6aPeEgC5OOcTqh9HQh4GwiWN3+M9KmdFeSvNNPjHX32CKLwzPdL0kqSKuM4EnGv3QiTNjWfML1bZc7wpr4m+TUQjNE+90soSkHl6OoHPHb9C8cP+UVQj+AULLF8dL8zSgBGEC6RX+q4HRrldMHaPVt/69UofcuzWi8ZlnnKrrZtOYDEFUzsYbatenZ7qhz5OKNsEWADTyzpTm3B+p1rUulDnlApd1cy5zYFxvYfdCJSIYcg2cvaLm+VL9lFn3nanrgo+gTSDDQ2W2SqzI0IbupneiNEX3bIwwvu2QFmL24CPwfkSTASB1DSlrrqQ==;31:Rc2q/Qmtvo55dkce1q3pyYjX+WlKCbEPzC76PKjUJg5HtjCHlZ5rIjulTE7CtVjH8gVdVKQ/YWVP3s7l8zFCsXd4rVDpFzyW/tNPMvK3GdTuYIcXqEVG+vib2qdvhVEX04ReV16n1Ih+oa6th9LY4SnnmeIaxpP+LZ4kRVdRt3/BCjGz5l+YR76pkT0QAKfuIGnByfMNoLNGQEfJp1MAjj0ItAV2y80hSXzIYcsFwGs=
X-MS-TrafficTypeDiagnostic: SN1PR12MB2365:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB2365;20:jMCrthv05OKzo/0D60RQvEYt1nrHOB04/5mBCaLQHnmZ4VzCdaIkCVbwhgCQ/NXnzAimF/SGtQ501INsvQ1Ywv0RCQ66btqFjDg9mKUae67MaanZd/RdcLk+uaAO2WIY+nF9HpGUuwCOVazUdA7bfKDXUbWjP8t2iOFo8tBfexVczvSh5ugzcDprNVkv28CmbtMB/FfVtRng2OGOyurSTKmjNhY1xWnX02eOL8d49bwHEYz4JshKfemNJl1vYcjIryEv6sgtEnL78Ay1I9mhbhZZkJ3K+lHhYgbVFprYzeqxzQm0a5llUJ13PKKpp+nGGU7RTqf4M/Uy9iEcMyXowCYioOrCXA/zOQxN74dKJMJ+f6qp5N7obJYDWwAUIrHBoVvcElp6Qcb4jtq7oCPPIFp+A1w5ISzOoxwrBRY3IvsXJTQy/gazKOYrFwtGvrMGHE7LeJAvKmW2lTx3yTTanJ3CN6Vt1q3B5xavZbMiRsAojHEZXvGwXx/q1O/ueTEz;4:g1FfiTuNOO1luIIhPd813UFMn2qXPWxmzgWqvhFY0ufOjzJ3mcBbne12SWHdisCeRm74VJ2WSxI143WgEBEu+runlVijJP3oBXcHKbGERftPEM8Y7c/tXR9JIa4SIirco7CMnBjI9PVzskLL814hyU0xWELOY4ehRI0od2N8qxprtymrcjmsJIZbVrqZvnp5pabUR+5F3GCX1je1vjJAZvLYC+JCPCBWTDKFZcPOF0kZwl70MkW5cZIn+hkqdlzP9l0Y1JUSQcXjZf7P+f0QOMiXBQ203cQEBrq+qSKBvtBEnmq+N9vj++T9MPmWFljG
X-Microsoft-Antispam-PRVS: <SN1PR12MB2365001DF225E7CFB480CC5DF85D0@SN1PR12MB2365.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231311)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:SN1PR12MB2365;BCL:0;PCL:0;RULEID:;SRVR:SN1PR12MB2365;
X-Forefront-PRVS: 073515755F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(136003)(39860400002)(346002)(376002)(366004)(199004)(189003)(51416003)(6116002)(16526019)(6486002)(1671002)(386003)(7696005)(186003)(48376002)(36756003)(26005)(76176011)(72206003)(52116002)(50466002)(478600001)(97736004)(3846002)(106356001)(105586002)(53416004)(316002)(8936002)(50226002)(5660300001)(2906002)(16586007)(25786009)(44832011)(54906003)(86362001)(53936002)(81166006)(81156014)(4326008)(305945005)(6666003)(8676002)(7736002)(109986005)(66066001)(11346002)(2616005)(476003)(446003)(956004)(47776003)(486006)(68736007)(39060400002)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR12MB2365;H:akshu-HP-EliteBook-745-G2.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR12MB2365;23:YQniN1hLRQLJWh0VOA345/orc8xixMAouFkYRwBof?=
 =?us-ascii?Q?23lB2u7qDzCkr3T2YyyKE65JxJcgo6usEV50yxblqU3LuPwK8eecy+8jOfzT?=
 =?us-ascii?Q?AHtxUo7C8X1KmUSLO3DdC18ePnbOOm7Ckr9IrVymXQ2fghL+e7Luo/77kBFR?=
 =?us-ascii?Q?x6nlUOLzD3j7xFjoIRiyNH8LAN2jM00J4qHRfU1+5wVcKdq873/K+WrkzMtj?=
 =?us-ascii?Q?qxGcLUMdnvz0hP4GwivduwgtdiOvE7hgEeN4Vxzw4OF8m92qSxvcyH1Ll6PP?=
 =?us-ascii?Q?+8kKBgH4Mw78U4n0GqE98JIIDbP2G8GPP3NWKtz+Ca6oeQbqwc/XRe+9yrl4?=
 =?us-ascii?Q?8LfhD+a6EqcKtqitRMVdPQoFN3UKaL6p+y+htJZVDAcRK+GLlYPe9oEYj5Xq?=
 =?us-ascii?Q?ss+fKM/gZ71IuOB/hqcoNZ787dXczoI0xsOJ/GVKdADq6TUXg5ewPKUlwKsE?=
 =?us-ascii?Q?Q0pAUKgAqPmtCGXjSiDqCqBoXoF+8a84LzUlweqfSSa250i/u9mNgT41NgKU?=
 =?us-ascii?Q?zuDCmyVfvW3z5MMXfVnd4ceLkfVcoi242dilm/9byp4DmEgyB223DCYeakEf?=
 =?us-ascii?Q?AiGZnqqVvrdKEMKE8nhM0iZ5BlTh9hjtrNip9EBuQ+02DxmwtilUFyTgh05J?=
 =?us-ascii?Q?jsMrSq1WLFrZZ851EY7w3zTpaKTiSrsfmYar+RKzKLQrjHiiJhEnrifevGBg?=
 =?us-ascii?Q?bOdEPpdNjuHknkhZBvXqvKEuho9sBFC0XPh0bNy1DAIoAfQXe/QByFQ2t7a9?=
 =?us-ascii?Q?RGrpnsmAAOeXXWW7Utg+ze5bzlZKHyCk9k5P/4U91DblCygRqYP/NTqQEbnA?=
 =?us-ascii?Q?Gtjsm1xPMxsr+DstsAO1Q047TyFZACvG7TnyEELeLKQJpg2LibkA8nXY1bKI?=
 =?us-ascii?Q?NYPSI8kMY9dIu0kA7fHZgPt7SPt2osbO37pbpZanPbDi/ZvonmML80jPKl/n?=
 =?us-ascii?Q?bnQQ9vqjPBEOCZsqU6E5ofaZ7iLq+GFaz0DQK17p6Up4JGCwXNz2dyAmZRB0?=
 =?us-ascii?Q?T5Y5UPxeUlNsO39ieAT5Ejfv/AjYgpMHjL7YDoV32nqAp6MYP29OfRAJuH0w?=
 =?us-ascii?Q?aI/TQKjlv3dMcYylPPrA+HHt9ADSW8w0IX1K+r/RBU4+LGJcKv4BNz5A+i7d?=
 =?us-ascii?Q?M1LSWCcvdWd4EwgUruTmNCR1SjyddDb+ysan28j4K50uC+7tkPMo98oYWimA?=
 =?us-ascii?Q?1TX3QnB1qufj1YjPV/92SFlKkArZ5Sn/5AP39oasw0QbZ0G+pnU+53j7Eu80?=
 =?us-ascii?Q?fxQFtjWNGv0SPtcFOLZ5z29gHZarKX+9V8FhMRcNBP93xUVyGlRseCPH7VGB?=
 =?us-ascii?B?QT09?=
X-Microsoft-Antispam-Message-Info: 4oCdl6I6lo2iHE3XknZkmjgUYV8+gwxleZrOmDjTp9r5sIhNslJ6fKhQOSe2HtM7in2tovJZruxD+SGQAfSE+fo1ZsbFioaiw+Qup3z5wuU3EeYOn5k4BgrPr1BUExinj79X/DqhLfzvXttwtYwgTqrCEWikaON97V+lMxmqz64BO+O1WpoLiXOQiY8MS/oGYZy0K2sQNaUvA6b0+Epb/hvlJUwXoa+3s/QJLA+kmTfqNPpEes9uqdphDFzwGdbLO+c083iXSoXCxD54w4nHjPEyP68lTsf0QSoBHY6/C5be4isefT1f2V1axy6f24yVPKCUH+x46DLJmAipWDjLzGDDLnEzZGlffJkLkiZWFBg=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB2365;6:qEdaZhEriIlTf603o5NNweBAPGiCacK2qnmkTtSWn4b1Yo9HA+QMQNBahS++1FTnf6yIje2smvv0doC6PIiECOgFFw9YtiY+xVJ6EbQKtKArwa/ZjJ7VLGH+Y9eVR60PN0tV7dytWalfQ6m0y/pZzTCxZwNYDHpdUfY/Sya6GDlWfp5wh2KFz5BMDlWyrcFIq1w4rmMlGVWYU5LmLydWUseaA/DFJvU/Cw5zriUtCy0kRgwbtR266hWHznQ2SblfuvmxILhGdt9xge5QJCCtVhpUxmcn28EkYa+fYxjStxp+nYi0Wes7E2MJLUi6zSH7G84Gi+B5FiGlJrFcnt8m2+w3Fz8TJUKx6gQp9bLgt/d5acq4QXguN8W+aw1/IylDnHFfGuj4EScIVesijIyaAAxN6nSNPh+VMsv6/C4S4Qdpw0WUyuxUGVL3zyxiBfRGq6p8aFpGQBjSY6eb03d+mQ==;5:DyiyjMilx2gCyeJ8BHrcwlxVu5D/3U3V8dZC4hBqBgRXc8wdEdlXr+V9CyE3E1fUdo3v5SSuObuaPW0yvmm69k8hYZExLkCUIKjM15jPX0VmsfB4xhYghJp7dLhPRWzubdN+k0z8f9+1Lf6d9PC8tX/B7ITjqsR5O3qLgPBFA60=;24:mEnNniXNB6TT+9YyN09CQQfajt3mHXbsFq7vnA3AeXmRfoTfDWP0+kH/AGVUvQq3YbtOJQ6/YGfT+MUCwKuEsD1WqK6D1kP72tDusEpdHv4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB2365;7:S50PfACsqZ/UrwB2/MO7EPBNYkrwzMKiCmvmfZMTYTJvOW1BafFb1RzVlwAeEVv4K9JUUzKbsW3ArQz+PpdhAFCSPGNHjD6oceAjj1zxtVBKfgazw+RC4LVE7hAJc/ra+zGs/o+qUvTjYi4zclt2tPVpX4ORNiRTiKAd0w987Ch2/RWWCt/PrEjcf1918q2JHnLlfqW8KIgSp40tBscvyKoEvpU5BUWwPRi/glgzFxQCXStuIdGlelDpzAkx9LFh;20:+mfuw+KUptZthVb9bdUwmkDMPoXJCT/TxQsA7tYzep9f2qhVjajXwQkaxmv+FgZVckG5jEnTfisZSzbdhnhJkVlt/rR2DziJSSC8aRfjHiw/qUgbiQm6jPTCx78K7blfJ8Bfv9QSbrcfu1QdualE4tNPZf7m9lofa7ETcMua/qB2XG5gXpUvJ0qEnvVBUncbv7Azhx4nTTdrrgXwf2G79yJsEhtAudqX5WBk2428JBcy2upmk5eQG5xhgTWk1Pvz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2018 07:03:26.2059 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22b12abe-4cc9-4be7-7f37-08d5eaea3f16
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2365
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Having interrupts enabled for ACP<->SYSMEM DMA transfer, we are in
for an interrupt storm.
For both playback and capture interrupts should be enabled for
I2S<->ACP DMA.

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
---
 sound/soc/amd/acp-pcm-dma.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index eeb8677..94bcf69 100644
--- a/sound/soc/amd/acp-pcm-dma.c
+++ b/sound/soc/amd/acp-pcm-dma.c
@@ -224,13 +224,11 @@ static void set_acp_sysmem_dma_descriptors(void __iomem *acp_mmio,
 			switch (asic_type) {
 			case CHIP_STONEY:
 				dmadscr[i].xfer_val |=
-				BIT(22) |
 				(ACP_DMA_ATTR_SHARED_MEM_TO_DAGB_GARLIC << 16) |
 				(size / 2);
 				break;
 			default:
 				dmadscr[i].xfer_val |=
-				BIT(22) |
 				(ACP_DMA_ATTR_SHAREDMEM_TO_DAGB_ONION << 16) |
 				(size / 2);
 			}
@@ -421,9 +419,9 @@ static void acp_dma_start(void __iomem *acp_mmio, u16 ch_num)
 
 	switch (ch_num) {
 	case ACP_TO_I2S_DMA_CH_NUM:
-	case ACP_TO_SYSRAM_CH_NUM:
+	case I2S_TO_ACP_DMA_CH_NUM:
 	case ACP_TO_I2S_DMA_BT_INSTANCE_CH_NUM:
-	case ACP_TO_SYSRAM_BT_INSTANCE_CH_NUM:
+	case I2S_TO_ACP_DMA_BT_INSTANCE_CH_NUM:
 		dma_ctrl |= ACP_DMA_CNTL_0__DMAChIOCEn_MASK;
 		break;
 	default:
@@ -705,18 +703,18 @@ static irqreturn_t dma_irq_handler(int irq, void *arg)
 			      acp_mmio, mmACP_EXTERNAL_INTR_STAT);
 	}
 
-	if ((intr_flag & BIT(ACP_TO_SYSRAM_CH_NUM)) != 0) {
+	if ((intr_flag & BIT(I2S_TO_ACP_DMA_CH_NUM)) != 0) {
 		valid_irq = true;
 		snd_pcm_period_elapsed(irq_data->capture_i2ssp_stream);
-		acp_reg_write((intr_flag & BIT(ACP_TO_SYSRAM_CH_NUM)) << 16,
+		acp_reg_write((intr_flag & BIT(I2S_TO_ACP_DMA_CH_NUM)) << 16,
 			      acp_mmio, mmACP_EXTERNAL_INTR_STAT);
 	}
 
-	if ((intr_flag & BIT(ACP_TO_SYSRAM_BT_INSTANCE_CH_NUM)) != 0) {
+	if ((intr_flag & BIT(I2S_TO_ACP_DMA_BT_INSTANCE_CH_NUM)) != 0) {
 		valid_irq = true;
 		snd_pcm_period_elapsed(irq_data->capture_i2sbt_stream);
 		acp_reg_write((intr_flag &
-			      BIT(ACP_TO_SYSRAM_BT_INSTANCE_CH_NUM)) << 16,
+			      BIT(I2S_TO_ACP_DMA_BT_INSTANCE_CH_NUM)) << 16,
 			      acp_mmio, mmACP_EXTERNAL_INTR_STAT);
 	}
 
-- 
1.9.1

