Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6996C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 13:56:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 591F12152A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 13:56:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="YJ1BaxZI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 591F12152A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732920AbeITTkG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 15:40:06 -0400
Received: from mail-ve1eur01on0131.outbound.protection.outlook.com ([104.47.1.131]:6684
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731223AbeITTkF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 15:40:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XlYm+3iE/PMapwymuU7ypiGUKr2ts7a8XIdUgdN5gzs=;
 b=YJ1BaxZIKZmQuRUoD8O50+wi1ccFRIUg49Yz5HPE6xoySgz19OPyK8CF9zezdCV4enY5ilt3qa/KlyCuyLbFcJ6+lq8zzCN7WGf8FmMlhHINHMggpxSlHMmAGLtEjW9v4G1KFMuBF3pq5l7yi2EEmUCOTA0qSGAvbNu/b9/OyoQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aryabinin@virtuozzo.com; 
Received: from i7.sw.ru (185.231.240.5) by
 VI1PR08MB3264.eurprd08.prod.outlook.com (2603:10a6:803:3d::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.17; Thu, 20 Sep 2018 13:56:22 +0000
From:   Andrey Ryabinin <aryabinin@virtuozzo.com>
To:     Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Kyeongdon Kim <kyeongdon.kim@lge.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>
Subject: [PATCH v2 3/3] lib/test_kasan: Add tests for several string/memory API functions
Date:   Thu, 20 Sep 2018 16:56:31 +0300
Message-Id: <20180920135631.23833-3-aryabinin@virtuozzo.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180920135631.23833-1-aryabinin@virtuozzo.com>
References: <20180914152800.GB6236@arm.com>
 <20180920135631.23833-1-aryabinin@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: HE1PR0301CA0004.eurprd03.prod.outlook.com
 (2603:10a6:3:76::14) To VI1PR08MB3264.eurprd08.prod.outlook.com
 (2603:10a6:803:3d::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fda58248-52c8-4843-dffa-08d61f00d9e2
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR08MB3264;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3264;3:F4gHzjgawxaNH2SFRlcVgA+WHmdddJ+YVAAWeHecQEDoOhLB5EMVrtFRp8eCpOnIIbZgrA3c0RmfNCJhm1oJtBShvNi08yKgi60BPNee3iY5TXyYh3rVkL7F5LCK99v16nKW8eJ4qUBqVRkd3X217IIrez6vX1jKSZVePK4kHkbLM9VwDSg5feE4Z5YaJbdDWrniPDdL1CeLjIYHjICurcIfIm0yHV2wX8cktobhzIiBy1iJ2zghePbDkMUvS6z1;25:RhgJ7SZtBIvqKKCBMXszSOQswjh4twYyJZMm7OaUuxDSGcidOi/b+MJXPUwKsiwn6LhoGl/rO/1+3snSAyVZQz2HkujLUevUhgOESEZs35ZqDpPUUkpGKPTKFF9K63BNhN4fnkwZpFYiwMeJaYcPMoMzrou3MEGqcrIk0XpXwDi+uD1jfKZwVQWAzlQw0344WHikoXezo25MWgpFYY6Ir7YQl08RCf+VYq8mliG9aoh/mHt4mzgO67OSFF8i9hAsGq85sn1QFpVlbP9B3G409b7H3C6MEOou1WdCkyqugEE/Gx7T3wM0vh61REfE13dlt3QmVwvNSWcvXVpFsVHbjA==;31:KQL5KSq31tQV7jbIA3+Qqty1SntPBnbM/RyOXsBg/GT8HIvKmRCwa9Ze5y6Wdj4xf9UCYr2I/fuLpr3z2bgkSrDaN3NFYFUqmqOG2MSaVoIDIix6fGlKKVcxsscFJXjv4r+HUyDqLpTwFtxunIRoRQP7GkSeN+CmkB0hLMdz4U6aerIHTjb0WnFeuNHZtVdXSngRkUgm1wsOUiu41Cg3v5HWL6AJgl3H04mQUvvUywM=
X-MS-TrafficTypeDiagnostic: VI1PR08MB3264:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3264;20:UOgj79MHU6/KQdPMPtrKKlwHRqgD7qIlQjIK/0468XQm16QOoi67zQsyCZS59qiBmlxx+I/Ocmu6sUyZDRRLqTucQ7/mYWVcM/LoD1TO8QIN4dTP2yHC53fBlGCjnDH27M+k5gkkeBQ5azadciQhtoVKVyU5+d87HFZi/5R1ErGl3hLDtYLqHnnz9usXVP6A9DboVR3XsMCL4JP/Gidq0orlONUAIWvnpRht3xOAcmhAH3hMf5ReS9wsvlxlhHXBBZeEOStM8NVBmVYDVQX8wHAAc5+VcSaDIAojN3F2bKKWrnJGo8Z+Ox39qvGd0faB+3gfVeQ6MkIRXhIyZhbmJ9IioYo7SbA8vzGv+y44oR1aRgEKqGlrzDs+DXo9nYP/FMcy5sWJRoKYRZEIzQ0ohkitslm+bN4OPCnZi8pHd5cmo/97fHn6t2w3zv7qAUoLOKOZ8rIQyWkCEgchW6ke1TTDzcZ6kvAda04HRm7sX0k5deK2+h0WMbF6TvHZ4733;4:lEr3P9Ms5iA5e2vUVoU6GXi7/3ddmptwUNlACjB0qmvg9Dug8nBkfagceds09UxMDCxf6OblTlj4oiMH43lg28E1kDYAj2sWZw495S/pCQtnM5BeMES8AoAIj2ITlySLuFRs1AL9uLAnOcKoecChW3d5l0MbgGmUb/56xWl7yqmRGHd24WWBWxAiHteY3jJImXb4zHIP+gljTrURkwf6hQgGMYhWN0hnUUIs0kp7TaMdUukUsTzh8oMIXZ3JLEYMOlUAC+64+Rhol9QHJS9Shg==
X-Microsoft-Antispam-PRVS: <VI1PR08MB3264F2BA47DE3688F1DE1D42B0130@VI1PR08MB3264.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231355)(944501410)(52105095)(3002001)(10201501046)(149027)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699051);SRVR:VI1PR08MB3264;BCL:0;PCL:0;RULEID:;SRVR:VI1PR08MB3264;
X-Forefront-PRVS: 0801F2E62B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(979002)(39850400004)(396003)(136003)(376002)(366004)(346002)(189003)(199004)(68736007)(52116002)(7416002)(7736002)(956004)(6512007)(11346002)(50226002)(446003)(386003)(6506007)(1076002)(6116002)(8936002)(476003)(50466002)(16526019)(486006)(97736004)(478600001)(186003)(8676002)(53936002)(48376002)(86362001)(2616005)(26005)(4326008)(107886003)(81156014)(106356001)(2906002)(105586002)(305945005)(5660300001)(6486002)(316002)(6666003)(51416003)(53416004)(16586007)(110136005)(81166006)(76176011)(36756003)(66066001)(14444005)(3846002)(25786009)(54906003)(47776003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR08MB3264;H:i7.sw.ru;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR08MB3264;23:fwLF2pJ15qu2p0J2JveRrOBWgZI2qW+iFTRbBr48l?=
 =?us-ascii?Q?JI8zaLdXbE45fMHWq9TlmylZtQD7e3IdeQW1ev5LawN2x2Imi63XXOYsQA8I?=
 =?us-ascii?Q?YaEzxVUmmIgKeKFCnr8pQuvU3C15FRpwIawqkG/b6aY0zFnfj3RwiugOrNDS?=
 =?us-ascii?Q?e4WnV7zcj10woI0d+/6ngrvBqzPZnBpqdsVzOTlzAFmQzX1LArTV2YWG4FX1?=
 =?us-ascii?Q?2VkSfqvSMjbrYzJ51fuXdwvr9yNaM/zBYJaEtzXy2O7XGInEm0IQsSZHDIp0?=
 =?us-ascii?Q?VH5wdQMA0JjOUIGnbWlUB2m6PxhzPhW6uSxQtJmGwOhnkLjgzxFw5vA/yfy5?=
 =?us-ascii?Q?WyOIf5tTuiqUeSbLxj+KBxWrlfHx5ClTIu2zD8Nhz9kUK665WTGcuPx7PCAs?=
 =?us-ascii?Q?tSodZAmVVTG3vE8A0D8kvtGJxKgG3vB54CU7W4niB5SExHfKOKgEhKlVXa0N?=
 =?us-ascii?Q?mb/KEw9WY4IqJUo//C0MweMbf4xLnbXx5vW7Or1ta5wfjzq2F+BQf4jc25+k?=
 =?us-ascii?Q?TcnN4hG/QltL3UCliXKXK08csZPYR1/s0tBKAsNa3042XSltgTOvWEwUIJqA?=
 =?us-ascii?Q?9V0OvpqWsCguVrQQzPky1K7KPv/tgXEPFvqkQ6qXbWrUs6CHqVJMoYlapb6t?=
 =?us-ascii?Q?fp/LBjyy8tX5K2vxR5IPraK9YYxGRuT11NwTxN8cMgWvyxb37b/62jLVeu8j?=
 =?us-ascii?Q?lKq6pHUTKs4Wyq/utrH/nEvSiNJYh+ZKDp5Pn5XKCSOHPv5oXN/gqBEWExdf?=
 =?us-ascii?Q?WlgjP4/XqpB1lwVCQWgIPMxxV7FgQUh88BXq5U09NBylayUrnghbxcSerzXv?=
 =?us-ascii?Q?SsI0XMhsOcS+YIUvCT2GtZ+jMDgCP+TrgEIyGIN9zpMClOu1N6/pYq6sexJi?=
 =?us-ascii?Q?P5/VOFycqpTSbDxX86oaHwno8pYcDwotrQqderOl78EmIBKTOHDnK3clJP7f?=
 =?us-ascii?Q?s0xGDzul/BgKMNJMIXukw/kZU4wSGmSO8UKYwUTn/5q1IvcydyBI70tqj9cJ?=
 =?us-ascii?Q?IDaKCiqx4ms0bynndENLnmZEphIWlcUppEHQK694u3nUf61QsObV9smbzN9r?=
 =?us-ascii?Q?codbKSzVbz2G3zh8Cxjq9fN+A67MSNU8Zd7dAG0m2iJx3WwbCENVabUindss?=
 =?us-ascii?Q?H6WykhkWwRnq4lHHplQ52PlLk2j4ZD7ELjs3T3jN6l2imRqDo1RVUMCsbOka?=
 =?us-ascii?Q?tz5Qs/51kTBpIZUtX3efQOXAFsQpLqFKvDC58hjKZN/9OJjamN4bN5+EbQ0f?=
 =?us-ascii?Q?4g/dBuKmMNbG78TFd8cwNl7eSFqmn9cINjGBzjEiV/B7xJfXj1Lw0ynA9nGs?=
 =?us-ascii?Q?ED0gyuEweqx/bYljlCuGU4hGF0AcyCM7CcxNvglDUqrWdSsv1ViWKFAwh1zS?=
 =?us-ascii?Q?KqtEcjK/4rWSioofl+e5UPqTFA=3D?=
X-Microsoft-Antispam-Message-Info: M49G9z4Dxc3Hx9b6sGzwkLeynA6tTn8PWFHlEoOIiSj4p2R94ZwdjNiY9NjFs0uScmJJbs4vEE5aeXDzfi+80d3aUQU1joNMlPIuLOws3Svd0LttNYvRMBvIO8ViIJ4Rypv1LiPpNPDG15dP9+frR+t1Vz/fEt5q2WC8kxcLDqN/uAePrfxZ7mTIi0t7F74qycy/eVOWN24PHcH7gL+J8QNoYga7nUJpiO5fKUtZn9dV4TlEAUi9mavXsO3V85+OmQMY4bHelhQknNrTDICbT2NxwQgQZSvUpiy2nw0GW0vLQCHMrSys8XeBGOK5ay+YMo9N5LGIV+7km47+70sOpCLeSnYtX8NRrDa16wtdN5E=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3264;6:sxGBgtXsQR2PZn/7bFIYTeulIVGhWrkU2x4RQrSjJmN9g3UprV0RZB1RFN1P21AdeyQRugxijA/ar/u02j0DufPE/mux7wJ+EoL4p32fHLLv18U4jkj7PHtt3XXEhbCGA1prOfeMfolyaR5JHPxysWrFkxZyoNmtdiZxdUcuw9gGfMeA9wjs4mJ4TaIGIA4/jpEYg65SetXAejzGO8+iuOkT/uhwc9t5b1RkkN8/imvBYGO+LWbPYv9z13YGW92rCh9WPGVSqX3wiLO8qyAy7/vcDIVPL325v6y9dMNad8akhiOXJ+xtLHyjUOQOvulbHI/h3b8irU3wKRLLEL0foCpNXJRISvgevIXeTvXAH+3+rVrj3YrI6hiyBjn8x7bvTrw8i+kj4FTPOnDBdZuLoEoChCW2QfsA256CmcEBWpntW9kv9G/jSJg/PznYrusStThlLV3MjHTs3Hfg9k6b2Q==;5:B0C/mh4iVfTMShZ3iXp6D+RUrtHlKyZDqU+NO3EJBq1upeFZWmiyLK8RFUqj4e7mINNQ9yFOBMgyZtl2V6e10XG9qemEcdlVil8FMooDhIFwmbD2wkpgp+YhUTgJqFrzd3WV2+hZ3+WWvJFh44rmqzOGv7+/G1ZtxdfM7ff16RQ=;7:/aVZfv40hilcoI8OjqtZ7S6Pyd0OejVmbaQF0W0NC6SOdXYHdAhjyJbqpPYZuDYZMtQTfiAUL7ZFzuKYynQ8Hb8vTIuxm8GmXWsBvMUxtI2T0lbOErZePGaf1mfM0mX2Hc7qIYauqFeB34eCY+wiQsn14Jh7TGIFuzPhWAkMMTiI37qBUjeI3BpbN26WAEoG7x1J7/2Fwl9Q07GWHzRfgTHGj23ZY3cApf91ZMV1RXhnBUkO9pAat1ty8566qGW7
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3264;20:SeR0VJrF/KfUSNYERUmvwC4089kUh9EwUxLYUw/hGS+7Vbptu/ejFXa1/vW7iggUqAipXg3xyT/xBsdDNXZ9Hvqe7RV+MeG8qh41AA4fDsQTuPN+sqcGzoES5Y6Tuz57Q7Jptysffifmr1PszxTOMkIxQzFV4cHG83s4UaX8J8g=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2018 13:56:22.2871 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fda58248-52c8-4843-dffa-08d61f00d9e2
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3264
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

 No changes since v1.

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

