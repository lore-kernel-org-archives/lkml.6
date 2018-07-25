Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD020C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 09:01:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CA972064D
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 09:01:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="eAAd4HLO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CA972064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728672AbeGYKMk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 06:12:40 -0400
Received: from mail-eopbgr700059.outbound.protection.outlook.com ([40.107.70.59]:3392
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728222AbeGYKMk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 06:12:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CYubvhcD0H5/SeQYg8iWu6YTEqc+a1LI+zNSVlbfgOU=;
 b=eAAd4HLOUSTNzzvHgVdkiXjnveM847r0+Q6J2T6JHOCuo294e6Ymg0LkDdm0VkmJQRWivQgjAarcwT6t+uW1KDnRz6aCHn11TeQ49vi+lCEC2g4jbyMitDMsfYgTulVVD4Ht19NGVpxWmP2Nr1L5QotnD2aSoELM3j9Lo182N9I=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Akshu.Agrawal@amd.com; 
Received: from akshu-HP-EliteBook-745-G2.amd.com (202.56.249.162) by
 SN1PR12MB2368.namprd12.prod.outlook.com (2603:10b6:802:25::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.16; Wed, 25 Jul 2018 09:01:37 +0000
From:   Akshu Agrawal <akshu.agrawal@amd.com>
Cc:     djkurtz@chromium.org, akshu.agrawal@amd.com,
        Alexander.Deucher@amd.com,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        alsa-devel@alsa-project.org (moderated list:SOUND - SOC LAYER / DYNAMIC
        AUDIO POWER MANAGEM...), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] ASoC: AMD: Add a fix voltage regulator for DA7219 and ADAU7002
Date:   Wed, 25 Jul 2018 17:00:59 +0800
Message-Id: <1532509274-8280-1-git-send-email-akshu.agrawal@amd.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [202.56.249.162]
X-ClientProxiedBy: MA1PR01CA0087.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00::27)
 To SN1PR12MB2368.namprd12.prod.outlook.com (2603:10b6:802:25::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3ad6909d-c2a4-4774-df8c-08d5f20d421c
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600073)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:SN1PR12MB2368;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB2368;3:40iOVdacaASA7A7XUfg16JIyGw3sMmJt/7qP5d25VxDTLVn9SsD9OZwejy/Z2HaNHaTKNgEUEk6yVlEwNiLfE65KmR0KasZ78wU/0BlAH25dhvHmiWsDH8x/8gs2SKVPFGgaI4C/EEG6SCmiL+PeS/oIhZ/27VXmhe/gng9RCVw15f+z8NgUBUvPbrRVtQli0BobAVjpxJBAYlphn2JH7mgzVXsQhEF98xIWx7weP+Xj4Hkj0/ZuPKrNSnvCyHU3;25:X11znaapdsIMeGeFVPOp2L4qaR/MJfabko8L24Js6o1FGnM/gzbBFXTCFFP6Bum58Pudt+zZWf97KDwsCneUb5EvkR1T8MVFEj86fdmXb3GhNQcn98rJQOT8hpb86HqtFfFEpueYDNIvY2zVwujfbfCEbMsv5hrG/Nw8aLabb+/3WPSKmCEk2BrRzwwGBJp5lyP6MpHIZ31ustT92k+2exGl1j6SVyfKGiJZ6Ff8LbmnUfFeT3LGd6Z1neQwSwVotr4JQ5ue/ybsXyVgEWlZnrPVLfXr92yWgvtksWqgElfKPq6G2ZgBMUHX/IPJknRfZZdeqPF57RR6ncwXYBT/kA==;31:EZx2ftP0ihqGt0f1rEDsfCDeWbqzlMmS6EZrjiy//xGl0ZatiTeeBwN/Aoz25Jc6uy9KtMXdFDTvo7aqs34n/IgOm3h4mHxHBti6CnC9IHSYYMu9d23yDUtVSxhNLFulp8VwuCij5oYREtqwA2MmhTHf32zV1F7FPJv4uL1QzuHQ3a3etyrhqCnvsbrLrnRVmRvXvxXTSeRtdR/nuzh9OuT0T2G9HDUG/2rBV54uKso=
X-MS-TrafficTypeDiagnostic: SN1PR12MB2368:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB2368;20:vf3Gnz41Fygev8fvoXIvNoTD5G7y7lgrwu9nWRErgantMw7O2H9O0NSJ6zbsp2DC+R9lGAG6VODBZwpCZ+DkXp9bMzm5SuTddIwuycHcPMPNgSl7tufzg4M0LnwwwdTWJHMlSBYFRTTgUEwKOZQRT+vqaOwohSiZ/uc5Dvw+y3MiKG+Qz5QN3uRRpvoacGFmX5g5Myv+20FIq3T92lC8tXg8YBHXOfL95noxXCRcftEzXn8JSxyDzJ2vxW77PhB6uYdkbnf4iXTAcJX9kPdhcXK5S8zmQ/zjCx1L4DvYO8Ur6I/EJGs6JCD6xhlH68XAZexMnmQjGbIQAJyylrPjkOEmwBLj5tocKcE0qPeHJA7xeOIyQn9putvMRJXQEy9zvcDhorXYNU14u9f9ijIKGiiyw0mrIwPrjJO16cEc6kvIa0eVwGtHmmzOgf2wO5RvaTKFTfOYQR8u9FrVYj4jHscavl5aSUUGOflsp0kp6UE4fJgmhAU19PkgC+9JntW5;4:s59g4AWL7ETkj4sxYP1Z1WcVtCJb8+y0VMlZjgbgYel4ZNvOagR8bcG0kvyTv9pbnMUK0UosBkcwN/cLKxxC9Yk/mloIS86IgvD8EemDp03i0VlcfXWEjOriFkTtuxZj5cgFpBi2oI0dJTAts6Pt15llexJwQ8ic/fTNJHvkswUeW/a4BXx7Cle3LpYyT1qRxnYyZVKin25JKQXK1y3cwnmfCwei+TFp7qAdIWjL/FTdjS8pK5j2G1f1WTXoGUf580WFY+GrzSDwbZz4dqrIc4CWdfO4393nJJQP+xltwN1EWqk4Ox3V3uf0tNzjnLfy
X-Microsoft-Antispam-PRVS: <SN1PR12MB23689747B20D81DA259F14C3F8540@SN1PR12MB2368.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:SN1PR12MB2368;BCL:0;PCL:0;RULEID:;SRVR:SN1PR12MB2368;
X-Forefront-PRVS: 0744CFB5E8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(346002)(376002)(366004)(136003)(39860400002)(199004)(189003)(186003)(66066001)(26005)(386003)(1671002)(50466002)(81156014)(81166006)(68736007)(53936002)(16586007)(7416002)(54906003)(316002)(48376002)(105586002)(7696005)(52116002)(51416003)(8936002)(53416004)(97736004)(4326008)(109986005)(50226002)(2906002)(3846002)(72206003)(36756003)(6116002)(39060400002)(8676002)(6486002)(106356001)(47776003)(7736002)(16526019)(478600001)(6666003)(44832011)(2616005)(305945005)(486006)(476003)(956004)(86362001)(25786009)(5660300001)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR12MB2368;H:akshu-HP-EliteBook-745-G2.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR12MB2368;23:k512v4sZf6rhY642M/QQ6g2uDHwqOetrb7nWTPVev?=
 =?us-ascii?Q?wsvxLjIhDnz3wIgpmyQpkFWMqycVIzAu4o0WlgUdqhKc+vdaABj4Jxe2ImuM?=
 =?us-ascii?Q?jwJnU8xHorpTMQJBpZvNOQcFl8jfBntOMzEsskT0cFF83Rc4KL/8pHls37V3?=
 =?us-ascii?Q?jrVOoAiledg4k+DwMzIGL/EdgUF6gR5Vyx0yFRQhOpsoYEQHIcig/o9CHOT8?=
 =?us-ascii?Q?YYGaHfVMocVWw0yiBIkP4QNU7ptjar3LNvnfW9w4Cx9SYb+JzNYqgb4cTIvk?=
 =?us-ascii?Q?Oq7QIdWwFP8DvDHBI29GhPWfJoAW3TsrcjBSF0fWZ0FV+Xi/p6qbXlmpK19J?=
 =?us-ascii?Q?+20Ld0Zf5lez3hEIRW2ebRUwPtX0tIbqTH/Miv81B7N2NWtdj9UDilyVYDlL?=
 =?us-ascii?Q?9zPffYF50aZKU2UFByXV3p1nUBdJNx5iOHaKbRYzsQST7WQEdMaykqE5AjRS?=
 =?us-ascii?Q?wYdg2tov3laC/fn3Sg8vIMhUqNrCLBmYS4i0lgxI+MWTgvEH2wafMwiD72Bd?=
 =?us-ascii?Q?SomyBi6udH5RTrAKQ1ITCCo6snpkiPTjh7mE5fQRYLNvT9/cAhtTATef5nGJ?=
 =?us-ascii?Q?MqoksNwoNnOjxt8hIBKtxaCjtNmFy0wLuyvDISm3reFMa79lm8A3j4mXJug4?=
 =?us-ascii?Q?AzdilJq38BmmUE17ZWvOBvLFwNpd362crncewVg4u6E3D3f2DLB4tj7XLC1j?=
 =?us-ascii?Q?H919lVkOTz3onlVae1KEvnHHSH5fqypLP/wLDh4iqUFr9EBZlW4mkDdzpELP?=
 =?us-ascii?Q?GgB5BHnWn5MtxyEWRlYEQ5yP8CYQPxQqtRoQ+ZlHTw7Kyc6yKmmnIBCAtU56?=
 =?us-ascii?Q?i+17Jv+wxDybPePUvZRcr25DOHDKntgOUWviFEOUiv+r1hZ7BQp8ze7qi2Zv?=
 =?us-ascii?Q?jpsRnuD8/x78gOou7PEhYsr2bbEma+k6REowBcQaFQL7UpFbDW+m5dOFdcTl?=
 =?us-ascii?Q?eit/BZl6pXI9z1nEhmFLIGRVizerqoNRYnU2PYliE//bRIDmWSRMcX0c9F8x?=
 =?us-ascii?Q?aJH95Yoh87WHRsWMKyY+JmxBoVGGv+wIn6ssyyvFl3rUTkqA4UHlAtvdurV4?=
 =?us-ascii?Q?tu2NlwXmAYIvbyFyqiCcorIVvWpV6cSLri6Jz6sbmGh4CUW6qh3DcIjqVEfe?=
 =?us-ascii?Q?C4V1pWR/kt1YO868FXJUhfxgCvQIVDzjG2Snc7X06sa4dDVtfxFY4s2yAFDA?=
 =?us-ascii?Q?vdu7zKx+kCveIx9gucf0oQIQK5Vd5ZEcKPpKid4fwiMkz6IaE+tYML8AtHvE?=
 =?us-ascii?Q?w3gnh+nr/sVdWr/fdHTEKL+9gCQ+1rjSYEF0Uac?=
