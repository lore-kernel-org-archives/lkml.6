Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ABDEC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 13:56:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1972C208A3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 13:56:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="KWeqR4LU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1972C208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732878AbeITTkE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 15:40:04 -0400
Received: from mail-ve1eur01on0131.outbound.protection.outlook.com ([104.47.1.131]:6684
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731463AbeITTkD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 15:40:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z8QKY9aEfj2hH4vRIPncn2AaAspPR4lLTMtnt6Gz7io=;
 b=KWeqR4LUpBw33AZMrZCZMA5eDX+fZqLf2qdY8wUcAJFNtQ2TRHlH9DoFzejsgoQ+C8q7KulnRR9bRZvHG+rxVbittHG1a6BbZ0nx/SfqJFZj0t3in0bWHEbZPOirA+k79wjuro7jf6cvIa5XmSxw/qgzrKaZR3VS3B5GVxR8X3w=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aryabinin@virtuozzo.com; 
Received: from i7.sw.ru (185.231.240.5) by
 VI1PR08MB3264.eurprd08.prod.outlook.com (2603:10a6:803:3d::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.17; Thu, 20 Sep 2018 13:56:20 +0000
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
Subject: [PATCH v2 2/3] arm64: lib: use C string functions with KASAN enabled.
Date:   Thu, 20 Sep 2018 16:56:30 +0300
Message-Id: <20180920135631.23833-2-aryabinin@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: ffedca51-e55b-4dc8-def7-08d61f00d8f0
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR08MB3264;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3264;3:Pc0nevdkUjZrATr2QlR2n0K2emyVA/qdkcX2tUY3wJycUu0pOY9KeYDGLuXtbFyoyrVC/LjVZAMUMoytFr0NQQRsnfExNupp59gw8FTmmq4M1vuH9foKu3z2DZEBD9nFOUQMIq2pG/4OnArk7xZhna5l94/WNaHoWTY7SEzfsyqTRXTF4psXeDZMSahpX1bvrR27Uj27aq9VVwdiJwjs5WdJmblPWNBS32U6Kz2k0DzB0/oE1kOmH4tmSNa9isyV;25:ZsMZmjyFKEh+nSgsEtMeoXXBqBEICgneUCDuA86Fe+MA+ZIcphHvakUa80d9VhG8OppSsINhq4XhvaJoyRtfJ0PEiPWu8JSxxWgCAU40/bu8tpDcmsgSFtoNkr+gA1VwdmFKdSp/5jTsQfNd3DwzZ7SkypXy8UmFPPZiNsJQuUcj3mg4SlLTWtqAj5lXFC+SD2FkrqZKjxnoB2aHs7UP4jU2VvhvzbrVr37dckdoEGG44UZQlXxpnV1Pz5I13trqlBdd7yr26ih6o79nxfm6I028e+LPT6inibeDznHP0UvEuOfMdJRZ5ZZF+Oujm6P6d4V2eS+pCxAAD/Z+fXjglQ==;31:d+P+lPePjIr69c4VfCaPC+H5qxWFlmRAKNxOC3ydCkV9y4TcJoM5yT86lxXKTZNm4ILMRlfCvp1GzL0YTBm8sx9G1vtYatx/D0fwun3eEEbMSkOt+pg2DTlQYA9jVtIArT9fbAXrIL5tCddR0xcPBU5JFYS1HwL54VS9og4ehacYPaxs5gYNazFX5vR7/hdH7a8s2i9cctfeSs0Hr0wo4p9xUuPDTwZgBQQCQ5Bd2Dc=
X-MS-TrafficTypeDiagnostic: VI1PR08MB3264:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3264;20:x5uabdWbSAOxSLJKxdoHzUMlqz/6ElFIMGRGgsSSel5H3HZtyDpoK465K/UK+cjOLVjy312DsDUAfQ8ui5fLFzHSfjGCUcnsefViOLfWyWnNIFKY2xWZ4qHKETjK2jVRWXusLb/DOsRhVpyAHtGWtH5pVs19auw8+Fq95tUZZ+MlrDafATLUD/BDqeUHNvfYZIeSdQ2/rUnr6QkTPbLvrW3tVxwj639Yx0eG4rW/P1gge/AWDjqL3E2Hqfr+mOFEFmrnk1s3dARNkVkMJZOg9OHIK+iEOhbXV2KvQFssv7j2tM8VH9jbhynA1fY3R7DjqknHEnWJ0osW/KKla/5RPtiVrGMPVwmsHk6sobXe7v/HZKlDCS+USA+O6R0MqM+r0T9NqK59o4pDt6Eq114yofyNQwQB13MqQbMDiRJzMs0v7KkgLHdASBuyRRhYgLTeEoTwE2IwkSN23lwm/vZGR0frwHR0HQXIAoFv6CBS+h3tLtz86tU3Z7219xk0+/au;4:5zWuOzGEFQYfe3XHv16qMpgBkFR2AgczvHZKFRmVdu2URdT8cL4fOBRFr7Eu+8YnFzylRobbhcN0en1bqqqgwlcJVE0tr5i7n7OKSXvTULP4ihFx5pCEMAq3kFZvEJTg9mHkvGxwj2WpXwcpx3e9y0A5DVj3VO/Zi/QUhJ4ul6rbYS6sduXhYSFMXn3llo8UnSDfxofA546QMgbqcgnk9yNXvoS4k5g1uCIVX52Fu5GaJH29zyjP6VnnSXpFIhGFbE8tM/elgBiMOOHlo3m1JA==
X-Microsoft-Antispam-PRVS: <VI1PR08MB32640D7C98D6F8B47F79F8ECB0130@VI1PR08MB3264.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231355)(944501410)(52105095)(3002001)(10201501046)(149027)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699051);SRVR:VI1PR08MB3264;BCL:0;PCL:0;RULEID:;SRVR:VI1PR08MB3264;
X-Forefront-PRVS: 0801F2E62B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39850400004)(396003)(136003)(376002)(366004)(346002)(189003)(199004)(68736007)(52116002)(7416002)(7736002)(956004)(6512007)(11346002)(50226002)(446003)(386003)(6506007)(1076002)(6116002)(8936002)(476003)(50466002)(16526019)(486006)(97736004)(478600001)(186003)(8676002)(53936002)(48376002)(86362001)(2616005)(575784001)(26005)(4326008)(107886003)(81156014)(106356001)(2906002)(105586002)(305945005)(5660300001)(6486002)(316002)(6666003)(51416003)(53416004)(16586007)(110136005)(81166006)(76176011)(36756003)(66066001)(14444005)(3846002)(25786009)(54906003)(47776003);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR08MB3264;H:i7.sw.ru;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR08MB3264;23:de2BTEUABYFrCevAl8k5X6IhnvUJif8s989teDQxV?=
 =?us-ascii?Q?Bk9KoNdYo4wHZfRxfu5rApBKmVJcoRqzG2svQYlMqhtXr0MTZrWvVxCyBPkD?=
 =?us-ascii?Q?xXbSgNPgNAG2nB2G+8x/9SR7wraAxlZ991CSpwP2csgsSuXm2L4DqMLrRe0I?=
 =?us-ascii?Q?Aab6kfzK6YaMH5/E4tijsp0XNKgGLD59uZjab2YjdgSu2PhwRnN5w0hofdup?=
 =?us-ascii?Q?rvCha+K0JD0lpRASKwLmqqwWoqRj60gyQN1W4y0LeASW+Y/wa966AfBZ70dn?=
 =?us-ascii?Q?Py0WcAMaBsgjbozs1WNtuuRI5BMPY+WaEn2RTmfFgP/Ulk+u1Z/8QhpdMzau?=
 =?us-ascii?Q?i4VBwZDQczd2tPKlYe9nxiTrXvFoaTTR/5CD+7IsJKesvUSwB1IumiUpqc36?=
 =?us-ascii?Q?SjVpLN5aKE5avMBzJfqrEq3g7Xava4gaUgKIHq9vnbaszXb0zXtTVFzSy/M9?=
 =?us-ascii?Q?Ij1gIAxgOjKycpkGJh//4RFVWwhZUBSjPnkGcuSX9IdDKFYWg+5joeAF++08?=
 =?us-ascii?Q?isNa4JQZ1x3hczpLRrK9faCsyIkjIcxqrHwJMJZQx41vu0/DbPWZFAmVw1tk?=
 =?us-ascii?Q?f6BT/6V1PgkHigXkNOr11e8MyBkWh0Is7i4qffRdgB+awwvfHqtrAsYk8fRJ?=
 =?us-ascii?Q?0p4XGW3k4+xfqoQ89h9F0/7riBJggkut9zWSTvefHZ2hGVlp69o3kR41bwFv?=
 =?us-ascii?Q?pe1DkiIZeKQvxzFjjhexRvu4FOnwZi5hNBhqYV9ORbR39Tx7gul9hz0Y7siQ?=
 =?us-ascii?Q?+p9Q6jZCYLbpk1YXZHF9YpmMuigBoAYcPzDmeDFKswcdvSDawuN3d3PcvfPz?=
 =?us-ascii?Q?HlYKXMWSH68fXiK7ZFjq5+y1/SlO/TlD/eXp/nJJ08l9JdpP0oGQ1CDbC88c?=
 =?us-ascii?Q?0ajX0QZN/3jSAtd7pWjplslJZn0OR9iWvFZDx9hv+JYQLfjis7FAQHHsZIwW?=
 =?us-ascii?Q?evbYZIJHAame45ruXcLXAXD9Lqh9O6Z7VdvkyPhTpFWahNMqRFNZf6km8GwN?=
 =?us-ascii?Q?2nwMAqNb/F+/RgVxqbhcSX1l+dh3P3mhkND8ML2FnbVTGS5+RNg2Ak21Esrv?=
 =?us-ascii?Q?U9KLIGGeomWQgUHZU+ItmBa6Q9Igt1mRCvUXYNvpnH/90fNMTcu2Izs5hen0?=
 =?us-ascii?Q?4O5QsO5RADUO2te8+BYMqCAvm7WTKbbC23RwU/HNWLhtQ+t7dZogPVt5s4FR?=
 =?us-ascii?Q?eBXZMD9vnM28BkxBCbNj/j/aSxL8BMDWAuyD7OcfAWRTsA64j+CJgyVVPi7s?=
 =?us-ascii?Q?/WFM8TGjeq8rbwBvSGk+sVUFpjFZOPhXwyCkNHEqMXCaTs/7hCC+rCoFp6MT?=
 =?us-ascii?Q?xRK+rR5V7tq8oLiI+6bP9U=3D?=
