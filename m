Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A1C7C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 07:29:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BDF321535
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 07:29:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="svnaNHzb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BDF321535
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727256AbeHFJgz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 05:36:55 -0400
Received: from mail-bn3nam01on0079.outbound.protection.outlook.com ([104.47.33.79]:46080
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726412AbeHFJgz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 05:36:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ZRrrNLvOJvb0lhoN4eU2afev8R1r2Tp80pl4kbkhJY=;
 b=svnaNHzbmbbdAF7xDn36Ewfb99nr87AKWE3TpQaIGls/VN47mwLBB1NUQEM8cK1F363QiPGkE563472w/wQf3Ft2fKUYcdvmPUIKuB9Cja0L5Umvy0ZGgKWyQX/HA8/o8udWCk9/n/3RRGRFJHdeAq+kJC454OBytRw+Ct7a9T4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Akshu.Agrawal@amd.com; 
Received: from akshu-HP-EliteBook-745-G2.amd.com (202.56.249.162) by
 MW2PR12MB2364.namprd12.prod.outlook.com (2603:10b6:907:8::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.15; Mon, 6 Aug 2018 07:29:00 +0000
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
Subject: [PATCH v2 3/3] ASoC: AMD: Set delay value for the capture case
Date:   Mon,  6 Aug 2018 12:57:16 +0530
Message-Id: <1533540439-18735-3-git-send-email-akshu.agrawal@amd.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1533540439-18735-1-git-send-email-akshu.agrawal@amd.com>
References: <1533540439-18735-1-git-send-email-akshu.agrawal@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [202.56.249.162]
X-ClientProxiedBy: MAXPR0101CA0041.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:d::27) To MW2PR12MB2364.namprd12.prod.outlook.com
 (2603:10b6:907:8::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ba44b046-3dd4-456c-bd52-08d5fb6e4bf8
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:MW2PR12MB2364;
X-Microsoft-Exchange-Diagnostics: 1;MW2PR12MB2364;3:eYKi5lBPnkWqaMts8GkIukV5RSWCXAA5O07L5nin7JRCYlaugAi7i0Ynuo3V7b1tcvr89WRMtYTq34RnB9eVFh//XI5vZ/gww2+rePf3TPSCVXN3yKFGGLz8wFXiotQmmWvhXE3+PIq6dBj5vmdrMpGvM8yKUmZ6lDQcTfSjIHJ9V/Knj6hk+AnO8MYNaOwIPMIXegWG9HsRE/m8SRAN4SK48Ll5NPZdByFmX1s5sMMHnj2bz1LcPgLFyYoBq818;25:9aihwuaTGfcC3/a6DIhwn3f7Lqql7AiEaxUfsLJ9oKl+ZxXdIGgQrdqqtMUM2IS/OWQjIaF2V5K5c3s3gsfPb1lyx8lUuVlr1qeId2rW4mbeZIPcIT0KauW6FctBs134JliYKTbI6uQresRXB7zjAUzJy+IeMhmUEt46H+VGJiDYG0KSS9Idk7fkl7eBhc+FeXqJNY80OOgdPjDXyPhoEMzXEZlU+ut8p/VyI05LcNaYARm0MbabNDkNC3Bg8SnTbyMuSK3+q+Boq73KjcEoGzeVvmJlaY/csSReNLIppxkYTcLZcs+nVBtoy7uODpjIfTwisUQwX+nLRhyoRt3fPA==;31:CLsheNo2TEgLMPateUN8cvlJwRV/LkR1x1xZOOfqODMcTGFH8yZRrvd9bfO0N31j7dEu0ND1kFw82OE2BBmhQmbZNQlo0UUolx3o231QkOpuV35fiG4NFWGxGKGNaNjQ1SCNmchKa9vGDyvz5VfDYeroQYXbsawgRevA69wcP+SI0A5g2ckXQyFlNk7pRITqBOWanScd5ser2lkGoMFaJpLcHVeEDsE2xD5j3TfJGqs=
X-MS-TrafficTypeDiagnostic: MW2PR12MB2364:
X-Microsoft-Exchange-Diagnostics: 1;MW2PR12MB2364;20:ZANdEFkc0oM117I1NoyzvyPRDT8KiVoiClS4Jar6n1rrBE9Racd0Fiu5pk2cgVIQol3Q5hU02aqtscX9ZRXR9rjAhtZ3Mlm4GKu8xAEOClkm+fcgWCAZO7nRjpPJEYxxhPtI4hb2I4IDvYMJ12f/LMNtswUmGvXU647yfqjuruBSQLuqjgc5I2rnPt/2krBeYdAcKXoHzbr10LsDt5pw7Q7RH+HXrfC5C0nLLYYk/1Mn2q5zTB/FOLSTn4eDYLF6sZogW8p/JSxRiYGo4/0D53pXIY0ac3DpdktSppo9qtSxUYqjzeTtjt3KO4msxrlLBc8zrdB7jsXLOKcCpSyt9eAxWwjxIVd1lH2ZPJxdTvlwlUNzlBTwDuFQK9ECMLIoPW1LvZoR/iQtbsNLgsy32PiW2RzJZM3Qktf6C7tjwj+QDNvKNQmxcFDrPiEKqi+hnn5ukOmgZmt5u7unzZdjh3IORIS12E1+0+jSNuBSfhaJrE6HWlZr4L7LmCEF2+te;4:NepBpGiU2BhBaT/b9eSZmKgFnWk8tUoS9T5OfuDKH3zzkCCcS4SuhwDp5AWof+RiNpAT744GyO+wa2hFDDggdgAOiSeftNAtZWh0jEsLdCz+1NQzSJ6z85i+0upVoMIN7+eQfb3T1C5SczT8FSaLKGLsFw9elLpQe2ZkkOkQh95Srx4M/19qQ3ZASCWoMOdoa2w2dXzoW52xVH7S1j1W3NkEZ56eAu/clmi9OHsHzyQ58JkGjq1HyVKn8ny6i0Jcn1SEBhbCdp/MWLj1khgov27rOacWIW2sN08cjB+lmIbhHe7UbMYv3nHDfuTDOY+s
X-Microsoft-Antispam-PRVS: <MW2PR12MB2364512D84A9DFBC5DBE881EF8200@MW2PR12MB2364.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:MW2PR12MB2364;BCL:0;PCL:0;RULEID:;SRVR:MW2PR12MB2364;
X-Forefront-PRVS: 07562C22DA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(136003)(396003)(376002)(39860400002)(346002)(366004)(189003)(199004)(6486002)(386003)(86362001)(2906002)(486006)(476003)(186003)(16526019)(105586002)(48376002)(54906003)(1671002)(36756003)(52116002)(51416003)(305945005)(7736002)(7696005)(76176011)(47776003)(26005)(2616005)(956004)(44832011)(66066001)(478600001)(8676002)(316002)(25786009)(11346002)(4326008)(53416004)(72206003)(97736004)(16586007)(3846002)(6116002)(109986005)(8936002)(53936002)(50466002)(39060400002)(68736007)(446003)(5660300001)(14444005)(50226002)(106356001)(81166006)(6666003)(81156014)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:MW2PR12MB2364;H:akshu-HP-EliteBook-745-G2.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MW2PR12MB2364;23:TFdfZ0woEffU8w7Goq+Nkf+pRo/LIfoY2yisVD9sN?=
 =?us-ascii?Q?tiiZCMGjyUVyvvlSAM6IZVpdRwUr6qSwqesvG396h36NAcqVtkc4fcj2tlpa?=
 =?us-ascii?Q?GKf2Hj0XzqpS8KEIBCLUQ/UutwvddSbsX6I/886m1bigyHQBVvdRoFePpMKU?=
 =?us-ascii?Q?Xmmby2gXWat3XH7x1urEbbscAkGj6Izv3I+ouNZ+dZW7CHe++4iIttI53q9g?=
 =?us-ascii?Q?JXXqwD+fCPlSs0Uo/Yh0py4mVxq+m/xUd6oQ6cDgT0aLQJc7HQVfl6g8mruH?=
 =?us-ascii?Q?SIO6ZyeDjsCzMF+IF/e7DyNjaa/kF+FtgQHo/VvVHt1M4iebvRSoiLYla8jt?=
 =?us-ascii?Q?yGlsGSWuXyAKN/K1l7ur4qjzOOIwAte7cvZVjm1FM1q2I1MeaxuBkLe+dssx?=
 =?us-ascii?Q?8J+qLJo6hwWQ+Bx2rPtw07t1ijIoDehhP+9dJIzZKmPMvJ/ip5s8Nb4lp+C8?=
 =?us-ascii?Q?3759ww3BrtdTpeeJh1y/93G58kMdCO3Ox0JgVVTaPubldiWryN5Y7tK6d3KS?=
 =?us-ascii?Q?+NBnHnXhSJfKYESVZM7TsPu7OCJVQfk29RgknO4dafFxz0KWIoY5edjWA73S?=
 =?us-ascii?Q?xn3A8wCAcKYSetitsx2HE+uHUwi+SmY8O9NiUy1fZHcifE0jrhgeahCrqhnz?=
 =?us-ascii?Q?OwO7Ozzoiah4HwtWtVgP0+TSUXvl5fFPZDpaZDtdJcJBiYKmTe64zSszR+LT?=
 =?us-ascii?Q?TMqsy+kzkRzoEZoZcbPxqxOWKbTTAqNS1u/rvnm4yNT1+yy0CENenvmsaw/y?=
 =?us-ascii?Q?vvLAi4daq7hLBX2WrFmSsm9b8gOvSB1+JxMx7Hzb5A5NmZtppoRx6MLMD+o+?=
 =?us-ascii?Q?5MmzmMSDMvjItpefUkFZeuwlUsBiIYzqhChkMznPEPpXcMBd/mSPP+go5pdr?=
 =?us-ascii?Q?Kjm1hhSxJLWO7ix2oVlNWrGXlDRbNsJdX8utem6gGq3qmJIvxTzd3Hc9X07u?=
 =?us-ascii?Q?vCD+Wqjy6JO7ux4QhG1tnVyEZo7vj1pCddHRsc6zpam9iNKqD+0FRVyqGE2f?=
 =?us-ascii?Q?0xEC3fgXDcG3wMQEDMeE4ifX2KE5SSE/RmnyvQuoSxQxr7ymFon1JTHdnTzP?=
 =?us-ascii?Q?RG8dvT5T6q/AeIjViaXefQq6JWAPdk2GKINwIUf5Z8zeOfmnwx0IV11Ts7nf?=
 =?us-ascii?Q?9ULFEo+xvXYdWSOQccFteCyeudpMqtureNxdT7WOetVVx8ZBdQz2BWzAmrEu?=
 =?us-ascii?Q?c3SbCTtYP/yp6iyN0ECruQ1iODTXEAirReRKLWyWdA0gjEj22zCtM/HgKN7j?=
 =?us-ascii?Q?sSvsrNLpuXWA47ROhTSZXjFJWndFOjrM5J+fjk2r0vn1AViQLjS+hTIRNxd3?=
 =?us-ascii?Q?bzMuw+4/RFXqQePpRJicac=3D?=
X-Microsoft-Antispam-Message-Info: XEdSDM4eRqT2BhydywXu9tQh0tbUhUz67t4p3trcRFrCn1BZAkVQdjv5END0lnmb545IIYMcoomCz3oUIzWb7K0sp3JR87ovHP9s7FjQZAy33k3HwY0rc1T3wUhtGRGZxzcBn1cO7bnZBY2uTEIbQLeONmOrze2asVzQ1tCljW2/y4pWXrP5BdADUcGTLoBZ70hk3oavUhgk6FGkLnAVUQHWdW6Hwbh9LOp3b3u3eoWuh7Q6ZPFZRcafXt16xl5zGdsw/H+tQj1QGbQaH3WIoIBvBhAXrgdPlHrnFFMwDkUTV+PbomC0/2K2wd7hIEAQw2jRj07j8zmxL1Q2Csl3d5OBoahibnNqdofJ9oT/T2M=
X-Microsoft-Exchange-Diagnostics: 1;MW2PR12MB2364;6:bzlEWYsxfmOfigST/qMDvK/FdAGm+ZfuArPWIZByR7c8d3DtaFBhPDnF+Bfu6OOrqSAMdhrPwDQBc/xSnIYHaaHj0CCJ9HdHNETvMscruQWrHUXj3Xmci/pU3Lt8WGm1ZuPeO8slhbfP0EkWmUhSdbyrNNlkISTrk1YRb8zNy/wEREh7Uyk/6ihEtXFNWWgSk4Nc77PkZ0ou5S8BVBObX4y7NKbUVRozj4Fo2K/953HxbEXyaKw5qN1ctJMm49MpA5YIr4ZTKhs+/6ocOIeGiLGMf+SEXcttdr5Jf6ZgX7zjLE6r6s0AGUWab+xyIPyeB+yE590n+aWOBaTmjjj/0rgm3+j6wgVuZQ0pIwMZ37GWxNAbhfhSFfHm082eirKMfjMMz4YgwdZY0i3Vl3DvTpykxDf8BJdESFcllqvsy2WPNEBQYpNsWbE2gWVa22CrRHPCp4Oj0f9Jg9BNs+1ChQ==;5:UEzvoLN+H2oP08w6LsSUzXB3cPFqFnSbTAmKzJHRb6Vg1QBe5PZrxdsqoRUitE2h6YqZWpmdToNk5GOnQD+F0KYIckY2w8iH3ddVT/GEzTtbZE2vJmjRLTbUdeqAsPJ9JJeTS79nJoTPoZYCwPHCyYOyz8dV7rk7TnzspF5a+OA=;7:am5u0JAVVEJ3NO6hI4sYiEZbAyoekQfG9VZH232+UIQF3dfZillwg4Iuz1isPdM4sg/aXP5AOJ4reCjkG6p+6Kx/29Oxhg0xzLklcXRbAnqB4tCAZmUIDcrt7ZzhUiV9v7LReKlHTYh9uNbSiG+kldvPJu4kxIMgW23kHfe3vKzenZebhhwSY05FUiTM+sCwW4An7shIXD5W5MwG7iZq0h1xT/qlnYOsYvcQrAlLAli5qA2rXILwbtT84Y59flCz
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MW2PR12MB2364;20:wM1zjHRZqVMevbb2qdh+0tQvkKmn9B435uEgzG5EzuAg7R5xkA9rpKML0nhIgdSciaxpuFzB43H5NsjXpDJVHXl+KfVPm2Bz2pHALOKLK2kOBu983OaeWEdjWvduWgSBzMoWujsvs5kQJ/jwxkK5D4cAm+UELEZijM5UzJmBi8atJTnXKAZo8c47jKYdmD/pd8X33+i0esX8np+KqvHXbP5NMU9jG0UfUrvrgQUT1pfM4mMBxHWSndVGz9i4ETTa
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2018 07:29:00.2306 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba44b046-3dd4-456c-bd52-08d5fb6e4bf8
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2364
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ACP->SYSMEM DMA happens at every I2S->SYSMEM period
completion. Thus, there is delay of x frames till
I2S->SYSMEM reaches a period length. This delay is
communicated to user space.

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
---
v2: moved reading of bytes transfered from I2S->ACP to get
more accurate delay information.
 sound/soc/amd/acp-pcm-dma.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index 32f27c5..e359938 100644
--- a/sound/soc/amd/acp-pcm-dma.c
+++ b/sound/soc/amd/acp-pcm-dma.c
@@ -922,6 +922,10 @@ static int acp_dma_hw_params(struct snd_pcm_substream *substream,
 			rtd->destination = FROM_BLUETOOTH;
 			rtd->dma_dscr_idx_1 = CAPTURE_START_DMA_DESCR_CH10;
 			rtd->dma_dscr_idx_2 = CAPTURE_START_DMA_DESCR_CH11;
+			rtd->byte_cnt_high_reg_offset =
+					mmACP_I2S_BT_RECEIVE_BYTE_CNT_HIGH;
+			rtd->byte_cnt_low_reg_offset =
+					mmACP_I2S_BT_RECEIVE_BYTE_CNT_LOW;
 			rtd->dma_curr_dscr = mmACP_DMA_CUR_DSCR_11;
 			adata->capture_i2sbt_stream = substream;
 			break;
@@ -942,6 +946,10 @@ static int acp_dma_hw_params(struct snd_pcm_substream *substream,
 			rtd->destination = FROM_ACP_I2S_1;
 			rtd->dma_dscr_idx_1 = CAPTURE_START_DMA_DESCR_CH14;
 			rtd->dma_dscr_idx_2 = CAPTURE_START_DMA_DESCR_CH15;
+			rtd->byte_cnt_high_reg_offset =
+					mmACP_I2S_RECEIVED_BYTE_CNT_HIGH;
+			rtd->byte_cnt_low_reg_offset =
+					mmACP_I2S_RECEIVED_BYTE_CNT_LOW;
 			rtd->dma_curr_dscr = mmACP_DMA_CUR_DSCR_15;
 			adata->capture_i2ssp_stream = substream;
 		}
@@ -997,7 +1005,7 @@ static snd_pcm_uframes_t acp_dma_pointer(struct snd_pcm_substream *substream)
 	u32 pos = 0;
 	u64 bytescount = 0;
 	u16 dscr;
-	u32 period_bytes;
+	u32 period_bytes, delay;
 
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct audio_substream_data *rtd = runtime->private_data;
@@ -1012,6 +1020,11 @@ static snd_pcm_uframes_t acp_dma_pointer(struct snd_pcm_substream *substream)
 			pos = period_bytes;
 		else
 			pos = 0;
+		bytescount = acp_get_byte_count(rtd);
+		if (bytescount > rtd->bytescount)
+			bytescount -= rtd->bytescount;
+		delay = do_div(bytescount, period_bytes);
+		runtime->delay = bytes_to_frames(runtime, delay);
 	} else {
 		buffersize = frames_to_bytes(runtime, runtime->buffer_size);
 		bytescount = acp_get_byte_count(rtd);
-- 
1.9.1

