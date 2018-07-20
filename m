Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 971F2ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 06:39:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7DBD206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 06:39:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="1jks6jpI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7DBD206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727266AbeGTH0I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 03:26:08 -0400
Received: from mail-eopbgr720055.outbound.protection.outlook.com ([40.107.72.55]:52160
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726555AbeGTH0H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 03:26:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1wSDVhVhZHL7sSIDm48TvnK+/C8wW72kUoCYy0JP/Uo=;
 b=1jks6jpIesWpfG/jrVUuol0fLGiIWKa3deZTT2mEWQCp/pz4inVVl7HP/K4z9N94+mdkCq3Z76ce9Y3DjC3QRNuZEGdQy317uRuIzsIrlgI2aVj9cymFf+URVgVzgAVDwfepzxIU2nekVdQBfjcgQS39468UHiK/kgRJakGVYvI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Akshu.Agrawal@amd.com; 
Received: from akshu-HP-EliteBook-745-G2.amd.com (202.56.249.162) by
 DM5PR12MB2359.namprd12.prod.outlook.com (2603:10b6:4:b4::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.18; Fri, 20 Jul 2018 06:39:10 +0000
From:   Akshu Agrawal <akshu.agrawal@amd.com>
Cc:     djkurtz@chromium.org, akshu.agrawal@amd.com,
        Alexander.Deucher@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Dylan Reid <dgreid@chromium.org>,
        "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        alsa-devel@alsa-project.org (moderated list:SOUND - SOC LAYER / DYNAMIC
        AUDIO POWER MANAGEM...), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ASoC: AMD: Add a fix voltage regulator for DA7219 and ADAU7002
Date:   Fri, 20 Jul 2018 14:38:11 +0800
Message-Id: <1532068715-2992-1-git-send-email-akshu.agrawal@amd.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [202.56.249.162]
X-ClientProxiedBy: MAXPR0101CA0036.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:d::22) To DM5PR12MB2359.namprd12.prod.outlook.com
 (2603:10b6:4:b4::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 19f90ec7-9890-4237-1554-08d5ee0b857b
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600067)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB2359;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB2359;3:ZvyKNGOczItSSQgTx5x22Xuvg+dqbrAWI+t4g7gceu15oQ+1ZlXbgF4gCnqY2ydSNZqCDar+vlNjq4dVyXeD25vduKt/0z04htFMTEe1gH4JExeBnFotZ5v8n38TriY136Gjzb/lO8V/bzzbsATcfiW2ObYwzQ8MbnIhtDYSMkajdyywOLCMkZjn0u+Jgizsse5NFR+CTKekrklsTNi3tPi5kygAuBcqeHq/So1rJt7875jBI+CWICjKb5o9HsZt;25:8l/fl8akjWZrg9Ep/a55C18vBa+mm9yJM8537OtJalnmqXOvBLr9wPcTuji/Q3BPwMwAr01xiIm3yUm89jxdoM7Xsui+HHo35LDEXEfgOHIAkfJGVlKZPaN2YDW63CVxl9J3Yhg8Fcuej6G4BPKmy7E/C61aXcNrq0TFWSpEMYUi11yZmzp+5G6XKvRgmmGoLtaM+VaiOF7iS512mnWLs5EcAK6trME+xK4U9ffo8NadrJiV/FTdYVYCWTMWxQf2bn/aya3l7OrwMxBnRWxvFxIdt7Gx6bR8tEej3IucT6VqSl/tPoiYD9e3Yvdv76BrcZaQAWCrdXXnrCPsVZ54iQ==;31:QM9qnuBrCnlPW81+FreGopYLNOSyH2Zvc4iLejATsKyK20V6xK5iWfcCQYbkDPyaeLkkd3s9ZAk6jIehIsD/HgLJUaqokGQowXw6FNcWc2fLDM2prNwECL+7vcG9AECJfg3vGHvCkBY/s4G3TDDyec1UzyocnOYfi0uo7/CtmvQ799OzefdCJOp9hvUcFoL+TZN4vTjx1LlDrPgqUZH0vB94a99EWHmVadDwbe5IOWQ=
X-MS-TrafficTypeDiagnostic: DM5PR12MB2359:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB2359;20:owZ+4rcV1GFFWjp4SVoImdT7iZy4SSnGgnLK5oeRwcDr7FiQRNzDMn0T9BuvuDLZtifw6BEf6c1InK0ixIGHShrAp6aDmPmo3x4wUhCxuxiad3JYWIkRaXYR1aOgj+SMW+NrMyBDcLBtOc/LOycn00SvcnHhtquCiwCmCZS8DjTG9ukvFwAhqFwOysmhQaQSSparbeTtHeFTuFZBfq1n21MVW90mUyNR4AQP9/1GwMLADPHziv7Z6uJRvhO1czVm/nZL4MV+0nUFWWgTcCdqaE193jqBXV+b6VA9jPg5Nq/rxgb5hrwjRsfmNx7gWIVpER5o/AcnqeRjLBXzTvncZ4Xxz7P2ZjB+hyJ7OTCTzVd/dFttrguKzJlDGDBC+Wh03hfTJoCN9MB0Pko9vELmuwNiX9oZXRqZ2cTtIfHXQBPXttmUbwgFYPnQ47wlX4AkyFmmncWYZQzY49t5Mc9fgiWbAAGrcJxjJXZnNMNHSNHxIIT4lYlGoX9Ld+/yc1z5;4:GORny0QXd+Ei7Ukj3hTY7ZeuuPEeJ2W33pxNQmOH2ggDlVQ1I5ykIoj53yWlGSD1HWUCfV7RoyUqLE5Ua7tRDzu70ZiCx2HGq7SDgJyKtAyx6uckvpPD6aFlEzwpAmhPY2rLiyml/b9cgB5WYkwC5ccR1voAoC8U2+UJPljtcC6POpHXgZ6GyGjU2V4DW3TPyy+EyiMDj5SY9HnJGR69Qo3ALXp6W8VPmHLdjAlmBAk3w/J+B7fIQqFdaSJnxUGTOt2UffsHUolY9QPZUNz4gldiZehuzl6Bl++DmkNcElF8m1UHYlCmadU0TBmlERxT
X-Microsoft-Antispam-PRVS: <DM5PR12MB23591F579C81E42952F301CCF8510@DM5PR12MB2359.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:DM5PR12MB2359;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB2359;
X-Forefront-PRVS: 073966E86B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(396003)(346002)(136003)(39860400002)(376002)(199004)(189003)(53936002)(51416003)(7736002)(4326008)(478600001)(16586007)(26005)(39060400002)(109986005)(186003)(16526019)(305945005)(72206003)(386003)(316002)(2906002)(7416002)(81156014)(8676002)(53416004)(106356001)(6116002)(7696005)(52116002)(8936002)(97736004)(105586002)(3846002)(81166006)(25786009)(5660300001)(47776003)(486006)(36756003)(44832011)(2616005)(956004)(66066001)(68736007)(50226002)(476003)(48376002)(1857600001)(50466002)(6486002)(1671002)(86362001)(54906003)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB2359;H:akshu-HP-EliteBook-745-G2.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR12MB2359;23:hPnWsviuuZO1CpCdme+cu3w6PGGK1KUpKlIF+K4Db?=
 =?us-ascii?Q?kF+uacDc92exgMObj1YQ6OfAnFXshYcrzVlkq7yQ/1q3m4zoxgtblAWnRvye?=
 =?us-ascii?Q?KUQQFpVI/h9y6e9AYfEjvbcCfxziuDTwsSmYSdkW0J8JxKU4D2V5Ry6SBlL0?=
 =?us-ascii?Q?+5poX6NCRiit0TQphInxEmdAxuAQ2EQVY0xBaGTyV5EyZBpaGZ8TDCk4aB07?=
 =?us-ascii?Q?AsG2F2lyPqTPnSlwVBwQfqYUQ7SXk8TdbdkpOS1Cg/HlH6ZtmJWSjC/O0ZqH?=
 =?us-ascii?Q?xh1Q8Lki4xpsgjt++1vEjQRBuoBcpYvYs8qTaDCnAn1SLQ7/JpnxJ3Ix87lB?=
 =?us-ascii?Q?gHIuXiBy9GIVth9D7tsLvz4+hIQXX6+V++sCqcPrwlYDhfLABz9DmhoGz7Xe?=
 =?us-ascii?Q?V2XQcz2gjHxFqGRxkQh7dsna667zgCRKcLn5P69FrcSjTSy+QMN0/Ra9KtFi?=
 =?us-ascii?Q?FoMdbRYQI/MBnpUIbPerLT96NYL1Us5985D7swYM7mKVUjuZ4YfOasLnuDdY?=
 =?us-ascii?Q?JFln07BSlf80HRJnhGw3cxKi8eU7gjttjCQhu3iZadsakdJXY/FkKHTJraHK?=
 =?us-ascii?Q?Fk71IRoio+9R8MrHlmco94b6fHU3CGPSG6a8mQHJ8jDsVIWu3K9TXw22curR?=
 =?us-ascii?Q?U+rDKVJc9hlbehFMQAH2nuMXImnjvjm5+oj71HEGaeqXgMoVLeMZMGQebgMO?=
 =?us-ascii?Q?T15u8kXjjAzRys4j3VlnTSaLDS4p9kpG9oa3pO9u98KeHHSzhSbxGymBgEtw?=
 =?us-ascii?Q?TeTb0oWzXeDeGGiaUzGPtyaU6L79aiWyfnT8D97hywWmUpWbutwoKkolA0Uz?=
 =?us-ascii?Q?uO6lXHA8u1vy6zoUAJRSxvY7mh8M+bytH4l/vzVhqlPEWNDdxYRho2tmKcZU?=
 =?us-ascii?Q?DNQrcXoP3UEsAuwcZaoo87CIYNv1maq5iGRoTDymv5dcdyg8GqxitxDPYS1x?=
 =?us-ascii?Q?gFynWG5Kl/HxbNQNykqUNp0UaJoKWv0TfE0dgkDPbwIS2G2IxyZOkktX+9m3?=
 =?us-ascii?Q?RiZIPZghGb96KkJ/zGh3W/DCzVExhMI8Xyx64OVJJv11oqwTF2qz1ofRNtD8?=
 =?us-ascii?Q?tgxYsL75K0ZNnws5QHp7S9G/ZrwSAFDzNt0bod3bVe4/IfkObsLtivMxzhvG?=
 =?us-ascii?Q?7FFtiVb972yblvFv9MPpPJEanaNoZguza7S1FaJFYe7aU1mUPKIPrWN79bkW?=
 =?us-ascii?Q?9GmAt17BU497L2OgigElPv8Gc4GK7yVWKGh8LY2a6KbxxdF3uI6FmPTOypbD?=
 =?us-ascii?Q?hI8agID3gsF+k9fDoMyWk3BCpuDHkEFfmnuRDme?=