X-Microsoft-Antispam-Message-Info: SkrUxvDUBxSo31NeED73XpGFiUF6majWqS06n8T6cKS73pAyWeiaLY5AcJy6JiNjIMhphTRbCZ4GvqwICyi6XG4QZb9xtK1p/VpH/06YYdoYC4uA6atwRgtkZ2KaVnLz4DKlWYfzdqDUQMjW/6miLPFTP1B3eHuy2LmsxUCtaOEp+SBjIM3M6WRp+dX4PQ2QDkMi94N+0rbBd/W0ESBtClPS/vP8sthkSurPnjSgUgH6q56EzRKepr+kB7ZlkM84uktl3aaFTW5+vS2V8UzdV46xJ9MVcJ5slJrQHkmnqTipTqL9VBcwDPsKY3GlTXAj1wkgN6jc6qtouav3ZAsb506z4ZDbJNOHr1Y+aly/cY8=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3264;6:bE7F9M1HHkCX9dCiPvrztzpCCTUWDY58a1MCGs4UqtF2AWTqT4GhymbaSNKDdewoSdePTGdbXeqN1W/NtugN5xMHvQwa4HLsINr3loqtI8jhaY1wKGxeJdv5BgVzK9TpOuxwdCIKS9cTBZHzWpy0LubqJ+ON+6nUzI+dyEibsSefRf3+WE5uW+ArBdp4lsDnc7lrLaK3oTXO0f88cm3RM6J2oQJoqovBNDXH0RsAOxLIYEip8Yg2B42RLekg4XbWmqez4gytPGhGW/8jVYiYLanG6Ebz/Y/o0UKuilPVi4YHeTIDospWDDpcQdubAo3e0XHNDyRUweqkvXbAwp4MRkOZBgvMBXj16JbIjgw85A4wk0D42ZDes/ya2e4E8vA8bcFVYIKGU+8UGxP/Vy9alkiN3bp21UkYiaeIOBhhf1I5sryWcfeoiAm73LV3ok9koHdJ0KRkUm+q9bNnDVRFDA==;5:tzeqMtX5wdanNgW4y9ZiojIXvoaQijg1gtisZ46Y62yxS2K9QoCBCnSROJ5dS7fbG0NrWf0IPXtOMoU+Ae8GcL1t7s68VIzQOefHs+gyze77yertsDRGcJj+pyuvbTS5CXtUyvmt12l+mnw08JCtyzxS7KAogcHDJ9nlcwdAIpY=;7:UN6ryBrJHXCEpwEI5zlS8dgDf8a2eVdr0qgj4CLqY3por9wr6aDQZqa9hXIV9mrpyY+JUPkA3ZwK8BSjAw9SfDyHM00Mz9jSHRBmA3pF1rzEKYDP6UltEEu4Elj7jtfhKYOP0R9SCBmr6BYXfnXDi6ch8HBnVxt4kRRq9CgWgq4TYvtjt12/atSrq/tsDeGEbRRht5bwy2sQTMZ/KgsTCGOlPTmkvId6OvgSdETu9GlVRKr0Ppa4ltLZ4xXBgv/W
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3264;20:eJcw3+OV/dIVWP19Gz4eRG2inoZjoCuWBCxza7jkRj5ZIqE4UCGfZAuAFERXL9jFXMkm+GUdY9dSDySwTncuCxkT8S7CulyB8gM0AKygXOG+etS+O6uBrQLSYcDttr7wK35eTjSKszkhtmJBW+Gu9FrFvMESVBAN+pwhiny49ro=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2018 13:56:20.7741 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ffedca51-e55b-4dc8-def7-08d61f00d8f0
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3264
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ARM64 has asm implementation of memchr(), memcmp(), str[r]chr(),
str[n]cmp(), str[n]len(). KASAN don't see memory accesses in asm
code, thus it can potentially miss many bugs.

