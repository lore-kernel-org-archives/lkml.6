Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753351AbeDSBen (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 21:34:43 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:34813 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753128AbeDSBel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 21:34:41 -0400
X-Google-Smtp-Source: AIpwx4/4AyvrOVUf96GrJt7Ut7J4iZ5wa8hnXJO1Zb/ZNG3qS7uhnQfIxoF5ooXj0AZ6t3sZ4TtjPg==
From: Leo Yan <leo.yan@linaro.org>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Leo Yan <leo.yan@linaro.org>
Subject: [PATCH bpf-next 5/5] samples/bpf: Handle NULL pointer returned by ksym_search()
Date: Thu, 19 Apr 2018 09:34:06 +0800
Message-Id: <1524101646-6544-6-git-send-email-leo.yan@linaro.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1524101646-6544-1-git-send-email-leo.yan@linaro.org>
References: <1524101646-6544-1-git-send-email-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit handles NULL pointer returned by ksym_search() to directly
print address hexadecimal value, the change is applied in 'trace_event',
'spintest' and 'offwaketime' programs.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 samples/bpf/offwaketime_user.c | 5 +++++
 samples/bpf/spintest_user.c    | 5 ++++-
 samples/bpf/trace_event_user.c | 5 +++++
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/samples/bpf/offwaketime_user.c b/samples/bpf/offwaketime_user.c
index 512f87a..fce2113 100644
--- a/samples/bpf/offwaketime_user.c
+++ b/samples/bpf/offwaketime_user.c
@@ -27,6 +27,11 @@ static void print_ksym(__u64 addr)
 	if (!addr)
 		return;
 	sym = ksym_search(addr);
+	if (!sym) {
+		printf("%llx;", addr);
+		return;
+	}
+
 	if (PRINT_RAW_ADDR)
 		printf("%s/%llx;", sym->name, addr);
 	else
diff --git a/samples/bpf/spintest_user.c b/samples/bpf/spintest_user.c
index 3d73621..3140803 100644
--- a/samples/bpf/spintest_user.c
+++ b/samples/bpf/spintest_user.c
@@ -36,7 +36,10 @@ int main(int ac, char **argv)
 			bpf_map_lookup_elem(map_fd[0], &next_key, &value);
 			assert(next_key == value);
 			sym = ksym_search(value);
-			printf(" %s", sym->name);
+			if (!sym)
+				printf(" %lx", value);
+			else
+				printf(" %s", sym->name);
 			key = next_key;
 		}
 		if (key)
diff --git a/samples/bpf/trace_event_user.c b/samples/bpf/trace_event_user.c
index 56f7a25..d2ab33e 100644
--- a/samples/bpf/trace_event_user.c
+++ b/samples/bpf/trace_event_user.c
@@ -33,6 +33,11 @@ static void print_ksym(__u64 addr)
 	if (!addr)
 		return;
 	sym = ksym_search(addr);
+	if (!sym) {
+		printf("%llx;", addr);
+		return;
+	}
+
 	printf("%s;", sym->name);
 	if (!strcmp(sym->name, "sys_read"))
 		sys_read_seen = true;
-- 
1.9.1
