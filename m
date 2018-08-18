Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EBE0C4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 02:59:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FA1B208DB
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 02:59:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="P9iltLna"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FA1B208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbeHRFvT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 01:51:19 -0400
Received: from mail-eopbgr80059.outbound.protection.outlook.com ([40.107.8.59]:47776
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725853AbeHRFvS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 01:51:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kJ9uW92zeMH9miA4yc3HTz30IqIfvzNgHvKg4IzjdBo=;
 b=P9iltLnaqYr1aXzwLB7kpsn/3wiIOZ9VJRjO6KfuZDRNal2zTEb5B9CLE9scWeVS9MeekAMXrwOsbaFlQw+jqYe+AgS3Qd+iqHqRd1gY6fyvf2ATKWvzrtXxVlTKIOnLK/Nc9L8nYyB8EWn3RduHWBnY6YGQJGNisPMxc9JUqY8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
Received: from mlx.ziepe.ca (174.3.196.123) by
 AM0PR05MB4450.eurprd05.prod.outlook.com (2603:10a6:208:5a::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1059.21; Sat, 18 Aug 2018 02:45:18 +0000
Received: from jgg by mlx with local (Exim 4.90_1)
        (envelope-from <jgg@mellanox.com>)
        id 1fqrEg-0003ek-D0; Fri, 17 Aug 2018 20:45:06 -0600
Date:   Fri, 17 Aug 2018 20:45:06 -0600
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH] Revert "Permit silencing of __deprecated warnings."
Message-ID: <20180818024506.GA26409@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [174.3.196.123]
X-ClientProxiedBy: YQBPR0101CA0043.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:1::20) To AM0PR05MB4450.eurprd05.prod.outlook.com
 (2603:10a6:208:5a::23)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 26e84985-eb43-45f3-a121-08d604b4a23c
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR05MB4450;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR05MB4450;3:/7SQjORuPY9wA5KSkTCr6aIQ7SHbAoEru/MkLLir7Df9m6j+9kbbvTj9uUI9RqH/CDTqYeTMpgek3mjbEEkicY1ZVryZtQEGb5e1gfrZwz4ZylG/17iNEP7Dko0UjsMbe0YV7PqnVPjgYsAx3trwc4Kno3/MdvxmGDaYEoxRCes95P+JHukZ4HPE/A9OemKrq/UrxAPAVMo1M+wif7+0mJg6vA3Cezio0d9VToK11yvEANY2hzXMoXelUrRG3W/T;25:zCcVjDljE/a5yPO2LaDLofozUpNLJR47O8SikC2L5MqipFLeR32nLbrvNTmdFB7gBbzt+BiXEtZBfhY/m0biMGecQ+4+UB1M0IDsPWrN1NKHb1LtSj/yG/vENK8vzVmsg1RVgCgSu7CwwSxsM4FifWDaEKXQHMaNfRoCvLKqJ7Magf1Xb0qi+sYd1OJIpPtdfDZ01LMaix3sCQiQov1lR8O7BQvmtwtW1jmIvSoxnyVIyB8YiF+eMfZF6NUFwE3esgOrFD/y+bOKE5BtPavzfIiGVYZDYI0hiC8tyLgS282I5SEWNJKF7F8X+rD4xiIwKiFwDCTMBTi/yd9DzUDHUA==;31:oUAdxqMR9PJfbblUWFVpp8suE2OFuYLOV2U/EK1z7ontLa7TVJ+G1GJ78/GvGyURsHaFkEKM2qXkWEvr8EoxNhsh8cjdeq/AwLedn8SybnXjDM8kIh2brYjkJ/UO6t+SsRw3YMITuxPDMWxmmNtF7QG3mfPPq2AJ8E5tEs1OwRtGnTG0m3QdPEYIaFPqJ/CP5dgEcjMtza03eGx0+i2YYD3FNjZqsTBjLKYSeNAwEjw=
X-MS-TrafficTypeDiagnostic: AM0PR05MB4450:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR05MB4450;20:eP4NvPbxEndhFLwTn2ueEyNrGb0WuyuLK9uKQ+lFTqG4T+z0sC7YwSiMmRxcMv7V/GXyaYPONe4W96WJf7Ad1sclbrhDPgR2pwC3BRx8RvpAiH44jvIbQ8elRZBmR4Vy143K4Ajj2rkYLJryZtUZMqC8//YF/3EtOCd4Kgc6py5A7pfJPDTRbxQA70FH59I8ScCyQlVciMqOCUVjt+CB8c+Y847lq8/1Fl6gakKG4v6QYZsdxf8lxbM3gxUh4eegiDe0lyJJnm8yWA292824hp7RqLxOw4Ik9IrCrbv5okZDG0UqtQWLgrHaF5gYMATtj4EWRjbdDEAyd+/S5hOh4bkrgkuWv2/hOVZXKGdi/4euXnuNXiWWInUWLItrBy6k5vnuleHfSlh/fa6P5YnCZuWCAQsqqejk2RJGVrGn7iRg5x1SFEmp3F3/8J/O2UoFGb57D7g61QPi8ncs803UhIZGmzCSAjJoRg/H2Lig2QfvsYvRK4dixfCuLmdE25JP;4:Kf1TivyZC0MaiauWtiyxO17AESFyuzeqMLK7NOkoMfnF5nCkyvpWf+ejBILYJj1eQwMTtEllxvF7fvYsc1ddNP2ATt9xOvn2NnrrLWYPegRFX5Hn4l5WMuVeHeWDQzMvbLfaogmc0/BX9riDnpu1Sf3ERvwW75b78OBmIHqHLMAc+XsOgHHFxqNzXO5nV9ugMM9LIR9MvQqLUa91eQb5ETFlSJwIfShTIQlsDAzHMcFpcEutSLwMi1vJxeYyqfqkCUzbAN7MUfwSXjNkwjmJnIgnztmHlc+Zl4OP8aOtK/kPgoEeMSHrECARYHHgGzzXO3+AxgjBLK+A7aHbL5J9s/toe3jzdRZizWxp/zInEFE=
X-Microsoft-Antispam-PRVS: <AM0PR05MB4450F36B392674E296DE680DCF3C0@AM0PR05MB4450.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158)(42068640409301);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231311)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:AM0PR05MB4450;BCL:0;PCL:0;RULEID:;SRVR:AM0PR05MB4450;
X-Forefront-PRVS: 076804FE30
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(366004)(376002)(39860400002)(396003)(136003)(189003)(199004)(8936002)(7736002)(46656002)(66066001)(105586002)(53936002)(23726003)(57986006)(6116002)(16586007)(106356001)(386003)(83796002)(69596002)(58126008)(1857600001)(47776003)(3846002)(45954006)(33656002)(966005)(305945005)(26005)(9686003)(110136005)(6306002)(186003)(316002)(33896004)(122856001)(19627235002)(36756003)(5660300001)(52116002)(476003)(478600001)(426003)(575784001)(86362001)(68736007)(97736004)(486006)(79686004)(81166006)(9786002)(81156014)(1076002)(14444005)(50466002)(8676002)(2906002)(9746002)(18370500001)(24400500001)(42262002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR05MB4450;H:mlx.ziepe.ca;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM0PR05MB4450;23:R20g2fbsDbnBkcLe4S2qPFt2/VQRumBugdm6HJ7U3?=
 =?us-ascii?Q?vThCixdHfGh6i72sWmPPo+SEFg6vgD+WFXbuA4IxhnlpJnsJqLl6HBjeW+PQ?=
 =?us-ascii?Q?XlgRNwcli5SUYbEZe/fCfwl7xHoWNdZmoKi38mqbXeNJ0b2PLOI78iLbREN2?=
 =?us-ascii?Q?Mvmeh5A3S2ICtcuUT97fAQZLx5UPXxunSgJBOzspeGIpsCf75hPwpeorE5A+?=
 =?us-ascii?Q?YMcn0jI7agnJNA+5Eb+aIVViANd3sYMK5LsDw5sjq3lHe2S+/hHw4qcGkev0?=
 =?us-ascii?Q?CFY3qAJsDqZDLTtB4TT8vVu58/eq+Su8mTbElcMJedfIHFkLNFhhupkOKZkQ?=
 =?us-ascii?Q?7qr23ZhG1zmDUpKgge+ZLQHvAAyOnTV3HN2ECrNpPPnSIYgljtWgN0ANvQCN?=
 =?us-ascii?Q?4HrijBmxW2d7W1KZRqrLZbNFlVyiUIhyThCeJfPX9BtupdXHmpFn539IYQIF?=
 =?us-ascii?Q?VzO0FZp1T35YI0nRtn49vfF8/2DbsYMU2SXiBbFypWJKTI0guLi7Ps9q6kR8?=
 =?us-ascii?Q?1uaYhUw3afbCrG0MSQ7E8eh5r4HiOl2JS7jXmFaRn+/V8l5X0vMKzOwnwX76?=
 =?us-ascii?Q?Ida7eJhgjsMY5Fsb+cI/hygP316L7N75+TRJsfNavd76b7Nh1erJYlo/iuH4?=
 =?us-ascii?Q?tVLF8mFiSPH6A99rDR4Ef5dwUmwWW7yi9LA5v1Pc9ff7yJhDhW8tlzTnTYPW?=
 =?us-ascii?Q?LkJN5aGNkTZsSDtCkZOIb6IFpD4z4P1Nat7lVgIVkazDuW7mkJTAIQLKqecd?=
 =?us-ascii?Q?LHWGquWRDJgcASFEwCQNCJV6B0Vjk358jtHpuwoA9SgWciED61Ew8QFi6twX?=
 =?us-ascii?Q?I8SXdJpm2/G2JI01u7fcdnooBKBE6tMddJ2sKPY6+JHaVehYMx+1KNScYDW9?=
 =?us-ascii?Q?0RzgefQsKky7J8fOIagZA2byx+8+9TsroX4WMqwjvMR+tdU+LW9GSPNt15Px?=
 =?us-ascii?Q?xEnIDUAALtUx6Bs/hdTTj4+cHY0126l+BdCa+0gZwIxRWbyH30iLBKI0cHxX?=
 =?us-ascii?Q?p6GYRik9eW4wi9b9Pw8vPv5yRZkTjNBJiBj/OMH6K8zZQmSk3zI6Sqw0qmfB?=
 =?us-ascii?Q?w+tWi47mmy3ODKFpkh8HMnb1zMdwYZF6K52Vf++HgbtrndkLLrJH43xrqUUl?=
 =?us-ascii?Q?g/2r0RvIx9V6ncy+qxY56W6MUaJ2txFJISHktU4HUm+oRwpKiRDmTJTB0tip?=
 =?us-ascii?Q?7QO4eH1P7q6zddTilQwvNaqTxvNV51fuSjpvXxTl1baqVCqifTkNB1XBza5D?=
 =?us-ascii?Q?K7/edP4SHHdntnCMSAmff+DEIRmAllGQaYWyPbcv0xGC+fuOZvHXJTA6ognh?=
 =?us-ascii?Q?QcJCUcWdyNLMe2iO1tfYxL6yMesZ7MvdM2lz6GSyTo9Eoa7dk39/IpAT+SsD?=
 =?us-ascii?Q?NyPEmcFajIeuBMK/g4fDlzLYuT/RmzdT6JZcIRbiM5Rx4MU/IhBiLXJwYpur?=
 =?us-ascii?Q?tdUFrWSyw=3D=3D?=
X-Microsoft-Antispam-Message-Info: 3X0xcrettBWPwJGs8+VgIaWrDhvxnOJDOcvc7N42Rw1UNQdmALpWadRaQHVQN7Nil4esE2X4zdanN9CJm3o08Ue4+p/gU3cYxUnniiPJgoGI8HVJDh5NzqSdcFgrnfHZcjmPHJdoAb6vuaPxtqXJEN4oMMaTNayuOrNLGgQY7xgVzdTZz9d39S/Aol848tl+3FjmzA534t64w+yg27Pol7/oAscW6VwWPoWOJiNbDNqh9qME4t8z9XFKhH4xeaHDL5ZGKVNSrhnzPn2dKqS6n4fY1VKfLXfqu7ZmbLPrQk0dl+PExiN0RxWtN560SUx/Id2FJG78sITuLrz67OYDgVnWMG3DHf0we3y5hoSBpBg=
X-Microsoft-Exchange-Diagnostics: 1;AM0PR05MB4450;6:Ame49R9Q7W/uZaxDTFUPUOx9qXhrxJoj9591QyQEH2z7+l9O6zTwFFyFXydnbXsX5e0xVjhEUMRzjb4eDOAGnc8+7GgiG0dyPgNt/ixxu0PTiQmZe3HFhGi0vsVjgVmIAdCUg2sv8Xtlk6je2myDIX5DcGnCFB5Tyly1NLqAZi+Me5hHriSYy54A+OORUkSmEytwk9a+PLSbBc/YBXRXL0cfkscRJi8oiLIuxvibw0ZhC7VvlmV4dsvFUeeBLahvUXZ+Be4ChSqMvSgyLMdxYbmB5GbB/KCJCLIPrHMXYohBj3OONFPp9AkJ8gh55QZhjvaGT9Tppv7sLEA4Ceti0NoTxZJ2gAxVkbYwEeNVIRvQbRFsNLOym4RJwRDufLNVCXcpWv0KwGxK9GU+xhu154bFsSpL4kFiPYIOri98Py2vJlGvbOBm3aPaGPC8pwn2gnmZjRkGx1jWHdT6X9ih9Q==;5:WlpYIjW7kEf4mWGujgMLqRZky4ycK3yFFScKvW5TZtHTwNStVrJRM7hj2hqVHQvQYVw76brwTYxGt1zhvvQn56vE+bYMjJiflN3esoruQZIVMraST9YDBbPMxRT6iXbVW+zPh114PM8k7rJLVaMb1ERBtIs+flamLalUc207MFI=;7:lc434/a9J3Zq6hiDrVCgWNaKY0SzB+G2yJVca1+GjXl27+ANY4YtsCLi6TRVb1d+XetKxANG345IXvOixMEM/73xg/W7adW4PffI5ADeSEA2lScr+qraS8+h8DRLJAnpwz3r/Y2gKZXvXrdeaKj0wjXGPhOafir+57jxLuvijz9aCDWj9bdupTAc/vAyelZEymLcR7j6tbZmVRrZzXHCOBmVncc41yzpjY1Lh2r909rPYO+kH/p1xxf+dElIzkQ8
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2018 02:45:18.1990 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26e84985-eb43-45f3-a121-08d604b4a23c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB4450
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit de48844398f81cfdf087d56e12c920d620dae8d5.

Linus would prefer that __deprecated never produce a warning in an
allyesconfig compile. Since we have been at this state for some time,
the option no longer has a purpose.

Link: https://lkml.kernel.org/r/CA+55aFyGLKSzS8O3m4JaE69wUm03tGOf+507jCCViTRQaGBGxw@mail.gmail.com
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 Documentation/process/4.Coding.rst | 2 +-
 include/linux/compiler_types.h     | 6 ------
 lib/Kconfig.debug                  | 8 --------
 3 files changed, 1 insertion(+), 15 deletions(-)

Linus: As discussed.

Jonathan: I'm not sure if you prefer diffs to documentation to be
minimal like this, or if should reflow the paragraph?

I can send this in a PR via rdma.git with the __deprecation removal
patch probably Monday/Tuesday if there is agreement, no 0-day
surprises, etc.

Cheers,
Jason

diff --git a/Documentation/process/4.Coding.rst b/Documentation/process/4.Coding.rst
index eb4b185d168c05..f03c62f50d7d0a 100644
--- a/Documentation/process/4.Coding.rst
+++ b/Documentation/process/4.Coding.rst
@@ -249,7 +249,7 @@ features; most of these are found in the "kernel hacking" submenu.  Several
 of these options should be turned on for any kernel used for development or
 testing purposes.  In particular, you should turn on:
 
- - ENABLE_WARN_DEPRECATED, ENABLE_MUST_CHECK, and FRAME_WARN to get an
+ - ENABLE_MUST_CHECK, and FRAME_WARN to get an
    extra set of warnings for problems like the use of deprecated interfaces
    or ignoring an important return value from a function.  The output
    generated by these warnings can be verbose, but one need not worry about
diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index a8ba6b04152c13..a2b428c43ae134 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -135,12 +135,6 @@ struct ftrace_likely_data {
 #undef __must_check
 #define __must_check
 #endif
-#ifndef CONFIG_ENABLE_WARN_DEPRECATED
-#undef __deprecated
-#undef __deprecated_for_modules
-#define __deprecated
-#define __deprecated_for_modules
-#endif
 
 #ifndef __malloc
 #define __malloc
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index c6e73904c5a5da..ab1b599202bca7 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -211,14 +211,6 @@ config GDB_SCRIPTS
 	  instance. See Documentation/dev-tools/gdb-kernel-debugging.rst
 	  for further details.
 
-config ENABLE_WARN_DEPRECATED
-	bool "Enable __deprecated logic"
-	default y
-	help
-	  Enable the __deprecated logic in the kernel build.
-	  Disable this to suppress the "warning: 'foo' is deprecated
-	  (declared at kernel/power/somefile.c:1234)" messages.
-
 config ENABLE_MUST_CHECK
 	bool "Enable __must_check logic"
 	default y
-- 
2.18.0

