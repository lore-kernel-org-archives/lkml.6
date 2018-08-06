Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 970FFC4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 07:29:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DC8621535
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 07:29:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="irl+KeGY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DC8621535
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbeHFJgo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 05:36:44 -0400
Received: from mail-bn3nam01on0077.outbound.protection.outlook.com ([104.47.33.77]:29600
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726412AbeHFJgn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 05:36:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1sCxUg9BZWW+eCb2cPtyo4pLsw8oYbrfQiJ07wzKkQE=;
 b=irl+KeGYQhJDI7mtw7Uue9K4G7v8xWacHS4tUqXwDlZeQYrQqbfpMmPiZK81HTbF0XNoczy7vJem4iivhUTQxPkHg3UaeLVpNtIxz0geDGfBb+MeJPUI0OdYUcvmJ3JwFasANhrFU9Zwv09V7u6HVKQynrdzk25nQrFpuoZAvOo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Akshu.Agrawal@amd.com; 
Received: from akshu-HP-EliteBook-745-G2.amd.com (202.56.249.162) by
 MW2PR12MB2364.namprd12.prod.outlook.com (2603:10b6:907:8::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.15; Mon, 6 Aug 2018 07:28:48 +0000
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
Subject: [PATCH v2 2/3] ASoC: AMD: Modified DMA pointer for capture
Date:   Mon,  6 Aug 2018 12:57:15 +0530
Message-Id: <1533540439-18735-2-git-send-email-akshu.agrawal@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: e5245cf7-9396-4fcf-ee66-08d5fb6e44d7
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:MW2PR12MB2364;
X-Microsoft-Exchange-Diagnostics: 1;MW2PR12MB2364;3:QsvszDWVowSjDtK4ZIK2LKkjDKlT1FZBCGx0/hMdhhNv3C4nCnFbMeGMSDsMcG/WnqtM0/jM1K3fVBphAQhS7fMaonn2vReW+UpIMyY/pjWaN/vIPYqTI0hogjzynX0svHixW0fJ8D2dd0A6BPZzT9sO7rEsUx5lF5sOiCeFvwyhJqINCfW1NCwhBKUXr1MainIzMkni3u3h/P5Hqkk6cCcG6xFNmjTpWI+1RygmyBsX69r58RnpcJy8dfUIMtRZ;25:BLdQKFr5rlKEWBbQPaLA3zdXR37QyNP7B9Cd7MGQSvwYaWeXD19C6QCfOHekrVbRSz8JA/RukzmhH7FP7iJz2XCwkOZ3Pj5kXXZaZjkxCadEdW/aKVEGij5w7ZxKSQplhSOC+swt3B5sIABM+HCKlJXR69WpwW9xbO9TfFyy6Xgnqjh9/KYzja30wYEw+g6Ycw6COhV3NsnNytcTfagyde13EGJ4EG876a43E+obMncI2CkTau7ZcJm8wIhzZiLLxJWd/39bCyA/t3rfScu9QDCKK/YKchYhNXvKT7iVuShd/5F3e6gB2ERECBA/FBhLXHI7M6SezWiSm4BzsGZF4w==;31:sycoyCQOI/RXOlRIX3h7LBsOV3bT7EL5wrHbyPl182GZRPId9v3H9PTASf5UXNGDzH7urx6ncvW+O4Zutqz1dy2QsTgLDABHPOkxbnch36kJVlFpCirPilL87AhYaM2+HgWWJwaaLvK08picejJegRpP3aLn9Um9v0lxtUYwtzy52DhJzi6/Rlr6FmiD9zOGtOW/dobzmmgrctnTMY1vN/NJOgAv1l9/HM7mywlKJK0=
X-MS-TrafficTypeDiagnostic: MW2PR12MB2364:
X-Microsoft-Exchange-Diagnostics: 1;MW2PR12MB2364;20:0fueSvTfe+cfVNmJRNaE6AtMYNfuerR66Xne4/ihzpx2kGELNqEnmKOvY/x7V2R3EglKvl2txRC5mYMRi0ml6BjwJZyhcPR0ARJawL9x9hS/mxJ49BzNlXCGDHbSQ9oRQ+8iHqRg612PaP0ILAvyUV9D3hp5FDXkT5urHI6YSYXDgiW4FdvHBuW5Ri1T1Qx7C5OhGIG25PTi6sFax6oisnZJTx0HlHZQOTZTPl7yB8Zt7Ok8LZyhheUO78E2r3pmCvRWozGc3QTnvzU0Enl/3gor3d9LLnM5NdXMQj6BRxLr8iUCyQuI9cUVSax76w5Ant3cqaL2Sc9TJ5e/cvnr33M+B6CD8dVD1/EDnT93EEgwK02EWFNsYk1NugZyFIXHjNTrVeDwMN1d7EuJkM6TwdD5m3Qa5CSXXJL4b0wOW4pmYJ4LY4Yd1CQsaMSizuKeMuOyfuhCA+aSVXhmVRGxCTkCAUiDxGXFRkP+7dZC8VnmsVsS6PAvkZwrxVf51MdE;4:1qznqv0xE3vM5s9S4D3k5aEaK6gsCU+jHTAnfXqEp8kvjVj0OEq3r7+9SNItYHJh6GXmbLgxISx7vzI809N7sDqTOSepktveQwDg2gVNNsHHLU+jB2+1ubd0INVRTrZumDokgwE5ytxym//jw59LjK6JMe6iexb2ckO+xo6SW7sajmGHQGA2aoji4i1ul5ElJWd5zbTQ8+iOQre5Mso8dhuzBtEzXc0SpxOJ2IBKYGzHUpWzIJaeAnp2J/GySnXXDgslsGps/Zcro1MSuKkMIk64WVBPgi3Tyi/5uydYUYTIylF0dOwcmSz+xC81Wrx/
X-Microsoft-Antispam-PRVS: <MW2PR12MB2364711F3BC120DD0F5BC60AF8200@MW2PR12MB2364.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:MW2PR12MB2364;BCL:0;PCL:0;RULEID:;SRVR:MW2PR12MB2364;
X-Forefront-PRVS: 07562C22DA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(136003)(396003)(376002)(39860400002)(346002)(366004)(189003)(199004)(6486002)(386003)(86362001)(2906002)(486006)(476003)(186003)(16526019)(105586002)(48376002)(54906003)(1671002)(36756003)(52116002)(51416003)(305945005)(7736002)(7696005)(76176011)(47776003)(26005)(2616005)(956004)(44832011)(66066001)(478600001)(8676002)(316002)(25786009)(11346002)(4326008)(53416004)(72206003)(97736004)(16586007)(3846002)(6116002)(109986005)(8936002)(53936002)(50466002)(39060400002)(68736007)(446003)(5660300001)(50226002)(106356001)(81166006)(6666003)(81156014)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:MW2PR12MB2364;H:akshu-HP-EliteBook-745-G2.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MW2PR12MB2364;23:XR1W7oye+dbklkFsGiUqaK6vDcEAIOo1Jyf09TeCm?=
 =?us-ascii?Q?WamYjTWNrNTG3Vs6fUmIf+MUTuADSckcl67Y9fygEU3zqFmly3cKcJTx1xGB?=
 =?us-ascii?Q?Urt0tqxIYTlSHQcwZLol31a9D7KtV4cKCj7uiZZF288qJzS1IDMs9D1Jopqk?=
 =?us-ascii?Q?kWynlFiq8Io7jO1dAuTNYwHLsSp35PWQrAKh3BUn16Ai6B6CJY6YGMHXzjlf?=
 =?us-ascii?Q?HTVttKw/P8VUZQrtp9V4KgL87pMEBRSY1iVVeos8RYcCTGNixp9Y2KMg7eNr?=
 =?us-ascii?Q?g8rpRzZdar9D1FtTZUXRPVenwEw4Wk5tTR67IDfhtBEEsd7WMB4Mi/h6rJpJ?=
 =?us-ascii?Q?uzdhfF8uIAj/wp/J7X+m+48l0BPcylRPfAX65D0g7pNXV+w2s2Os/dzy/3lz?=
 =?us-ascii?Q?Aw92Se6d+Y9fyRCxHhq/CL7i7cq4A8M3P0MsjVvfwbZQtGDhIo71ijosM8vK?=
 =?us-ascii?Q?gKtHt4LUxFoiNSDMDALlHLRx3j71JaFcKcEsdFFUbSmA6FH3MlBRJ4QqH871?=
 =?us-ascii?Q?rjy4Xzkc0sgjPdKMlIL8+XexXEE4dI3hnhfgTJ62Bx5OKIYhvC1wkNYV8fEB?=
 =?us-ascii?Q?CPS3AWSCwjbU7+HQ8+mEm/OEMID5U43EATkhpQimROUCCOHIZwrOIBiAJ4lC?=
 =?us-ascii?Q?OcAiW8zKHG5e4B+q0dCGDFeT3ACBbHCC4l1q550sdByyR+Q7VTMY5KAPOLBO?=
 =?us-ascii?Q?jnYardkgfGo/aBKSsTdut/YmsEz8zHj3G+Jbqpk0nbSOhVi15gnHrENyLsKO?=
 =?us-ascii?Q?TG0dQqO1pm7VogcRfpaIG1bOHS9vMd4n5I9TwRHDfOjJpB/you4mbindOKEu?=
 =?us-ascii?Q?bDlHmwQy8ZWQ3L4s4P21pO5YsC+DNEpclkckQZOoYNJy+z4kQ/MYB4GptVb1?=
 =?us-ascii?Q?gMdzEmg4ECHVgRkv+QeyyavWbxbPckZ7tZN9syCii2EncaLIZ9d4XXdjH8I8?=
 =?us-ascii?Q?JxQ6mC+1HlFiVZa14UMd/ci2D+6+s31DlBxhxyYn0ZqJZT+e40sMldYfe8t9?=
 =?us-ascii?Q?7WnpZpEdKIO4NUXvcBTwc2S2EW+6ZyWr0Q8hrE6czLQxWFM9wbteKTzMz9QB?=
 =?us-ascii?Q?6IbvrHjSin+2M3VOH2A4BBgDxcgv93eaTxnNE2x4/sBT6R63tmWpn2OJq/va?=
 =?us-ascii?Q?+suFBN8/1x8xYEHnJ+Yb8D4ds2erBNNpNxq7/PSimVodCmbeVkigJWD21xCo?=
 =?us-ascii?Q?RRVb+5mxKXMWXybXFpYxElE0K3yHypZPeniiaRo+cjXKEYh1Dkx2/LyC7BtC?=
 =?us-ascii?Q?YkT89Zpa4+8X5OcjA3eFc8WuFCehKoi2PSOK53uR7JgFjt49G/zTHxnRvdEh?=
 =?us-ascii?B?Zz09?=
X-Microsoft-Antispam-Message-Info: 1UG7WpfK1o87rU0Z0scONBoE59nETulFIZ1SVdXrrHjWpVb5556hEvJXdJ5bX/A5pf5NWrQr3gOrzK9BzYDLJlW6L3X/TiTRIP4Jy5fM6NW9o2KznYfyXL5h62KQWeeWrtqlwYS0ckRYzWbxJcnW6sGTChvaBKPGz/An/b8oRnFafOj3d8zzF118U05yS40dJCyLub7hGSh/jeBGRe0byxEECVyPPqPyHQ2crn62k44NDEbZn1e5WKdijfcMD1ofIbkgt25BnbomhGtSAXATJKhx3lfVC4TQWTs/0yBwKUHmgs+OA3EVQ6dJEbYDOYmuzLMOSDLGtLdci/n8MlFnNyURrDtyrjBgmF7cusFuJ6w=
X-Microsoft-Exchange-Diagnostics: 1;MW2PR12MB2364;6:JaL6UNlDoj8C5jigB8utjIKz59u90Uhx9OnJJ1ITzeYybM8qeVgLEnLzMHeX1RgWVElfCKsh87h6U3unpQMF7Iz8oeSOyVkDZOwphrB+EMA6oa1jBjiMUYFEeQrz45PO+tB83TatSH3eTK8mcn0YzPvRftcBFBTKJNo2D6Knfo5itdmsdSItzlUvytoa68wH7nNbZ5z6jnGqY72BojrNW4dZ6bkRSBIiNhfPksJhb6Cj2ZeFoVu1XcJBQA3Wud7ncgYE43mlgZrMaYBFssW8D95UvvXg8/YuO72VYQniGwXag3xWv5V3MAd9TDsX86ELVLljvdcRh6FHGXA5Z3aqS+wo7NmvXw9IlDitfNlsqj7RvQdHxawROLLoy+qBONJ5PFah1MTYZ3hWiuuJrjMlAb2OGMRBNvBhS41EXPv5dZKW8yZ051ho5Ql+dkZCi5q8XNBR3Yi1Pq7G5UgQ4hl25w==;5:oADFmh6WRDO2UnNTyGIc3e/PEVl92xy89H4ybJu8wXzm+ulcOlwKVEV56O/GwypWjRqkpsUPqMEzkJi4XAw5wvjxhuUFayNs5lbyiLZUIhw5KhBS8w7DmvbDhQM31w8nLWHtQ937mOhDYsvQ1Ce8QI2Kg90YzPm7bg4dvzLsdvE=;7:XTyE84aGLV+i+dOt2XSz/BDMJW0fbPLSTw7uXaeNiL0SmQ5Q7KRo8R9+/nLjIT1NSypkOvG2UeVy7MFBIYtOrxbZDgeluPkk6h5COyXJBlbAAkHCy9RyTzbdHOCfjPyVjN1qiUxux7JLm5qrdSaKlPolw5/yws/26xVvu6yCYnrk9DS4amhLhEdAeijod0Z5JwtrpLNUQ9em/TwmZ4eTfLYxD2W+rhxiQxsyDNa6F6eu/vsXYJezAAzh9SDFCTUh
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MW2PR12MB2364;20:f37Y4pnGiUL6ziCglBIESxNe83hQTuRvIUTj4U96wF2KjKWGShQFjapo2U6BBqpeKneo+yu1CX+QataNkSDw20XKmESv011jduD5bUA8rq8RpjPq14IELO9t9ISNFlHth/m8ME/LKTduVSnI/RIoiErIlJmx6aIZOGYf8XEfHplqYbvwIt1JFvjbYXDo8+VUcxefk9oYsERbwMjzHQeiLV2JFsqGyzhesH4T3XzNpRQmbMshakEw1uwaXc3kqn/B
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2018 07:28:48.1144 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5245cf7-9396-4fcf-ee66-08d5fb6e44d7
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2364
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>

Give position on ACP->SYSMEM DMA channel for
the number of bytes that have been transferred on
the basis of current descriptor under service.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
---
v2: Fixed position, now position = 0 if on 1st descriptor and
pos = period_bytes if on second descriptor.
 sound/soc/amd/acp-pcm-dma.c | 31 ++++++++++++++++++-------------
 sound/soc/amd/acp.h         |  1 +
 2 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index 816abd6..32f27c5 100644
--- a/sound/soc/amd/acp-pcm-dma.c
+++ b/sound/soc/amd/acp-pcm-dma.c
@@ -922,10 +922,7 @@ static int acp_dma_hw_params(struct snd_pcm_substream *substream,
 			rtd->destination = FROM_BLUETOOTH;
 			rtd->dma_dscr_idx_1 = CAPTURE_START_DMA_DESCR_CH10;
 			rtd->dma_dscr_idx_2 = CAPTURE_START_DMA_DESCR_CH11;
-			rtd->byte_cnt_high_reg_offset =
-					mmACP_I2S_BT_RECEIVE_BYTE_CNT_HIGH;
-			rtd->byte_cnt_low_reg_offset =
-					mmACP_I2S_BT_RECEIVE_BYTE_CNT_LOW;
+			rtd->dma_curr_dscr = mmACP_DMA_CUR_DSCR_11;
 			adata->capture_i2sbt_stream = substream;
 			break;
 		case I2S_SP_INSTANCE:
@@ -945,10 +942,7 @@ static int acp_dma_hw_params(struct snd_pcm_substream *substream,
 			rtd->destination = FROM_ACP_I2S_1;
 			rtd->dma_dscr_idx_1 = CAPTURE_START_DMA_DESCR_CH14;
 			rtd->dma_dscr_idx_2 = CAPTURE_START_DMA_DESCR_CH15;
-			rtd->byte_cnt_high_reg_offset =
-					mmACP_I2S_RECEIVED_BYTE_CNT_HIGH;
-			rtd->byte_cnt_low_reg_offset =
-					mmACP_I2S_RECEIVED_BYTE_CNT_LOW;
+			rtd->dma_curr_dscr = mmACP_DMA_CUR_DSCR_15;
 			adata->capture_i2ssp_stream = substream;
 		}
 	}
@@ -1002,6 +996,8 @@ static snd_pcm_uframes_t acp_dma_pointer(struct snd_pcm_substream *substream)
 	u32 buffersize;
 	u32 pos = 0;
 	u64 bytescount = 0;
+	u16 dscr;
+	u32 period_bytes;
 
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct audio_substream_data *rtd = runtime->private_data;
@@ -1009,11 +1005,20 @@ static snd_pcm_uframes_t acp_dma_pointer(struct snd_pcm_substream *substream)
 	if (!rtd)
 		return -EINVAL;
 
-	buffersize = frames_to_bytes(runtime, runtime->buffer_size);
-	bytescount = acp_get_byte_count(rtd);
-
-	bytescount -= rtd->bytescount;
-	pos = do_div(bytescount, buffersize);
+	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE) {
+		period_bytes = frames_to_bytes(runtime, runtime->period_size);
+		dscr = acp_reg_read(rtd->acp_mmio, rtd->dma_curr_dscr);
+		if (dscr == rtd->dma_dscr_idx_1)
+			pos = period_bytes;
+		else
+			pos = 0;
+	} else {
+		buffersize = frames_to_bytes(runtime, runtime->buffer_size);
+		bytescount = acp_get_byte_count(rtd);
+		if (bytescount > rtd->bytescount)
+			bytescount -= rtd->bytescount;
+		pos = do_div(bytescount, buffersize);
+	}
 	return bytes_to_frames(runtime, pos);
 }
 
diff --git a/sound/soc/amd/acp.h b/sound/soc/amd/acp.h
index 0a2240b..be3963e 100644
--- a/sound/soc/amd/acp.h
+++ b/sound/soc/amd/acp.h
@@ -138,6 +138,7 @@ struct audio_substream_data {
 	u32 sram_bank;
 	u32 byte_cnt_high_reg_offset;
 	u32 byte_cnt_low_reg_offset;
+	u32 dma_curr_dscr;
 	uint64_t size;
 	u64 bytescount;
 	void __iomem *acp_mmio;
-- 
1.9.1

