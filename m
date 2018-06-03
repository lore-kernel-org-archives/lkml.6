Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751508AbeFCRRj (ORCPT <rfc822;w@1wt.eu>);
        Sun, 3 Jun 2018 13:17:39 -0400
Received: from terminus.zytor.com ([198.137.202.136]:55705 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751057AbeFCRRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jun 2018 13:17:37 -0400
Date: Sun, 3 Jun 2018 10:17:28 -0700
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-o3wfwjnyh7r8l0gi9q3y9f44@git.kernel.org>
Cc: mhiramat@kernel.org, acme@redhat.com, mingo@kernel.org, hpa@zytor.com,
        adrian.hunter@intel.com, jolsa@kernel.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, dsahern@gmail.com, namhyung@kernel.org,
        wangnan0@huawei.com
Reply-To: mingo@kernel.org, adrian.hunter@intel.com, hpa@zytor.com,
        mhiramat@kernel.org, acme@redhat.com, jolsa@kernel.org,
        namhyung@kernel.org, wangnan0@huawei.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, dsahern@gmail.com
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf tools intel-pt-decoder: Update insn.h from
 the kernel sources
Git-Commit-ID: 0b3a18387f3e5cdcfaaf884860a4688280d09c9d
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

Commit-ID:  0b3a18387f3e5cdcfaaf884860a4688280d09c9d
Gitweb:     https://git.kernel.org/tip/0b3a18387f3e5cdcfaaf884860a4688280d09c9d
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Fri, 1 Jun 2018 13:15:19 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 1 Jun 2018 16:13:18 -0300

perf tools intel-pt-decoder: Update insn.h from the kernel sources

To pick up the changes in:

  ee6a7354a362 ("kprobes/x86: Prohibit probing on exception masking instructions")

That doesn't entail changes in tooling, but silences this perf build
warning:

  Warning: Intel PT: x86 instruction decoder header at 'tools/perf/util/intel-pt-decoder/insn.h' differs from latest version at 'arch/x86/include/asm/insn.h'

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-o3wfwjnyh7r8l0gi9q3y9f44@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/intel-pt-decoder/insn.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tools/perf/util/intel-pt-decoder/insn.h b/tools/perf/util/intel-pt-decoder/insn.h
index e23578c7b1be..2669c9f748e4 100644
--- a/tools/perf/util/intel-pt-decoder/insn.h
+++ b/tools/perf/util/intel-pt-decoder/insn.h
@@ -208,4 +208,22 @@ static inline int insn_offset_immediate(struct insn *insn)
 	return insn_offset_displacement(insn) + insn->displacement.nbytes;
 }
 
+#define POP_SS_OPCODE 0x1f
+#define MOV_SREG_OPCODE 0x8e
+
+/*
+ * Intel SDM Vol.3A 6.8.3 states;
+ * "Any single-step trap that would be delivered following the MOV to SS
+ * instruction or POP to SS instruction (because EFLAGS.TF is 1) is
+ * suppressed."
+ * This function returns true if @insn is MOV SS or POP SS. On these
+ * instructions, single stepping is suppressed.
+ */
+static inline int insn_masking_exception(struct insn *insn)
+{
+	return insn->opcode.bytes[0] == POP_SS_OPCODE ||
+		(insn->opcode.bytes[0] == MOV_SREG_OPCODE &&
+		 X86_MODRM_REG(insn->modrm.bytes[0]) == 2);
+}
+
 #endif /* _ASM_X86_INSN_H */