Ifdef out __HAVE_ARCH_* defines of these functions when KASAN is
enabled, so the generic implementations from lib/string.c will be used.

We can't just remove the asm functions because efistub uses them.
And we can't have two non-weak functions either, so declare the asm
functions as weak.

Reported-by: Kyeongdon Kim <kyeongdon.kim@lge.com>
Signed-off-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
---
Changes since v1:
 - Use WEAK() instead of .weak

 arch/arm64/include/asm/string.h | 14 ++++++++------
 arch/arm64/kernel/arm64ksyms.c  |  7 +++++--
 arch/arm64/lib/memchr.S         |  2 +-
 arch/arm64/lib/memcmp.S         |  2 +-
 arch/arm64/lib/strchr.S         |  2 +-
 arch/arm64/lib/strcmp.S         |  2 +-
 arch/arm64/lib/strlen.S         |  2 +-
 arch/arm64/lib/strncmp.S        |  2 +-
 arch/arm64/lib/strnlen.S        |  2 +-
 arch/arm64/lib/strrchr.S        |  2 +-
 10 files changed, 21 insertions(+), 16 deletions(-)

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
index 4444c1d25f4b..0f164a4baf52 100644
--- a/arch/arm64/lib/memchr.S
+++ b/arch/arm64/lib/memchr.S
@@ -30,7 +30,7 @@
  * Returns:
  *	x0 - address of first occurrence of 'c' or 0
  */
