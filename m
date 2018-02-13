Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932848AbeBMAEk (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 19:04:40 -0500
Received: from mga05.intel.com ([192.55.52.43]:38701 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932641AbeBMAEi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 19:04:38 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,504,1511856000";
   d="scan'208";a="203567453"
From: Andi Kleen <andi@firstfloor.org>
To: tglx@linutronix.de
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, bp@alien8.de,
        dwmw2@infradead.org, jpoimboe@redhat.com,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 1/2] objtool: Don't warn for intra function calls in alternative
Date: Mon, 12 Feb 2018 16:04:21 -0800
Message-Id: <20180213000422.16916-1-andi@firstfloor.org>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

objtool suggests to put intra function calls, like used in
stuff rsb, into alternative, but then starts warning about the
alternative section too. Avoid these warnings.

Needed for the next patch.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 tools/objtool/check.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 2e458eb45586..ec46db0dcdc0 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -544,7 +544,8 @@ static int add_call_destinations(struct objtool_file *file)
 			insn->call_dest = find_symbol_by_offset(insn->sec,
 								dest_off);
 
-			if (!insn->call_dest && !insn->ignore) {
+			if (!insn->call_dest && !insn->ignore &&
+			    strcmp(insn->sec->name, ".altinstr_replacement")) {
 				WARN_FUNC("unsupported intra-function call",
 					  insn->sec, insn->offset);
 				WARN("If this is a retpoline, please patch it in with alternatives and annotate it with ANNOTATE_NOSPEC_ALTERNATIVE.");
-- 
2.14.3