X-Microsoft-Antispam-Message-Info: Bx7muRIMyCx5QxnQpy74CCVbdq3fcAYdJmbV7fpCIhCuNCK4ZgqazYp1gOc6bpN8RwqgUAhtlNI0/I3RZWYEg0iJpqJ8ZoncxGMDl5QfVoaSyK6t5AD9fVCAO8qrgZnMbToWryyvAfVntBOugoQoIffwYwahBhDAWrGv33zkQ+axwcxq/0Ujo8VlAWUWwvweQclD2dLo0dM/7DEVL0Ov3uOFUQuUuEQFj165WziL/CXxljcEERk/PXzbXz/oisvEkAwmJlEkiaSqsnawkkzlum8IqIvD0YIibxDuYWDZ2jAQv4NSX3mX+KL0cks3j+N5K/vuvVn4jY/ARGuwdm1QjaP+JJ4wqRwyVYf4NHOwjvQ=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB2368;6:JsuQmjuXGUOb948S0kXJeIVH5KGlOYlVOaET3Bi7nQivxL1LvXGD0ZdT+f7rGYFdkZqeUvABtcS/0a39dmHJCjjEauRjey3IM1YEWB+eSLThFAlHtQZtmEbAU5A9Rcbm2/2A0lXyPyIYUmrU7DSaEijTCalEUQK4hKlpSb24sCGWOPgaWaCWbJY4tmILr5VEIyqkwmf+q4xzh3+8tJDiyAZEFxZtwbrzaYMA7oBJY5yOHlDCW5JuqzSxZBscJT4Br36VMst6BHJ87t43+KlcrXQKL//mfCdq2fNkjNEYN1HwTA4NtbaiK5cnS7e0qR6mFqxIJZyx+PajGsz+Zday3jnd30nu0G9xSPhBuGRpgb/0LriugqsmAmw3C9Mefe2hjj2M6Yh0sFpC8PNoGwJG7/U/rBODJefeGCTxMHdQd2nZjfFRFLvZgULdiCfM4VKyrLDjusI9W0fNFnHD8iBCsQ==;5:P4quU8vLr1YP0jhBCggEtNOWVkzZJ+v+XERPmsO+imLLN0hAqfMNZ1yMmEGxYToc41JoXWS31LjvYGZufJsptEzHGhiWAa9w9q7qzG3GWw0G6pEL8vAAzRb76yns3vC6dD8jnHRU9fif2zeEdi6j+i9E6BSdLSrz/baoecIQLo8=;7:CmrsylDxRcrw1TUwFAQjyhBzRJDb1SarCGOwQcDu7EKMV2qL0antLkpni30xgzHN0FzH4wAKHP72I2LuafpNRmvDVz5GwfzwwnN5BEhxNhnl2bCMNkwNaaWqTNxNZf7wYCjmd1t0Ujzgwer+9BbT/VW6wTcYeit49wCgknhMVFLQn0s/T3gCQS1iDCbzKoYwaDOBtpzPqUDJwVwv8WSAEnsq0qceGkIFRd13mnYHlHEwcmEizJJ8iTo06QLdgObi
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB2368;20:PS23cs+P4iZzZLlUhbiQQT38Ju3l7Jhtr+cGutrbPdyTqJARASfMFVIK9lwy8HzvHbvnQNufXxjAOAyfcUeKOQkUR5b5k2n42utv76xJ9DadFc189xzTPR/jwrUVOJCFdP6EP/xkmaQdy5AC75c++MwNuVm7u/Q9B0tKwTHTDHdIkdCxpwRkILHMXqktsHqtKQGBuB13hLecMSbn+2XN1fCy6I8ACfGFn0rdY4tT4oYu3ImAIPvx8nz4q6G/kbKc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2018 09:01:37.3445 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ad6909d-c2a4-4774-df8c-08d5f20d421c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2368
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DA7219 for our platform need to be configured for 1.8V.
Hence, we add a volatge regulator with supplies
of 1.8V in the machine driver.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
---
 sound/soc/amd/Kconfig                |  1 +
 sound/soc/amd/acp-da7219-max98357a.c | 43 ++++++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/sound/soc/amd/Kconfig b/sound/soc/amd/Kconfig
