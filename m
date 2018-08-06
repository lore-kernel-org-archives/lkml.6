Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FD5DC4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 07:28:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AB3621535
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 07:28:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="gdK3LXVl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AB3621535
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbeHFJga (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 05:36:30 -0400
Received: from mail-bn3nam01on0067.outbound.protection.outlook.com ([104.47.33.67]:4287
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726412AbeHFJg3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 05:36:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qPs7Lja3sgj6XDliEo/n7gBVB+Rxkzzc2r2BWyvwKEU=;
 b=gdK3LXVlPwl6aNRup9RthLJu/ZsJOXlIYmoPaJBe+unDO4eKX5Spzz/jHSVKeCfIz4KiAIoxtVI9QqxOabxjv4mkstQkY/JWkjjVAHe6KRejsdiTgC6ZpI95cZt3x7fGwNeI/zBl7JL1Eb7iAoQzxlMQh1ysmw/wF9uHXjSLnS8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Akshu.Agrawal@amd.com; 
Received: from akshu-HP-EliteBook-745-G2.amd.com (202.56.249.162) by
 MW2PR12MB2364.namprd12.prod.outlook.com (2603:10b6:907:8::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.15; Mon, 6 Aug 2018 07:28:33 +0000
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
Subject: [PATCH 1/3] ASoC: AMD: Make ACP->SYSMEM DMA non circular
Date:   Mon,  6 Aug 2018 12:57:14 +0530
Message-Id: <1533540439-18735-1-git-send-email-akshu.agrawal@amd.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [202.56.249.162]
X-ClientProxiedBy: MAXPR0101CA0041.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:d::27) To MW2PR12MB2364.namprd12.prod.outlook.com
 (2603:10b6:907:8::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cdc4a1bb-6702-471d-5e58-08d5fb6e3bd7
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:MW2PR12MB2364;
X-Microsoft-Exchange-Diagnostics: 1;MW2PR12MB2364;3:gldq6v12FZiDnWa7aY9GtUXDRfB/uiR2oeAYZMjFc15VKS5yDm4NKmhp5FL5q5uI9dmYJjLqLWmSoC0xE/6G9ZgppFgvWPFe8OeRUFEnRRyxpDOTRTmZJ3VyhjK7Kz4QR3AmbqZWiKv+2nR5nWjXeuBLMideLZGZSCH/hJ5Uqdpc4dxQLDdRvv75KPySOnfzX78aZcppuimAQMh+Dvy1MNKODcgee58UEsB5rX1/hlQWEJL8yhDPdzdsWRLP1tM/;25:Ay/Se4OBjmcf6qT3lcHOpP1zp274CL+qKRvBZPpjk8PRFt2mkIr+GWiD55zXHirQltR6PGMFK4bk0TFGgafMfugsMtk2p32GuMQFQb2M03P+gmHoDb6IWwp9gQkfdG2RRuRnjg+Yk1Ku2s7Wb8wbSOvnVH7xmrfdj90CDsWAvm0jMNXkARbCeG8MfKN8PXmG4jCzFYl3AHPRYRtSrhkzAq1prxYDq1ning1WAqA1393n77KxkhN5JYrThQLGbsk8A5WfdssFsjzn9wEPH3l0d37xjCvOUZEX7ZiIlKvDkH0bfD0XKs1zNlt5/5A7C9mlzWOGqL40Vz6SJpdyOpT/TQ==;31:CCFvcv/ZcQEcu8TmwVt/sj5KD7hFHO43BuFW3g6jB6V8JlaS6F4ABgVV4vOZ5paUlC7Iiw/9c96vp7f7B/W5kMr8A2HMmYKVzxjYsUJ4/3d8S5pqBRXHGXSjGFj7382INEzF5KC3P8anqB9LtXIGy9eLjBJxDEfsrU/d0KDs3WuvxdcSH2Cvhj0/GhoOdJYsNyNQVcSf7MbCx2wDbQX6ZrDJJnB6E9W+FMXdrLU3tbU=
X-MS-TrafficTypeDiagnostic: MW2PR12MB2364:
X-Microsoft-Exchange-Diagnostics: 1;MW2PR12MB2364;20:fT0xKWoSiCTxZwF2jgJ24eQY2Dq/vF9SCX/DDObWRe25cttUTLaZcPwqn9TJvFCeyLjxhPZjasQ97ewxauFsGyuXNvD4NfT4HAq7BMQhjfB87LgfgotYZnVfwuMXJBe5KT4MJgs8YCaKqfTI3NM0ms0NIevEwsaqcCI+e2/gynsLRbAPHlT6Gcb0OXbsVNJ3mBuba36cRMNni1CywYc7YIO8vx/+Spc1i0kmTc0b/aox6z9OKwIAXfy5VgHBvqbc6f4mrCAQFJ2rO0to4om5simNNR+0CPBHODKJ6lQp9atgnnd/fKvTPWC4RNFnMvTHE4R+rYrstiZ9sK26RbxZZxytWDFGXq4gkMwadiWdOFRjmnSGL5XSSUu4jRPpv89d2J/pGMtonFAM8SZUq4JRzb632D3AFoNQHEwSNxsjG8sQ9cUy5O3EFkUBe1eAfQrSCoRU9Lv7Sq925JnfE/oh6qc0QW4d/NdTiXbtFWZxWTrg3D7pUc4lj+Wl0kLbk7Ou;4:0YvybLesKGrJeVm209ifplvtsWPQed/BV+qYRSMWLn9gIg8nKeW2FGww+CYmJy/UegrlZZyNlKTH3Kl/XZsxv257KGb6HaL/NLKH0f+ybejFCIIq0X+TH5tdBP1HOMJgPB9Al0WG2fD3N4+e1o33igJ48bzIerrseoFswlhGiMN+0r4c2xIgIOOh/GmGqAiwjd0/Qm5aIz+RngTObGPxtWGk1sAUnOndmPFh66Nr+TYcIvHkTwGwPC6HeJ2c6UsZR/sChMNP4XIgKzeHBmdYFwOPjxmfTyiosE1cg5G+CReFEIIBK94T+LAJrXx0uwsb
X-Microsoft-Antispam-PRVS: <MW2PR12MB23644C61016E14B1AA7BD229F8200@MW2PR12MB2364.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:MW2PR12MB2364;BCL:0;PCL:0;RULEID:;SRVR:MW2PR12MB2364;
X-Forefront-PRVS: 07562C22DA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(136003)(396003)(376002)(39860400002)(346002)(366004)(189003)(199004)(6486002)(386003)(86362001)(2906002)(486006)(476003)(186003)(16526019)(105586002)(48376002)(54906003)(217873002)(1671002)(36756003)(52116002)(51416003)(305945005)(7736002)(7696005)(47776003)(26005)(2616005)(956004)(44832011)(66066001)(478600001)(8676002)(316002)(25786009)(4326008)(53416004)(72206003)(97736004)(16586007)(3846002)(6116002)(109986005)(8936002)(53936002)(50466002)(39060400002)(68736007)(5660300001)(50226002)(106356001)(81166006)(6666003)(81156014)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:MW2PR12MB2364;H:akshu-HP-EliteBook-745-G2.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MW2PR12MB2364;23:tIrvHCn5aFwhbg5IFb0G8UrGr3Bx/In5nIfofJzoL?=
 =?us-ascii?Q?YVkM0Qt1IJFyuQNdlgG1u2hj1a3wDtEjk9ROANxYcMONyOamW9DBl/+RaiYi?=
 =?us-ascii?Q?+EiQCNLOAQQ6pTHcwFsy6OvsiDmx8+OER+/kIifcGFH9LpxGtmwvbwr7zEIM?=
 =?us-ascii?Q?qI57xkU9d+7SXimkJXa0mWU8sNjStAvz6H9y4OQeukD6z/X35lbHD5oVZxZJ?=
 =?us-ascii?Q?xOqwx0bkHDRBTEQqnf7+R2U4AHXo7YLNXI5Qc/P8S2fUOSJ2OP4pPdkmdZq+?=
 =?us-ascii?Q?0Nu4shq5e2onFV32eqEx3+MSZyYVU+O2DQJusLZ6ACfVnkhQqM3dUkjK9DIx?=
 =?us-ascii?Q?4juvcJpzjg+WuY0Y3B6hW55Rf/Vf4ub7czDc85SHAoD5CEhEuuTN3jQ8KuBg?=
 =?us-ascii?Q?aY3QGgieryUY8+309Q8fx+mTScl4xhXxvzlULuqaI5lYdZSJgjhFE9Jvt71V?=
 =?us-ascii?Q?Rjd8uk/AZyALh0lSJo4j4wVC+lS/ezEy3jNFerzpPJZtReqnxtDeKCF/RpXb?=
 =?us-ascii?Q?Fhdb/WLwj8sAxiFRbDQrBAapPvUcQgRlbShC5os+ogAW7Ae+AdR6rCuakUU1?=
 =?us-ascii?Q?uUYW0LDkxNsRObipqdHmp8y7jO7LuvHL2bVPpuPVrlTrp3hiu+kGnO1bwMJL?=
 =?us-ascii?Q?pz7iHAYGhgcPp6g6dz+TCJ1IdSTHtprRJFrzgEcqwmy9JqKGQqu0kRRH4Nxb?=
 =?us-ascii?Q?cNik4gATDGiKaVejeUhP+jJ/02P8yCwcId59vbWcah06xoocgII4mDXfLWgq?=
 =?us-ascii?Q?Z5/7ayhCYwDKnyuiRDBLH2YubUiRaUWCUpNzJWLio8N9HTfp2D2s7SlKEAFw?=
 =?us-ascii?Q?bJNKkPqI6Cyk/Dem2VpEhetsJKgLLJY6ZhrEWKfvrq26T3mwPG1/HgEvBBl0?=
 =?us-ascii?Q?hUUsFgIFFrhEgbEG+/OlM+FXutpuMXkowKx3xvMIrgLM4EygEHGawKo7Tgwe?=
 =?us-ascii?Q?Na+2B/R8+5QsFavPFgDcK+x4MoHOAEY6KH/Hn3u99FpYwAJ0+xoZXm+bJPji?=
 =?us-ascii?Q?knyMfa3+yPLV5gGp0S7mBpsXoE7fez5U+p8DgP5uQQm36uO6So8YrVTRvuwB?=
 =?us-ascii?Q?uUcdwXQceOsSKNhZUsHXtnRT+vZzBvjog4eUJoA87Q5Z3DcKNc5y0Ds4lONS?=
 =?us-ascii?Q?RmNSMPnMRBR0WiPfEt/ebV2+nBfPTxCaniyUQ3z/PW+7Vu+CbbxZm2SHNRdO?=
 =?us-ascii?Q?RLeDZ4iKgRVvG092XukbyuesedlX3nG7EKGc+Utg6Chk6BJGzgRA6aD8jNA0?=
 =?us-ascii?Q?EkJ6FFQc8171uO5SwYvYsNZBTwRTcSdYRutJhc3?=
X-Microsoft-Antispam-Message-Info: Cw8UVnUS1F+ykkt5miH3R2i1ULDKG4Gj1n1bFdSgysP+aHdDMTsWvzeWNG4fLWTvzz22uCAYayiYgWCwGe/3legkF51e2r7DTDRo2CVNW3WX2W54KC/Sy61yC9/HrK57I53sVDg7IK0atMN3dWMbPDystCM/rT1ZW1TgTW0yjijVjjpdyBeNq9+g2Y0Ty3zjR2lRHcnSjSG208CtWKgWSvdkV0j6/vmEn3TmiOrff+ge776dnsgqpMRgm35/0pwpLTTMzTrWlrh/x0Agyy9lttlFkHuvlKR93ElW7ka7XbHcDHcgL3qgesXCpSAG6a+wDN8cGzqOTkOQ/tEz2EkFx0OV7y5ZuNk/MHzFgPqls5U=
X-Microsoft-Exchange-Diagnostics: 1;MW2PR12MB2364;6:rBNIKEX6c56MX5txXkgpw8rkcjSzyX7TBCbTM83dQxd+FvmNm8JJ1DFgiTN9bzgmwsMWLMEsNAupkm9zArZ520fbN6jy7wnbH8yTCFxeIMnfLN4ALn4CDW/xph9iwIwNIzem3Y9N4AOsUeDO26GuIHFswl619qccd1UUqG1GbRxeZybPSSj7VmhsOfav/ECFrLJEdqXJq14WAVNh3NR7YtPO/wCW0EATodFf9brwOs+39qM0ZiCYTEsL3NOpB983dmL7hQXRnfaIYPN5IJpCGk7G5RQis9Kw7nWurk8iDtO53mlusnMPwaSx/ZwnoJCB4BWHZgPg+eSrcrw2ofrxdcw683SfFX9RlDjH/SZAe4T8c2/Tmqw6GSlDzwQHYfGi2GOauaVwe4aTLlA5jI/my2uWJgE8A0nzKDXQik/0R49102xir+V5XOwhKLFvu3CADtji0snKontiBvK1Y+18Ww==;5:Ul6mfK2/ahL9uUTEtkqaDMcYduQt/2tNqMybNP0dZTWdxbLrEp0PoFKZ/Lk3BLtPpHIg59sJsIwTXilO/cS/JGJp/NYeBRrm+RzYvQ3VONzMqJLjRFMVfFyosQdCmWiHFdq47yEuYy0VCmEUTA/zP5trtWZ36KdxEF1siXHRw58=;7:pE0k4PBf1VZMLQuTR4r8qrl8j5AnfEXB3SMglOPYueJh6iI2yHRTXiy7Aajv3LfMOXMR+DCzPMbHY0/gZfFWZA8OZ5C3xWvUhbtzJRgqJtieTKgJMXVarGtA7bK1DOK20msbpejWPb3NbZWYbfqkGAjrmSqPJwLOTWv2y0V9qBCg9NYI6vFSvaUuS4NaaGulR2Awq57BNJ0iz/T253WTDXQpWHZ3GBVTsn5g3PhWoonMXX0TS0bS5Y2249DONndq
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MW2PR12MB2364;20:+GRGRV5fSvY4xjYczO39hUdHKtG0q+nX8I4ysNWwKgxz67sQWQprWUSzrb57+p5x2HdaYX+JZnp0JbpRdF6p5wqmHgOcgZIZruQ2KMgzILKxCnDVq30O2UjdIAaPeiWFj1FokGd3L4YhT8HE83s8UvSBfB2rmBEsudl1q5r20ialiXLofJkYEg4zLamps0ROSeNOIb/FNFbN0GklVyTFwrWYyu7tox3dxdgLPBRbEuqu/cgD5bvo1/knKad/fOm7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2018 07:28:33.2324 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cdc4a1bb-6702-471d-5e58-08d5fb6e3bd7
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2364
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In capture case we don't want ACP to SYSMEM dma
to be circular. This is because if an in place DSP
filter is applied to captured output then circular DMA
can overwrite the filter value with stale data.

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
---
 sound/soc/amd/acp-pcm-dma.c | 36 +++++++++++++++++++++++++++++++-----
 1 file changed, 31 insertions(+), 5 deletions(-)

diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index 94bcf69..816abd6 100644
--- a/sound/soc/amd/acp-pcm-dma.c
+++ b/sound/soc/amd/acp-pcm-dma.c
@@ -400,7 +400,7 @@ static void acp_dma_cap_channel_disable(void __iomem *acp_mmio,
 }
 
 /* Start a given DMA channel transfer */
-static void acp_dma_start(void __iomem *acp_mmio, u16 ch_num)
+static void acp_dma_start(void __iomem *acp_mmio, u16 ch_num, bool is_circular)
 {
 	u32 dma_ctrl;
 
@@ -429,8 +429,11 @@ static void acp_dma_start(void __iomem *acp_mmio, u16 ch_num)
 		break;
 	}
 
-	/* circular for both DMA channel */
-	dma_ctrl |= ACP_DMA_CNTL_0__Circular_DMA_En_MASK;
+	/* enable for ACP to SRAM DMA channel */
+	if (is_circular == true)
+		dma_ctrl |= ACP_DMA_CNTL_0__Circular_DMA_En_MASK;
+	else
+		dma_ctrl &= ~ACP_DMA_CNTL_0__Circular_DMA_En_MASK;
 
 	acp_reg_write(dma_ctrl, acp_mmio, mmACP_DMA_CNTL_0 + ch_num);
 }
@@ -674,6 +677,7 @@ static int acp_deinit(void __iomem *acp_mmio)
 /* ACP DMA irq handler routine for playback, capture usecases */
 static irqreturn_t dma_irq_handler(int irq, void *arg)
 {
+	u16 dscr_idx;
 	u32 intr_flag, ext_intr_status;
 	struct audio_drv_data *irq_data;
 	void __iomem *acp_mmio;
@@ -705,6 +709,15 @@ static irqreturn_t dma_irq_handler(int irq, void *arg)
 
 	if ((intr_flag & BIT(I2S_TO_ACP_DMA_CH_NUM)) != 0) {
 		valid_irq = true;
+		if (acp_reg_read(acp_mmio, mmACP_DMA_CUR_DSCR_14) ==
+				CAPTURE_START_DMA_DESCR_CH15)
+			dscr_idx = CAPTURE_END_DMA_DESCR_CH14;
+		else
+			dscr_idx = CAPTURE_START_DMA_DESCR_CH14;
+		config_acp_dma_channel(acp_mmio, ACP_TO_SYSRAM_CH_NUM, dscr_idx,
+				       1, 0);
+		acp_dma_start(acp_mmio, ACP_TO_SYSRAM_CH_NUM, false);
+
 		snd_pcm_period_elapsed(irq_data->capture_i2ssp_stream);
 		acp_reg_write((intr_flag & BIT(I2S_TO_ACP_DMA_CH_NUM)) << 16,
 			      acp_mmio, mmACP_EXTERNAL_INTR_STAT);
@@ -712,6 +725,17 @@ static irqreturn_t dma_irq_handler(int irq, void *arg)
 
 	if ((intr_flag & BIT(I2S_TO_ACP_DMA_BT_INSTANCE_CH_NUM)) != 0) {
 		valid_irq = true;
+		if (acp_reg_read(acp_mmio, mmACP_DMA_CUR_DSCR_10) ==
+			CAPTURE_START_DMA_DESCR_CH11)
+			dscr_idx = CAPTURE_END_DMA_DESCR_CH10;
+		else
+			dscr_idx = CAPTURE_START_DMA_DESCR_CH10;
+		config_acp_dma_channel(acp_mmio,
+				       ACP_TO_SYSRAM_BT_INSTANCE_CH_NUM,
+				       dscr_idx, 1, 0);
+		acp_dma_start(acp_mmio, ACP_TO_SYSRAM_BT_INSTANCE_CH_NUM,
+			      false);
+
 		snd_pcm_period_elapsed(irq_data->capture_i2sbt_stream);
 		acp_reg_write((intr_flag &
 			      BIT(I2S_TO_ACP_DMA_BT_INSTANCE_CH_NUM)) << 16,
@@ -1053,9 +1077,11 @@ static int acp_dma_trigger(struct snd_pcm_substream *substream, int cmd)
 				acp_dma_cap_channel_enable(rtd->acp_mmio,
 							   CAP_CHANNEL1);
 			}
+			acp_dma_start(rtd->acp_mmio, rtd->ch1, true);
+		} else {
+			acp_dma_start(rtd->acp_mmio, rtd->ch1, true);
+			acp_dma_start(rtd->acp_mmio, rtd->ch2, true);
 		}
-		acp_dma_start(rtd->acp_mmio, rtd->ch1);
-		acp_dma_start(rtd->acp_mmio, rtd->ch2);
 		ret = 0;
 		break;
 	case SNDRV_PCM_TRIGGER_STOP:
-- 
1.9.1

