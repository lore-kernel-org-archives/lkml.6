Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA478C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 01:40:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 810B720875
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 01:40:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 810B720875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754220AbeFUBj7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 21:39:59 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:58613 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754018AbeFUBj5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 21:39:57 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id E9B149E587C37;
        Thu, 21 Jun 2018 09:39:54 +0800 (CST)
Received: from [127.0.0.1] (10.177.29.40) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.382.0; Thu, 21 Jun 2018
 09:39:45 +0800
Subject: [PATCH v4 21/21] sparc64: use match_string() helper
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
References: <1527765086-19873-1-git-send-email-xieyisheng1@huawei.com>
 <1527765086-19873-22-git-send-email-xieyisheng1@huawei.com>
 <80339b72-902f-a74e-6ad2-28744c7760cb@huawei.com>
 <CAHp75VdvpxZCuGmFV0r9nUdO1u7=eurDFZur7Q=ZO0kMC6D0rw@mail.gmail.com>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Anthony Yznaga <anthony.yznaga@oracle.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        <sparclinux@vger.kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
From:   Yisheng Xie <xieyisheng1@huawei.com>
Message-ID: <29324e04-e6c3-188c-a7fa-0363305b6455@huawei.com>
Date:   Thu, 21 Jun 2018 09:39:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VdvpxZCuGmFV0r9nUdO1u7=eurDFZur7Q=ZO0kMC6D0rw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.40]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

match_string() returns the index of an array for a matching string,
which can be used instead of open coded variant.

As Andy's suggestion, this patch add string literal instead of NULL
for crypto in array of hwcaps and make an additional condition after
match_string() in all users of it.

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Anthony Yznaga <anthony.yznaga@oracle.com>
Cc: Pavel Tatashin <pasha.tatashin@oracle.com>
Cc: sparclinux@vger.kernel.org
Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
---
 arch/sparc/kernel/setup_64.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/arch/sparc/kernel/setup_64.c b/arch/sparc/kernel/setup_64.c
index 7944b3c..6fa0c78 100644
--- a/arch/sparc/kernel/setup_64.c
+++ b/arch/sparc/kernel/setup_64.c
@@ -401,8 +401,7 @@ void __init start_early_boot(void)
 	 */
 	"mul32", "div32", "fsmuld", "v8plus", "popc", "vis", "vis2",
 	"ASIBlkInit", "fmaf", "vis3", "hpc", "random", "trans", "fjfmau",
-	"ima", "cspare", "pause", "cbcond", NULL /*reserved for crypto */,
-	"adp",
+	"ima", "cspare", "pause", "cbcond", "crypto", "adp",
 };

 static const char *crypto_hwcaps[] = {
@@ -418,7 +417,7 @@ void cpucap_info(struct seq_file *m)
 	seq_puts(m, "cpucaps\t\t: ");
 	for (i = 0; i < ARRAY_SIZE(hwcaps); i++) {
 		unsigned long bit = 1UL << i;
-		if (hwcaps[i] && (caps & bit)) {
+		if ((caps & bit) && bit != HWCAP_SPARC_CRYPTO) {
 			seq_printf(m, "%s%s",
 				   printed ? "," : "", hwcaps[i]);
 			printed++;
@@ -472,7 +471,7 @@ static void __init report_hwcaps(unsigned long caps)

 	for (i = 0; i < ARRAY_SIZE(hwcaps); i++) {
 		unsigned long bit = 1UL << i;
-		if (hwcaps[i] && (caps & bit))
+		if ((caps & bit) && bit != HWCAP_SPARC_CRYPTO)
 			report_one_hwcap(&printed, hwcaps[i]);
 	}
 	if (caps & HWCAP_SPARC_CRYPTO)
@@ -504,18 +503,13 @@ static unsigned long __init mdesc_cpu_hwcap_list(void)
 	while (len) {
 		int i, plen;

-		for (i = 0; i < ARRAY_SIZE(hwcaps); i++) {
-			unsigned long bit = 1UL << i;
+		i = match_string(hwcaps, ARRAY_SIZE(hwcaps), prop);
+		if (i >= 0)
+			caps |= 1UL << i;

-			if (hwcaps[i] && !strcmp(prop, hwcaps[i])) {
-				caps |= bit;
-				break;
-			}
-		}
-		for (i = 0; i < ARRAY_SIZE(crypto_hwcaps); i++) {
-			if (!strcmp(prop, crypto_hwcaps[i]))
-				caps |= HWCAP_SPARC_CRYPTO;
-		}
+		i = match_string(crypto_hwcaps, ARRAY_SIZE(crypto_hwcaps), prop);
+		if (i >= 0)
+			caps |= HWCAP_SPARC_CRYPTO;

 		plen = strlen(prop) + 1;
 		prop += plen;
-- 
1.7.12.4


