Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752101AbeEBPVe (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 11:21:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:47308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751537AbeEBPV3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 11:21:29 -0400
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 28/52] tools lib symbols: Introduce kallsyms__is_function()
Date: Wed,  2 May 2018 12:19:18 -0300
Message-Id: <20180502151942.20542-29-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180502151942.20542-1-acme@kernel.org>
References: <20180502151942.20542-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Out of symbol_type__is_a(type, MAP__FUNCTION), which is the only variant
used so far, useful in a kallsyms library and one more step in ditching
the MAP__FUNCTION/VARIABLE split.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-faonqs76n5808z9mq77edr94@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/symbol/kallsyms.c | 6 ++++++
 tools/lib/symbol/kallsyms.h | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/tools/lib/symbol/kallsyms.c b/tools/lib/symbol/kallsyms.c
index 689b6a130dd7..96d830545bbb 100644
--- a/tools/lib/symbol/kallsyms.c
+++ b/tools/lib/symbol/kallsyms.c
@@ -10,6 +10,12 @@ u8 kallsyms2elf_type(char type)
 	return (type == 't' || type == 'w') ? STT_FUNC : STT_OBJECT;
 }
 
+bool kallsyms__is_function(char symbol_type)
+{
+	symbol_type = toupper(symbol_type);
+	return symbol_type == 'T' || symbol_type == 'W';
+}
+
 int kallsyms__parse(const char *filename, void *arg,
 		    int (*process_symbol)(void *arg, const char *name,
 					  char type, u64 start))
diff --git a/tools/lib/symbol/kallsyms.h b/tools/lib/symbol/kallsyms.h
index bc40101d72c1..72ab9870454b 100644
--- a/tools/lib/symbol/kallsyms.h
+++ b/tools/lib/symbol/kallsyms.h
@@ -20,6 +20,8 @@ static inline u8 kallsyms2elf_binding(char type)
 
 u8 kallsyms2elf_type(char type);
 
+bool kallsyms__is_function(char symbol_type);
+
 int kallsyms__parse(const char *filename, void *arg,
 		    int (*process_symbol)(void *arg, const char *name,
 					  char type, u64 start));
-- 
2.14.3
