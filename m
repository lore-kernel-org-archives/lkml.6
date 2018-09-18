Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DEADC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 07:28:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B756F20867
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 07:28:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="zYI+qP7/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B756F20867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729127AbeIRNAA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 09:00:00 -0400
Received: from mail-eopbgr700068.outbound.protection.outlook.com ([40.107.70.68]:53184
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727475AbeIRNAA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 09:00:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s+KAxp9SCpVc2QT/vN+8dLV63W3xR94785d54vX0sG4=;
 b=zYI+qP7/z+NRVJcPa0XLE+KaXZon5qwjdwxzH2zZPn7K2wr1OT7IlSYvTnd9PFXbr//yZqMxHZ5q/dZ37Hrcy3/HtOUK//LZZEnDcHobr9SbuVyRnsst9CZf47p0dHNZ4Z6RPUQqXaMJeNVwmZg6j3pJAdCJ+qraMoBf+vhFd8Q=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Akshu.Agrawal@amd.com; 
Received: from amd-chromium.amd.com (165.204.156.251) by
 BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.18; Tue, 18 Sep 2018 07:28:27 +0000
From:   Akshu Agrawal <akshu.agrawal@amd.com>
Cc:     akshu.agrawal@amd.com, djkurtz@chromium.org,
        Alexander.Deucher@amd.com, cychiang@chromium.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        alsa-devel@alsa-project.org (moderated list:SOUND - SOC LAYER / DYNAMIC
        AUDIO POWER MANAGEM...), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] ASoC: AMD: Fix capture unstable in beginning for some runs
