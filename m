Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755360AbeCSHcz (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 03:32:55 -0400
Received: from mga07.intel.com ([134.134.136.100]:26218 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755218AbeCSHcy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 03:32:54 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,329,1517904000";
   d="scan'208";a="212824047"
From: changbin.du@intel.com
To: akpm@linux-foundation.org, tglx@linutronix.de, pombredanne@nexb.com,
        neilb@suse.com
Cc: linux-kernel@vger.kernel.org, Changbin Du <changbin.du@intel.com>
Subject: [PATCH] scripts/faddr2line: show the code context
Date: Mon, 19 Mar 2018 15:23:25 +0800
Message-Id: <1521444205-2259-1-git-send-email-changbin.du@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Changbin Du <changbin.du@intel.com>

Inspired by gdb command 'list', show the code context of target lines.
Here is a example:

$ scripts/faddr2line vmlinux native_write_msr+0x6
native_write_msr+0x6/0x20:
arch_static_branch at arch/x86/include/asm/msr.h:105
100             return EAX_EDX_VAL(val, low, high);
101     }
102
103     static inline void notrace __wrmsr(unsigned int msr, u32 low, u32 high)
104     {
105             asm volatile("1: wrmsr\n"
106                          "2:\n"
107                          _ASM_EXTABLE_HANDLE(1b, 2b, ex_handler_wrmsr_unsafe)
108                          : : "c" (msr), "a"(low), "d" (high) : "memory");
109     }
110
(inlined by) static_key_false at include/linux/jump_label.h:142
137     #define JUMP_TYPE_LINKED        2UL
138     #define JUMP_TYPE_MASK          3UL
139
140     static __always_inline bool static_key_false(struct static_key *key)
141     {
142             return arch_static_branch(key, false);
143     }
144
145     static __always_inline bool static_key_true(struct static_key *key)
146     {
147             return !arch_static_branch(key, true);
(inlined by) native_write_msr at arch/x86/include/asm/msr.h:150
145     static inline void notrace
146     native_write_msr(unsigned int msr, u32 low, u32 high)
147     {
148             __wrmsr(msr, low, high);
149
150             if (msr_tracepoint_active(__tracepoint_write_msr))
151                     do_trace_write_msr(msr, ((u64)high << 32 | low), 0);
152     }
153
154     /* Can be uninlined because referenced by paravirt */
155     static inline int notrace

Signed-off-by: Changbin Du <changbin.du@intel.com>
---
 scripts/faddr2line | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/scripts/faddr2line b/scripts/faddr2line
index 7721d5b..9e5735a 100755
--- a/scripts/faddr2line
+++ b/scripts/faddr2line
@@ -163,7 +163,17 @@ __faddr2line() {
 
 		# pass real address to addr2line
 		echo "$func+$offset/$sym_size:"
-		${ADDR2LINE} -fpie $objfile $addr | sed "s; $dir_prefix\(\./\)*; ;"
+		local file_lines=$(${ADDR2LINE} -fpie $objfile $addr | sed "s; $dir_prefix\(\./\)*; ;")
+		[[ -z $file_lines ]] && return
+
+		# show each line with context
+		echo "$file_lines" | while read -r line
+		do
+			echo $line
+			eval $(echo $line | awk -F "[ :]" '{printf("n1=%d;n2=%d;f=%s",$NF-5, $NF+5, $(NF-1))}')
+			awk 'NR>=strtonum("'$n1'") && NR<=strtonum("'$n2'") {printf("%d\t%s\n", NR, $0)}' $f
+		done
+
 		DONE=1
 
 	done < <(${NM} -n $objfile | awk -v fn=$func -v end=$file_end '$3 == fn { found=1; line=$0; start=$1; next } found == 1 { found=0; print line, "0x"$1 } END {if (found == 1) print line, end; }')
-- 
2.7.4
