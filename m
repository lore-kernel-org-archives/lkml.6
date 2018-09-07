Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8066C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 18:55:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FA7E20844
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 18:55:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="HkL/nj+e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FA7E20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727715AbeIGXhN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 19:37:13 -0400
Received: from mail-eopbgr700102.outbound.protection.outlook.com ([40.107.70.102]:48769
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726614AbeIGXhN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 19:37:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pOVULiAsP8WbHiMN2MtIfTFyVv1ABa+q9c9NajxlqfI=;
 b=HkL/nj+eLU6JJwl3T3B6KHgIBgVASD9B0YNzNx5P2TO2UiOgDdvXy2bOSyfTT82qGosJ+O3qG0MP84EvGeCH1DCFswQIn6LmFZ4CqVvm+9beVy0IESJL2DCspzU7k7VrMnPSijHNvB7M5gZd7lGK5/20crOOU4QGfF21vpPAseQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from pburton-laptop.mipstec.com (4.16.204.77) by
 BN7PR08MB4929.namprd08.prod.outlook.com (2603:10b6:408:28::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.13; Fri, 7 Sep 2018 18:54:50 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Paul Burton <paul.burton@mips.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Jaedon Shin <jaedon.shin@gmail.com>,
        Mathieu Malaterre <malat@debian.org>,
        Rob Herring <robh+dt@kernel.org>, stable@vger.kernel.org
Subject: [PATCH 1/2] of/fdt: Allow architectures to override CONFIG_CMDLINE logic
Date:   Fri,  7 Sep 2018 11:54:13 -0700
Message-Id: <20180907185414.2630-1-paul.burton@mips.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: CS1PR8401CA0027.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:7503::13) To BN7PR08MB4929.namprd08.prod.outlook.com
 (2603:10b6:408:28::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3159f3c7-bcc6-4a2b-19b5-08d614f364ae
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BN7PR08MB4929;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR08MB4929;3:S1PwxUMIh0E9WumjKyIQUlb0a6wEWx5pJ8JPK/xw91grJwPEB030Vas982/rnJl6vbhixqRzEoZr0XN2wD/tw4vYFOwT1MvUL9efFeMtH7gtMlUmJ3J576SyjEo83QQdIg49udll/Zl4yn8r/s2xHUPYFFTGJoYXYF6hllYaT0NedHpn1CyzMdx702vjQUPrknwIa+8oLnjI3UBZW/O61AAlxaFXy4Rd+7+iWSMtHPxcGXECeDtIbiibfB5Stwr1;25:zhw7xhnxCYg1dh6youGDhLruMHY6FT8+7wiyTEYWKF4LgPH/fZOCZwzAZ9nfHTZkTI/xWSWrhHVccY4ZgVdG8F5s+7Q6uHopawAX6NIO/Q9OdTCEKpDOfpMDa915oqc4cn8BDTQREpQbw3eu1XItcxUYOZC17xRypKTkhNgBRxAKMZbwUIDLBFJFfp4njkmWiJeMFkas7/xsx3CEIvedotmBTUvFc3HdUO1I8Zt8cQFn0S16C0fTeM+Y1vOMZDQf/SfzUUtcGujjGxC1sKz5+qGWy5Ek8jT89eYlQpDYpePemvWIW/HQEAgUVpO2hCE4GTX9enGXoe0uhtPlj3GZVQ==;31:miR0H+ci8UfMKOhFeP0rb45++ta2e7Paou4GOGyyC/jwt4SMOPBPYxsNYSLstUXFQuTTvtmy0BIdObqZcz2kpnRuuAnvhWGW6ye3Ta5nKfuMsHtCO1qGInYPfZmJ45ZjYNR+nIXkebfcqDd9X9DtAJTraOM6NduwvFeSSuNC1ek27FYFygMDwWObd9TzhUJEQ17emeY4GsfLJAcG0p9Y/2+NHMT07bCEqYHyPmYM6EY=
X-MS-TrafficTypeDiagnostic: BN7PR08MB4929:
X-Microsoft-Exchange-Diagnostics: 1;BN7PR08MB4929;20:WxDrOsiNAeiwaVo6uXkuJ643H7V0/a0TFcFnr4k1dltccDRMbMtQGAWCx949HxfiuZesgyW4vyJAIAxLmQ9uQxaTzfNTQ3Z0r/ZrZex8MkUO7E4UJXgcGM9mnzyVH8Bt++GewQxxMs7tzblvi8RkwEFA5ck2whRBOJKv2UgxE6CtUD0J9N48qT/h7X5DNjpX5PLzS1OGtos21eyyHvdk4bq19CXYdEx9hqAejRuqJm48iRQZnA85OdCb7W+yaHac;4:XQwAoAjUFsJBIeUTK3URdxvltMKQfxFNOqdxl0kluBgy4szh6qBShPgBWsiQSLbAMk9jl/w+QKq2V8DhWiy0CJ6BTJIfiyoZJydQDtF0q3F1AmNQCHfNYAmYnrH/kSGuJ0S+v6FkyXI6kSUr2ImZWKo+rhWTDPto+r+prq9PKXo6bOBXKlWRj/eP4mKDzeZ1q5qPa6emVusbdxajS5/Wh/q2CCUDhKWPdWGNhXWhk1KlPZG8uG3fHdci20YL+x+X6eAn0MRKjA2zpDdMB05g52f9xjtvWh+RUq9pvHDrL06t7g4ilSFlLlfoxzQqQgIK8aTvhAIDwsx9o3WPn6OnqlCNv35qdEPJ/V0aTSKvMpMBHnhTYIEyiegGVgNWfdfE
X-Microsoft-Antispam-PRVS: <BN7PR08MB4929420CA3100BACDD9470B2C1000@BN7PR08MB4929.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(85827821059158)(788757137089);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(3231311)(944501410)(52105095)(93006095)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699050);SRVR:BN7PR08MB4929;BCL:0;PCL:0;RULEID:;SRVR:BN7PR08MB4929;
X-Forefront-PRVS: 07880C4932
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(376002)(366004)(136003)(396003)(39840400004)(199004)(189003)(42882007)(39060400002)(105586002)(305945005)(7736002)(476003)(956004)(2616005)(51416003)(52116002)(48376002)(186003)(966005)(6506007)(26005)(386003)(478600001)(36756003)(6486002)(50466002)(16526019)(81156014)(6512007)(486006)(6306002)(44832011)(8676002)(2906002)(8936002)(1076002)(81166006)(3846002)(6116002)(106356001)(4326008)(316002)(47776003)(54906003)(25786009)(68736007)(66066001)(50226002)(16586007)(53936002)(5660300001)(53416004)(6666003)(69596002)(97736004);DIR:OUT;SFP:1102;SCL:1;SRVR:BN7PR08MB4929;H:pburton-laptop.mipstec.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN7PR08MB4929;23:GO7MLRD8m58CqT1Yme3V4j3AvJARSnR+3Dr3NPsTn?=
 =?us-ascii?Q?EGOZJxYLMHmPWQ9HKzzTQLUeXTXm5Wu2TUkUthmyR9bvxxpE6peGgdyumkca?=
 =?us-ascii?Q?9o6j6QBxSqs1YLvWovTUbvKc7dcoKTj6EcibP73Erb/RgLVKA1viJKtNtk07?=
 =?us-ascii?Q?NWBbCsbb6KnksrSdHB2/mbWJ2o1gQPSoq7l1rMvST6NTuOGpgy0ZzFYlfHaj?=
 =?us-ascii?Q?apm2wvsEYaxULcYDcPqVxWvEIfhFvtaKGaSpQpDTPFrtgl9hlWfxHyPAzb/v?=
 =?us-ascii?Q?QTCFyg4WSU34lCUUPH3px6zOPR/Bc/+oy8JW4pOf7PYyHdwTcrBUIYuJCMa4?=
 =?us-ascii?Q?8nDam1+Lpv9YR0G67iBglX7Fap0BZxBSMugdjy7pl0K5CLgUY2m6y8diB6gV?=
 =?us-ascii?Q?+5iyWx2RjN0dCySqF+6lcoZqZiWj47dB/FJa3WU9UMIoRmw5Qf/WlJHFc+Kf?=
 =?us-ascii?Q?S77y8xIzBG6B+ORDOuyr42l0Ad0Ci1irlW0XSVL7uCDn2nR298ID8MtsKceU?=
 =?us-ascii?Q?GpThcRwDjo8fyJbqzbIHmicj9LTKqreCRbevK8trk8msdCQ+XpENWH6QVEy9?=
 =?us-ascii?Q?OOCMhy7Zu/AcmtgKhb+pXr9+78//vv5U22h7/y6XtvcKlJHz/vGC9oABBb0y?=
 =?us-ascii?Q?I/CQL8TlmirQRwEnEPFF9Im3rSF9/H3QkWBHWnm+4NEmZLL9L/KsVqJNNAsz?=
 =?us-ascii?Q?mN7Se43P4uDQkZv3qlEoAh1+AuWTruOxBSaUXAnZ72cWgLdnZITAF+HffZKl?=
 =?us-ascii?Q?BtTkg1G2L5u3neh4FlQAG1GyxaKClQ7JflazDrtlV4By+DP350cqdbEzwFLZ?=
 =?us-ascii?Q?/YxNfF5tjmkFNiBeIwSTnkciUmCgAeBP42eAzRAOlKVDhFb71JxAMJDF9mRL?=
 =?us-ascii?Q?v/I4jdK2YA9tMvoZP+YTTJfIQ/0hYNC2wWKj3xCzFWlsGsp0/5ulpDSNGFZD?=
 =?us-ascii?Q?RDpMTT7ha91/yGh3ye+BLFVmlZbQX1rkDrKgDj2Km5pmqJvNNcxSqhnguU3t?=
 =?us-ascii?Q?dzvSsjUcNQaGRY/t3zSAK2sbhMpznIYxgofaochppRckAwlY5qW613BDh/LP?=
 =?us-ascii?Q?V91GOCymh/aLbekyQgEjbrbxNYovMXJHePKlk2VJ2xGV5Ai6LZWBc1NCl+0n?=
 =?us-ascii?Q?A1EOzvZSPtrQ+AIMwU61eCCP9jCadqgsecyl1vKYkBhY74XRmyTee4W2s7mf?=
 =?us-ascii?Q?ifELnxB5S+AlG73vZgafvtegPf7BTxPBTXyPZ7ZW96FrthQ08IMgd6cC46Rh?=
 =?us-ascii?Q?ZXSs2Yy2aCP2E/+5M0=3D?=
X-Microsoft-Antispam-Message-Info: /oZ21IBLs7pRBJopqRPo5mL7bxln/eiiaj3gMfQECPq7+i6UqJDeLREWDa+yeO+3NFru4Kh2AAakGeT4DKOnqOAqAeW0dMx1wPoDqYyxbbjqrGOVg8VpjMDuP+Afg7Y319UVT2na/J+xveW7NE+OyLmRC0Io5ySlTf0OVjlIiLvTZ21jJha5AtILut5E9SheusHpn1NKWA3FYQD0ZMjjpQm1ftg9kMLUee+AFRwvUHh1LGZJz48dKxlhQyN646SETJamdnToLfgQO3pXrLnpdmHlJq7VA1D5CuWhn3fQnzIbQFQKWpCic9yt/jnUC0IVAqCyi72oF4hbtcwHjGwtMZDbovS3dMDeT5WFAjQGU2o=
X-Microsoft-Exchange-Diagnostics: 1;BN7PR08MB4929;6:ACBVT/TMFtawieM6GmcEnTb9Cyv9I7R1+9ku5P7OYCIPOimwWHsfdNYvetdM5EREg5JZ+vm7645AFo090O+SzicuawQt+hEea+PVHzHYW/0kThn7LdflFzLvmHoFkpF3PDkD6ojtS8TdEn35FGtLuT4gmOQZPiF7pvMI5/eDiDry7adWsRwp0qCrch86j55eQqknbhGa4oUX7TQnDoUACekBcrqHIFzAsUq9Mtb6Iq8JNVmtgpiIy17lnrerVVxhCaTMFQrTRxMIoU+62XI6Y7cKsZl/OGtWUfcvtzr6wcr4U/6whqmUKuoJ7eS9Eji7Fodtz+vGVho0Gh7J+iyugqa+8Gbf4tBRWN0/5BxXo3SmvwT+xUZQ/Ra3f5JdaT1RdamNYBrsl0BWP6CU185YU1hXC1zTSPM1cIgSoj6gS3JSjo0AgfpCYluBwY3XnCXV56OlCrwOovnDRKVZ2MYtHA==;5:rSc9F51gkxypAnTM6xp178I5JAOj0UV8A1cFJIkgRA9exZUmbfXhoL1e5iyyT5t4qgpdBo/6zbS2SNYAOYiSjd8hT1aaKIlqehNqtXEt6vJ5PY7bZk7fAyOP4akWUDQEJMyYdMn66UTSWfAG4kPDYmB5GOYxdBLDnlCC6xVnZXc=;7:Kzb2eGZS6QuHN70738ZPnJFtE217rCNJr3cOdWYju8fRfF4DRltCloH8XXFXIzgma3d4X1LhchC21ixqjNCehj3MF4HbNaMKrgZYuu1gMijjNg/mohXXRQbLUYTFU5W4b71UF93pLZWx6bMwKLb8QwWsNmH4TS+oEO7yLmPNT0vrqaxXUK0wtPbpUKPSxwJeeMoHNZSxe7/wFFtQLmDdcWR44F+e3k5x8xaJoINKhZJNqFrhT3H4RC2jVFMCjyX/
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2018 18:54:50.9337 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3159f3c7-bcc6-4a2b-19b5-08d614f364ae
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR08MB4929
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CONFIG_CMDLINE-related logic in early_init_dt_scan_chosen() falls
back to copying CONFIG_CMDLINE into boot_command_line/data if the DT has
a /chosen node but that node has no bootargs property or a bootargs
property of length zero.

This is problematic for the MIPS architecture because we support
concatenating arguments from either the DT or the bootloader with those
from CONFIG_CMDLINE, but the behaviour of early_init_dt_scan_chosen()
gives us no way of knowing whether boot_command_line contains arguments
from DT or already contains CONFIG_CMDLINE. This can lead to us
concatenating CONFIG_CMDLINE with itself, duplicating command line
arguments which can be problematic (eg. for earlycon which will attempt
to register the same console twice & warn about it).

Move the CONFIG_CMDLINE-related logic to a weak function that
architectures can provide their own version of, such that we continue to
use the existing logic for architectures where it's suitable but also
allow MIPS to override this behaviour such that the architecture code
knows when CONFIG_CMDLINE is used.

Signed-off-by: Paul Burton <paul.burton@mips.com>
References: https://patchwork.linux-mips.org/patch/18804/
Cc: Frank Rowand <frowand.list@gmail.com>
Cc: Jaedon Shin <jaedon.shin@gmail.com>
Cc: Mathieu Malaterre <malat@debian.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-mips@linux-mips.org
Cc: stable@vger.kernel.org # v4.16+
---
Marked for stable as a prerequisite of the following patch.

DT maintainers: if you're OK with this it'd be great to get an ack so
this can go through the mips-fixes tree.
---
 drivers/of/fdt.c       | 55 +++++++++++++++++++++++++++++-------------
 include/linux/of_fdt.h |  1 +
 2 files changed, 39 insertions(+), 17 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 800ad252cf9c..94c474315cff 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -1072,6 +1072,43 @@ int __init early_init_dt_scan_memory(unsigned long node, const char *uname,
 	return 0;
 }
 
+/**
+ * early_init_dt_fixup_cmdline_arch() - Modify a command line taken from DT
+ * @data: A pointer to the command line
+ *
+ * This function provides an opportunity to make modifications to command line
+ * arguments taken from a device tree before use, for example to concatenate
+ * them with arguments from other sources or replace them entirely.
+ *
+ * Modifications should be made directly to the string pointed at by @data,
+ * which is COMMAND_LINE_SIZE bytes in size.
+ *
+ * The default implementation supports extending or overriding the DT command
+ * line arguments using CONFIG_CMDLINE. Since other sources of command line
+ * arguments are platform-specific, architectures can provide their own
+ * implementation of this function to obtain their desired behaviour.
+ */
+void __init __weak early_init_dt_fixup_cmdline_arch(char *data)
+{
+	/*
+	 * CONFIG_CMDLINE is meant to be a default in case nothing else
+	 * managed to set the command line, unless CONFIG_CMDLINE_FORCE
+	 * is set in which case we override whatever was found earlier.
+	 */
+#ifdef CONFIG_CMDLINE
+#if defined(CONFIG_CMDLINE_EXTEND)
+	strlcat(data, " ", COMMAND_LINE_SIZE);
+	strlcat(data, CONFIG_CMDLINE, COMMAND_LINE_SIZE);
+#elif defined(CONFIG_CMDLINE_FORCE)
+	strlcpy(data, CONFIG_CMDLINE, COMMAND_LINE_SIZE);
+#else
+	/* No arguments from boot loader, use kernel's cmdl */
+	if (!data[0])
+		strlcpy(data, CONFIG_CMDLINE, COMMAND_LINE_SIZE);
+#endif
+#endif /* CONFIG_CMDLINE */
+}
+
 int __init early_init_dt_scan_chosen(unsigned long node, const char *uname,
 				     int depth, void *data)
 {
@@ -1091,23 +1128,7 @@ int __init early_init_dt_scan_chosen(unsigned long node, const char *uname,
 	if (p != NULL && l > 0)
 		strlcpy(data, p, min((int)l, COMMAND_LINE_SIZE));
 
-	/*
-	 * CONFIG_CMDLINE is meant to be a default in case nothing else
-	 * managed to set the command line, unless CONFIG_CMDLINE_FORCE
-	 * is set in which case we override whatever was found earlier.
-	 */
-#ifdef CONFIG_CMDLINE
-#if defined(CONFIG_CMDLINE_EXTEND)
-	strlcat(data, " ", COMMAND_LINE_SIZE);
-	strlcat(data, CONFIG_CMDLINE, COMMAND_LINE_SIZE);
-#elif defined(CONFIG_CMDLINE_FORCE)
-	strlcpy(data, CONFIG_CMDLINE, COMMAND_LINE_SIZE);
-#else
-	/* No arguments from boot loader, use kernel's  cmdl*/
-	if (!((char *)data)[0])
-		strlcpy(data, CONFIG_CMDLINE, COMMAND_LINE_SIZE);
-#endif
-#endif /* CONFIG_CMDLINE */
+	early_init_dt_fixup_cmdline_arch(data);
 
 	pr_debug("Command line is: %s\n", (char*)data);
 
diff --git a/include/linux/of_fdt.h b/include/linux/of_fdt.h
index b9cd9ebdf9b9..98935695f49d 100644
--- a/include/linux/of_fdt.h
+++ b/include/linux/of_fdt.h
@@ -80,6 +80,7 @@ extern void early_init_dt_add_memory_arch(u64 base, u64 size);
 extern int early_init_dt_mark_hotplug_memory_arch(u64 base, u64 size);
 extern int early_init_dt_reserve_memory_arch(phys_addr_t base, phys_addr_t size,
 					     bool no_map);
+extern void early_init_dt_fixup_cmdline_arch(char *data);
 extern u64 dt_mem_next_cell(int s, const __be32 **cellp);
 
 /* Early flat tree scan hooks */
-- 
2.18.0

