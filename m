Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DADEBC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 06:43:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B810208DD
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 06:43:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="gGV1MUQb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B810208DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbeHBIdN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 04:33:13 -0400
Received: from mail-eopbgr680065.outbound.protection.outlook.com ([40.107.68.65]:28635
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726021AbeHBIdN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 04:33:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qPs7Lja3sgj6XDliEo/n7gBVB+Rxkzzc2r2BWyvwKEU=;
 b=gGV1MUQbEslwdB+KzqnjtEYaOGei6DZV9QIeMlVegIaUPY5JQt05/UIaYsw+8hXXN1x/AEvTjUFVddOPbD3jn8qsw9nFjKnBbgprj9NeQKXaDnGpqL0ZNQFaLKz15Pr6BVo8URjkgwwm5PSs16zRekD+7JqLOLv841xi+/lBh54=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Akshu.Agrawal@amd.com; 
Received: from akshu-HP-EliteBook-745-G2.amd.com (125.21.194.1) by
 DM5PR12MB2359.namprd12.prod.outlook.com (2603:10b6:4:b4::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.15; Thu, 2 Aug 2018 06:43:16 +0000
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
Date:   Thu,  2 Aug 2018 12:11:54 +0530
Message-Id: <1533192134-11626-1-git-send-email-akshu.agrawal@amd.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [125.21.194.1]
X-ClientProxiedBy: MA1PR01CA0086.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00::26)
 To DM5PR12MB2359.namprd12.prod.outlook.com (2603:10b6:4:b4::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 64bc2d22-424d-4874-aecc-08d5f8433f35
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB2359;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB2359;3:DmldJ/UPpd5jHnuk0hjDwC1Mg84UlbXVt1iwTOTnQtMkLs+TP0ByMq22K8ww1tPm6n1GFGZG8skNpEWsOtbDipd4TIkIXGLVWybIw6rNW4XyOlBurkGByFBs174kBtjoXfrJOQJ1HLLvYeHRKJRQ1KbQvD1qXrXUG/Xz967GFXgShRtjJDvB5xJZpM1g+UMlztpUJQxXDOwCSqb8Ru1MPL3owDMRfhQC/+4nSAVXzKkL652Jze3cCzk9SaRsO/4n;25:f7UDBkfuN7ivWbWHpBdBNU+wlSkEDMVQNJbVaRAq7/HCPjC677Tg2fqkvEIxa8lfK0ggVVoM1RMzjxge2S103J6fJN1rSG1XVCJ4frVHrQG9dSIIbCELs522mVTjvVwtTMCq8ruaI/0BEOGcwHQ9+MVD4hLitv3LItcZSF/1J2HIKeO0k+2IBgucdMnV3nfWEduFxzeg3Ax3e51+PTFByTAjd6mAIlinL7ljgUNJwr927hf2qYtWwGJd7HRyyPNriRHnXXf5Pt2xzDGg7hRhktRTcfu5RFvXitPfTkUJVgnRFQWCiQNXGEqPotFpDNuTZVnqkZeJbiyhhsy9bCSL8Q==;31:hXokGJovFPvPg0yEAHWggtVsUktr6mkrj8SZbEJUD+rWVCC3xn5IvpjAXlodT40YlY4kjdXf1KgWGDTyCaF5AtstFtCJwzMWnTw/l3OLyBOqDf6HLIsKpYdkQM2b6fWK/bdQLMWgZN7KnD86pqQ2/HdwDbWj3cdmrv1DAuOOePiH781mbrUV9lnZ7k6mmF1oGR5qGnYCi4RkapR4XE9t510JdpDWLvXKx8gsTcdBE+M=
X-MS-TrafficTypeDiagnostic: DM5PR12MB2359:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB2359;20:C9klloynIQqVJ05H7Z98dQCAO32BJhVscRcCE7idNcbNr0eFxakFdgm5rjZo9dht7QwwJ5YEhQQiRbA5kxqUOgg0cGDiz9rhWzizBGx+oC14FlB/Jq5Gn7x7CYgh+eJPa2fnAODT68ELXg3WG39HRFFuGZu+4pPDIQU3B+mGffCkwpauZ0JYdLomARdljN+qQS9EuuFQzanZuB5fATc3sVKVd+pZ3wezz2/w596/0YwlqqkiiE3y+8J51lGQ5z23nb3RXIfzir2EvEcLe6tuDTCi0rNYHsn+7hGmbPhLARb+DdZNSp6jYGbw3InGim/g3cT4yy5y8EzrrjNC+7z9dzsVWPlFps0WrCGVESN8CodgwKkPy3GopkGgO2ap2Djb12oXMFkRhVBaHuGYIdCbSc1RWwrpgzA3fsalIzkv0gK1Zmj00eQpw5K5wqG0/MLeLq5nKM2m9nKjqQbrBspkDR3ZC3gw319HPev4eqWQ1EcjrVifDqiahXNveyWNpXnJ;4:EqUOz3qbAJB3awpBiExq2TidaYRg0yfM/ioNuymXUn1ze1QvJ32qHueTHEUxyYlQXnh/46If/T2dw72Huu5+w5bdWj+S4nM03zvuLwPz9Zkupe/FtrFvhgAdGKvNmTcG3MWdaGs73czL9Qy4DuMgTUS45u9726OMDV5RJRVMKpibOf/aLQbwkeTBaN8Y8ykVcFszB4wD+/D4TENCp81uHbbBs/JrTzHJ1iIDwFiQjAklinI3ULUGR3umDwCR+wuLNwIBsSiLQhK7D/mK2ameBM02sSpTWsMQinC3k3JnMR/XdV8ORNXuuOHNRy4hD8Zb
X-Microsoft-Antispam-PRVS: <DM5PR12MB2359AFBC2602F1CEAF84ED2BF82C0@DM5PR12MB2359.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231311)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:DM5PR12MB2359;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB2359;
X-Forefront-PRVS: 07521929C1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(136003)(376002)(396003)(39860400002)(366004)(199004)(189003)(51416003)(50466002)(2906002)(6486002)(8936002)(8676002)(39060400002)(3846002)(81156014)(81166006)(109986005)(4326008)(36756003)(48376002)(44832011)(486006)(1671002)(25786009)(86362001)(476003)(50226002)(217873002)(6116002)(68736007)(66066001)(6666003)(7696005)(26005)(105586002)(106356001)(16526019)(53936002)(47776003)(54906003)(16586007)(2616005)(5660300001)(956004)(53416004)(7736002)(478600001)(72206003)(305945005)(52116002)(97736004)(186003)(316002)(386003)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB2359;H:akshu-HP-EliteBook-745-G2.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR12MB2359;23:qGFqCZeCbW9/qQwzdqRsZcQARf91ergS2ZhSkK28J?=
 =?us-ascii?Q?Z4K7oA7+1JO6mYRyC5CUTNTo22gfahzATYYDwVIzxNIjs1iDyDHEmE5lziSg?=
 =?us-ascii?Q?LBs297t9a5T1jJVwTktKlpvlmwPbbHXnlLbw7xOwHC4VkT12HePnBGQswgp1?=
 =?us-ascii?Q?vhi6lkzjGYizGsS+1PsSVjKPuM4enzOlRDwOSb6JBEQciR80BP4gabVmdj57?=
 =?us-ascii?Q?kAlwQ6kJ9MaQVxZ3MBplqxplIdDu4qu+zLmLS7ZMxkQMoTDqc+3QrmBR3WQF?=
 =?us-ascii?Q?WQsjnKWwFFWg9JlgH1iKxXA6xyEG66G1BhK1yB056A39VH605st2XBpBZHTt?=
 =?us-ascii?Q?jjKJgeS+9VKQlMGHJpS891SGFB4gRjsWan4T7bDl6kAx3tONvMEs5WEamFpv?=
 =?us-ascii?Q?fJj7b6jhN/XoKXFbWlww6YTu+2JuhTbwgFSbws4ELwuhKlmPhBY3ZtO7qK21?=
 =?us-ascii?Q?6izpEv54aE0HeuzbZTWK/3Z8+VT2Qv04cDelWLL2p+z+RNXFNLMaTxSv+mGA?=
 =?us-ascii?Q?uFlFu/s2t32Sn8G8ZjVY9Jfr1QWIhUf88JF3TxjJTTcxJ5M3in89ctmHef+v?=
 =?us-ascii?Q?OUNz5oIrMGR2QZb8cJNYswayL4+Dc7b2VCC7mB+2q3wJrUE0zg9zbWwhse/X?=
 =?us-ascii?Q?k7tu0WkP4/ckFRS3fuggo82xPOkGRXw8sVYJHxQuvLGIG8WAHkxnWO24Zbfl?=
 =?us-ascii?Q?hNtS10tPmfHhOeIzRec7+Jhk4R8SGAO4mW+I3gQO9vpmqMG6lNGNaSInTFuz?=
 =?us-ascii?Q?92kuoFIKmyTag9RAAIbwq0yXat/qvoKCz5VmCJZWpUwNRjDclzrfvHr2AY/S?=
 =?us-ascii?Q?a1ILv2iUglpCrm9YKaqbAOwvuTHBvFZB8nWuZuReqQpoXsq7ZJ09j5wfc+Ct?=
 =?us-ascii?Q?2t0gUVo8fpGqmy+aIx5cjjh8xp5Wews3ZkCV+pqmzCgVDPnMGiBMvWfK146e?=
 =?us-ascii?Q?FwY3TNpDucAc7uIST2X4A0VUQXxp85GCR7ouEmj7ksyO/PTE2hEzIx01h6Y9?=
 =?us-ascii?Q?rWOLCjEnyq7HIcUPxZT3hL+V2aBzZYhzJVrUb1ZMyBCalL0R5RROZAlw3GHh?=
 =?us-ascii?Q?BnFhdLQR1AYaNbrl0NCWDDqAdX7SAGaTho+APYm1DGBeWEAZoqtV4Ho7gyWG?=
 =?us-ascii?Q?FTj5FlqlKV3ESxUDNKjiQNKl1g5OApsmNPa/9UUe3UMdbi0XVVM07n+F/4Mr?=
 =?us-ascii?Q?vLjbT6q8PmNd9iBe4DOnMmk1bynUHYNRvMgH3kZS3xf456dfupuCJvwvIzZv?=
 =?us-ascii?Q?h9pOxM22JoefuM2mH3IodohHNmoUpoJGmYyeFEp?=
X-Microsoft-Antispam-Message-Info: yqmnVPxyNB87khKg5kcxkoqulHRwudZoJbXCYCn4RmUilpVY5vxGxkllgtQFDzNR4izkpRO27MbsYiXV03zWZq6JuQ6emVVFleaxvLRQLo6hQ+wSNhZrDbz0Zz/xdLL1e8a4r7i6YMdv1tBrMahcA/t8fJ/isvUdZWS5rxyb2c1H7IOiTF+KMREdXr313ZpXS/6l/d3hPhvMeeq6Ru0lf+n9KHgMaRj3WGeBtN+38WDWceg3qe1SyKyxlJAhOxbRu5Isa7VWFDDPdxgvJGuOkJ1JIiQ1anuU3XmXCKCBwLRwGffFPTE+jMDDu/uSjhM5qelntmkZ91MQ0CiCaWzBw9i89Ls3Poxr6+NiNW2bUSE=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB2359;6:PpI3HEiheaAPMBUFrpX0JgapMlGVj2f46ZMOFCjxGhWHCIOM7Y3HDx9uRhFyucnxz/Z7nmDz14SLSB91qVy8SyoAzTiJ9aZywckHJPlspDZZHvunj3pI+0auWP49p1dT8MFQu3Op0+AyO0+gsInulr88nx8uYYNsSAF8hrM8jGeoCV9GE+Mx74axG5u43DBOsAq8t5SlFik7msll1bWXuV9oxXlTu3GkkmCsiNNAV3NTd3gmfRW7EfO7XppbLWE+9JBpZeZHgrn4zyXP/1IDlzKq2fpcYQ1COZxnPUEsbCJjeIHH7rPqKcWRI7PkXbhNknmwjH+iud9pzfCwM3GPr/hPBbcO2dj+lM/gRYc7nMQbxbcNSXjln0TtWfUFYeni7K6oS8lAxsfT6zRsQf7n1Q398b1MJ6m2jltM+6ESl8aNbRyG2qpx3FqAXGtO/W0IKFZ6YbdRYvyHID/JvyztLw==;5:bar/cILOr0QSybcQeqiR3+6lcvppHk6ag3QECuP9ymjWSsL8ifqZzauvZvxZV4ERinbDUUYQGDhWJNbsFzcG9w+JoQTjcP+wnHE1YRnAPdzop+Xybbd9aFQAfep4gA72vVsPLKEjGURlIJBRfVfe1J6ZulXBrrdGZSg/Xvt/qh0=;7:23hYpjVS9pbbIyRM2YQL1IY+gycqT/7ln65f9e5mwjwyfo3CICJKSaesxsmYXgmnOIr1B/Fvsw3mzFGWJygjEtao5MeBJExHKadRlfkUgHawN1DceTEiiFGz8gNP2Z7W79KUrUA4UiaF3ssQzcmF1epr3GHWXYzAHVNj9iQjXy2B727UQm1x4+NRSQSYV44jEK4NrTeDPi+0QOQ2YkwLFhlCpXHxwoqe6NPllMLzHVcpz+v7CkMZ+St5lapxNsdO
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB2359;20:rknOip3mEjVsMlINhlhzv00sbacSzLrjSks9agy98EfxlQOL32U+HCg77fEs+S1n2anVuUOiQEkoKreZKSiDnegcPGpaxcczB8cNa0joxRHwSljLlMVmA6/wAgs2k5/0/Lh2gREn/U3N2soSTe5DTe/IqLTYtyW0v1055OzrLUQUd/tXL1J+AfNnFcvoZDUR7G52fzoSaE5KZAKTVipZMsnOPTwhw8QAjXN4g4Oe/5J5MyPwV6OFA3iUwd7uNm9Z
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2018 06:43:16.0369 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64bc2d22-424d-4874-aecc-08d5f8433f35
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2359
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

