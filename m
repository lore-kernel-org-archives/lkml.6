Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EB08C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 15:35:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69EA621526
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 15:35:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="WKX8Stp3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69EA621526
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387675AbeHBR0p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 13:26:45 -0400
Received: from mail-eopbgr30110.outbound.protection.outlook.com ([40.107.3.110]:8561
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387490AbeHBR0p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 13:26:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T0yFUfWgon6lbcjF6/McGJrJieEFa/DxXIThEVl+RJg=;
 b=WKX8Stp3h1qvQb1A7P8soQFkygUB43m31eE2A1XdnQ41LAtxJX9U8I+ebOxLhwVhl/0+fGZjBrVGxta0yFU97zfFDMxLxlUs8teGGQeYOb5gRmZKzqXJnGqasYmTkcPVmsrV+DZPVWzwHtaK5ABacn3TtFE7Y7z0+OiNskSK9xw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aryabinin@virtuozzo.com; 
Received: from i7.sw.ru (185.231.240.5) by
 AM0PR08MB3250.eurprd08.prod.outlook.com (2603:10a6:208:5e::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.14; Thu, 2 Aug 2018 15:32:19 +0000
From:   Andrey Ryabinin <aryabinin@virtuozzo.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Andrey Ryabinin <aryabinin@virtuozzo.com>
Subject: [PATCH] lib/ubsan: remove null-pointer checks.
Date:   Thu,  2 Aug 2018 18:32:09 +0300
Message-Id: <20180802153209.813-1-aryabinin@virtuozzo.com>
X-Mailer: git-send-email 2.16.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: VI1PR08CA0130.eurprd08.prod.outlook.com
 (2603:10a6:800:d4::32) To AM0PR08MB3250.eurprd08.prod.outlook.com
 (2603:10a6:208:5e::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6257800c-7040-42a7-1408-08d5f88d22e5
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:AM0PR08MB3250;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3250;3:/c8XDmcxMOJ1DYtYFXU6z55/iIg7YCRmPHNn/RrsmoWfWZ3XuKAAXUchI+iyqTIQowosHd72h+h/VP5krfqXEKilpE2fSTaKL9V+vs9oDd/pqFrVbvO3wBVgQszZj/DB4T/gyjh9QDbrY1kCryjLLxmmUBQiDcKtsAFqct1J/73pU7uOlmJY87FEeeQ36fXeBXohRhesMJ99fHdRVU6MDTy/90fCr7vQn0gGp/dO2Ms4AZvns5LP3hJUnHJNWhb4;25:wi4qSoQOv8bVx58FO5OJBgo/EE9/h2edU8ZJ5GZl8UloYMkF60xQuCkOHCkCDAWD4wyFKaq2Xnr0rAUvGGR5wkiD6GPxx0FG5Ywn7g+Fq0mGBZp2D11b/WEw8fuAkLbjOnfysW3Ibwr0ArQT/0vHxXmFcOP79NbblvOUkfR6LZurraXstmZOA8Qbbqr3TzVqv7W9zpUdFtK6ul8rwvFRT/obZEd8QzUQ4YLv4XLqVsRpOnXFtTENBiJTyJMR1GPIzmYzI0j69wLgJnNq+/RnaSqGTvfl82F6yOpXg6o3sutwAXELatDN5nVZpb+LhiW7nS2u+ce/IruO6SqdyHSGNQ==;31:E4X4x971EWpoquBcqyQXcgDzYil5CaGGGXCu4WpYDTiiWybIb810WfNpBqG97C9/Gu5MfXThq2oYDBB+NBtgMmI8aqp+poo3SI2xRVm+c/Z5smyEYFv/w2gAGcyb7c9TWsgCGejZmesqxJmWUpMgiiPDU+LB+833ICXU1sou4tvCgaaHU7K1PUWkZHohNZGxOeGe/5KRMnEGKqu92KU2tuTjgu7ESc+VZ6X3I9Lj81E=
X-MS-TrafficTypeDiagnostic: AM0PR08MB3250:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3250;20:CfaJO/nTultxeovIUe25LTAgNfjOB5nci1fzbpy2tjkOEI0VYZLVYVUdXhgWxh3BoQlx08sVF8XoZ/2qYIEEgTVYr1hg3kt58PckpJ2+EmqgB1uXejkqCN8OVZeP4oT2wetNDJ030M9pUyZesPDcnASmLgNGUKHQyi9eMM90y76GKKm5lm9+Wv51YwOyhbGQ/Ihiaopx2tS4JCKtDbA9lx7QliqYFuPZUHvFHuHjP/BH9hzkeqPzTdyitUx3lQljf6zvtXGE1uBjbogDsIGeoslMRsoV771uUaQeUFh5fDnb17tI68PqZ69FZLGgGrv3zKWMvK+bSVb6MrM1Z910kEFWZ4/oT0R9q12S2GnacrFUSI/MfVig7BLFtmkneKkVWaVJydiZBq9oKwNA7CAhXs+UWuRo0NoLlOZWM2BSlFHR+ei0kaAZVmTZP5o1WLirbpioq6aED3V37cbrFDEFMYtchx8G9JGfO7ZCmWlC/snkjomsjcdwWiMaMz8yN/cq;4:KmJXwyWDklHvuOjcYJNFt6ZKQcIJbN4UlCWnkDJBxvvO1sg9hb37ho/45lpbKv3vm6pcqjrgGDXC44gNxxJlQrPLkbie1NKd6pMohVZC0oindb3r1jBTvn7gm5qHPm0FFbgdvpS+x6sG781Qatg+YDScEk3xd72J8Sn0cGYLSOChyCatwD+6XT0yIl1AT/U9YqJRtaiEi46IZZ1Rhwz98sIwbUaYxUi/Zz2sLAelO4q4LSPXXVxpYBDOISHHuW+6crP/+VYGcUF6XV+C9VkTAQ==
X-Microsoft-Antispam-PRVS: <AM0PR08MB32500D67D9D4FD5473C05D42B02C0@AM0PR08MB3250.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:AM0PR08MB3250;BCL:0;PCL:0;RULEID:;SRVR:AM0PR08MB3250;
X-Forefront-PRVS: 07521929C1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(136003)(39840400004)(376002)(366004)(346002)(199004)(189003)(97736004)(51416003)(478600001)(52116002)(6506007)(6486002)(5660300001)(186003)(48376002)(16526019)(50466002)(68736007)(50226002)(6916009)(956004)(53936002)(107886003)(386003)(6512007)(4326008)(53416004)(316002)(26005)(6116002)(6666003)(8936002)(1076002)(8676002)(105586002)(3846002)(1857600001)(66066001)(47776003)(486006)(106356001)(25786009)(81166006)(2616005)(7736002)(16586007)(2906002)(86362001)(476003)(305945005)(14444005)(36756003)(81156014);DIR:OUT;SFP:1102;SCL:1;SRVR:AM0PR08MB3250;H:i7.sw.ru;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM0PR08MB3250;23:gjFwRi+P3NraDZwTMPYjKDd+yYi52WkAVPITirSUI?=
 =?us-ascii?Q?VNUgY4+yXVJqPgv9EmCyLys8tjJ1VAcpnVxNJhyGVoDfv7NZZOVsC4qqjOrW?=
 =?us-ascii?Q?fBPqNZqAbVeCajEYL+yUJOJ28FSrdXojf2++Nja9xRZtNkf+obGHAnwUzCog?=
 =?us-ascii?Q?FwAhJa4cNijEhYaVebblzZ+Yn9s8tevyak/zQrx0njfWrq4yqirZYmAGwUG+?=
 =?us-ascii?Q?WO8Jqg5YBuGDdiZKlKcVYxzaRoWMEtVbVNwBeE6kPJ2fKtzP8iCAtpY6AvmG?=
 =?us-ascii?Q?3hQi1mHENzd53oJOwN45gd/RqeGYZvwKWhBzcTZZ36Ae/8rpLruFPVgrjumR?=
 =?us-ascii?Q?W6TMiQKiz7F7j/n52qy1kTQdEbClZ1+IaZTAwmID8rADgbXm+94ZvyHqCacs?=
 =?us-ascii?Q?etjVuxiM8f0n+35gBLo7jFJQ9x970Qw8Y7csIpwqBILa29Hw4DL49dfLXrgC?=
 =?us-ascii?Q?Hw26Aea9AhoWmACQERiNTAqekwLqIHAsqzjZ83hiP/zWyaB1j8lxKskuQvlQ?=
 =?us-ascii?Q?nx9DWQb/oNhz0ttl9O/bn4uhDhrYW3LEy3jivtL08CWh7X+d+z39HBk7NrND?=
 =?us-ascii?Q?kUDoPglccEdGb8VwNkPr1w+eUtemh/K3tTDCy8qBjT9oMa4pb66fLzFHQ+ob?=
 =?us-ascii?Q?fCSzq7E/x4NidWHHdPkneTBTV/+mXKCoa9NCZDv4yTasIV4W7HMTIt4oYHls?=
 =?us-ascii?Q?9PAKv91B6iNSIzU/3TEpuqUky+Oh0DwybpmPOwG1gAKNGwKYWbhyq3PHx3bd?=
 =?us-ascii?Q?y1c8WdQlhw8GPmA6RT+xfidlI1MurZnYtNqY7bEIIhk+Uo9ZL6yewP+2LX4f?=
 =?us-ascii?Q?4TBDtkTHtMzlVFWgMoLGuu/jUQbzyMn/zzXQUA5B0C5+NvIVpFtvBMsnJZVe?=
 =?us-ascii?Q?UcuSzLEbz3tvwWY+oDAFcv1+EGkHK9AcCIOSAEYt1xm/av/BpzlFQNPr0d75?=
 =?us-ascii?Q?NyLfzV0K8hTFIVYzAvY+nbzXVc3VZ5PLNc2j/FQvPxVHgVf9wwMQzWM+2xcY?=
 =?us-ascii?Q?va1F+wkOTOJTkdWKIjJvNd0Krq0NEyXSS4mJ3im8pBlY4N7dWoe7Cza3+FPa?=
 =?us-ascii?Q?RsBgeIjmE0kRBcLSjDkABW1PANOSnMQM/PHniUJq0PaFZ9Zz744qIJQD/sUg?=
 =?us-ascii?Q?a1mYNr41tmlpMO/KQ42UAJuATVmMy075CH2ZVU3RmPVkYRyLkWGAKuCCo8/F?=
 =?us-ascii?Q?DO0KOfqfPeEfAejwc5DksQtcSWnfXqbScXR?=
X-Microsoft-Antispam-Message-Info: nHkGZ42qz14HspeLle88gINcsGP5xPTfbbg3YLJupnRrYlhtki8dDV6KRtR6d5C4UixrgFe5HaaSvKPg8l3jw5HhbGK3lw05AAxnQq6KMZy8pZgKC5IIkBYor9FgbibSC9mKF8AHGXEVofTKw8kGYyHIs50ib8c/WTwRS/fQwD/5uliB5KeM3o9yXUzOg2kElF+Yubu+6GE7udZDM5F8rQwkJiJO4AEQr5ZaYZwoU/40j+gOijfRLouI26U+TPOXf+6cBOLjVoS5O7Xdd4fD9/k5nropHQnGUDGVnNpYbJKEpqLC0yTgbQTqu/qL/fBc+FN8OyaKbno83uxbic0YucPcJhGHeyjfWdJsCfAWkqk=
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3250;6:G77bu16UdQDSNxKH0ITeZUQz8yaUQ9TmFq+exkBZtvSx9rwP1pyYl1T0iVhH92yfMxJK6Y+N8BcYv3GN+YRdfCzPiQ2EmCBlCtgVgISJW8l/6dgq+jlPBNw78GADxk5Pzvpx4fXLc3I6R/KsHeiEf40DFgZcIQS+crgL4yQ8sCd01jz+GjW6rzpaJOH6VgxY6ATdmwwh+y/NZRZm5am2Mxr3shI+LIbl7sikcRQu1Z1oeVQVqmZu3F7d6hXRfCVI8W2HWbXsxtvnyBNY7N7VrNNFJR84RH9dTA2xrd7EneSP4jS6k45P8tuOjnLlxZ8o6aZ0u+/uV0afkDphWoxVccBFzfM/vJXzDGxh0/FkASGxLtGGbhNr0OOXh0RdIEAvTPgcflWf2wwdTdrIkxboI62lA7KuH1pN4SyxwVtcYeaBa40+8V67TiXMNOVL0AwzYIhBsCvnZSbyGrcDldydCA==;5:o+uCaykQ/YObxVFtiPCUZ9tecy5OCXQMxmeAZHxx5XEBIu00r9DnLGA5daInmhdokSJ1tDnt8pRxkZQuCEYFc2XdY+k+hr6PTZ19QfVrovSgPG8PRi6t7FvKwHL4LHu0003oQMMtS0Z9ZoQDXw0yCfoeORt47UWBRuPAnQVhjeY=;7:LZb7+GphMoBE5++7chgQGt1WVj1H8YNVSeNeaGEkLfDxp3wcooUW23iqCavuCXcfzwSR9t28bchjg4kN07oqQKrtzLtq3rmiEbizqeopFf7BYW/+fS7Gs4UkZERGO6ynbO8TXcFXNtXd6gwZwk5zKlms5ydSa87f6ToR6BjB4KKa1zkb9rb6XrARVEx2ZLkdLrnD6HebO43pg4ymvqOVdIdVGvlOR9AyzYy/oqvP2GUg+umLqewXnt3YZtrkK0hj
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3250;20:R0e3X66q9oiZ/DB7FglYYup7M8s+QqkxmEdhfOCftPKCbLMmnfuGpjLoNxEDnvTvzmKUr52yb/Oo0ulh76KDWqs9nmI/0+OO7/uP7j0tNfMz/afvxO2qxtGKkgs9H6LqGCIJPc1EcDceVOIB0solMYY+1b3lvREjgS6Uozbs1Y4=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2018 15:32:19.7995 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6257800c-7040-42a7-1408-08d5f88d22e5
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3250
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With gcc-8 fsanitize=null become very noisy. GCC started to complain
about things like &a->b, where 'a' is NULL pointer. There is no NULL
dereference, we just calculate address to struct member. It's technically
undefined behavior so UBSAN is correct to report it. But as long as
there is no real NULL-dereference, I think, we should be fine.
-fno-delete-null-pointer-checks compiler flag should protect us
from any consequences. So let's just no use -fsanitize=null as
it's not useful for us. If there is a real NULL-deref we will see
crash. Even if userspace mapped something at NULL (root can do this),
with things like SMAP should catch the issue.

Signed-off-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
---
 arch/parisc/Kconfig    |  1 -
 arch/s390/Kconfig      |  1 -
 lib/Kconfig.ubsan      | 11 -----------
 scripts/Makefile.ubsan |  4 ----
 4 files changed, 17 deletions(-)

diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
index c11d9939c1db..e21751fb24aa 100644
--- a/arch/parisc/Kconfig
+++ b/arch/parisc/Kconfig
@@ -11,7 +11,6 @@ config PARISC
 	select ARCH_HAS_ELF_RANDOMIZE
 	select ARCH_HAS_STRICT_KERNEL_RWX
 	select ARCH_HAS_UBSAN_SANITIZE_ALL
-	select ARCH_WANTS_UBSAN_NO_NULL
 	select ARCH_SUPPORTS_MEMORY_FAILURE
 	select RTC_CLASS
 	select RTC_DRV_GENERIC
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 184ea341437b..515240576930 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -106,7 +106,6 @@ config S390
 	select ARCH_USE_BUILTIN_BSWAP
 	select ARCH_USE_CMPXCHG_LOCKREF
 	select ARCH_WANTS_DYNAMIC_TASK_STRUCT
-	select ARCH_WANTS_UBSAN_NO_NULL
 	select ARCH_WANT_IPC_PARSE_VERSION
 	select BUILDTIME_EXTABLE_SORT
 	select CLONE_BACKWARDS2
diff --git a/lib/Kconfig.ubsan b/lib/Kconfig.ubsan
index 19d42ea75ec2..98fa559ebd80 100644
--- a/lib/Kconfig.ubsan
+++ b/lib/Kconfig.ubsan
@@ -1,9 +1,6 @@
 config ARCH_HAS_UBSAN_SANITIZE_ALL
 	bool
 
-config ARCH_WANTS_UBSAN_NO_NULL
-	def_bool n
-
 config UBSAN
 	bool "Undefined behaviour sanity checker"
 	help
@@ -39,14 +36,6 @@ config UBSAN_ALIGNMENT
 	  Enabling this option on architectures that support unaligned
 	  accesses may produce a lot of false positives.
 
-config UBSAN_NULL
-	bool "Enable checking of null pointers"
-	depends on UBSAN
-	default y if !ARCH_WANTS_UBSAN_NO_NULL
-	help
-	  This option enables detection of memory accesses via a
-	  null pointer.
-
 config TEST_UBSAN
 	tristate "Module for testing for undefined behavior detection"
 	depends on m && UBSAN
diff --git a/scripts/Makefile.ubsan b/scripts/Makefile.ubsan
index b593b36ccff8..38b2b4818e8e 100644
--- a/scripts/Makefile.ubsan
+++ b/scripts/Makefile.ubsan
@@ -14,10 +14,6 @@ ifdef CONFIG_UBSAN_ALIGNMENT
       CFLAGS_UBSAN += $(call cc-option, -fsanitize=alignment)
 endif
 
-ifdef CONFIG_UBSAN_NULL
-      CFLAGS_UBSAN += $(call cc-option, -fsanitize=null)
-endif
-
       # -fsanitize=* options makes GCC less smart than usual and
       # increase number of 'maybe-uninitialized false-positives
       CFLAGS_UBSAN += $(call cc-option, -Wno-maybe-uninitialized)
-- 
2.16.4

