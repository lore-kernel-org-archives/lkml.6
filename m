Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5869BC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 08:21:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2720D217F4
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 08:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545034882;
	bh=nOufy+5Q97ErJCPdA6sg5bXp2yPze6GK6jeSkjaimg0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=D0lrdiESV7e4TpwG2HQs5nMuvEVZEVNRefTtg5xZujhVxngGq0jgR99X9I7Ea+UlZ
	 P+0EmEcdcumn01q1BJz0MXaaqr6eK8dR+xWia6T9YszACfnNp+1f4+xbVbr4CBRCuq
	 nM8zU4a9G5d5dj8EnmAXPXfKQKX+asJ8xgvwvWwI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731720AbeLQIVU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 03:21:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:56204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726496AbeLQIVU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 03:21:20 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E6E520672;
        Mon, 17 Dec 2018 08:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545034879;
        bh=nOufy+5Q97ErJCPdA6sg5bXp2yPze6GK6jeSkjaimg0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zJgMibpKlHIZHaJuc1GkmFmqOVKPTGOikGRAJyFjdaHSN1slFXlk44O71dbHwerC9
         YtQ7DdY8xXOY2gVD0py1hkQ6v2J/7V9l5Yr6ZU7i5fLJ3xT+iBLqjU9pv8k01rZyM+
         e93ao3PeQgkIkWZooiArNuvuONGomEYfD5EYSdPc=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Ingo Molnar <mingo@redhat.com>,
        Andrea Righi <righi.andrea@gmail.com>
Cc:     "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Yonghong Song <yhs@fb.com>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] kprobes: Blacklist symbols in arch-defined prohibited area
Date:   Mon, 17 Dec 2018 17:20:55 +0900
Message-Id: <154503485491.26176.15823229545155174796.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <154503482486.26176.6224515860220847638.stgit@devbox>
References: <154503482486.26176.6224515860220847638.stgit@devbox>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Blacklist symbols in arch-defined probe-prohibited areas.
With this change, user can see all symbols which are prohibited
to probe in debugfs.

All archtectures which have custom prohibit areas should define
its own arch_populate_kprobe_blacklist() function, but unless that,
all symbols marked __kprobes are blacklisted.

Reported-by: Andrea Righi <righi.andrea@gmail.com>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 Changes in v2:
  - Add area based blacklist adding helper function
  - Blacklist __kprobes_text symbols by default
  - Add __init to default function
---
 include/linux/kprobes.h |    3 ++
 kernel/kprobes.c        |   67 +++++++++++++++++++++++++++++++++++++----------
 2 files changed, 56 insertions(+), 14 deletions(-)

diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index e64b26c81c2f..e07e91daaacc 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -242,10 +242,13 @@ extern int arch_init_kprobes(void);
 extern void show_registers(struct pt_regs *regs);
 extern void kprobes_inc_nmissed_count(struct kprobe *p);
 extern bool arch_within_kprobe_blacklist(unsigned long addr);
+extern int arch_populate_kprobe_blacklist(void);
 extern bool arch_kprobe_on_func_entry(unsigned long offset);
 extern bool kprobe_on_func_entry(kprobe_opcode_t *addr, const char *sym, unsigned long offset);
 
 extern bool within_kprobe_blacklist(unsigned long addr);
+extern int kprobe_add_ksym_blacklist(unsigned long entry);
+extern int kprobe_add_area_blacklist(unsigned long start, unsigned long end);
 
 struct kprobe_insn_cache {
 	struct mutex mutex;
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 08e31d863191..f4ddfdd2d07e 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -2093,6 +2093,47 @@ void dump_kprobe(struct kprobe *kp)
 }
 NOKPROBE_SYMBOL(dump_kprobe);
 
+int kprobe_add_ksym_blacklist(unsigned long entry)
+{
+	struct kprobe_blacklist_entry *ent;
+	unsigned long offset = 0, size = 0;
+
+	if (!kernel_text_address(entry) ||
+	    !kallsyms_lookup_size_offset(entry, &size, &offset))
+		return -EINVAL;
+
+	ent = kmalloc(sizeof(*ent), GFP_KERNEL);
+	if (!ent)
+		return -ENOMEM;
+	ent->start_addr = entry;
+	ent->end_addr = entry + size;
+	INIT_LIST_HEAD(&ent->list);
+	list_add_tail(&ent->list, &kprobe_blacklist);
+
+	return (int)size;
+}
+
+/* Add all symbols in given area into kprobe blacklist */
+int kprobe_add_area_blacklist(unsigned long start, unsigned long end)
+{
+	unsigned long entry;
+	int ret = 0;
+
+	for (entry = start; entry < end; entry += ret) {
+		ret = kprobe_add_ksym_blacklist(entry);
+		if (ret < 0)
+			return ret;
+		if (ret == 0)	/* In case of alias symbol */
+			ret = 1;
+	}
+	return 0;
+}
+
+int __init __weak arch_populate_kprobe_blacklist(void)
+{
+	return 0;
+}
+
 /*
  * Lookup and populate the kprobe_blacklist.
  *
@@ -2104,26 +2145,24 @@ NOKPROBE_SYMBOL(dump_kprobe);
 static int __init populate_kprobe_blacklist(unsigned long *start,
 					     unsigned long *end)
 {
+	unsigned long entry;
 	unsigned long *iter;
-	struct kprobe_blacklist_entry *ent;
-	unsigned long entry, offset = 0, size = 0;
+	int ret;
 
 	for (iter = start; iter < end; iter++) {
 		entry = arch_deref_entry_point((void *)*iter);
-
-		if (!kernel_text_address(entry) ||
-		    !kallsyms_lookup_size_offset(entry, &size, &offset))
+		ret = kprobe_add_ksym_blacklist(entry);
+		if (ret == -EINVAL)
 			continue;
-
-		ent = kmalloc(sizeof(*ent), GFP_KERNEL);
-		if (!ent)
-			return -ENOMEM;
-		ent->start_addr = entry;
-		ent->end_addr = entry + size;
-		INIT_LIST_HEAD(&ent->list);
-		list_add_tail(&ent->list, &kprobe_blacklist);
+		if (ret < 0)
+			return ret;
 	}
-	return 0;
+
+	/* Symbols in __kprobes_text are blacklisted */
+	ret = kprobe_add_area_blacklist((unsigned long)__kprobes_text_start,
+					(unsigned long)__kprobes_text_end);
+
+	return ret ? : arch_populate_kprobe_blacklist();
 }
 
 /* Module notifier call back, checking kprobes on the module */

