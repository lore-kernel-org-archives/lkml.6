Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751544AbeEBSAg (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 14:00:36 -0400
Received: from terminus.zytor.com ([198.137.202.136]:54783 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750918AbeEBSAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 14:00:31 -0400
Date: Wed, 2 May 2018 11:00:22 -0700
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-us590h81uqgxaumucfttqj50@git.kernel.org>
Cc: david.gilbert@linaro.org, dsahern@gmail.com,
        linux-kernel@vger.kernel.org, namhyung@kernel.org,
        adrian.hunter@intel.com, wangnan0@huawei.com, acme@redhat.com,
        dave.martin@linaro.org, mingo@kernel.org, hpa@zytor.com,
        jolsa@kernel.org, tglx@linutronix.de
Reply-To: wangnan0@huawei.com, linux-kernel@vger.kernel.org,
        namhyung@kernel.org, adrian.hunter@intel.com, david.gilbert@linaro.org,
        dsahern@gmail.com, jolsa@kernel.org, tglx@linutronix.de, hpa@zytor.com,
        acme@redhat.com, dave.martin@linaro.org, mingo@kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf symbols: Use symbol type instead of map->type
Git-Commit-ID: 18231d79466e6b183b4f3b2aa66231fb4052fb85
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

Commit-ID:  18231d79466e6b183b4f3b2aa66231fb4052fb85
Gitweb:     https://git.kernel.org/tip/18231d79466e6b183b4f3b2aa66231fb4052fb85
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Thu, 26 Apr 2018 12:45:17 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 26 Apr 2018 13:47:20 -0300

perf symbols: Use symbol type instead of map->type

map->type is going away, we can derive it from map->prot, so use
the same logic as in the kernel's arch/arm/kernel/module.c file:

  ELF32_ST_TYPE(sym->st_info) == STT_FUNC && !(sym->st_value & 1))

This was introduced in b2f8fb237e9c ("perf symbols: Fix annotation of
thumb code"), that fix is maintained with this change.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Dave Martin <dave.martin@linaro.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Dr. David Alan Gilbert <david.gilbert@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-us590h81uqgxaumucfttqj50@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/symbol-elf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index cf2e6f428bb4..82a1aadc245f 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -982,7 +982,7 @@ int dso__load_sym(struct dso *dso, struct map *map, struct symsrc *syms_ss,
 		/* On ARM, symbols for thumb functions have 1 added to
 		 * the symbol address as a flag - remove it */
 		if ((ehdr.e_machine == EM_ARM) &&
-		    (map->type == MAP__FUNCTION) &&
+		    (GELF_ST_TYPE(sym.st_info) == STT_FUNC) &&
 		    (sym.st_value & 1))
 			--sym.st_value;
 
