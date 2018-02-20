Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932303AbeBTBAJ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 20:00:09 -0500
Received: from a8-62.smtp-out.amazonses.com ([54.240.8.62]:46556 "EHLO
        a8-62.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932237AbeBTBAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 20:00:08 -0500
From: Jeremy Cline <jeremy@jcline.org>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeremy Cline <jeremy@jcline.org>
Subject: [PATCH] tools/libbpf: Avoid possibly using uninitialized variable
Date: Tue, 20 Feb 2018 01:00:07 +0000
Message-ID: <01000161b0b991f8-7579000f-4510-4073-b081-a0ddd60d2090-000000@email.amazonses.com>
X-Mailer: git-send-email 2.16.2
X-SES-Outgoing: 2018.02.20-54.240.8.62
Feedback-ID: 1.us-east-1.z18Isoc/FaoPOvCyJyi1mnTt8STwoRuibXVNoUcvG6g=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes a GCC maybe-uninitialized warning introduced by 48cca7e44f9f.
"text" is only initialized inside the if statement so only print debug
info there.

Signed-off-by: Jeremy Cline <jeremy@jcline.org>
---
 tools/lib/bpf/libbpf.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 97073d649c1a..5bbbf285af74 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -1060,11 +1060,12 @@ bpf_program__reloc_text(struct bpf_program *prog, struct bpf_object *obj,
 		prog->insns = new_insn;
 		prog->main_prog_cnt = prog->insns_cnt;
 		prog->insns_cnt = new_cnt;
+		pr_debug("added %zd insn from %s to prog %s\n",
+			 text->insns_cnt, text->section_name,
+			 prog->section_name);
 	}
 	insn = &prog->insns[relo->insn_idx];
 	insn->imm += prog->main_prog_cnt - relo->insn_idx;
-	pr_debug("added %zd insn from %s to prog %s\n",
-		 text->insns_cnt, text->section_name, prog->section_name);
 	return 0;
 }
 
-- 
2.16.2