index 6cbf9cf..58c1dcb 100644
--- a/sound/soc/amd/Kconfig
+++ b/sound/soc/amd/Kconfig
@@ -8,6 +8,7 @@ config SND_SOC_AMD_CZ_DA7219MX98357_MACH
 	select SND_SOC_DA7219
 	select SND_SOC_MAX98357A
 	select SND_SOC_ADAU7002
+	select REGULATOR
 	depends on SND_SOC_AMD_ACP && I2C
 	help
 	 This option enables machine driver for DA7219 and MAX9835.
diff --git a/sound/soc/amd/acp-da7219-max98357a.c b/sound/soc/amd/acp-da7219-max98357a.c
index f42606e..cd3cf6e 100644
--- a/sound/soc/amd/acp-da7219-max98357a.c
+++ b/sound/soc/amd/acp-da7219-max98357a.c
@@ -32,6 +32,8 @@
 #include <linux/clk.h>
 #include <linux/gpio.h>
 #include <linux/module.h>
+#include <linux/regulator/machine.h>
+#include <linux/regulator/driver.h>
 #include <linux/i2c.h>
 #include <linux/input.h>
 #include <linux/acpi.h>
@@ -320,11 +322,52 @@ static void cz_dmic_shutdown(struct snd_pcm_substream *substream)
 	.num_controls = ARRAY_SIZE(cz_mc_controls),
 };
 