X-Microsoft-Antispam-Message-Info: U9XeSOqbAxxlohzrFyXjokEPmwnl616bNXQGozWMhXLQMSAdeUPg1LrtxEMU9/2zYhSRJiAR95BwUIVLWxXIjr7I4xadfzDXj3LEqhJkdHzF6GLw9JDI677iSGXlBpGM6lDnUkncWJr6b/HNcp/PNhlg2W24stx9ML8EF0r83iRGg5Ezg7f5AGaMXzwNbytZkzdnOUwQKxyjZvR+vzxHKkov34gObW/43cNm9BcgJgTjgnUS61zdiYAZADsuBJBInodRM7tzhWe/Fvt6Vwo0JwGcdufrksI7/SvcHgOnLb85rutYOvVThxRdbcVcW/qKNsxyzH/L8k5ezmCk4lQoput5B2tHFHN4vWI4rDmvMlg=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB2359;6:ETFnzjmacN08eoIb4q0piqeSuxtlkOcjx9dSM8REHwYQ4kGn2dVJwFFO+p0SBNLkbsfU2GxCRlipWbNbhoS0zLJwZaSh8RXMEGi+tnDEiITZFVajJ4fRxT2itJNOlvTrod0ld84aj+sNghzWfj5KrstRZ5DAdLahElEUgJj/yPsySNCwEyILzM7Av9OrYqzntHWTP+sGZ0+A7F+PM/4OtFStmw51nymgJh9HMHhMZw1VwauwkbtZgWki5ZLmWIb/fBYnoM5G/iqMAfZ5nD2BKkYJZdNlMT4qeamCXZ9Rx49Z3/jO7ydHYKO+eSu8u5w1+eeFruyAOXtKC+9kf+ZxgM7RnXC3rhmhYkQ1NSC4ZRPt0gEULlT3BEI4xE1jgGHellKOPZu9bpaDBf6Ca0KHXXTrRyalha5uMqyZkFWrVQ8ipz3Nx5PwsO495GtFXqEmJSR0nuw/ULHSxuntBAYyzQ==;5:F66o4IO1GhZ1lzlJr07NCcg4puoraeKAI3JyK2uOokFqGdknw8pAUBvM5cwdVydbI/zWVt5gFivTBKOdJWoC+pzq3LmApDQI7NXgP4+rhIhm3lLW4CyU4EIKQ7xtulwxeqiSBfy5URnfQ+Xfm3gtwH2t8BsD/hv1jwJ+Tjqj6Wo=;24:X5wXLWklhkNqC1aWnKwOfQQbXYMUTt4RcjwGOx3eSEG6yYYusg0Qoe5fQu1hPXzYM8SUtphKxYTuMytrWFKboTl/tlCN+X4qtTBjjsjzWoE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB2359;7:lkXAwjvuV9YDLLtweJtJUgBYfUDirE+FR0aRBMcxTOm9+G5fpEvVYOCLI/ZOcY/l5IHAojcLM1CmjwDLi5ePRwemJMgZWE61vFRM0M3tp/i+8171p1vLIM0FjoM8Z2qPiqXyaSOw1khRULfdf8S9JrhZikNrWKlkHO4s1juBDrZT17X/li8m2nsL8afKONRL7kqveXpJVAlJO+X2OCaRqimBwQ24YqrSwLv87Gx/uvd7/NODBbXXU83qxk1wjyv+;20:x2KfXTCrxwbfSl9Yys51Z/moJyQDmv28ufKHPRuEx4EFEesQNhiSdNguduz651nT8TV7fqHf16dyvljaaDan/vLhI3C7+NBQSLEVp/Xsy4+n1bnRiR2Yee7gpAc4fI/PRsI/3oiPWU+5fRN3RRsc7h+mgLex/e/Ly50dX2BU1b8ZqTHPA4JQkmZg6Jat/moJlnURxELOGWKZTfF3XLVfdUwjiXpHO6/fnslxLkcvUxzTpzntsNBGu3PbZdVadJIN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2018 06:39:10.4816 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19f90ec7-9890-4237-1554-08d5ee0b857b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2359
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DA7219 for our platform need to be configured for 1.8V.
Hence, we add a fixed volatge regulator with supplies
of 1.8V in the machine driver.

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
---
 sound/soc/amd/Kconfig                |  2 ++
 sound/soc/amd/acp-da7219-max98357a.c | 45 ++++++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/sound/soc/amd/Kconfig b/sound/soc/amd/Kconfig
