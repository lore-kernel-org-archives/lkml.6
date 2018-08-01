Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 281CDC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 10:08:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 964F920844
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 10:08:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="3MAM9WV2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 964F920844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389351AbeHALxn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 07:53:43 -0400
Received: from mail-sn1nam02on0075.outbound.protection.outlook.com ([104.47.36.75]:49952
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388984AbeHALxn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 07:53:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C3Dyww0pDYQCS8gCHnOY/K5l59jj9j6xMJlbGfGYCpo=;
 b=3MAM9WV2XNLFKxKWh5aKnQUrx5rNxRSG2blTDBErS92tnrqfYTGnygv0IRdyCpTBgeHlywNYjsfVkDYpwjsj0QX6RrbjKPRZ4Sx6dS5iRAqEuhwEAFTiNe9BJf8/SJdasdrzp2dkZsapHjULReJwHIsjk6yTIGQRFJ6RvZms+Ig=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Akshu.Agrawal@amd.com; 
Received: from akshu-HP-EliteBook-745-G2.amd.com (202.56.249.162) by
 MW2PR12MB2364.namprd12.prod.outlook.com (2603:10b6:907:8::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.995.17; Wed, 1 Aug 2018 10:08:37 +0000
From:   Akshu Agrawal <akshu.agrawal@amd.com>
Cc:     djkurtz@chromium.org, akshu.agrawal@amd.com,
        Alexander.Deucher@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org (moderated list:SOUND - SOC LAYER / DYNAMIC
        AUDIO POWER MANAGEM...), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] ASoC: soc-pcm: Use delay set in component pointer function
Date:   Wed,  1 Aug 2018 15:37:33 +0530
Message-Id: <1533118054-14509-1-git-send-email-akshu.agrawal@amd.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [202.56.249.162]
X-ClientProxiedBy: MA1PR01CA0071.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00::11)
 To MW2PR12MB2364.namprd12.prod.outlook.com (2603:10b6:907:8::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c1cd8452-4006-4516-5f2e-08d5f796c101
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:MW2PR12MB2364;
X-Microsoft-Exchange-Diagnostics: 1;MW2PR12MB2364;3:1DnOUQhaq89HaXdaT4+n2Q1HgwCubGpyL7iW8CLgBmt7tucN5ZclUKVzzlBy3z2cP1W3QfaTWNz2PJe+uh2ne5Lu8nZOeCP1q5DPbiGqilfLqwd4vCDAU4jobBX5ijqUERnu9fHf4L3tpHym+MsG1lUvyo6w3cCVGzf15LIHBQK6YPmEXlP6d+tWXnL2Tt4tI+0OTuTstqOKO0LFT9k4mE/s1AYdHYl5TLiEh1/pCX1ptj9PqmOkegRXDsz9J4zr;25:Qej+p3t+uH7/lNXwHiZFSaQW6eInwvEpSSVyS0q3LLxwqbqA5yh3b1KbSBAAj0D25FGXJmBM28lh7qfe6xqcIrI0X1paygPt+hyQBSuDU+aqnyiCiE39DaORK/VLUbI2/bSX/Ujy/tpe1RQllrmarzOZxWZms6hOsKuXXRsFOrAXJdozfgWSg0XTns2q+71q1oHh++X4POAR4tT15dJMt46kjYSxe8ucnRSHW+gAPvb4r3QrARCieASm5IUO8+b1/zJM+G/wAAsXQho/b1ZGDsbCeZ4dS+k4txDy0MsnRIoCXsmXmynXT9Axi8aZv8XYGvA9O0YEql3CRdLmmDjJHw==;31:32UayC02Wl0J3xYcCDPbVoKJXd/yDt87HCMdHtvMxVAjILDxWbvB/3RE7L7XQRGK2vAZj78o2WQkLHxr8qEX9y71D56BOk4rtQaPakXnpgeti475lXwPiXCCbemcZVHouNjYVFqmVC9Whz52AjoueBCBgc5/UXjSDYXPo5/dredVoapA56O5Ej98x+oSoGezXgFUWGehtsSdriLg8ZPjQPq3SDNe3s8ChO4FN1jxWjk=
X-MS-TrafficTypeDiagnostic: MW2PR12MB2364:
X-Microsoft-Exchange-Diagnostics: 1;MW2PR12MB2364;20:8QRWq8KVmTjYpKDNASCpmZkqy+8/SomdAhSrydxxdvWiYS+oqOIaWrrRS5sXO6ZSQXoRRh7n+BOPpH4tLY4k1h2WAUJdsWXwzSuIdIvkZOE+lyt5J+C18+bao2veDOqR1cY59X366kLCFdH7DWSVlQBhS4EXZa0vR3CxlySNDJE76nc3CWiN4Mbhm5rKrSYi2rG8vdNtMiv8Yc4SEJ25njyfWnbTTJ97BIIKLYxvVffp9+2RBpc2RuuyQKK9/LvI5FKGxI5W/JeCteWUokPlyMWml3KpJDFoz8+uM73A5ibNYka6/k6rTZwUUemao0x39HAOAJuP6cyeM6+xxXgM+R+5g+3CN5qKY9u+HJqMjwBeDlFD4OGrvEz/+LW49vqB2uUKXX0358/tThUbzxz/FAFNqm0tQN/qM43Tyf16z529JL/cKKDNp3wgTCufhXL+thPn8adJl268o2akjYKB+Fb5epJcIbtVKFBs6C4WJSL5HcS+aGPaqPu5Y+KWR99t;4:Ls812Dti9qjHBUeaA8Lrt0QGUxoZ8r6fHgN+CpBjHlk7DgWttnMNH53lkw5B17jja9jD/eK0tT76IVyIwh1ZYxABQxrrg/bgsBcznJbQCgSNF5+BBTz1I5+NaBbATraO3T+L8IQ4Sdw0gNKtlaCjdb7eBSOZgV5sp+Y2g/XAgF0JzKvMRpScbOMVfPYzLthY6sF79gFQzgsdV+BdJQD5DdrNaSjQADRTyMEKmMVT2lu3oXvvAm462Fh3kPEs0UK48HzOjoCh2Y86dSTIyYVs3IDDUR3HFwDA5QLZcm3n2w8TmdQWkAqhpXXuFQ0qT2C2
X-Microsoft-Antispam-PRVS: <MW2PR12MB23647BE057D87AB7840CA054F82D0@MW2PR12MB2364.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:MW2PR12MB2364;BCL:0;PCL:0;RULEID:;SRVR:MW2PR12MB2364;
X-Forefront-PRVS: 0751474A44
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(366004)(346002)(396003)(376002)(199004)(189003)(97736004)(105586002)(106356001)(305945005)(47776003)(25786009)(386003)(109986005)(39060400002)(86362001)(4326008)(66066001)(6486002)(53936002)(7696005)(2906002)(36756003)(3846002)(6116002)(53416004)(72206003)(478600001)(50466002)(48376002)(54906003)(68736007)(1671002)(14444005)(26005)(956004)(16526019)(476003)(486006)(44832011)(6666003)(8676002)(51416003)(52116002)(7736002)(2616005)(186003)(8936002)(16586007)(81156014)(316002)(81166006)(5660300001)(50226002)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:MW2PR12MB2364;H:akshu-HP-EliteBook-745-G2.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MW2PR12MB2364;23:n+JmsVqKNRTWM9s2Es1WZdZuQ0nnPrLA8d5YB58J9?=
 =?us-ascii?Q?vMuqzQkBCdtbDEUAYIvCB9jECS1gqWF53TWmx2I9f1Z8COwjMuqwmnIheYxW?=
 =?us-ascii?Q?hRztD+S5lAdLSboykEWr1w7zgGR3LJ+5zdR/d5mk82xsFg+109OKWzncmnrI?=
 =?us-ascii?Q?dywHxut7c4bVeKi8MHhBtbEYr663vlTaXAQd0GdgaeqoCVg6ZFWhpmAR0qer?=
 =?us-ascii?Q?vdryGSCValWqCKf8Eo+vkzAe8jG1O7wSwXXONfv/yHJT8NdlehwldmLt1xYz?=
 =?us-ascii?Q?0WMWAT9lfnx7/frTbNWzjSd7hgRFI8hYpvABudX+jZWtYh9YC5k8nQkdbPgn?=
 =?us-ascii?Q?GwUVzcAAAO6BtBJTL1R+QTLJxS8XMmnpROlqkXyy1TT8lBm96VzuYDlsX6tv?=
 =?us-ascii?Q?y24VEvgBrg+qjmaWxXrd4MT8kB2T77yTBs+bdvUnmYTyQ9jxR+qmxG4mOf8v?=
 =?us-ascii?Q?fODMGoirfOgmo56JLbCoi+dIfMfZJXOxv0rtt+1nnNn88LRZaLZbymsMGJZo?=
 =?us-ascii?Q?+3u0iGtVshBD7A7UHdQZxsoU5mTtBgVXoMJllDSW/H3egS0iHuBP0lEQYoO2?=
 =?us-ascii?Q?IZy03+qE+WxJoAzObluj0F+kWgPzpSkntWxljerD5hp8OVDdkuDi1P1CKyI7?=
 =?us-ascii?Q?2XqpMe/99VbjgQ8u1XWLDK4FoxcKYDUpMbDjUvUSboNivA5+ebdI+oIhfr4i?=
 =?us-ascii?Q?MYvzV19q0/hjG+ZXK6FxzBY+EwW0rMO4EZce/EoFrKPDJxsPXsbGQBaXm5NN?=
 =?us-ascii?Q?WZrGLr7FBv9h9iU42w51FQxw8WW5XTIzK/rng1w/ick/eeWPkIdz4glcZgGV?=
 =?us-ascii?Q?fbOrkqX0ag95+wZh4iWpyg5ol7GylOZb/dRFFO7xbDPa4+134LC7BT5Y4NYN?=
 =?us-ascii?Q?YFhcn2iC9oKHQvzTfJxD48Woqgg9ZsacRePg/DIOyptZC3neFUbsiI0hyXJu?=
 =?us-ascii?Q?GWzv+Zy1I2fnNcQ1vr9pVNY3qEr3y/fqrK+TH+x99yyw0KQRrvm0tbpOBNa7?=
 =?us-ascii?Q?e/p8GzFwx5x7bRRTbBnM6Qh/s5UIxexs1ZjkIfG9FvGUa5v96SPFyRPpv32y?=
 =?us-ascii?Q?DOaIqi4QCmMPJa5J+8CvteCuY0/IjR/q96NE0Cly422TPjXihE5r7cn4aldB?=
 =?us-ascii?Q?pNSZ16OHV9taxV/v36N6T9TMSatoBBObQijeZkEFRTdhSvXFf1/xDKIZdAg8?=
 =?us-ascii?Q?DTj0akvHNqAJVaSmrvT0UWLTf8IAnL4dCGHi4CYDE7+kNlloTN5NqrS/JAp+?=
 =?us-ascii?Q?cM4mQvZUi/mPgGog0/PmLH9YbQL/z1nqXPmw2ut?=
X-Microsoft-Antispam-Message-Info: l8/6/1irxHsyEsc1sID9x2fP3LnrEjgPDxlYEclUYb6BjE0GOHr4GcQMwgRCedNGI8JIZ9dKBuQh9Qwe/2Tue4p5rKsLL2j0NvVVxc6hg3rD6dYIjH50m4ONxBRD16ecxtW/GEx58Us2GPSJa9Q8DHXCLbR+ZLIIgcPfijllXD8dfNkEc7xECFkdPaGQZRwclbvv/XxsJLE/GDT/BigAxt8IRr3Lr0V9a+YQ7SRSqbqmKbY3U+JnCi3wwP1QHSbJjXEqMhH2PwnB/61WSYktOLON/x1NVU/i+RRBrDVeL7M/qr/tRvMKyhJbeG1mn62xOlMSCoqY8KHWG0VHlOk/aVSNrFUFCPhnk8PgFjZuR0I=
X-Microsoft-Exchange-Diagnostics: 1;MW2PR12MB2364;6:5UqUxMJh9IT5SVylJuiXIIfXAspcxuLBRRloB8mdn8/Zxk72w2h/kg2+8A2jPuHL1FBIOcIVcelOMUx4V3aJTOoHCvYKdPzGrjKgV5OlHWjYHymocN03mKT4YF3sbAPz2Iv0jQkPzHnDQWOWsOiVltB+MCWwuA30iwyang8OSZodlyAvIxbRzixDmRvJHJinhbvG8TeKQ7YPBVQjloJwHbSJ4ANSvOREvfFnC1jBu90jutoO0PmbgfQJLHcDxJfeZs4avLsnEnHZptwoucErB5MjO5Sw9Aywada+zLlWxbCI/g4iGFrUpoYt6szOxiQtfh17wCV7CgPr3CaWgLnlkIjJbTDMO6BAk87ONWDGw+wu12+hySWq1+jyUMdZy6KHU3pjQEUF89mEv5ysmpX5NfMRM+Voddtfz/GnBSVDKEwGm3fUrhwkxhz57Cs8QXYAePTml4bRW0YCFb8QWvCtrQ==;5:emasZwNjpGXIj0BLOYbcVguREjUlZCr7unL1EuXFXApfXpKsD4E8B3lbN7Pp193KhCHwCRVZwYT6x2raQSDN9ZPHtHcv1mrEjnGvy/IakPVJr9v5WFEHnLvSZ192jg+RGTEyequB1yYc1+H0LQqGJCjak9NlRTZH47JAKzKuy+s=;7:JDtypAWrjObxAYzPuhhTlqBB4ACdYw+xYsrWnpQQN+QhvKoXnD2qQ6sE4xYjOfPPms8QJB9TgLyFTIkxVekg1fHBUr8xNuIMCg/q9wAzVCXfEt3GSMKDVeRQCDOnVVA2eUdAkBVtQkKW6OTG33/LjcaRSFXg3eG98ngxJsMnpRgy1kRuF1dnGjtsgVv1dPLI1CS9LcSUrDSKYRUf0+5fAQWij0xr45l/fy0Tm7/ayVzoWbmf0Bwtgv/5seNvce/Q
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MW2PR12MB2364;20:7hKRJyLlzFDe6ZAyS89pIGa35o2TXVK5XnnJoTADlEWZfECoqzmVKd10LY1Ws2wbF/FUwr6PmjEp5n/uSD6QfW0O1AHreGhPminOB8sCXcIzTFMPduHdc8xuH9VN7eIkAb+zvQkEwMIDV1FYDrN6leB4NxW5hEEgXqrk3ri8Fe+Umw7TjYdcSZq6viAGmIJ/n/NI1+rrPo+26l3XwmJQ6PhXbICQJOw4HAn1QQRQ5LNbIT+9JpwM9YY+ZjUqjTun
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2018 10:08:37.4694 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1cd8452-4006-4516-5f2e-08d5f796c101
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2364
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Take into account the base delay set in pointer callback.

There are cases where a pointer function populates
runtime->delay, such as:
./sound/pci/hda/hda_controller.c
./sound/soc/intel/atom/sst-mfld-platform-pcm.c

This delay was getting lost and was overwritten by delays
from codec or cpu dai delay function if exposed.

Now,
Total delay = base delay + cpu_dai delay + codec_dai delay

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
---
 sound/soc/soc-pcm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 98be04b..e8b98bfd 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -1179,6 +1179,9 @@ static snd_pcm_uframes_t soc_pcm_pointer(struct snd_pcm_substream *substream)
 	snd_pcm_sframes_t codec_delay = 0;
 	int i;
 
+	/* clearing the previous total delay */
+	runtime->delay = 0;
+
 	for_each_rtdcom(rtd, rtdcom) {
 		component = rtdcom->component;
 
@@ -1190,6 +1193,8 @@ static snd_pcm_uframes_t soc_pcm_pointer(struct snd_pcm_substream *substream)
 		offset = component->driver->ops->pointer(substream);
 		break;
 	}
+	/* base delay if assigned in pointer callback */
+	delay = runtime->delay;
 
 	if (cpu_dai->driver->ops->delay)
 		delay += cpu_dai->driver->ops->delay(substream, cpu_dai);
-- 
1.9.1

