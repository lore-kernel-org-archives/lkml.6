Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 144A6C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 17:05:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5D7A20652
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 17:05:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Ycudg3Pn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5D7A20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729959AbeIFVmP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 17:42:15 -0400
Received: from mail-eopbgr50104.outbound.protection.outlook.com ([40.107.5.104]:55375
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727770AbeIFVmP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 17:42:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fDK8vb3aDvLAfp5YL8K3dvsDEUJOmmgCWIugaKbfPng=;
 b=Ycudg3Pnewx7OucEzbGcTRMpj3+f27h2c237XE92DNrQPkcxuiibtjxqxsHZ9mJ2c4vKqi6c+z6YUZhj2tergqEygCseCNekAe0N1nGoKkNmUKgnRt9r2XHftbhD0/lbRplm6F9iafbSaiDtyQ6UAXajiGlhR1FCt3ypx3tYVaE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aryabinin@virtuozzo.com; 
Received: from i7.sw.ru (185.231.240.5) by
 AM0PR08MB3251.eurprd08.prod.outlook.com (2603:10a6:208:5e::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.15; Thu, 6 Sep 2018 17:05:27 +0000
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
Subject: [PATCH] arm64: lib: use C string functions with KASAN enabled.
Date:   Thu,  6 Sep 2018 20:05:33 +0300
Message-Id: <20180906170534.20726-1-aryabinin@virtuozzo.com>
X-Mailer: git-send-email 2.16.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: HE1PR08CA0069.eurprd08.prod.outlook.com
 (2603:10a6:7:2a::40) To AM0PR08MB3251.eurprd08.prod.outlook.com
 (2603:10a6:208:5e::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 709009f9-699a-40a2-14f1-08d6141af224
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:AM0PR08MB3251;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3251;3:JeYHk6PqtokPojOcotD27q02QxYbuYcUocUESBZkFs70cjQTGpJRJZp1XnkfxhBGC4Ws3iRAgTXuJ6jFDxeC4gZxe7OIb2RSZBx85avLGZhpZAnUf26DSbVyzPG3S10p09oBQHmRcJwyWp0WjGTBtbUOMw2/ZrpxxJ9NofieJsymb7JQtUiE0cM1oONo2yj81+1+CaS5P00r83mr+KcJfn9hkbJwuRvcr9JcLqLHcNded3A+yPs+pnrCZYwjoHre;25:B2X0yx6RCms3CtHGX3Ou8jVT2nqloS+p+jH+hHYr+E3Kq2kBbV+XinJfbYfbeXOoYdDheipKvc1+tSCBom5cr1gMiasIce/+MKgM2lwvMiokCkYtyFM8Itdpg3aWsyzygdqu2ZrMadtPYNcmU+1mycVOHIlswb/nqKghpzwyCBSiLai8SzSoyUjKp0zHLEePDE+T4n1nDgNMqVD9zbqN3wUkZudjuS/xbUJ1Elv5d9QBcOUgW5IdZXFEQ+StZsBawt5ianuEPfyzvjVOD2+mlXWWlSpTuelDXj1BEChmtD+5MpX+jXVPzWym5L5AusHBtDQ2L/CdYkIP1QAdpxVADA==;31:CD2tY5vUxx2Qrf21lG0lPX4eoQp+9QvvCCk+yU/IQN4Oz8IOycfw7qx9SZSFYgrm/njHQ/6kSSiLNlQaVrRQyu0I5q0QH57v+6GdevgGSF79ksilzACeAgKYfxHFrqOondNUZm7KCT/DePvVobVXzVF3iquwNYbtLHtoKhfb0BLvwyv5As9+TXKLq95H7+MYk5nzf96JRaU3GM46aNtx4Q0JY3saLb7y82EJ659/1Xg=
X-MS-TrafficTypeDiagnostic: AM0PR08MB3251:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3251;20:Ewbo3TVUczhNMbk2inferGEGCBTWObgeoiiLQ1dTwfGU2E6YpO/o5nTnNcv9QOH4s3yGMP23a1t3HuxiOrLVFV5mz/WOipxu6auXsKH8vBx61k8RF7FiEGhDD3IrMkWx48uie7QCo5ZHJaLNkp0OQIlIIQ6Gk/fFSrSp/+LLETG1uaLuxcu9BhS3BQ5foFnjY3/kfGlWspLVyLQFETGdrEd0iqA7ieoIOlooUiekmT1xy1jjelLI3EnAHWEM9bK8at4FQohmfu+Kx4FhLcUCsKeBb7M3qUPJkK+RGq7Uapg00Zs/3dKS5ads7JP/oBTM/nkFAQJfZcmeAKwE12FPJmyjW8F0nPfPkZ8O3A5k1sCrrd0JrJh6yaZoIA1kUbgoOaRnfWM9NufXnPHXgb1BdMx6nyNiW3JMNAE3KH81A8315Hg4QeSuK99Vd7kRFn5jVH4ZNAQRkcuzVqNyeeI7D+mq5ODPfjJwQpVO6qbTG04etKvG0JtJua8U153stfyO;4:Y6CeJ3UXIkvkclTOIw/ekCfM2z9x5i10iE37lCMgJR2NkTW5BjLOjlw1Yf3YhWUpDrI4MeebZjQwnZJJHTv67XITHpc2Zl9hRX99IWEuNgo7UAvCltUeGqunRQnIZoqHJFuZw8Q7ftE5jHI0ndSUOLH+kHSGlzUtgKfI6288xlrUbupLCmTu+wm8S5rHxq+wCi7eNhe7LIlwbcr25Nl0w3iG3ZNgYl5oX7jYIIqiu/rCEwDBx7xckhbiU9a6VKIPQ9H8ASHa58Sqq3eCgY6+gg==
X-Microsoft-Antispam-PRVS: <AM0PR08MB325169D5E111A60C86F15A9AB0010@AM0PR08MB3251.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:AM0PR08MB3251;BCL:0;PCL:0;RULEID:;SRVR:AM0PR08MB3251;
X-Forefront-PRVS: 0787459938
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(396003)(366004)(376002)(136003)(39850400004)(199004)(189003)(575784001)(106356001)(6666003)(86362001)(97736004)(105586002)(81156014)(81166006)(47776003)(7736002)(7416002)(66066001)(14444005)(107886003)(5660300001)(305945005)(486006)(1076002)(52116002)(53936002)(478600001)(4326008)(8676002)(956004)(476003)(2616005)(3846002)(6116002)(50466002)(1857600001)(53416004)(6512007)(51416003)(386003)(16586007)(50226002)(110136005)(54906003)(8936002)(26005)(25786009)(316002)(6486002)(68736007)(2906002)(36756003)(16526019)(6506007)(186003)(48376002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM0PR08MB3251;H:i7.sw.ru;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM0PR08MB3251;23:A7rzFuFrJWZ/ZpHy0elzohPrH70D4saBhPezBg5yA?=
 =?us-ascii?Q?tFu1bAgbgSSz9drvANZFRz/Y3xgH4hoOPe6NqH6LpNKw/LPMc+zON0NoDIVO?=
 =?us-ascii?Q?PBESbhTVZ9vL9dypyxSOjZzy3Gx3m/AoH2XuQGqEuIEGoTvpyje4wg18Q4pN?=
 =?us-ascii?Q?ahEKbJNajK8BwWbYqwmIyCI8Ar0NEIM2j8IQ18dV3YpG6Gamp6UDs3KR7BLC?=
 =?us-ascii?Q?ihMeM+1T1lqsS0FraHRYbmwTVbUqgCpYYehKGbs93lLtSES1SesRkdJnX6aU?=
 =?us-ascii?Q?LBUhRyM1YY5JXhkpLoTjGX7cfLb6kKhzC+DI0gzR62oflcmP2Y97bBSyYPbo?=
 =?us-ascii?Q?KYpg4f164p/1mUe0AJw8M19gyTZ8G8IfIkSZdbc2/XfnvZWeRwzC61rXm4Hm?=
 =?us-ascii?Q?ub7Gcil2P1qZ+ykKokufoqaPzy5UJ3zbgVaKI1RyL8FafU54EWOaTEom+A9c?=
 =?us-ascii?Q?3ksC3/SDXb8nn9TGkL0KQ2h/KjiRCCiRFQ/gLyVMzwGN2t29eNHik+E95FLD?=
 =?us-ascii?Q?MYWAFkQotLzwXaPb8uYDKAx8gK/jwKEud1oKImSmuvfhx17cTznQXLu/uZZo?=
 =?us-ascii?Q?eLPVMOgcYmaPqglwcJ+vNFVGTfBGZvcaSubviQmrw8CV5eXDMANenwzpR4wK?=
 =?us-ascii?Q?T+hhjG6akkdkxxLvt07+wwNc7It1e45hDqLmZkMouX5Gi5ChaiExQyzRxojm?=
 =?us-ascii?Q?WbQGGhB/lqOmWbgWAgs7JEV0zLgu2WFgK0u+VyTq3L+ykc1JFrSyWfW75u6+?=
 =?us-ascii?Q?oloKuLt7DTkhAY7QDZLWghoGM4oi+LgoG4+L7YEVaFCtL0DDhbsIff8NEn87?=
 =?us-ascii?Q?bY2+5CYUYv3a5g3rrFCbNJxzZ9Y+YXjYvkYvOIEYboo5afZkPUVOJCqkQP2F?=
 =?us-ascii?Q?0fTqdRyHR0JTbgxh3ytzHTAMQUK0DZuF4J03LfNCDvkfq2LM/Pmd++Xuh3/X?=
 =?us-ascii?Q?4BF5QXeSO/andabj5hzo0mzH/AKy+4kLTcpeseT0G5ShLOO+MbVr0RXyUUDj?=
 =?us-ascii?Q?5AHimXNbuIOZMmpYqwGOOEuLPSlSLuV9uWn12D9HE0KlOWwjBxgNZ2xFRYb3?=
 =?us-ascii?Q?YC1Rd0l8dKGG38iKGWSnerMj4BOHtN8CoQu+PHgdH2vfRxmVCGRkFLo8fX8Q?=
 =?us-ascii?Q?uJEzr84LWKiN2zqERLa9vSuCUzh07Mxq29fj2vWTtZisraE6DSeeB4zK7765?=
 =?us-ascii?Q?ARFizbnWi8rwRSSEFRhhu6mA7Zb4QQECUFiMBQa54DaUF1NyU8mLEugx0xRI?=
 =?us-ascii?Q?g9sZPOcQOKcc2DadKKHU9iZGW3eK4eG8fYuYH+HJBs8aoxTwntv0uY/z3bTd?=
 =?us-ascii?B?UT09?=
X-Microsoft-Antispam-Message-Info: ndQ+l+U2BUN0YvGalHqYt0ewwIujMjBRa7zmq6rOvCJ7EB+f63G7nr6uveXHviELHIfLY08BiFmSrujO/hOc+m4RU63Nf7TShqwVZXuAkrMv7C2ggsP+5I7qXElJ/R6Iyc6kjaU0WScvjSKvLsqY0LoCKm/cEnrKhSICq3IwvWJGpyF6tOOm0Fm+4ODuWCf0yIcF0PUGi1IPJTJ0Z+1W/6kmhG23eYiwt5WSDU3LF63SxtkQiryCnBcPWlRjVL5R89jOyHCDPM5EvUVVdo2MKdVNu3dL+egKjPLJfEAXG9VinAbaujWEzGMH7h3km973DvOmHZhcX9gk3ClOQWZMnWFHaISdnySvSxOP+Qspzaw=
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3251;6:JAW0wBUCY3pKg25HvK+Z2KUi52yXbGiClkfc6DQLzxWiD8DE9BbyD8ZxwefeAMuDTQkznPsy2qObP9AXaBx1vl7m6TiVRRalZqoB/kvLGAFAxU+gcyUZUSznChaFeASOYV8rJ37WBwvT0qVZQSFtv7kX51FeTBNmfLOOkaehzhBhmmVU9DX5ZtBEmKy0DI8LYp7e4mp0JaB7gRBzVrcYEB0ugqVcoxFt0BDmbQbEXk1KB3x+mymz89YqPgznrbS5HxBtPG0/SgJJH5jGE4lMZFXdJQqc4YO9aUEndXo7ouhr9D6Iyj6bIDx+96yhscGIJgTeeGWM+xMhg/iePCu3QbBJbHFPea8BRfU3KgXdNbpwGuuvvBFR7RjN/aFlatusj8LV8W7/4gvmy1RkG5ItZbfg6+NpIw3VsYrnldpECe2XSteYM2zQdvE9VVpWEGSM1l6Mdki4v7qIYw37EWt9og==;5:Kxb6l1q0RvlxMM1QOo0zmuIlMPO1Y8zLlBC0gNsg+g1aNYP9/1IP0aJllV5m7lz9UwMfbK1WI4GzwFMK82deaTsOuBDWe8WdMS/Rg2WfsrKy2g4UEMny8Q1tfTbwYxXq03UiXvuP3RRJtS/LPJrQ3gfWBnj7Vwf/F+A4LvxS7Ek=;7:rq6irxp/W6suWokpN3FtemHdHPX7PtBQJOO0D0JkgxRs8p6RrXz7LSUiFFc1LtogSq6sCgnsGDNbbSYHvlkqIgDHLtdA8cad74KrudJ9E6NP6koXrv2doNqZQhYtPoyIYnYhrmY+gvKrfO7No1w/chw2nQuB50nfWje8RtTBgmjfoHq8yYsZrWHm8osUUIt/X8FLQ0a8DidiM31GrCnMgCr6idfjxhMsHgo74pAb28AJhyzza57Opl1+IoixXEa5
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3251;20:QseaH3Kap/A+hp39o1Pr+hlVRRKuYa9OkTRHXQS4kyfElzQ5uTPA3Nx69dHVNy9DW693diiwr+dfpZQpktd0GYh0vlZ9TCRewYuDnAZuSEU5neWxCp6ldI7YpdeM1KUUOqcUVEJb2FGnzleCggx+aJKaThnkRApCzXKL5DiySAU=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2018 17:05:27.3191 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 709009f9-699a-40a2-14f1-08d6141af224
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3251
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ARM64 has asm implementations of memchr(), memcmp(), str[r]chr(),
str[n]cmp(), str[n]len(). KASAN don't see memory accesses in asm
code, thus it can potentially miss many bugs.

Ifdef out __HAVE_ARCH_* defines of these functions when KASAN is
enabled, so the generic implementations from lib/string.c will be used.

Declare asm functions as weak instead of removing them because they
still can be used by efistub.

Reported-by: Kyeongdon Kim <kyeongdon.kim@lge.com>
Signed-off-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
---
 arch/arm64/include/asm/string.h | 14 ++++++++------
 arch/arm64/kernel/arm64ksyms.c  |  7 +++++--
 arch/arm64/lib/memchr.S         |  1 +
 arch/arm64/lib/memcmp.S         |  1 +
 arch/arm64/lib/strchr.S         |  1 +
 arch/arm64/lib/strcmp.S         |  1 +
 arch/arm64/lib/strlen.S         |  1 +
 arch/arm64/lib/strncmp.S        |  1 +
 arch/arm64/lib/strnlen.S        |  1 +
 arch/arm64/lib/strrchr.S        |  1 +
 10 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/include/asm/string.h b/arch/arm64/include/asm/string.h
index dd95d33a5bd5..03a6c256b7ec 100644
--- a/arch/arm64/include/asm/string.h
+++ b/arch/arm64/include/asm/string.h
@@ -16,6 +16,7 @@
 #ifndef __ASM_STRING_H
 #define __ASM_STRING_H
 
+#ifndef CONFIG_KASAN
 #define __HAVE_ARCH_STRRCHR
 extern char *strrchr(const char *, int c);
 
@@ -34,6 +35,13 @@ extern __kernel_size_t strlen(const char *);
 #define __HAVE_ARCH_STRNLEN
 extern __kernel_size_t strnlen(const char *, __kernel_size_t);
 
+#define __HAVE_ARCH_MEMCMP
+extern int memcmp(const void *, const void *, size_t);
+
+#define __HAVE_ARCH_MEMCHR
+extern void *memchr(const void *, int, __kernel_size_t);
+#endif
+
 #define __HAVE_ARCH_MEMCPY
 extern void *memcpy(void *, const void *, __kernel_size_t);
 extern void *__memcpy(void *, const void *, __kernel_size_t);
@@ -42,16 +50,10 @@ extern void *__memcpy(void *, const void *, __kernel_size_t);
 extern void *memmove(void *, const void *, __kernel_size_t);
 extern void *__memmove(void *, const void *, __kernel_size_t);
 
-#define __HAVE_ARCH_MEMCHR
-extern void *memchr(const void *, int, __kernel_size_t);
-
 #define __HAVE_ARCH_MEMSET
 extern void *memset(void *, int, __kernel_size_t);
 extern void *__memset(void *, int, __kernel_size_t);
 
-#define __HAVE_ARCH_MEMCMP
-extern int memcmp(const void *, const void *, size_t);
-
 #ifdef CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE
 #define __HAVE_ARCH_MEMCPY_FLUSHCACHE
 void memcpy_flushcache(void *dst, const void *src, size_t cnt);
diff --git a/arch/arm64/kernel/arm64ksyms.c b/arch/arm64/kernel/arm64ksyms.c
index d894a20b70b2..72f63a59b008 100644
--- a/arch/arm64/kernel/arm64ksyms.c
+++ b/arch/arm64/kernel/arm64ksyms.c
@@ -44,20 +44,23 @@ EXPORT_SYMBOL(__arch_copy_in_user);
 EXPORT_SYMBOL(memstart_addr);
 
 	/* string / mem functions */
+#ifndef CONFIG_KASAN
 EXPORT_SYMBOL(strchr);
 EXPORT_SYMBOL(strrchr);
 EXPORT_SYMBOL(strcmp);
 EXPORT_SYMBOL(strncmp);
 EXPORT_SYMBOL(strlen);
 EXPORT_SYMBOL(strnlen);
+EXPORT_SYMBOL(memcmp);
+EXPORT_SYMBOL(memchr);
+#endif
+
 EXPORT_SYMBOL(memset);
 EXPORT_SYMBOL(memcpy);
 EXPORT_SYMBOL(memmove);
 EXPORT_SYMBOL(__memset);
 EXPORT_SYMBOL(__memcpy);
 EXPORT_SYMBOL(__memmove);
-EXPORT_SYMBOL(memchr);
-EXPORT_SYMBOL(memcmp);
 
 	/* atomic bitops */
 EXPORT_SYMBOL(set_bit);
diff --git a/arch/arm64/lib/memchr.S b/arch/arm64/lib/memchr.S
index 4444c1d25f4b..b790ec0228f6 100644
--- a/arch/arm64/lib/memchr.S
+++ b/arch/arm64/lib/memchr.S
@@ -30,6 +30,7 @@
  * Returns:
  *	x0 - address of first occurrence of 'c' or 0
  */
+.weak memchr
 ENTRY(memchr)
 	and	w1, w1, #0xff
 1:	subs	x2, x2, #1
diff --git a/arch/arm64/lib/memcmp.S b/arch/arm64/lib/memcmp.S
index 2a4e239bd17a..de9975b0afda 100644
--- a/arch/arm64/lib/memcmp.S
+++ b/arch/arm64/lib/memcmp.S
@@ -58,6 +58,7 @@ pos		.req	x11
 limit_wd	.req	x12
 mask		.req	x13
 
+.weak memcmp
 ENTRY(memcmp)
 	cbz	limit, .Lret0
 	eor	tmp1, src1, src2
diff --git a/arch/arm64/lib/strchr.S b/arch/arm64/lib/strchr.S
index dae0cf5591f9..10799adb8d5f 100644
--- a/arch/arm64/lib/strchr.S
+++ b/arch/arm64/lib/strchr.S
@@ -29,6 +29,7 @@
  * Returns:
  *	x0 - address of first occurrence of 'c' or 0
  */
+.weak strchr
 ENTRY(strchr)
 	and	w1, w1, #0xff
 1:	ldrb	w2, [x0], #1
diff --git a/arch/arm64/lib/strcmp.S b/arch/arm64/lib/strcmp.S
index 471fe61760ef..5629b4fa5431 100644
--- a/arch/arm64/lib/strcmp.S
+++ b/arch/arm64/lib/strcmp.S
@@ -60,6 +60,7 @@ tmp3		.req	x9
 zeroones	.req	x10
 pos		.req	x11
 
+.weak strcmp
 ENTRY(strcmp)
 	eor	tmp1, src1, src2
 	mov	zeroones, #REP8_01
diff --git a/arch/arm64/lib/strlen.S b/arch/arm64/lib/strlen.S
index 55ccc8e24c08..f00df4b1b8d9 100644
--- a/arch/arm64/lib/strlen.S
+++ b/arch/arm64/lib/strlen.S
@@ -56,6 +56,7 @@ pos		.req	x12
 #define REP8_7f 0x7f7f7f7f7f7f7f7f
 #define REP8_80 0x8080808080808080
 
+.weak strlen
 ENTRY(strlen)
 	mov	zeroones, #REP8_01
 	bic	src, srcin, #15
diff --git a/arch/arm64/lib/strncmp.S b/arch/arm64/lib/strncmp.S
index e267044761c6..28563ac1c19f 100644
--- a/arch/arm64/lib/strncmp.S
+++ b/arch/arm64/lib/strncmp.S
@@ -64,6 +64,7 @@ limit_wd	.req	x13
 mask		.req	x14
 endloop		.req	x15
 
+.weak strncmp
 ENTRY(strncmp)
 	cbz	limit, .Lret0
 	eor	tmp1, src1, src2
diff --git a/arch/arm64/lib/strnlen.S b/arch/arm64/lib/strnlen.S
index eae38da6e0bb..bdbfd41164f4 100644
--- a/arch/arm64/lib/strnlen.S
+++ b/arch/arm64/lib/strnlen.S
@@ -59,6 +59,7 @@ limit_wd	.req	x14
 #define REP8_7f 0x7f7f7f7f7f7f7f7f
 #define REP8_80 0x8080808080808080
 
+.weak strnlen
 ENTRY(strnlen)
 	cbz	limit, .Lhit_limit
 	mov	zeroones, #REP8_01
diff --git a/arch/arm64/lib/strrchr.S b/arch/arm64/lib/strrchr.S
index f8e2784d5752..31c77f605014 100644
--- a/arch/arm64/lib/strrchr.S
+++ b/arch/arm64/lib/strrchr.S
@@ -29,6 +29,7 @@
  * Returns:
  *	x0 - address of last occurrence of 'c' or 0
  */
+.weak strrchr
 ENTRY(strrchr)
 	mov	x3, #0
 	and	w1, w1, #0xff
-- 
2.16.4