index 6cbf9cf..c447a51 100644
--- a/sound/soc/amd/Kconfig
+++ b/sound/soc/amd/Kconfig
@@ -8,6 +8,8 @@ config SND_SOC_AMD_CZ_DA7219MX98357_MACH
 	select SND_SOC_DA7219
 	select SND_SOC_MAX98357A
 	select SND_SOC_ADAU7002
+	select REGULATOR
+	select REGULATOR_FIXED_VOLTAGE
 	depends on SND_SOC_AMD_ACP && I2C
 	help
 	 This option enables machine driver for DA7219 and MAX9835.
diff --git a/sound/soc/amd/acp-da7219-max98357a.c b/sound/soc/amd/acp-da7219-max98357a.c
index f42606e..fdf8972 100644
--- a/sound/soc/amd/acp-da7219-max98357a.c
+++ b/sound/soc/amd/acp-da7219-max98357a.c
@@ -31,7 +31,10 @@
 #include <sound/jack.h>
 #include <linux/clk.h>
 #include <linux/gpio.h>
+#include <linux/platform_device.h>
 #include <linux/module.h>
+#include <linux/regulator/fixed.h>
+#include <linux/regulator/machine.h>
 #include <linux/i2c.h>
 #include <linux/input.h>
 #include <linux/acpi.h>
