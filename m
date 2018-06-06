Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1A89D605BD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932089AbeFFCWP (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Tue, 5 Jun 2018 22:22:15 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:8698 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752424AbeFFCWO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 22:22:14 -0400
Subject: [PATCH v3 21/21] sparc64: use match_string() helper
To: <linux-kernel@vger.kernel.org>
References: <1527765086-19873-1-git-send-email-xieyisheng1@huawei.com>
 <1527765086-19873-22-git-send-email-xieyisheng1@huawei.com>
CC: <andy.shevchenko@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Anthony Yznaga <anthony.yznaga@oracle.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        <sparclinux@vger.kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
From: Yisheng Xie <xieyisheng1@huawei.com>
Message-ID: <80339b72-902f-a74e-6ad2-28744c7760cb@huawei.com>
Date: Wed, 6 Jun 2018 10:19:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.0
MIME-Version: 1.0
In-Reply-To: <1527765086-19873-22-git-send-email-xieyisheng1@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.40]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

match_string() returns the index of an array for a matching string,
which can be used instead of open coded variant.

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Anthony Yznaga <anthony.yznaga@oracle.com>
Cc: Pavel Tatashin <pasha.tatashin@oracle.com>
Cc: sparclinux@vger.kernel.org
Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
---
v3:
 - add string literal instead of NULL for array hwcaps to make it
   can use match_string() too.  - per Andy
v2
 - new add for use match_string() helper patchset.

 arch/sparc/kernel/setup_64.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/arch/sparc/kernel/setup_64.c b/arch/sparc/kernel/setup_64.c
index 7944b3c..4f0ec0c 100644
--- a/arch/sparc/kernel/setup_64.c
+++ b/arch/sparc/kernel/setup_64.c
@@ -401,7 +401,7 @@ void __init start_early_boot(void)
 	 */
 	"mul32", "div32", "fsmuld", "v8plus", "popc", "vis", "vis2",
 	"ASIBlkInit", "fmaf", "vis3", "hpc", "random", "trans", "fjfmau",
-	"ima", "cspare", "pause", "cbcond", NULL /*reserved for crypto */,
+	"ima", "cspare", "pause", "cbcond", "resv" /*reserved for crypto */,
 	"adp",
 };

@@ -418,7 +418,7 @@ void cpucap_info(struct seq_file *m)
 	seq_puts(m, "cpucaps\t\t: ");
 	for (i = 0; i < ARRAY_SIZE(hwcaps); i++) {
 		unsigned long bit = 1UL << i;
-		if (hwcaps[i] && (caps & bit)) {
+		if (bit != HWCAP_SPARC_CRYPTO && (caps & bit)) {
 			seq_printf(m, "%s%s",
 				   printed ? "," : "", hwcaps[i]);
 			printed++;
@@ -472,7 +472,7 @@ static void __init report_hwcaps(unsigned long caps)

 	for (i = 0; i < ARRAY_SIZE(hwcaps); i++) {
 		unsigned long bit = 1UL << i;
-		if (hwcaps[i] && (caps & bit))
+		if (bit != HWCAP_SPARC_CRYPTO && (caps & bit))
 			report_one_hwcap(&printed, hwcaps[i]);
 	}
 	if (caps & HWCAP_SPARC_CRYPTO)
@@ -504,18 +504,13 @@ static unsigned long __init mdesc_cpu_hwcap_list(void)
 	while (len) {
 		int i, plen;

-		for (i = 0; i < ARRAY_SIZE(hwcaps); i++) {
-			unsigned long bit = 1UL << i;
+		i = match_string(hwcaps, ARRAY_SIZE(hwcaps), prop);
+		if (i >= 0)
+			caps |= (1UL << i);

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
