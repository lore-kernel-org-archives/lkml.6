Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A425C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 14:21:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 301012075E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 14:21:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=CAVIUMNETWORKS.onmicrosoft.com header.i=@CAVIUMNETWORKS.onmicrosoft.com header.b="oLxz5IbK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 301012075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=caviumnetworks.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727577AbeIDSql (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 14:46:41 -0400
Received: from mail-eopbgr710054.outbound.protection.outlook.com ([40.107.71.54]:61536
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727072AbeIDSql (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 14:46:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZnQIZ8TypOamw+pd/TBUbRoil+bgC+/r9YIHxtSWaFM=;
 b=oLxz5IbKOUNRsbQsGpTzj9F0MUhJ4NoAc20r41xbI8BfYKivg9+oBszK3L0DNgtGeiTVusyungXrLLzv5u8rRxc3eRdzAI9m5Lk1mf9eij3LwZT/C7zg2w+UPvqM8QkOdkgtjKXsfgIqWBcFgZC80OjuLjF45kd2V1MIsDnpIN4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Tomasz.Nowicki@cavium.com; 
Received: from camailhost1.cavium.com (80.244.146.33) by
 BN7PR07MB5170.namprd07.prod.outlook.com (2603:10b6:408:25::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.17; Tue, 4 Sep 2018 14:21:16 +0000
From:   Tomasz Nowicki <tnowicki@caviumnetworks.com>
To:     mathieu.poirier@linaro.org, alexander.shishkin@linux.intel.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, Jayachandran.Nair@cavium.com,
        linux@armlinux.org.uk, Tomasz Nowicki <tnowicki@caviumnetworks.com>
Subject: [PATCH 1/1] coresight: etm4x: Configure EL2 exception level when kernel is running in HYP
Date:   Tue,  4 Sep 2018 16:20:34 +0200
Message-Id: <20180904142034.19116-1-tnowicki@caviumnetworks.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [80.244.146.33]
X-ClientProxiedBy: DM5PR07CA0104.namprd07.prod.outlook.com
 (2603:10b6:4:ae::33) To BN7PR07MB5170.namprd07.prod.outlook.com
 (2603:10b6:408:25::23)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 87ecbe57-2c4d-4caa-ec99-08d61271aeae
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BN7PR07MB5170;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR07MB5170;3:hNrQRW1ITcI635uTJHSwPK8bSRY+WDCFNDnB1Ytwq29zvQPL3zzkt+xhBwK5R0aRdyf40NNCukc0XOdNOAqfaMKHfrSX/IfVKVrLHJXvsGpQqqVBfe6zDW5+YHvw0iRZZSvkPkoLblKhVBdKH4M8NSkrW/Arki92jvAeZQrzKIYmm5bGS6VoFzCgOdw0CMhv4c09aXBj+uokgSvyrVO/GPj5HcMsi4S1r1HcvsVjVF4lt6kyuv8Xh7Rkk4ytzbC8;25:4Wjh8jME3xvRoEI6nQYzNpwigDDSDJ0KG87vy0bjj3m6C1y3QG/9qMBAgzr582XzESbBYz+6+foMOQe7y8kq8Yri6zUca25y7s9zW0B24TTACpTJVZLzjV+oJxWmEh8h+W4xDMUbgx7gek+sg4CAPxgranH42BUr3/jNE8g9AyEu0J1IjZlOff7N0PmlScnVDg5Eqk1Pn8gKKN2uaBVP8MoKytz7Z8tVN+PIMFzReVQMgRXXsILjo8sFmTHCTCLU5k+Cb9m+93GGyY4HhzEd+fE4M0JX2m/rNnKEQDd0LK7LRSt+nD5qAektH6xSEkHu+dUNMMtLojD6DaGF52cqpA==;31:VbmCqkZgKsPRR7/XTTMHtwjVTC0NR4AZprTI2zMrfqK03UflMHLytYs4NgYuWyXPJlcmoQbIc8imEMY52s1o7uioz9G8vBVQsLsNsymsRB6M9pUDVxplSNoaeap68V/j7Truzoignf8K9BUoYH7/KtZbtUhTBFJJirKod2EGzu+oh2lgOgyB59dlRsE7GpRGqSontBf5z1FspFO/MCNAbeXczMvZyd37lzi93Py8xQ4=
X-MS-TrafficTypeDiagnostic: BN7PR07MB5170:
X-Microsoft-Exchange-Diagnostics: 1;BN7PR07MB5170;20:r0wN3MricgN9WE5es8jF3mk8VsDZfZeLMPsliXbYhQjbvYY/OL1SNmTqT5rY2/j/4ntUhWLJYealOlfGPtwA76iwQdA89AbJvQFcIcQbqHUaBFBz1+rtAirH4uccMNGqPrnLQ+6twz+RFlb/XO5ovsKFRb5olXjhLWmK0lUnsjTpxcZOHj7+4WfwkjIf7B9ClWiHd/8MEncj91bQCZim5WX1mLvNj9QMcN1xInHIRazFNMjDLdd4wkFAdAIT3bb7rVq6h8VbF3AhIdltI7XkdgkZwznI8j3XOfFnxnfYGi8fFASqgF3pD8xlbvgayT95naPlmfzZ6xgN1xjcv0zA8n9ImMeePOhekxeuiTTALzH97XPfz1yPTHIZ8OFW747NF6S+e387/uzlfiuQ8KE+APiLceGtwwzg6x/KHHro4TimJjZ/ncZZEarpgpA4woDb3Q91iRB8vNWrXB3oFOyZs3aNs1iCrk/KLqyBDeLuk3fAKL31tPWg8M0fVKo2H3Aoc8QOuFHgHTXrD2sWT3qS39a/19A5RnQKmmG1oipv23nn0B/KcOdY9JaJ3mt1E4819lfea0UUb+kJuYmkGLAWq0pQ807FbHgFxjjSYN+nhSo=;4:IUEqQtlsNCjr/Nt8eoWiZieNHch6ugoKKBLzxnVzbsd8Cw+gflOoamK7NcXcTRWYt/ReQC0s67t3QVM+Zcx/le33dK8e8GlfHapx+xpu1DPYwSvVLn9wCfzrk0vGRAqHhtayP+oOS3H/xqez+4MeCjwJX4f48DBk138qELYUkmXtK+RgXz1hRqoJ2q6H6feV4NTzQ35HoWSEc+QzvO/YhuTCfFn/cPB9zJwyi+aGSsWNPtj75BHGH5ImRfc3v38XTzyy5LDvAao0U8mhmo96zw==
X-Microsoft-Antispam-PRVS: <BN7PR07MB5170968A04EA576C219FA149FE030@BN7PR07MB5170.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(10201501046)(3231311)(944501410)(52105095)(3002001)(149027)(150027)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(201708071742011)(7699016);SRVR:BN7PR07MB5170;BCL:0;PCL:0;RULEID:;SRVR:BN7PR07MB5170;
X-Forefront-PRVS: 0785459C39
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(396003)(376002)(346002)(136003)(39860400002)(199004)(189003)(8676002)(476003)(81156014)(72206003)(2906002)(1076002)(66066001)(48376002)(486006)(4326008)(14444005)(47776003)(2616005)(16586007)(478600001)(50466002)(5660300001)(956004)(316002)(107886003)(81166006)(42882007)(305945005)(50226002)(6486002)(36756003)(7736002)(186003)(8936002)(68736007)(575784001)(6512007)(16526019)(25786009)(386003)(3846002)(97736004)(6116002)(69596002)(53936002)(53416004)(106356001)(52116002)(51416003)(6666003)(105586002)(6506007)(26005)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR07MB5170;H:camailhost1.cavium.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN7PR07MB5170;23:FC+kgqU7C5+fEt/klbpA/ORJ0cw80Z82l65UJKejK?=
 =?us-ascii?Q?AzYO+xaPOCJZvmZSXdPSIGSw8AZ33kL4c8lY+dZcjneAFEGQgF/d8NXTdgLz?=
 =?us-ascii?Q?CyDfBzuzO3/hosgNlQEClqtLIMOW/b4NgNkH+m/geNKVIfm2lnuL8r6FSzlM?=
 =?us-ascii?Q?5O4w2DIN1arOtcK4dmjyezAixMmCrxGpyI9AFtTd0elJLUYxxPHBCu+aLKZd?=
 =?us-ascii?Q?6OnHa4jMd8KtyUnELUVa9j3sgAN/hJEZf4O0lGRm1cBJ/aFPayQp+TSxdc4E?=
 =?us-ascii?Q?JkWScGBglq4/PJTPnNqZi/QE2NsTmU9jd6wDnHVBkvqS5kIQLHB6+mv2TSJs?=
 =?us-ascii?Q?FzyIiwao5ScH+O7utWI7EkLa7d0CqTuF8UD9WvgdufhnDGW5sbfdL3zK20fY?=
 =?us-ascii?Q?JgSV7rR+UCdMalClkroHEfE00BchRyk+GiiXYpfWaHjdeqVtHDm4jelBnQGx?=
 =?us-ascii?Q?/a5eL8WtubKyonEu7S+8EGUwOuvNulscNfVueTx/d1Nhf/Rax6v3oxbtauNA?=
 =?us-ascii?Q?ORJoc9XvbZJv5yuru5qUzNUgOX3a0r+/IBjeX4j66nbAdwDh+d1wxKTJLoLY?=
 =?us-ascii?Q?PFJNwJR3c9zIWPyem31+SYXx1OCtIeEHg4BAXiKi0Kb8sdSdrrOi2GNl4lPe?=
 =?us-ascii?Q?uPc6HeS9ITaCzQpedR5TVvWptUaZNQyaGzy9nwobtQ7XN2pd6bpLewVTn1eB?=
 =?us-ascii?Q?8BKMqCS6qoTAFg/1GfXZkqiH2IMmOnlp26QLkNwfh21Ld0c/Y4V3P1q1mRv6?=
 =?us-ascii?Q?asJrxw6PlXEjs1pHLy04cYgKm76i4qOmCxx7Ed0ULItC5CvxJHMLmqlXbPMB?=
 =?us-ascii?Q?hfD9mLrbWXL04PF9dZJZAAaWjya/05I914ZNKVqwT260dqWloJz0NgFcKyS2?=
 =?us-ascii?Q?HYx0r3BSdNodJLv+m0Vks93mhJofrQfMMLsuejn1y9VkxoTzIrYnYGmNcdNC?=
 =?us-ascii?Q?itSrE/EDNnEnkjCCf9mQ7iAGNGKQj4qkp1JA1N8wq65Mzbds8m++DMdN98Wq?=
 =?us-ascii?Q?AnteJCEuQNgJe6kcGVheIQZEAreX425IjkxMIq831L9wAC/bQ8JDsg0Y1zm6?=
 =?us-ascii?Q?KjtkKzp+z5f29s3+2QJLt5jJZtAuhsIQU4e8MJBiP8H3R5DYDH9ykvi/o+bI?=
 =?us-ascii?Q?P8GljVnrLb4ivc6FXvKOcPuYoac66FfyOtGAg2oelrK7Wsh4m/gImxYrJrsB?=
 =?us-ascii?Q?ODVUpu4HLWjTUXg9veSNK2qCwsTuuv7FrFZIGSfHna1bgmQD1TK6u8ldOpzH?=
 =?us-ascii?Q?RdMl/KGQ2Elwzl02mBLf2Y4jpz+DtwYMlIL2BDA?=
X-Microsoft-Antispam-Message-Info: lxfBGOy85fTA3bkJps04/ChLAi7G7adbfZqEBZ8dnSzfPiu5TvLwA1+wMcpMKWWLbTdx1cSqOmsBU1dGIcDj2JgdduHqPDkWiTapcQ5GheDdUac0BWZZIA+epy5W8s9UVZNGveJhcOHFkGx3O6FVClw1KdMXei/y4zkVJ+5UX7HFVtGJJC5ItwAZNFxiDlR6rtSMLgPfUeRMWdWRi3zRW60JhSjFOocFGs37t3BdZPOjHZ1S3kXPvjpTzqojDjAgS92gCcnUdJIOX0JHpL7oSC+BYft5HhnZlRn7dPQ/icd+Eq/o+w2vrG2XNsY7IMHr793fvFpgC09x2a8lPO49dkLNZhVzbvwmVeGUX+v+1Iw=
X-Microsoft-Exchange-Diagnostics: 1;BN7PR07MB5170;6:AKJfopYXP0QvrNvwY9Hl9XZdgojNKhGXF+O47TU8lnNN6uECRssP5S2ZcS3ghqVyPynda+ukhQmtxlF/6Wvulun0AJLpdOskNCnCAh0J++6eWzh5FLxnpsW4/WQVxmsFlRgNxtKF6/U2kLDLESChBLR3TZe3I1N3kkPMmvaxm/IgZm2S1l8BzCpGsbWjR0h76ON3DDhuKMU5zy1OQGkQ1C0DtN3nk/5fxbXjxmBWe2HXymF+huyvDRA77dKcSMgtc91yH3hwMI2ctJR3fGOaN47/6NwLddE6icG0ftx3on25P8QrCW31jB/lKgZFh0HgvQreN24Mb/r9rToy59YXtSvw06t+7S5LIu9vH/GTnorBRq6zNhkL+7lwVaVpQ7Zz09zxOXFKKjdt/q7DsSPzFUAIePXHf61u/z2Ik3vDmiUJ1Pq2poUIbKOQ9CbhR8JnEjkaHd7URqw60tzBmDMAWg==;5:8dMImkmzXbsbO8Jbq7a/3m0yesDHkakiNXtLbOmIdfxkl+L/0q+iFZni6cMATIaGXkv0qYsWefRxFBSJ5n/FfRXqDekPC+ScAXgtCLsAnYIfeIZNGD5SQINPKg/SOFAN7pKG+Tlb/ka14TOo2KGxvw75l6vKCCdFipBJxjKo/Mk=;7:BffS+B0ejxbuNpeO7gWIh1WCp+sc/TbGYDiUKta7emDkQpHWxZXV1QeB6SOEtZQA7AcmVz7bUJuDdMD2fx7tHDx6Ag+B2enMoiDQG2hWwJk8TznQ87aa9jmw93JJZFpDg2dYrcnRMKOD6Dfa9R3+BVP/y8dlMr3x9Pyp+695Fckd3lATouxFszNNpZoZ7PFMTYIc8NtXWilcWz7WrEA7XnSSat2HBOvCAZfiWq5jfwEbTcLnym1gyyJG0mU7Oqen
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2018 14:21:16.9372 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87ecbe57-2c4d-4caa-ec99-08d61271aeae
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR07MB5170
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For non-VHE systems host kernel runs at EL1 and jumps to EL2 whenever
hypervisor code should be executed. In this case ETM4x driver must
restrict configuration to EL1 when it setups kernel tracing.
However, there is no separate hypervisor privilege level when VHE
is enabled, the host kernel runs at EL2.

This patch fixes configuration of TRCACATRn register for VHE systems
so that ETM_EXLEVEL_NS_HYP bit is used instead of ETM_EXLEVEL_NS_OS
to on/off kernel tracing. At the same time, it moves common code
to new helper.

Signed-off-by: Tomasz Nowicki <tnowicki@caviumnetworks.com>
---
 drivers/hwtracing/coresight/coresight-etm4x.c | 39 ++++++++++---------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
index f79b0ea85d76..5f495c942f99 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x.c
@@ -28,6 +28,7 @@
 #include <linux/pm_runtime.h>
 #include <asm/sections.h>
 #include <asm/local.h>
+#include <asm/virt.h>
 
 #include "coresight-etm4x.h"
 #include "coresight-etm-perf.h"
@@ -606,7 +607,7 @@ static void etm4_set_default_config(struct etmv4_config *config)
 	config->vinst_ctrl |= BIT(0);
 }
 
-static u64 etm4_get_access_type(struct etmv4_config *config)
+static u64 etm4_get_ns_access_type(struct etmv4_config *config)
 {
 	u64 access_type = 0;
 
@@ -617,17 +618,27 @@ static u64 etm4_get_access_type(struct etmv4_config *config)
 	 *   Bit[13] Exception level 1 - OS
 	 *   Bit[14] Exception level 2 - Hypervisor
 	 *   Bit[15] Never implemented
-	 *
-	 * Always stay away from hypervisor mode.
 	 */
-	access_type = ETM_EXLEVEL_NS_HYP;
 
-	if (config->mode & ETM_MODE_EXCL_KERN)
-		access_type |= ETM_EXLEVEL_NS_OS;
+	if (!is_kernel_in_hyp_mode()) {
+		/* Stay away from hypervisor mode for non-VHE */
+		access_type =  ETM_EXLEVEL_NS_HYP;
+		if (config->mode & ETM_MODE_EXCL_KERN)
+			access_type |= ETM_EXLEVEL_NS_OS;
+	} else if (config->mode & ETM_MODE_EXCL_KERN) {
+		access_type = ETM_EXLEVEL_NS_HYP;
+	}
 
 	if (config->mode & ETM_MODE_EXCL_USER)
 		access_type |= ETM_EXLEVEL_NS_APP;
 
+	return access_type;
+}
+
+static u64 etm4_get_access_type(struct etmv4_config *config)
+{
+	u64 access_type = etm4_get_ns_access_type(config);
+
 	/*
 	 * EXLEVEL_S, bits[11:8], don't trace anything happening
 	 * in secure state.
@@ -881,20 +892,10 @@ void etm4_config_trace_mode(struct etmv4_config *config)
 
 	addr_acc = config->addr_acc[ETM_DEFAULT_ADDR_COMP];
 	/* clear default config */
-	addr_acc &= ~(ETM_EXLEVEL_NS_APP | ETM_EXLEVEL_NS_OS);
+	addr_acc &= ~(ETM_EXLEVEL_NS_APP | ETM_EXLEVEL_NS_OS |
+			ETM_EXLEVEL_NS_HYP);
 
-	/*
-	 * EXLEVEL_NS, bits[15:12]
-	 * The Exception levels are:
-	 *   Bit[12] Exception level 0 - Application
-	 *   Bit[13] Exception level 1 - OS
-	 *   Bit[14] Exception level 2 - Hypervisor
-	 *   Bit[15] Never implemented
-	 */
-	if (mode & ETM_MODE_EXCL_KERN)
-		addr_acc |= ETM_EXLEVEL_NS_OS;
-	else
-		addr_acc |= ETM_EXLEVEL_NS_APP;
+	addr_acc |= etm4_get_ns_access_type(config);
 
 	config->addr_acc[ETM_DEFAULT_ADDR_COMP] = addr_acc;
 	config->addr_acc[ETM_DEFAULT_ADDR_COMP + 1] = addr_acc;
-- 
2.17.1

