Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751456AbeEBRxf (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 13:53:35 -0400
Received: from terminus.zytor.com ([198.137.202.136]:46271 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751021AbeEBRxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 13:53:33 -0400
Date: Wed, 2 May 2018 10:53:23 -0700
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-faonqs76n5808z9mq77edr94@git.kernel.org>
Cc: namhyung@kernel.org, dsahern@gmail.com, wangnan0@huawei.com,
        jolsa@kernel.org, acme@redhat.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        adrian.hunter@intel.com, hpa@zytor.com
Reply-To: jolsa@kernel.org, wangnan0@huawei.com, dsahern@gmail.com,
        namhyung@kernel.org, hpa@zytor.com, adrian.hunter@intel.com,
        mingo@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        acme@redhat.com
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] tools lib symbols: Introduce
 kallsyms__is_function()
Git-Commit-ID: 494e31e2a2b1cdc3efc60043fac5bbd39a6fb04f
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  494e31e2a2b1cdc3efc60043fac5bbd39a6fb04f
Gitweb:     https://git.kernel.org/tip/494e31e2a2b1cdc3efc60043fac5bbd39a6fb04f
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Wed, 25 Apr 2018 17:09:55 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 26 Apr 2018 13:47:14 -0300

tools lib symbols: Introduce kallsyms__is_function()

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