Date:   Tue, 18 Sep 2018 12:53:13 +0530
Message-Id: <1537255398-25166-1-git-send-email-akshu.agrawal@amd.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [165.204.156.251]
X-ClientProxiedBy: BM1PR01CA0113.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00::29)
 To BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a06c9c39-3cee-4f9c-a530-08d61d385968
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BL0PR12MB2353;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR12MB2353;3:2drXhobR7EITBGZWOby2DftNwpucUinW6AiZ65os6L0jiTA6LNkXOWOkGIc+eD18khGHbNcclAKmiAcLr/MyoyKELfwvW+mLedYdgUHNCNw2/W9UT/ZInrAZZ14vSajq8hLj7ppmsADc08rsow/R44Lropmx39wRJknxn/UD10Zu1IukRwrsCrY84wRUUKniC7UVvcLT9Swl+QvzDgJ1wF1uN9sv/mEChk4BB7/g6DnhO3nQb5GoMgGREBsTW+tD;25:5y5UFn0XqkL+nNCyqMXMwvWbWPP6vbCxYPTTo9fdaXLst0Hw0RArKecNfQPiSwSUeMfd04n50s+/Pp6PisCU7TIX4z0+UhwC1CnipPr4vjLv7G2A7Nl5jTNwbXR/q6ImkbSOAWO0DmMnp+uqRa4g0ycuIz2CngLLiUzBOTfkzeXXHgwqJqtPVQhQp0kRuz7txdRONtRLC//Hnj9xuTbwVDAM6z2hNNqA64R29IR5Lau3HxzTLFQ1oH9q4p6H9ybuaSkd+otJs3JvszVFTYoe2GFulj7wHAQoxjg/vrWs04zjwmdTsRxO8XLkv1KZWsx5PYHESPFqR7ySt4Intt9SSg==;31:NZyksGfJ7GH247lrZzGo4iKdhv2Y4lfERYBDaO1IFF+KGpu3u8+PmSw2+7SgFy7CzMy3i3/OIqPSc7QHWt4KFhEcfNlYl/82T48W+Q6d1zVSAWVWB2eS/5gXB7dzebhHErzb6wa3VsvaDe4OPhZBR+eP2EaUV8TiH/VptV8NQhF3OGn69sOGp0HQszdm7kCT+Mz6qPt1qDirNjpvz0f2dCRmhxq1qjJIrdroC5iKNqw=
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:
X-Microsoft-Exchange-Diagnostics: 1;BL0PR12MB2353;20:thE8gMBdf/1TtvTfxXSyYHGAjSrIkVZSJAqdMLFF5VvNY+dbvv+0m3oXJufLICv9SQsL40YFs++Euw7IayCmegm2TOWIpqW3NzB7m6XiqFoM5EpUvJkM8Ue23RcMC8OykI8jm5xpPUbK5hO37jKqDbQWnazjvoSdSKPfxEhm81BjjHTcOjmqtTGqd4+0NtYlFJrCuEKsuBs9ZfshS99IzsPArEzAPzc6P0F9OCSqpE5+PPoOB35qETJWyb2DlJE0BkyjNO+IOnb+Cf59F7SRBgokCgOidnDiOBruQPP39YOPSh0tgOdS27X8sqyVdnX+LDEDbcUEPoAudu2x8qDkF2C4mvkcPnOrsTN8P3zrzb+op2NIirUJ7V5H9rCwmfZa83EcptfbCd+QHl+/wuRzeN3CxjtWG5wx4Soq+ebnpXyIs3HwZ7mLbqFcHadksf8+i+Nu48JmsLGsgqN7zkSywHoAKVNFkKrk2Aa8MTlTddiA/6gsGWA47nTXWFXaozw/;4:LFbVucWJUTmBzZ3A/C8WK2JPOelXPuLp4oqarqkpOov36GAdIj1hINmM5VNrpEC0DUO8UOfrfL0xJuv42i+TnwF97a1d7A09BmpSkrq6S1E5bEWsHROawyke4Bl2MHGaXBNqyDoT6Hm5FQl04Wy26bt0bvG655PSGvB25omgoUPpD3XRZtCUdBeRdu57hErbXucXgUH5eMhNr/LiAWxqY7W5oWLzPz5B3shoNszm34s5U875QbVHejIJIQft3kYvZRXE9b9kwKXjWNbED/d6VESbVrCvsXuL1tkMWyLkD5xu+qjB2aXwZxpO3XRV2a9y
X-Microsoft-Antispam-PRVS: <BL0PR12MB2353AC7D8E071312EB4BD3FAF81D0@BL0PR12MB2353.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050);SRVR:BL0PR12MB2353;BCL:0;PCL:0;RULEID:;SRVR:BL0PR12MB2353;
X-Forefront-PRVS: 0799B1B2D7
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(396003)(376002)(366004)(136003)(189003)(199004)(44832011)(1671002)(478600001)(50466002)(6666003)(68736007)(47776003)(81156014)(81166006)(72206003)(2616005)(476003)(956004)(3846002)(8936002)(50226002)(14444005)(5660300001)(66066001)(6486002)(2906002)(486006)(48376002)(6116002)(7696005)(106356001)(105586002)(305945005)(7736002)(53416004)(97736004)(316002)(53936002)(36756003)(109986005)(4326008)(8676002)(39060400002)(54906003)(16586007)(16526019)(25786009)(575784001)(52116002)(51416003)(26005)(386003)(86362001)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR12MB2353;H:amd-chromium.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL0PR12MB2353;23:2zcjpBjKjIXXDZVB6ElN87KbLXkeRvYlpfDqkNl7x?=
 =?us-ascii?Q?+Apg9O2KueVzecZpz8ogMitJhccH+WUgbWYhydhy3RcnavU6ZhQjuM/2p2K9?=
 =?us-ascii?Q?ace29vAB/yNQzeAUYhP32md2Wa7HfEpbI4TUQKfCyY7WhNzM9JxyeyOeIf2c?=
 =?us-ascii?Q?WtM7Op9GSgjYzGxiNjXuWR1ciaEZ3K+f0AbcCAHZLWTDe3VcVHLc9JtyIBAw?=
 =?us-ascii?Q?PVYtc9/wDpbg1rAyzgPZ9SGgNZqTLzO+1ZpqjSz9LaVAfrxEZrdmwJLGiXDE?=
 =?us-ascii?Q?B5oPnzDq27K+ILTOY+Yan9EDMAW6Qes/0mnWUYRsPClZ9bpuE9XJzB2dYP+e?=
 =?us-ascii?Q?1X+cD7uMD4fmjRVsBDa7KRLZhaHmYttDAEbwWQCwItarDmtezP4Mm9cAw/ue?=
 =?us-ascii?Q?Y3FMn1geqDKoj/3VY4vzHVEdj68IGXiIDRmG3Cp/xQ/fH/FjX4pgFk/dRWuW?=
 =?us-ascii?Q?pqTRVcQ/2/UnE0SDAM+60N+tM5ws3BWgiwZ1sZtFDjT+bZEJmnXVr/PfL87r?=
 =?us-ascii?Q?ZnuEYOl5VancznUvh1msLUysV/DVqSz3/YXDZ0B2PIHuYwpkVUI4/FOWszQ5?=
 =?us-ascii?Q?jBaANt70wISgzhiMOZ1qV3bJPxAiovJp19EYrm1kmR9wrxlahyOLGt7pt1po?=
 =?us-ascii?Q?NvoSQ7v5w1OmldcSSkuJWfzR+UOhsrSPNs5HZXAh/H8aupat2ngT+RmB4gPr?=
 =?us-ascii?Q?k3Mrya/w/wnMWtjaw8X5D2gJoJeRjCwcoL5FuIm7czGUW4KtwmYDsPfNSH/F?=
 =?us-ascii?Q?Hl3yCebnSDBcVC3GRi1cXQmsOQayM4Q5Ss+Y2boPKhZJ7kUcj2wA+cRubi6I?=
 =?us-ascii?Q?Weurd/sPGpCBFwGzsDBe2WVFIkbPAeDhu831qdi0PBwubRqiM2EUtvpzY5Vo?=
 =?us-ascii?Q?OBQDLJ0+XRlSKo9lprBUElahiih6/axfNzOsXxmJQm2Gsb6zlFZEaJgGe/1/?=
 =?us-ascii?Q?YB78mRbinR/GJTel46g1oS/UOozRPpEPgiMAOsvOW5+r/Wp+oc5Bo+ZWEc2X?=
 =?us-ascii?Q?eGI4bM6O2tKu7U9eZ6/NbC3d8qub3DypFdUMcT6SPYYIaJ0/S4fEI9lMCw/x?=
 =?us-ascii?Q?kFMHC4awEuj3Ox6pmX2wQM47qgPdCnFbcsievLhe/UbCQO160fhfDOS6qKcm?=
 =?us-ascii?Q?rOIsUYTjpveIY90DNMHhD2Pcs429eRMq+wCxzHdy1tHOJwfj+LsQI95rTRfn?=
 =?us-ascii?Q?zbPDsRc38wCt8BRzL5XQTuZA/l0IKkfo2DvaXcH7Y/wpeRHMqCAWnBiIdumU?=
 =?us-ascii?Q?GAASPS6MPhA9CcpPIczTz/xgWcYUBszZXhMKEQP?=
