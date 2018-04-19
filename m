Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753298AbeDSBek (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 21:34:40 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:40496 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752899AbeDSBeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 21:34:37 -0400
X-Google-Smtp-Source: AIpwx4/4UMNk9IAZNdHyk9EfxuWMgYKpbkFVDwDvDtpJjp/vDNHaVvhvVcXUbgTT28FC8sH6G394ZA==
From: Leo Yan <leo.yan@linaro.org>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Leo Yan <leo.yan@linaro.org>
Subject: [PATCH bpf-next 4/5] samples/bpf: Refine printing symbol for sampleip
Date: Thu, 19 Apr 2018 09:34:05 +0800
Message-Id: <1524101646-6544-5-git-send-email-leo.yan@linaro.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1524101646-6544-1-git-send-email-leo.yan@linaro.org>
References: <1524101646-6544-1-git-send-email-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code defines macro 'PAGE_OFFSET' and uses it to decide if the
address is in kernel space or not.  But different architecture has
different 'PAGE_OFFSET' so this program cannot be used for all
platforms.

This commit changes to check returned pointer from ksym_search() to
judge if the address falls into kernel space or not, and removes
macro 'PAGE_OFFSET' as it isn't used anymore.  As result, this program
has no architecture dependency.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 samples/bpf/sampleip_user.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/samples/bpf/sampleip_user.c b/samples/bpf/sampleip_user.c
index 4ed690b..0eea1b3 100644
--- a/samples/bpf/sampleip_user.c
+++ b/samples/bpf/sampleip_user.c
@@ -26,7 +26,6 @@
 #define DEFAULT_FREQ	99
 #define DEFAULT_SECS	5
 #define MAX_IPS		8192
-#define PAGE_OFFSET	0xffff880000000000
 
 static int nr_cpus;
 
@@ -107,14 +106,13 @@ static void print_ip_map(int fd)
 	/* sort and print */
 	qsort(counts, max, sizeof(struct ipcount), count_cmp);
 	for (i = 0; i < max; i++) {
-		if (counts[i].ip > PAGE_OFFSET) {
-			sym = ksym_search(counts[i].ip);
+		sym = ksym_search(counts[i].ip);
+		if (sym)
 			printf("0x%-17llx %-32s %u\n", counts[i].ip, sym->name,
 			       counts[i].count);
-		} else {
+		else
 			printf("0x%-17llx %-32s %u\n", counts[i].ip, "(user)",
 			       counts[i].count);
-		}
 	}
 
 	if (max == MAX_IPS) {
-- 
1.9.1