-ENTRY(memchr)
+WEAK(memchr)
 	and	w1, w1, #0xff
 1:	subs	x2, x2, #1
 	b.mi	2f
diff --git a/arch/arm64/lib/memcmp.S b/arch/arm64/lib/memcmp.S
index 2a4e239bd17a..fb295f52e9f8 100644
--- a/arch/arm64/lib/memcmp.S
+++ b/arch/arm64/lib/memcmp.S
@@ -58,7 +58,7 @@ pos		.req	x11
 limit_wd	.req	x12
 mask		.req	x13
 
-ENTRY(memcmp)
+WEAK(memcmp)
 	cbz	limit, .Lret0
 	eor	tmp1, src1, src2
 	tst	tmp1, #7
diff --git a/arch/arm64/lib/strchr.S b/arch/arm64/lib/strchr.S
index dae0cf5591f9..7c83091d1bcd 100644
--- a/arch/arm64/lib/strchr.S
+++ b/arch/arm64/lib/strchr.S
@@ -29,7 +29,7 @@
  * Returns:
  *	x0 - address of first occurrence of 'c' or 0
  */
-ENTRY(strchr)
+WEAK(strchr)
 	and	w1, w1, #0xff
 1:	ldrb	w2, [x0], #1
 	cmp	w2, w1