X-Microsoft-Antispam-Message-Info: ofHvFGsCDN/ghm4YIar+RWq/WjoTf/Tqi/AC2HqSQRb5k+zNV0zxpkueOt3jLr+qrrV1XtFE+ak2rzvRFtyUz6tAYY4/uyNnnB26C/Ud4ECQQ02+pBM/M/hL12FQBnp1Fr3szY2PAwMLFmuOWW6TO4f317veD8nd1rBVC4wWc6/aTg22jk6X13ZpNWokDxuacfdfCqr3XCLcq96RqJU9UmM6j+O2+JiC9E5ZBv7DHiXcXZQxcw+zVu63+ofZ1h6+y65Tv1EdHlu065fdut2XIndaRFeQuGpxdtRFs6un8WgIiUx1fA54liLRJMMpWM/puFM+9+aSf9qeSvk44qLqO1x1Nnyd95OabLKINSadiuA=
X-Microsoft-Exchange-Diagnostics: 1;BL0PR12MB2353;6:q2Op63RzbzErBKoRyqY4PBY4HqzskvwVLr/7L4E7cyKFz+iLkTbYzV0gfPPs/vqI4RKjQOIsgGkcCYj+kPG26eUw+3TdfCURh52uQu2TLwzhaI4Z+nIQhGYqhCTelAGkVzbuRkCNtkPK8TTfHozxJaiakXKhTq6Wcp08UnBHQ8WMopagpJ9rm+JDOhxsJOim1k59nh8FNpOOLQlHBHTssL2o59YDYoQqWUhJK+2HFXQaqwF/278ktQEpBlIwinYRPjXZdV1J4amC+LgX0cqesAKXkN2ZMU0Fae6HRo1h6px9Al5VB03Fv8CGQezMy9IlA2J9f+tuPwFmekxztafKm+ZBSCEp6dIXk1W7Jttoom55QWSLViIEApAvlL4YNI7sVl4dQk9Zs8IZe2YB/OKd0ul0iizptRfT4lO0Qa6eOv9WOSVPPmAH9SK2wBemkFRGaIKPvzxpWYr5yzO2MbvXhQ==;5:pEFN6BNSqE9exM41HNZ4O2bUgvttp/1+p96m97M2a/c40UXx4yfcuR0p/piOLcMm8a5+pVb8mvgOXIKY+hEfl01yzE+q35cogefPVJAsP8SonMc1Y3NaTPko738ri4tEIpEExS6y0p/zscrGUu+4gMIWptn2mmQsPdsBqFZHV54=;7:ZQyyGDOiBtdmTOeznUZvFrZTpemxitnc8d2zQLEYc0AfG6ExJpLcYf6Lm8mkPH2MWdMPvlahcvOMP/a9wsF0p6cd8aNtWfvHAkK5M5fyTtrQGjHXLcWgSYEuM09slgTqsVl0Bw49YtGwOr52Tn7aG0xGmnWb5OMEq1BlKjjziccvTQD6PhM6r/7mDadOzVIXYmIXf4+AoWwTmKrHRn8TAtE1gzQVl/Lm2VDxlyGcrGJB2fJLAhKK5g24Ju/7/lLE
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BL0PR12MB2353;20:OpaV4tQKHT3WpDQD2MNdHmPfFBsFWnKvISEOhicO+STn3wgBQXOe8Ipc8/zQ0hHNYjdOAfzPV0tQ/L/tDedxPTX7vUNLWvhwsKzrR9L7pxZ3bseNxhB+vMRlQ0cdAo27EONWlLnl+Y0EoU6dlbpQAXWPE210N5xXsyRueU2e6ShaI5jqrhOJgE6aRTPAUB5nkxQJriz9C9dzrJWvIVKre2mVopsls7bc6w3nN30AiiKHyGBUu6iWJFDOWhA+MlpK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2018 07:28:27.7860 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a06c9c39-3cee-4f9c-a530-08d61d385968
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2353
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

