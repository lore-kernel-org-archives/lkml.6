Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752616AbeEBPYy (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 11:24:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:48168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752300AbeEBPWL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 11:22:11 -0400
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Dave Martin <dave.martin@linaro.org>, David Ahern <dsahern@gmail.com>,
        "Dr . David Alan Gilbert" <david.gilbert@linaro.org>,
        Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 42/52] perf symbols: Use symbol type instead of map->type
Date: Wed,  2 May 2018 12:19:32 -0300
Message-Id: <20180502151942.20542-43-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180502151942.20542-1-acme@kernel.org>
References: <20180502151942.20542-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

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
 
-- 
2.14.3
