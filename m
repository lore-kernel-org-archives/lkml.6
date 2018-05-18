Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751909AbeERQ1p (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 12:27:45 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50816 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750763AbeERQ1l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 12:27:41 -0400
Date: Fri, 18 May 2018 18:27:39 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        syzbot <syzbot+30d675e3ca03c1c351e7@syzkaller.appspotmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH] uprobes/x86: remove the wrong WARN_ON() in uprobe_init_insn()
Message-ID: <20180518162739.GA5559@redhat.com>
References: <000000000000b759cf056c2b3c12@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000b759cf056c2b3c12@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

insn_get_length() has the side-effect of processing the entire instruction
but only if it was decoded successfully, otherwise insn_complete() can fail
and in this case we need to just return an error without warning.

Reported-by: syzbot+30d675e3ca03c1c351e7@syzkaller.appspotmail.com
Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 arch/x86/kernel/uprobes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
index 85c7ef2..efd7ee9 100644
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -293,7 +293,7 @@ static int uprobe_init_insn(struct arch_uprobe *auprobe, struct insn *insn, bool
 	insn_init(insn, auprobe->insn, sizeof(auprobe->insn), x86_64);
 	/* has the side-effect of processing the entire instruction */
 	insn_get_length(insn);
-	if (WARN_ON_ONCE(!insn_complete(insn)))
+	if (!insn_complete(insn))
 		return -ENOEXEC;
 
 	if (is_prefix_bad(insn))
-- 
2.5.0
