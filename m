Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10705ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 15:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E553B2088F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 15:46:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="AP3g/q3T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E553B2088F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729310AbeIQVN5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 17:13:57 -0400
Received: from mail-eopbgr720060.outbound.protection.outlook.com ([40.107.72.60]:64704
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728361AbeIQVN5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 17:13:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e0UhGaZEJfn+cSUw7PIpVR+jF8hcOMh7IDOkuhSl5LA=;
 b=AP3g/q3TAlpAxoOhzqMcn0xhu69fR6zBY8NOEpHKz0F9dan1DCrWO0jl0Q7qNxjUXGRSIcMBXLKxz2rTFo9WXmYfsOHVIoWHrLE/NPAepdaB+IBp8eyPgmeLgSz4R6H5GZ/yVkHom/ILmEgMXwDBBLJYTPXEgTUwiuGkZr6vitQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Akshu.Agrawal@amd.com; 
Received: from amd-chromium.amd.com (165.204.156.251) by
 MW2PR12MB2364.namprd12.prod.outlook.com (2603:10b6:907:8::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.17; Mon, 17 Sep 2018 15:45:49 +0000
From:   Akshu Agrawal <akshu.agrawal@amd.com>
Cc:     akshu.agrawal@amd.com, djkurtz@chromium.org,
        Alexander.Deucher@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        alsa-devel@alsa-project.org (moderated list:SOUND - SOC LAYER / DYNAMIC
        AUDIO POWER MANAGEM...), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ASoC: AMD: Fix capture unstable in beginning for some runs
Date:   Mon, 17 Sep 2018 21:10:34 +0530
Message-Id: <1537198839-15985-1-git-send-email-akshu.agrawal@amd.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [165.204.156.251]
X-ClientProxiedBy: BM1PR01CA0088.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:1::28) To MW2PR12MB2364.namprd12.prod.outlook.com
 (2603:10b6:907:8::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5e2f0101-fe00-4cc1-b8fe-08d61cb4a9d1
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:MW2PR12MB2364;
X-Microsoft-Exchange-Diagnostics: 1;MW2PR12MB2364;3:SlvVpr5+YTvi+1uIZL3bl+TivdhJWu9SVu958433SoDsEhHnuqaIt0qpwUDmDiq1puFIaRAsgQTK3WINYIH4n/S8A+Lq/ZGYqiOUY9jPGtcqmA1vvBqxQauxgXzSH8oUPrHFy7BXBUT4ISAJL+oBVtWdXo7CU63uBIE4nC4MivHrk/i+YKcm5Mi97+fF5GGMxaRdKJq+0SZlOv1gKUszvxOwvbwEcNnk+f5Q3UV5eo2CHS+axQMmSuYTxTLvVX9e;25:Y5q0FEDbKHe9BTmQ60LagD3yidSsxHT57XtHm+YVjQESbNmebb/Dk8V37r9Ia2yG2lxGlu6Hkf+d/oWaLhO0D3UjnJZlaOAgd3LWvkjjs8cymk1/qjsZm1zvSe7A/mv3j1OfwDXHZn/INO9q3rVymYZvUnpsqEpZu++jbUr8HcOx3s9HCbexmx29pWdPzp8cib1Gi462FMOzUP28baDZEzM3uPIRi2KzOxchsGxoQty7QZxD1qG0AqE20EL8vygkLcDmJOEAu0o4gCsomYwz8nbQKHNtnQQpXZvCkiEkr5QzYEAmWNTiJt5b7DpcLVWodyoLDbELv5rnIhQWv3VpqA==;31:aXDA44f1WLaUyOLjgdSDDm1RRy2q9frrpfobqIPrcGt5b2I2JFH1uNN4NdO51ckbWyBYVxNIbquvIyBWBtZ0rrSCafEptsQy0QdxrPk3WhoDy4YjSr7n7Lp1TUKTID2YitxdFhtqPpdBRyFnfxmhL0xN00+iYM8THkV66rHPlCB12R7aTC1iOlkdQexaGKWM26cEXDdKbsZMwrHqfbrhMpiJsHI4EiUxQU/evV28jpI=
X-MS-TrafficTypeDiagnostic: MW2PR12MB2364:
X-Microsoft-Exchange-Diagnostics: 1;MW2PR12MB2364;20:h5QVL5vGgH3ZVKt0Ni5jtJbAEPCzAEXPq3Q/eGolvJof2riuCW+pug9fiIlMfY4JuG/nE7BD6vBF0yfKtkRkR3Dt/kUAZMLUrJDFjarU3BiZi3nnoPpZZEnCtKSF6CuU2blURIBT6WmtRndDCvnWTYxi0d7TJo2chwttk8s7hC233t0huYGNwSh0ti/Xstx2MJLq2cqfkEFsubPHJ2w4p/iKEoVH28UOO5dykFHJ8tZeO1eaEcs55mtMHpVmW9G6QJZckrhsOTme8GDdfaSETBPnGz0mGpgZiYnXAzWQJlTn82Wf2Eq06qhuTTm+yrzgzEqQ+X/PKgION+4AGpO8JE3qZZ/siJX7I6rpLU3VXSyD80CQ7SOUSpQ1fP9fXPhzv4i8Xu9rFyD8a6UuDzPQLNq+pztlD3gSp1kbvKUR+/jZ/IiYCHKWO5u+GeZmW6Smmc3oJc1uOgBFIbHXUMO/YFWQ/5OQ++y6ojI+pYGyHlr/ps/YVo7T0QlHrIYKo+RA;4:m9ff0d9QDcBIHrADi5MbR1jBooiwQnMdL/bEq08uErkrC0cyVXCsHEQ3oH2Rk0QiEw8+i7ue3SSOroHniNl8bBjFd5WpjbZpbjJUp6pjvB0zYKlYbkPmC3Ee5lljqGIb6qKHu4H7hn1eSRAPTTloRSjMdP4TZha+u8q33CZgIdOwnOYeZcDV5OD4xd1LM3QQfwMiXpmLqLL8DIkAPlo6CdsHwMx7/SHtmONYWBMaBZSmPbKkLARqn//HyXwEwhtoVpl57YRb9y6RJYaUMaShlUsaIo0srZl3mcxZ18hiKjP7HAlefZeuwDoN0JUd6Klj
X-Microsoft-Antispam-PRVS: <MW2PR12MB23643B16827FB5382F4EED28F81E0@MW2PR12MB2364.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231355)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(201708071742011)(7699050);SRVR:MW2PR12MB2364;BCL:0;PCL:0;RULEID:;SRVR:MW2PR12MB2364;
X-Forefront-PRVS: 0798146F16
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(136003)(346002)(396003)(366004)(376002)(39860400002)(189003)(199004)(6486002)(486006)(5660300001)(86362001)(386003)(956004)(2616005)(476003)(50226002)(81156014)(26005)(81166006)(478600001)(8936002)(7736002)(305945005)(72206003)(50466002)(48376002)(53936002)(68736007)(2906002)(8676002)(16526019)(6666003)(1671002)(44832011)(39060400002)(1857600001)(53416004)(105586002)(51416003)(316002)(106356001)(4326008)(97736004)(16586007)(25786009)(6116002)(3846002)(66066001)(36756003)(14444005)(47776003)(52116002)(7696005)(109986005)(54906003)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:MW2PR12MB2364;H:amd-chromium.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MW2PR12MB2364;23:XO2pREiE2fxInNHGPXXp9zRS2jf4QjHD8aKQGnrQm?=
 =?us-ascii?Q?pslqkaLVlH3TkGklIrBLdZKRksLTYoZV7PDpZXLSrKfMii7rYnsjkuSmr4bl?=
 =?us-ascii?Q?2RECowj7r0Ymqa/AUGzI0+lkKmTrp6sOalZ6l4NjXtCVegJ6EjuTDfE86aHj?=
 =?us-ascii?Q?r/+RS6X1e+K1pEHusxVPu/QGpVfIeS0m/OSVUDI2YUgOItZ0/Kl7MRTRaX+6?=
 =?us-ascii?Q?YQfsjaIZllqw40cE0mz2PCQyFahEEYkjLTurrjTrfWOyXlmtCN10sciY6VmM?=
 =?us-ascii?Q?qm6XugV75ldBVK1plDI/d4u0dIrCivglnrW74CPnv8BMrFc8jgF9xZkHHnaN?=
 =?us-ascii?Q?SartnO/VGRc4Qpeuce1QSI0cy9r/UB3Vl6EVATTFlN1uDYpiIAVrDfZ91p/Z?=
 =?us-ascii?Q?wFhz1sfV4WCQE5EpvXWhR3cyMktpWARYQKiakC/qnlAGQvWar4GpXzQG9iE8?=
 =?us-ascii?Q?FvsmlF5uF/8i5x/QKBdpb7QEBzFPQU3pII5E+e6s7BRfqwa+PEY0iBdGTo/1?=
 =?us-ascii?Q?IZ+k/2P08BWmgRDxxnrvfRUx1O+nICGui34adzGM7g7joZFeaoO3wGSZNQL6?=
 =?us-ascii?Q?byZBp9jFZzxaNwe1RX/tdYG3B/dhvJ64pVytJaRt6oAYkcqEuVKX4nc8CPL9?=
 =?us-ascii?Q?HFGHZ3gZryMgppTNOOyJnGpsIP5MgXtLvkK0vmjSxlGECEK2CEOtdA5QGkek?=
 =?us-ascii?Q?0E+RfZrFnEmfMCEt/3s88YwynMRz/iJyRHhssF/Nq0hTB95lj9Cpl6HQYgY1?=
 =?us-ascii?Q?kl9jVUl9NzAFpPJctmk7mwNZ9dgxQiToo1UJU9xOBRUYUNGZ7i0H0F3NZQ+H?=
 =?us-ascii?Q?9Yd1va3GG4VB6kioziHBNDQkVhk0PWAiU7ym135t43YtQ0RC3l4ovSVbxapB?=
 =?us-ascii?Q?iaHovYkJzRkUsEx4WSZpyg0knTJ2sYwJWsUk10mFuVroxBHXzh1IVrwD/Lih?=
 =?us-ascii?Q?YPSIkPn53+v8giQgYZ6OGlcPDdUnmUAQ+iFuo9H2xuwADyugbBe37IxCOLgJ?=
 =?us-ascii?Q?FOmK7IM3oaExlS6xJRWnj25FFNE89W2QM9wEPv177bVrDXv95NedTgeDUkrK?=
 =?us-ascii?Q?WCDMS3phhuVgyIbyq+SmtvRwNtu5qy0vDhQsTqwrTJ8zqrDuSrzVYHAvZvGt?=
 =?us-ascii?Q?vD6Sis6XqUvTFJ9QKr/zA6G5ax3twm/rYc3a3cKZVDkuAKJagSXXNixy7Xuw?=
 =?us-ascii?Q?R3zcFGMvHKffHxU4c7obG/WU4A2zqqnQMDGlBaS2W6PG/816wXB5zG3Oscak?=
 =?us-ascii?Q?uERtqW27EkDCbLS7R56k9T9x02KpVhTsTVXfx40?=
X-Microsoft-Antispam-Message-Info: JGLa00p1rHuUU7TeTvhEU2uaDQ9URZLu4AabLlN0eilv4wEMZm8WrIISb3SOYMuvBY+/uIqjkRrtXrXvU8GkG6eJ8GgAdakThlNc2Qf4Umm5DES9gso+MlCplFC+ONc8Q5XSrSLXlkLa/HaowZPZMDGa3vnbmQIDZ1r6q8gskP8hK8ePaxfYwpIu/2kklVoGBLY/mF+KVvpmuBXnTqZXlWZ+YeVBGTI3y/SFhkdVBtxTiCpAkHacJUNwnZtL41+n4h7Zoq+JZUR40DEKLktk5xNc8Tf9vzg91qQ+1h2K06eRuj9fQ6jHmy9FJz1Q+SzClVIsEnFX4l+YgXgGW3vGUQ9gyhhKB+PvboOgOuVuHFY=
X-Microsoft-Exchange-Diagnostics: 1;MW2PR12MB2364;6:8zEE4LrgOXrGYV0Q1WKARMFMVReYgch3FLUlXpqR5UFDIWob0M3ApUdaNnQnGVUtx9emKDzfpY8bbx7c6TbppyidN8bQJp/UcqPFXDTh9UH6gzCmPwnd8/CYh58A64rdTlQAfNOqL00/kNIfD7Gh0dDzn2Z4DtFekVQq346NOcYzP0LdlclgW7V6hEInepSEiDzG907osA0/mf+KVtvYrzfKqd+s7ee9nDs2jmcFd3+QcNc9+JomfhdaXDLYtH9OhjLQdh4zBX1SwThHsF4zr4DitMTeydbT805cwSWm6OY9GSMg3KVb0SOwMnyZ72uz0u3xXIdHTcs8lkwEzpKieUpw/d5rq21UKI7Cq2VcUeBjLCbcoi1/BMezu9FPKq4+yXn7jvDx8xFO0jUeEwEE44qEC864Zbjfpb81pz9QGGVGyzi62wCA96oXlnOiyok1QESLbkvew6Tko8LGOLpPLg==;5:0sKCiAWUvPRyRtXUBJfa4cuTwblqRfHXnSvIpI+7OTtpKwq6yCviccxP3fbnnVrdnWDM1dy/0hxk691zUfpo0AJc6azLiN2OwaeRahAQ2KT9g2bu+7s/OIHQ7NpRQlZVUaVO5ASL+tSGZdVCA9QIviCnl28nywu3VigjJ4UiHNc=;7:nRQ9INgdF295O0J6FX63Si7Bu4awRKFMq8eiE76IFA4SoJ27qvwGLedJMmoZIhE6wzS1SX89kCWIT6N8Rs8qO8RqiuKx10eObYlw/JaG+EDaR8C6von77kfPvJnv3TTbf3EH11jphXL0+Zkdn9CUG5lFVtIvVVqmO4KhNa0gAu/8LfZE7lfPcrbq7jDX3RD35i7/0i5SvT+Sk9HJgAy7JPKYr0TsO4rm8KC7ijInC4xUiJQSfSyCsAU/qctV7Icf
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MW2PR12MB2364;20:/Htqz2e0OJ4BFrWm4EkL8lk44hLvW55nBndKXTJktaZOwl78EPZZZqfFe2WG1Fi/pS/z6/bXisFfSVujeDb/hEuXDWiwqfadaZUz4kWH8tTl2jOlsMlWmEWKnbHEOeFd7Jn2r5rIbsR8oBl2y6uYu5NTFnanmMtL3SW66DFHVukKB/BnnnWHKe+x74/xLSnYmjVzv4pUsj2BghsC6GC4RciZbJ7gzVAAyOrsl9qHYxPGcYfg/bLMSEpDQTiY/Ibv
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2018 15:45:49.6534 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e2f0101-fe00-4cc1-b8fe-08d61cb4a9d1
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2364
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
 sound/soc/amd/acp-pcm-dma.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index c7e972b..f27e20c 100644
--- a/sound/soc/amd/acp-pcm-dma.c
+++ b/sound/soc/amd/acp-pcm-dma.c
@@ -1050,6 +1050,8 @@ static snd_pcm_uframes_t acp_dma_pointer(struct snd_pcm_substream *substream)
 			bytescount -= rtd->bytescount;
 		delay = do_div(bytescount, period_bytes);
 		runtime->delay = bytes_to_frames(runtime, delay);
+		if (bytescount < period_bytes)
+			pos = 0;
 	} else {
 		buffersize = frames_to_bytes(runtime, runtime->buffer_size);
 		bytescount = acp_get_byte_count(rtd);
-- 
1.9.1