diff --git a/arch/arm64/lib/strcmp.S b/arch/arm64/lib/strcmp.S
index 471fe61760ef..7d5d15398bfb 100644
--- a/arch/arm64/lib/strcmp.S
+++ b/arch/arm64/lib/strcmp.S
@@ -60,7 +60,7 @@ tmp3		.req	x9
 zeroones	.req	x10
 pos		.req	x11
 
-ENTRY(strcmp)
+WEAK(strcmp)
 	eor	tmp1, src1, src2
 	mov	zeroones, #REP8_01
 	tst	tmp1, #7
diff --git a/arch/arm64/lib/strlen.S b/arch/arm64/lib/strlen.S
index 55ccc8e24c08..8e0b14205dcb 100644
--- a/arch/arm64/lib/strlen.S
+++ b/arch/arm64/lib/strlen.S
@@ -56,7 +56,7 @@ pos		.req	x12
 #define REP8_7f 0x7f7f7f7f7f7f7f7f
 #define REP8_80 0x8080808080808080
 
-ENTRY(strlen)
+WEAK(strlen)
 	mov	zeroones, #REP8_01
 	bic	src, srcin, #15
 	ands	tmp1, srcin, #15
diff --git a/arch/arm64/lib/strncmp.S b/arch/arm64/lib/strncmp.S
index e267044761c6..66bd145935d9 100644
--- a/arch/arm64/lib/strncmp.S
+++ b/arch/arm64/lib/strncmp.S
@@ -64,7 +64,7 @@ limit_wd	.req	x13
 mask		.req	x14
 endloop		.req	x15
 
-ENTRY(strncmp)
+WEAK(strncmp)
 	cbz	limit, .Lret0
 	eor	tmp1, src1, src2
 	mov	zeroones, #REP8_01
diff --git a/arch/arm64/lib/strnlen.S b/arch/arm64/lib/strnlen.S
index eae38da6e0bb..355be04441fe 100644
--- a/arch/arm64/lib/strnlen.S
+++ b/arch/arm64/lib/strnlen.S
@@ -59,7 +59,7 @@ limit_wd	.req	x14
 #define REP8_7f 0x7f7f7f7f7f7f7f7f
 #define REP8_80 0x8080808080808080
 
-ENTRY(strnlen)
+WEAK(strnlen)
 	cbz	limit, .Lhit_limit
 	mov	zeroones, #REP8_01
 	bic	src, srcin, #15
diff --git a/arch/arm64/lib/strrchr.S b/arch/arm64/lib/strrchr.S
index f8e2784d5752..ea84924d5990 100644
--- a/arch/arm64/lib/strrchr.S
+++ b/arch/arm64/lib/strrchr.S
@@ -29,7 +29,7 @@
  * Returns:
  *	x0 - address of last occurrence of 'c' or 0
  */
-ENTRY(strrchr)
+WEAK(strrchr)
 	mov	x3, #0
 	and	w1, w1, #0xff
 1:	ldrb	w2, [x0], #1
-- 
2.16.4

