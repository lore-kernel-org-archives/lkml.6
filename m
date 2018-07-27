Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1974C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:14:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55F152089E
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:14:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="k7jrCa1B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55F152089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388767AbeG0Lfh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 07:35:37 -0400
Received: from mail-sn1nam02on0075.outbound.protection.outlook.com ([104.47.36.75]:56144
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730205AbeG0Lfh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 07:35:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qS62/xwdbZGAwJmNCs+6BkZejaVP1fIhJ4i8EIee9Dw=;
 b=k7jrCa1BaYlHdsUVBPRUNwR31Mxkrnq3BbLSR+dWJCis/CuxJvt8CB/kF3W7cqOw6TWXwO9peuIkDHco0cLvOOVp1HW8J5Epjqe6c0jk7oklwZvJZ2egMCWTVxWwLeqpOSe3+x45KGJLSzx5R16eyvkKrcJicrvclPmXluqEpl0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Akshu.Agrawal@amd.com; 
Received: from akshu-HP-EliteBook-745-G2.amd.com (202.56.249.162) by
 MW2PR12MB2361.namprd12.prod.outlook.com (2603:10b6:907:7::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.22; Fri, 27 Jul 2018 10:14:18 +0000
From:   Akshu Agrawal <akshu.agrawal@amd.com>
Cc:     djkurtz@chromium.org, akshu.agrawal@amd.com,
        Alexander.Deucher@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org (moderated list:SOUND - SOC LAYER / DYNAMIC
        AUDIO POWER MANAGEM...), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ASoC: soc-pcm: Use delay set in pointer function
Date:   Fri, 27 Jul 2018 18:13:42 +0800
Message-Id: <1532686422-1790-1-git-send-email-akshu.agrawal@amd.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [202.56.249.162]
X-ClientProxiedBy: MA1PR0101CA0035.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:22::21) To MW2PR12MB2361.namprd12.prod.outlook.com
 (2603:10b6:907:7::32)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 660b226e-8597-479f-24b9-08d5f3a9b85a
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:MW2PR12MB2361;
X-Microsoft-Exchange-Diagnostics: 1;MW2PR12MB2361;3:QiQg8kRd6bP6CwCrcz3BJOfXKEv0SXTMHrZLjK0swhc0ahHSbYK3r0tl7834Kf1aRF4sU7GyYqkT7uywR2xV+dZQcobUgdZ/gORLvdKr8x+kgKyjXivuGRLBMULp4RUfLYdzIQg3hndgQI5VShgviR5rCKfM1+6OaA//uOEO8PcDW1FwuIr7ZwS+5PAGkjJUa9U+18LnA9JQqrO35E7NF1pN+lIJmyAG0pBfaX5xDNeJmhUC8yp7TYxnccClkmvI;25:PYR1UqmitjzbDm2bbxWfwdVqIIg/VTtYyEuD6wtzrCrjVE0BFZbLFTfs44jAtToRGS7jJU25N2VqrOaQqae7XV35oVP9nApKOkgDd4CoWp6blkprLzb19JP3ZFpK1ANicjrKsmpfFPtoBZKQMMTSsP0arEuKY5P6psmV1T5RUhFxAgOmEEWdZUSsmIHN/8AldbUuzPcxQym9eSlEMoxRVkXKDreYed0QXjzgxEMpUVefYkq4lfGsVPFF7/27ZWUWYXNsncDNuskLmjGfPo8sTVIxexLpt7mnmdQLLVixMT8kVxy/mQRoydAxaVqA5HkAh9XnkyOMHwNF9QG9kl4vpA==;31:jPQhFUm6RqHJ6js+7MMyPsFq7H8C/lTeUoDDxMGd/yDGr7cZq0XUM8wyxHMEB6HEzy3zEN6yhxeKja38fpua8ugBzncWUkCMnvDQiL8ReMwDB5O08zFOSfKRMT21Bgqn0cISbH0/Dj5IlJGnJY9K4zj6q2/N0j6Ii7idTlSBeTVTh5E3DM3xQzMohsyP9k95nzpiOqF7ZJGdk6GktJpz2PFoMcXtnVNcVL/yT4j5tHI=
X-MS-TrafficTypeDiagnostic: MW2PR12MB2361:
X-Microsoft-Exchange-Diagnostics: 1;MW2PR12MB2361;20:Wacx7JSMHgJmMvEz7biu2aKSY7qFYDbDyDd9NvEKgMRHB/mZn+BjyOGm2wLdl4zDOfcj1cemXEu9u1AVPDqjGd91pk2qUy0yJWbscjSKWAqvn95O1kQ59B5lHx4LWUDvxtNkilnMm5kLFHApUkTSOw+BzsuF5vxvXY0jGHd1em9K99H1LRttZGA2y9cHrOI96GVxQPKg61hRfUERPZbzmHqjvc5TBNbzlEEgPiSdM2TCxVmxRN6gIZw6zGP8E/ViLXgFxtIHcIahI15p5yHgq8VmS5kaYEoOqiMz0fy+gobhB5pMCrUZtIHw8KYivTFBcimUVA1yYJkmcbxmoSlXYIuapWu/H2E7erJk3ccLerO0N+/FDTz4csjBJV93+HFlzT9hvx+aCUG1EQrxDEsAikIMqtw/cL9lIkSJXO9Xrq44albLYphUZEHZR4TyLlcQsEctjlnB/zYLaaNR1HUztE2Eo+BuMrwdwvAmylxVe+MThd3pA4e5QA7Dn9mHPsuT;4:F8ieYGGjdsn3CVTJ2hhenljs9uW9kd49v7gnMqYRXIY0gAjJrQwpZjvJaUuoKgn/yXY44xEnQiyS9SsB6ZhrypiKJHvWJ6+n0KMBUnnRIsXSAK/9YtJJWHrRnpZUFJGEe9S2BI0vE32ShPlTk6m+AKW8ae8Fp7tOUVbXOVfp4Fg2GYxCJcEhDQDbgKTbCWHhiALZWWphFun6CCwv8ubuIYcVP04PALNl5OoLMS0IieMQFJLkaZ4U07MPlNYsOD16h6zP52qqRVDOGxVk5VPTTkrKZspH+lEzAhqUg8oTCDrvj4x/Zr7hVt9eSxulo1EO
X-Microsoft-Antispam-PRVS: <MW2PR12MB236134E8BAD83EFB4BC0AE40F82A0@MW2PR12MB2361.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:MW2PR12MB2361;BCL:0;PCL:0;RULEID:;SRVR:MW2PR12MB2361;
X-Forefront-PRVS: 07467C4D33
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(366004)(136003)(346002)(396003)(199004)(189003)(1857600001)(16526019)(8676002)(3846002)(6116002)(26005)(72206003)(186003)(478600001)(66066001)(44832011)(52116002)(305945005)(476003)(7736002)(47776003)(105586002)(2616005)(106356001)(956004)(54906003)(7696005)(97736004)(486006)(81156014)(81166006)(316002)(16586007)(6486002)(14444005)(53416004)(386003)(2906002)(6666003)(8936002)(68736007)(86362001)(109986005)(39060400002)(36756003)(25786009)(50466002)(5660300001)(48376002)(1671002)(53936002)(4326008)(50226002)(51416003)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:MW2PR12MB2361;H:akshu-HP-EliteBook-745-G2.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MW2PR12MB2361;23:R27qpSXBgAyoXpanTVHXkTy496Qhtioh77hZknie8?=
 =?us-ascii?Q?OHpUvtpan6BdkqQ6vhbjm+tjLvErY1B1v7q77cnEhTrdwTBanH8No2nb6dlh?=
 =?us-ascii?Q?t4bZKT21a0rKJddOH2xsG/w5CN6sjS2APhBVlU2xqm5Jh825e3a8Uh0QocU6?=
 =?us-ascii?Q?Dhg3AFrttJn4TyXVIwOtVAXjfp4dshcIFFbPuCtB9jcHqYiJZuyUlHY6xKVj?=
 =?us-ascii?Q?KnRZecCavMm0EyiEN4JFn0qgQIVBb5OWb5j+QoTdASSIjkZG/LBywDHi3Xuc?=
 =?us-ascii?Q?eloryak6eS3p2TbItC8m73CbROQCKC2W8DD6zWdN04bv/8DIGRj58Iv2fvmw?=
 =?us-ascii?Q?QUXPCBlWXIz+8QTa3OXPZe4WuLtgZKanCSSYwaWskg5CVAPZk63dhAmj47cu?=
 =?us-ascii?Q?Obc5truyxp+oVn/d5LO4oZ+DNJcOV30ywx868lylkMu9HJ7XgcqlCdi0KJN/?=
 =?us-ascii?Q?OBkgU+8I/5vu/DdhKa4KR0c8NNWWqy3HJ9p/x31XuOmQ3muXUqAafQG7tEyS?=
 =?us-ascii?Q?CAF9lZlfW3fwpeV88dxtVWHEkJCBfg6PheUSMUXSnChwJiYDVTerXimPUD5z?=
 =?us-ascii?Q?3S36+VSaxbWtMwJDTFF7/Ro0jsSl2Xgf0kyG33QWFE3RhhSHQr2BPch+HzVr?=
 =?us-ascii?Q?Er6heMGcCBDJLr8XD8vxqmt1J2Cc7nvy3EJCM+3CTlxDC5BbP+TJsZL6Y9PH?=
 =?us-ascii?Q?msRDof2YFWYneLNpyf2VjQMLNhgFpHYveWq2aT0EayLyHJwRsBIf+XbVOyFf?=
 =?us-ascii?Q?HwS1rurEQBqWuVm8jx0y9eqt1ezTQvvQF7bhD7LCHRwDA9+gP0QtbSUZisfp?=
 =?us-ascii?Q?wONMeQbHVZcDM0aG52iQ8dHlucH97pCcJXaUV8SkxdJZw8akIzzk5iYb8Fax?=
 =?us-ascii?Q?hGwweDOLl17juxUa9U4DxMVGgpzhXG5S1h1l2XXZERceqRqTkYmVxeStdkKd?=
 =?us-ascii?Q?O5z4ZV4lLs9yi6gO02IpFyHbTwxOmWfmngoo+DzepIAZfXyHBdKo4qEZ6I+b?=
 =?us-ascii?Q?M1Usaplsg7/EtWyRkDbVAeyLM3BI1RzPTHZXAIa1WcPKlmEU7crJDcKvf9lF?=
 =?us-ascii?Q?q9K6M2+g3yUhJTbZoSbbnzvmQO6CBHNQPMWkm1G4qVdMR93SLyPZlYcGJaDZ?=
 =?us-ascii?Q?xT072lZ67nH7gqKtv77ZaRCSrlN8F23aLiin6WZH9pgbwnahta6vjNocbbl+?=
 =?us-ascii?Q?3gIQ+HtBFjmQUGIL68TGiPnVbcCTXaSbHS+pRYfbdQr/VFdCy0wFjMlv0uVR?=
 =?us-ascii?Q?3ogP8PdqH85PaNoUN/e8bnZ81FZqlypCjjWmSEozeDQKyGpzRybomYeaHmmC?=
 =?us-ascii?B?UT09?=
X-Microsoft-Antispam-Message-Info: UoTy+73fw4eCeqnM5q6Snji7Rju03GAMna24eOPbrcEzCNfoehaKqrBpbsWlV6lfiBqgWEu6sWh3N7ovwq4lbu3ftzVlWXx0oQc0rIkByj8v4uqJQ30bOx7aF/Imk3zQnZDLUJo8fCzXjKquef5ygPqbMXUdJu1Cy/UhdYmuUxlBYKpROQFFSBSU91rvn8qnXbAL24NXAm4x7AfDeJYh5YoWd4mP9I/rVyjwMnGGNTOQounmQF1gzRKhhTbkGpSEbvHKyuwXwMcNwFkUjQxI75mhSUx5rouhZfjUOSFz2Q4JaZH39IMBLnf79c8mUF0Df0/PsV9lltZjk+XtssXv+N6On54iuGT/T+xDlEHnIMM=
X-Microsoft-Exchange-Diagnostics: 1;MW2PR12MB2361;6:XET1uZCXtBgpBn7VHfydKNQ7dfRLPEqkue2LiIlt08Fu8uU4R6bWDDBHzwyr661oFJBbrX8MQdIdmmAfXfvmd+jIKod775lsCTbk1uwMOJuHi+y89NeLsBXOyhGPDjZondK5W1M8zeDbqtHTklJtykhXPlrKM+OmihRRamudBndyPuCUpMCiEdi73Gn+RaaNEomTOKSewZARKRq7daeiVd4j0fpSz0s9J/Mel1Vyi9VMJNh24YExHG1rNkMIOWPjw+V/RxwCRuGu9KknOShk7KdT3VSWQP80DLkh8Oc3qEGTtcPnKmMocIoCjnJzU483sv3d9cLQBK1Dih5s9hICCOJ+ZezS0ijXQRIYUu041iMdB+0cwZXRo3A0qPOPJw46fgr41qEWkdmqux1H7GbmaOuhaCnAyvvbBT6lY/kvsdz2RcTlOBRmG0p8tb4nL7xDWB1TPKFn4nWYULy9AuAqFw==;5:KcyN00Ma9BlprAn6luFDq9ZUMfh+TWJl7lCoafGrY95JNNhE1tHORevvtHaVsFkaSoeHiXgPmzR22+qVPYcgxYVfGKjFM4yxYakXfNZLXd/NGv/7db4rf30M3xfHV+dalJwzmAO/IBW68sBPHX8F/ZnjCPBrbPx5AT2MUO4wcRs=;7:JmXUFU6DQOv82mvOzQSuXDo5bwrw1O/iaA93+HALi27FmCOMNcdQPPBHcFqfyFWzTXYdmB4CU6V5guIIvj+Ss/dPqBnAtqRqnj3dSoktuBuFNOBGMxjVpsXBcWtiFjDJRyzHxVCJAFYEwlqloZS60D7YPGsyTKPCqv7QwDM4Kff/n8cV9cUnKSx1Ddx99x1CXA/jBRIOPIDYH0otPefjotbOREGXb9VqKYnHmb/EQKSWsIqQRXznNCQLRrQfGBrZ
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MW2PR12MB2361;20:d73SCxtNp3UOvD+jT5pANqXUrRNuvYIY+WjYGOBO+ROypFlEUG3giXfEiZDWvmLp56XA3DmTTQl52T8twjbtgG5lbhw6IAREL+K1tK//51gooKkaO7p7YPAYhyuEqldTV2RocdcrEPKeDy0NFwzVMtXh/rUGj5bhxD8QVlf0qfCCaiGlXGGmh1+C2afKUjHJ6qz8fSRwKiS8h8AwnGRytt7fPoOIb+4bYl9chsPbVB1xq9hBjsFuGud7ZNNl7p2J
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2018 10:14:18.7762 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 660b226e-8597-479f-24b9-08d5f3a9b85a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2361
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are cases where a pointer function populates
runtime->delay, such as:
./sound/pci/hda/hda_controller.c
./sound/soc/intel/atom/sst-mfld-platform-pcm.c

Also, in some cases cpu dai used is generic and the pcm
driver needs to set delay.

This delay was getting lost and was overwritten by delays
from codec or cpu dai delay function if exposed.

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
---
 sound/soc/soc-pcm.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 98be04b..b1a2bc2 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -1179,6 +1179,9 @@ static snd_pcm_uframes_t soc_pcm_pointer(struct snd_pcm_substream *substream)
 	snd_pcm_sframes_t codec_delay = 0;
 	int i;
 
+	/* clearing the previous delay */
+	runtime->delay = 0;
+
 	for_each_rtdcom(rtd, rtdcom) {
 		component = rtdcom->component;
 
@@ -1203,7 +1206,7 @@ static snd_pcm_uframes_t soc_pcm_pointer(struct snd_pcm_substream *substream)
 	}
 	delay += codec_delay;
 
-	runtime->delay = delay;
+	runtime->delay += delay;
 
 	return offset;
 }
-- 
1.9.1

