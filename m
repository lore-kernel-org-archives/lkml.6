Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753202AbeDSBef (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 21:34:35 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:47020 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752899AbeDSBe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 21:34:29 -0400
X-Google-Smtp-Source: AIpwx4+aMYlHM4Dm3zupa6PWKwTgsbGNlOSGpy3sfqWe/uLp7A33iMHDHjJAuWn+GIiGq00jmnM7Ig==
From: Leo Yan <leo.yan@linaro.org>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Leo Yan <leo.yan@linaro.org>
Subject: [PATCH bpf-next 2/5] samples/bpf: Dynamically allocate structure 'syms'
Date: Thu, 19 Apr 2018 09:34:03 +0800
Message-Id: <1524101646-6544-3-git-send-email-leo.yan@linaro.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1524101646-6544-1-git-send-email-leo.yan@linaro.org>
References: <1524101646-6544-1-git-send-email-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Structure 'syms' is used to store kernel symbol info by reading proc fs
node '/proc/kallsyms', this structure is declared with 300000 entries
and static linked into bss section.  For most case the kernel symbols
has less than 300000 entries, so it's safe to define so large array, but
the side effect is bss section is big introduced by this structure and
it isn't flexible.

To fix this, this patch dynamically allocates memory for structure
'syms' based on parsing '/proc/kallsyms' line number at the runtime,
which can save elf file required memory significantly.

Before:
   text    data     bss     dec     hex filename
  18841    1172 5199776 5219789  4fa5cd samples/bpf/sampleip

After:
   text    data     bss     dec     hex filename
  19101    1188  399792  420081   668f1 samples/bpf/sampleip

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 samples/bpf/bpf_load.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/samples/bpf/bpf_load.c b/samples/bpf/bpf_load.c
index 28e4678..c2bf7ca 100644
--- a/samples/bpf/bpf_load.c
+++ b/samples/bpf/bpf_load.c
@@ -651,8 +651,7 @@ void read_trace_pipe(void)
 	}
 }
 
-#define MAX_SYMS 300000
-static struct ksym syms[MAX_SYMS];
+static struct ksym *syms;
 static int sym_cnt;
 
 static int ksym_cmp(const void *p1, const void *p2)
@@ -678,12 +677,30 @@ int load_kallsyms(void)
 			break;
 		if (!addr)
 			continue;
+		sym_cnt++;
+	}
+
+	syms = calloc(sym_cnt, sizeof(*syms));
+	if (!syms) {
+		fclose(f);
+		return -ENOMEM;
+	}
+
+	rewind(f);
+	while (!feof(f)) {
+		if (!fgets(buf, sizeof(buf), f))
+			break;
+		if (sscanf(buf, "%p %c %s", &addr, &symbol, func) != 3)
+			break;
+		if (!addr)
+			continue;
 		syms[i].addr = (long) addr;
 		syms[i].name = strdup(func);
 		i++;
 	}
-	sym_cnt = i;
 	qsort(syms, sym_cnt, sizeof(struct ksym), ksym_cmp);
+
+	fclose(f);
 	return 0;
 }
 
-- 
1.9.1