alsa_conformance_test -C hw:0,4 -p 1024 --debug
would sometime show:
TIME_DIFF(s)    HW_LEVEL       READ              RATE
0.000095970         1024       1024    10670001.041992
0.042609555         1024       2048       24032.168372
0.021330364         1024       3072       48006.681930
0.021339559         1024       4096       47985.996337
The issue is that in dma pointer function we can have stale value
of the register for current descriptor of channel.
The register retains the number of the last descriptor that
was transferred.

Fix ensures that we report position, 0, till the one period worth of
data is transferred.  After one period of data, in handler of period
completion interrupt we update the config and correct value of descriptor
starts reflecting.

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>

---
v2: fix overrun issue and missed case where bytescount = rtd->bytescount
 sound/soc/amd/acp-pcm-dma.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index b0e245c..0ac4b5b 100644
--- a/sound/soc/amd/acp-pcm-dma.c
+++ b/sound/soc/amd/acp-pcm-dma.c
@@ -1035,16 +1035,22 @@ static snd_pcm_uframes_t acp_dma_pointer(struct snd_pcm_substream *substream)
 
 	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE) {
 		period_bytes = frames_to_bytes(runtime, runtime->period_size);
-		dscr = acp_reg_read(rtd->acp_mmio, rtd->dma_curr_dscr);
-		if (dscr == rtd->dma_dscr_idx_1)
-			pos = period_bytes;
-		else
-			pos = 0;
 		bytescount = acp_get_byte_count(rtd);
-		if (bytescount > rtd->bytescount)
+		if (bytescount >= rtd->bytescount)
 			bytescount -= rtd->bytescount;
-		delay = do_div(bytescount, period_bytes);
-		runtime->delay = bytes_to_frames(runtime, delay);
+		if (bytescount < period_bytes) {
+			pos = 0;
+		} else {
+			dscr = acp_reg_read(rtd->acp_mmio, rtd->dma_curr_dscr);
+			if (dscr == rtd->dma_dscr_idx_1)
+				pos = period_bytes;
+			else
+				pos = 0;
+		}
+		if (bytescount > 0) {
+			delay = do_div(bytescount, period_bytes);
+			runtime->delay = bytes_to_frames(runtime, delay);
+		}
 	} else {
 		buffersize = frames_to_bytes(runtime, runtime->buffer_size);
 		bytescount = acp_get_byte_count(rtd);
-- 
1.9.1