+static struct regulator_consumer_supply acp_da7219_supplies[] = {
+	REGULATOR_SUPPLY("VDD", "i2c-DLGS7219:00"),
+	REGULATOR_SUPPLY("VDDMIC", "i2c-DLGS7219:00"),
+	REGULATOR_SUPPLY("VDDIO", "i2c-DLGS7219:00"),
+	REGULATOR_SUPPLY("IOVDD", "ADAU7002:00"),
+};
+
+static struct regulator_init_data acp_da7219_data = {
+	.constraints = {
+		.always_on = 1,
+	},
+	.num_consumer_supplies = ARRAY_SIZE(acp_da7219_supplies),
+	.consumer_supplies = acp_da7219_supplies,
+};
+
+static struct regulator_config acp_da7219_cfg = {
+	.init_data = &acp_da7219_data,
+};
+
+static struct regulator_ops acp_da7219_ops = {
+};
+
+static struct regulator_desc acp_da7219_desc = {
+	.name = "reg-fixed-1.8V",
+	.type = REGULATOR_VOLTAGE,
+	.owner = THIS_MODULE,
+	.ops = &acp_da7219_ops,
+	.fixed_uV = 1800000, /* 1.8V */
+	.n_voltages = 1,
+};
+
 static int cz_probe(struct platform_device *pdev)
 {
 	int ret;
 	struct snd_soc_card *card;
 	struct acp_platform_info *machine;
+	struct regulator_dev *rdev;
+
+	acp_da7219_cfg.dev = &pdev->dev;
+	rdev = devm_regulator_register(&pdev->dev, &acp_da7219_desc,
+				       &acp_da7219_cfg);
+	if (IS_ERR(rdev)) {
+		dev_err(&pdev->dev, "Failed to register regulator: %d\n",
+			ret);
+		return -EINVAL;
+	}
 
 	machine = devm_kzalloc(&pdev->dev, sizeof(struct acp_platform_info),
 			       GFP_KERNEL);
-- 
1.9.1