@@ -320,11 +323,53 @@ static void cz_dmic_shutdown(struct snd_pcm_substream *substream)
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
+static struct fixed_voltage_config acp_da7219 = {
+	.supply_name = "reg-fixed-1.8V",
+	.microvolts = 1800000, /* 1.8V */
+	.gpio = -EINVAL,
+	.enabled_at_boot = 1,
+	.init_data = &acp_da7219_data,
+};
+
+static struct platform_device acp_da7219_regulator = {
+	.name = "reg-fixed-voltage",
+	.id = PLATFORM_DEVID_AUTO,
+	.dev = {
+		.platform_data = &acp_da7219,
+	},
+};
+
 static int cz_probe(struct platform_device *pdev)
 {
 	int ret;
 	struct snd_soc_card *card;
 	struct acp_platform_info *machine;
+	static bool regulators_registered;
+
+	if (!regulators_registered) {
+		ret = platform_device_register(&acp_da7219_regulator);
+		if (ret) {
+			dev_err(&pdev->dev, "Failed to register regulator: %d\n",
+				ret);
+			return ret;
+		}
+		regulators_registered = true;
+	}
 
 	machine = devm_kzalloc(&pdev->dev, sizeof(struct acp_platform_info),
 			       GFP_KERNEL);
-- 
1.9.1

