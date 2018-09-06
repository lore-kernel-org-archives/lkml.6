Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CEA9C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 17:05:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23F6C20652
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 17:05:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="TkWtHqEJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23F6C20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730095AbeIFVmS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 17:42:18 -0400
Received: from mail-eopbgr50104.outbound.protection.outlook.com ([40.107.5.104]:55375
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728309AbeIFVmR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 17:42:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KcjscaIk5SBKODLvAixyzYCGYOhxzUWKeCMSYIvoppA=;
 b=TkWtHqEJU+Nv1HEswzZVH7m08Wa9X+FtCDk7I5CjtPfvcEIFYGO5wRuV2uBow6QepY8oge3/BlbqiYd0MKqfkEc1dOOvEVLQAxfx2edxHJdQK6ObnjPGf/WM7aXrSjg6zNPgCmfPryzH5I9yTyYFsMT0vQ+1Z4wsRDwACj3/sTU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aryabinin@virtuozzo.com; 
Received: from i7.sw.ru (185.231.240.5) by
 AM0PR08MB3251.eurprd08.prod.outlook.com (2603:10a6:208:5e::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.15; Thu, 6 Sep 2018 17:05:28 +0000
From:   Andrey Ryabinin <aryabinin@virtuozzo.com>
To:     Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Kyeongdon Kim <kyeongdon.kim@lge.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andrey Ryabinin <aryabinin@virtuozzo.com>
Subject: [PATCH] lib/test_kasan: Add tests for several string/memory API functions
Date:   Thu,  6 Sep 2018 20:05:34 +0300
Message-Id: <20180906170534.20726-2-aryabinin@virtuozzo.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180906170534.20726-1-aryabinin@virtuozzo.com>
References: <20180906170534.20726-1-aryabinin@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: HE1PR08CA0069.eurprd08.prod.outlook.com
 (2603:10a6:7:2a::40) To AM0PR08MB3251.eurprd08.prod.outlook.com
 (2603:10a6:208:5e::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 832f422e-9eb8-4e36-e433-08d6141af2f5
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:AM0PR08MB3251;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3251;3:sjM/uIHnD45nZNjgxMdVsrKh1Bzc9RbwthPfDPCe93Y3fhR+tjDDXF6CONMmTiqWEMK+mqWi7st5bjBLQlXD95x64cEGBAjXQCzU0CItKHLC/5OLJP7PtBk93F6I9PB49MKdMJO7mMu7gPRoiU5Xdk+Ag6fyblfl5jTOTKlJY+hpOpWiFLu/hszM06D8j7LdSuJRvpdgWk7EdqANwWx3ZOcHqoC32xReXRnhgrhiAlkQsxWRtL30PUdwJZ/0OZai;25:B+6X6GlY+NW2qWgnC25bsVHS75t6zdkyx5tfxm/+nSgnz4+0iicbWXwxkhVsY4OBy98lHKm3KTWQSxFk72Kj/7TFwtoePGLSnkKFkzjBLkuxCDMtf+nQfKa9tLQjO1jOKaOvw3/cGy82SSbZTJcw4IF8c05hSqEo+yDDuUQ0jZn3qe4YXNerzs/smuLlz4tzbSq0brdqfxKY3xHo/NAFfYAYUVcbag9yPZ0Nn1ybOWZ2mbwxVvoZ1vmppZWwEYRJ98wMJ6QUAZX5xpFJjGaQ/0WcxOEmpaTtyWjsMbWdJrHSqz1YVebJ8kcXxk/FkqE3mRXXYdWPEh6dMlxjyhhGlA==;31:yCmzt91ei6bZNGeajXygfGeCut6uV7RVANlQvGGh29zVaM/AWM8e9e1s1OdQSqqs9Y52ohw4bXfYwIzf7uEcqNtz2m25Gsn7Gxty8enMxmhJh1auj9RU5x/jKqiO9R2/lKzoDRsvzblrnqfBKGJJuGhi5I9qLpCg1fvzKH7+BYkb8PAc3hw5DE0dl35CfSBO68lkE7f9Rqeo63tkytERLPgkNwohp0O1Qci6EgtOea8=
X-MS-TrafficTypeDiagnostic: AM0PR08MB3251:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3251;20:h+ayTs0gMgQWH2ASz5IfIOqHTLLkW7hzrJJFfIdp+ge8uGbPk9/SyC1nuplu10pDzQGNhCIP7n/mYJ8L1kpUXMHTrdREuMPnHb6XyesbKgUHJbBfBLJM7UGPd0gUlswscjE/kKRqV/FMJIE70Dimq1BAoqNeiaTjhiSBTk7Wj3gbMmMl741JjvvnavzISLgZbTGopUqxDsNQgDnha3HxX5DKvNyKLya1B9+SSSKbd+Wn90xG5X3KF4DuGBZaCvzzk4efOdxgrF85He3PPqfpBFc6e1pspta2cQ15suiz+6JnjGdlKvgPK9JVBAsKpau5GXDcmIbwbTdWnt1Asi8zLGZ1fbHluXqL0I/HHu/PXu5M16SBkpDQRoqPqS8eVxQBa0ZrHEZwIfUA75shEse8r6jZyIRx1c3dwvusvRNL79f2gV/Ik/nTMGbqheqTx9R4zd3BN94j7GrNDjH8VtQow4llgA3rKapPGJuVw6zXF9sSIlR84NkWuXAx64vMneuU;4:XWUOn1AusS7xqEMwBWkLdXIfU5jdvzBDjYSMplR25kzU/3iccwMGniPKMc35ngkpbaKGnfk0Vv7bu5DKj4kddbFHUBn9oM+mJyhOBhTjK3trzzr89QlCBlskwlogjW/dx9mJgX6n4cLuJgf38asShS6WCyYGeZ4j+kATAB59lBP2nOm4WfGq7nshs5bOhdU9XiDWieTte1XWO8SoYzF7y1wJnkUpAPd9GM2nQ9tDJg6OJateWNKOHAs0UQMLRQLaHZewp1aW9aY4JthmDOSkMg==
X-Microsoft-Antispam-PRVS: <AM0PR08MB3251B42A2C6738F462CD1071B0010@AM0PR08MB3251.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:AM0PR08MB3251;BCL:0;PCL:0;RULEID:;SRVR:AM0PR08MB3251;
X-Forefront-PRVS: 0787459938
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(396003)(366004)(376002)(136003)(39850400004)(199004)(189003)(106356001)(6666003)(86362001)(97736004)(105586002)(81156014)(81166006)(47776003)(7736002)(7416002)(66066001)(14444005)(107886003)(5660300001)(305945005)(486006)(11346002)(1076002)(52116002)(53936002)(478600001)(4326008)(8676002)(956004)(476003)(2616005)(3846002)(6116002)(50466002)(446003)(1857600001)(53416004)(6512007)(51416003)(76176011)(386003)(16586007)(50226002)(110136005)(54906003)(8936002)(26005)(25786009)(316002)(6486002)(68736007)(2906002)(36756003)(16526019)(6506007)(186003)(48376002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM0PR08MB3251;H:i7.sw.ru;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM0PR08MB3251;23:7TrYZBVT3A++mVM81FDV+bxW42tnvjgomexF9fOwH?=
 =?us-ascii?Q?Cdkn8BLgeTM0Y50ZuQWUMhhBDU2h0pU82/vUiFz1zNHCNrW/Mv+o6g4UtExg?=
 =?us-ascii?Q?r6NVEVm5/rNkI3LZQoEXtiZpCJftnvP+tT3UdFEhRYbo8BYayz8q5KXKWPPb?=
 =?us-ascii?Q?JnQ0nr2cAMc5mIuE+fE4mQfsPrM6c22o+UqKRozM1LA3mMJffHHYzp3u/98B?=
 =?us-ascii?Q?xAxdMPMJ0e89BrAfB07SUIZkRP64kW38NEvpXTmVDxIPEohK8ahmnlTg5XYt?=
 =?us-ascii?Q?gGmoOW+IycLh32801R1ZDzh1xqjc1SMOtT7PGWUKtX4WO7NVwPpJcNt6CuEa?=
 =?us-ascii?Q?lajw9fGycDJAfJxTtR5HQG5fe7BBEPufjqcJQbtXFkGahaD07n6jDzOrwueF?=
 =?us-ascii?Q?6Aw1BTftzIQ0GMILklt+UqqOE21tkriYoXZNRwg7zi4BkGb5kfqy7M3oTkiS?=
 =?us-ascii?Q?ny+DmCOIDI8MI5SMGpT04F96/nVO6VD2Kljqv6JpXI8LpdFoEaZXTia1SAAE?=
 =?us-ascii?Q?AFXXIZnWgJdsY8NQGT8YrDVhfRAtrtrJfS4MAM1mmcx9vEUFpRX5xFKarTYc?=
 =?us-ascii?Q?Vy6psb25AnoERO1eYF3XuP0g5BwZnnbY8B7IpLW18s88aRdMWBqO37/Os6UI?=
 =?us-ascii?Q?ebFILrRx3FsbadEnw2oIIgKSLWF62V4BI/He2OTxCPw/S9nSkXNe6jPqgyZb?=
 =?us-ascii?Q?32ZKadkYW23pD/AoWltPQv6fmPDqO4HeGcsnynd2qajkC/4cAo747y2Iopey?=
 =?us-ascii?Q?aR3FKFNCbxkwHLjS3kB0h2AKbg9Ntasf2hkRBiabwjHnO3A/7AwLqnRELGno?=
 =?us-ascii?Q?f1OGIbJqOOSgj1QTGnXEW4g0I+kP2/7NXMlTRWSR6xRMGJb6hkSecXmZXpb3?=
 =?us-ascii?Q?wUAhndT0e6gJ4NwTX1ZV1fFBqEF1NCcNjonNvE1QNCX1FtC/mTArrPx+kfle?=
 =?us-ascii?Q?hXqRYuZMrVP/tmSq75/yMjfrnVL1DBvMG1KIQ87IkVQKTrDyy0QO4PfT/iyB?=
 =?us-ascii?Q?MnJFUnXn9H5jmlGt4pns0aJSq/i9WQkYS8SU9/h2ZVvw5s1mWPp2jmh2WYN7?=
 =?us-ascii?Q?uyCGsLny6nR/WF0DflpP6NnAc9SHTozem0hx95xES95iNHqrQhnUSXbpPS5a?=
 =?us-ascii?Q?V8Jsn+coQHWcOJ8fFGz4ANefuZaolhxZHSyP2LEo+4Dpj2JYKPJ3KLkRFfyq?=
 =?us-ascii?Q?1k/VwzQ78B3e334jJ3uuUFV0fL9vYf1KraWdHawJ2hZBk3B6K3dlc54+hDBs?=
 =?us-ascii?Q?3gQxIufmyMG6acJl0dIIe+VU+/XjUNbIo3wDwhtBH0D47W/t2f7erOXoXGky?=
 =?us-ascii?Q?w38VO+JehOeTZnmnubBifs=3D?=
X-Microsoft-Antispam-Message-Info: jZEWpXaRhzpdY7lU+S1QZhGAUJZmDikn2FfZwlVlx9Ad27+DAUrOLb2kZuQ/ukuobWBEifVAy1YSowFRx6YsnbMK44Z0LZKYn4gNlH7xl1TYIcBGkZeQzIL2gxj6SDZpXIzLVOtVE54koK2ZskFhCeNfierRsTD+EhAeGCbBMo5sBusVoJwGG9zFRgFQKHHbrrZJxU2kVyokLlPSJWhM17FPrqf+vLEnavIZx58Fciyd4QFo92+qx5ZD1I+bwcxWPDhVstcCvOtqAPl5b49IMNUgraY9eR1JJD5wLW8o4sbHMOYE4ecz/lltF4HfcqiM9jRMh1RQE3bfQGDaLRBqAo3Z2/hHaHuUPbkA5M71EKM=
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3251;6:EcnWyiw7qf7fhRk9hru9ctoJ0U4qjsKorWYk77nk3lcYZjpk+JEUBe1et98EwmqDBcbmbmvCcVjUFgmFRNGxXFI6syqv8VXLQgNwrATki2S8K+83GqmPRkaMdDxTW2e64xg3fYBa33CetiskVDrxWG/+jdESck1i5VG5F2v14nm4vmpqnoXvuyu1u1YPUjaOxZiWX7fh1jYaRQcziBCct4R5oE0IoX/jeJAQex6CFha34uZUoULQHmPsfzh6NrouMmneZ0mVsAG6ERzu8maruxIRgUlHtNhBLZkp6Y5JhOrfkcndM/wXVSqWwJRufB6/KfYqoEzv95j/ra08MfQg0zATMt7TJ5QgNvZ4lCyNVW0LYBlqFnfBP0PGXtl0ViWTrbrwwTTgu3G8bwaZNfZNopBuR1TbULghzvk6vAebJU37NM5N30l588S0hZ4OCLOeLR328ij45vvDn1BEj7GrIg==;5:BhYPXdwlFYCiRRW7SH08jRsxtve1xEzyDLodLo19/XvuDRjMl4myfcl10bgfhEUWvSKXnd75jApXWy82bTMvoWCAnuyZ7OlKeszxIxGRLJX+D4p04WjIIugxMm6UW4SJJbrK46O3U+h8WfyK3GfwUP8D9fSQ+5vUjB3rLugX2zM=;7:svtT4wJUGH+/zBLwhNSM3WijUrr4jV1Gq6q7E72zBwzRZjW3sL8aDy0hHVHd+hgzK08IfJpQXek1j+LZDqGTwgth7ogUeNtMs8tImHihu+oAAwAsruDYqVEcWjPC3kDEnXLvPMo9BLaurKWcGeH+W2+Md6GQiJCDqaeFuIDx+foduxK0ES8HG3Sh1XgVaizQYXsmcQZu4JllE2MdmFC4W8BxknLilk3rwfQr6irphGtl6IwLnzIlN6V97EamfLB2
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3251;20:2x7XZhd8POpPp8qPi3NkgQSfpT/rw/oKkBzURqRcunwL+uNRUngQx7GLKGdrKurawhqKTv94K4pC86/fB2tKgxdI7oq34iLBy21CUwnBFRshJCmtYeh0Upy7lVxh4EpPhn3c2ntrEwXRlQiawjJdf027KprRNIfaKhTgFG/qsno=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2018 17:05:28.6941 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 832f422e-9eb8-4e36-e433-08d6141af2f5
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3251
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arch code may have asm implementation of string/memory API functions
instead of using generic one from lib/string.c. KASAN don't see
memory accesses in asm code, thus can miss many bugs.

E.g. on ARM64 KASAN don't see bugs in memchr(), memcmp(), str[r]chr(),
str[n]cmp(), str[n]len(). Add tests for these functions to be sure
that we notice the problem on other architectures.

Signed-off-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
---
 lib/test_kasan.c | 70 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/lib/test_kasan.c b/lib/test_kasan.c
index ec657105edbf..51b78405bf24 100644
--- a/lib/test_kasan.c
+++ b/lib/test_kasan.c
@@ -579,6 +579,73 @@ static noinline void __init kmem_cache_invalid_free(void)
 	kmem_cache_destroy(cache);
 }
 
+static noinline void __init kasan_memchr(void)
+{
+	char *ptr;
+	size_t size = 24;
+
+	pr_info("out-of-bounds in memchr\n");
+	ptr = kmalloc(size, GFP_KERNEL | __GFP_ZERO);
+	if (!ptr)
+		return;
+
+	memchr(ptr, '1', size + 1);
+	kfree(ptr);
+}
+
+static noinline void __init kasan_memcmp(void)
+{
+	char *ptr;
+	size_t size = 24;
+	int arr[9];
+
+	pr_info("out-of-bounds in memcmp\n");
+	ptr = kmalloc(size, GFP_KERNEL | __GFP_ZERO);
+	if (!ptr)
+		return;
+
+	memset(arr, 0, sizeof(arr));
+	memcmp(ptr, arr, size+1);
+	kfree(ptr);
+}
+
+static noinline void __init kasan_strings(void)
+{
+	char *ptr;
+	size_t size = 24;
+
+	pr_info("use-after-free in strchr\n");
+	ptr = kmalloc(size, GFP_KERNEL | __GFP_ZERO);
+	if (!ptr)
+		return;
+
+	kfree(ptr);
+
+	/*
+	 * Try to cause only 1 invalid access (less spam in dmesg).
+	 * For that we need ptr to point to zeroed byte.
+	 * Skip metadata that could be stored in freed object so ptr
+	 * will likely point to zeroed byte.
+	 */
+	ptr += 16;
+	strchr(ptr, '1');
+
+	pr_info("use-after-free in strrchr\n");
+	strrchr(ptr, '1');
+
+	pr_info("use-after-free in strcmp\n");
+	strcmp(ptr, "2");
+
+	pr_info("use-after-free in strncmp\n");
+	strncmp(ptr, "2", 1);
+
+	pr_info("use-after-free in strlen\n");
+	strlen(ptr);
+
+	pr_info("use-after-free in strnlen\n");
+	strnlen(ptr, 1);
+}
+
 static int __init kmalloc_tests_init(void)
 {
 	/*
@@ -618,6 +685,9 @@ static int __init kmalloc_tests_init(void)
 	use_after_scope_test();
 	kmem_cache_double_free();
 	kmem_cache_invalid_free();
+	kasan_memchr();
+	kasan_memcmp();
+	kasan_strings();
 
 	kasan_restore_multi_shot(multishot);
 
-- 
2.16.4

