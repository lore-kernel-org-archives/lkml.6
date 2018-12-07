Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF940C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 16:01:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FCB620882
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 16:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544198486;
	bh=DyCh/ImfW25UtduGv52DWcdbMI2LCSAyfqrW9bLJ6QI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=TCN4WR7jlGZgg7FB8QiQCLgoWWAX0kRWOgVfCIATqH/mq34vkE7bYDeLyEuHK7K+X
	 dIpel8+bBXOGkIZM1nbAwrNJeSwz/Wzk58a1lPNfHibusmUmIqzcz2W4SCGS1T4DP/
	 WaXvJ5vKDbRpT20kYwkhTx6k55F+pNJpgxAu//Mc=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FCB620882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726076AbeLGQBZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 11:01:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:58378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726010AbeLGQBY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 11:01:24 -0500
Received: from devnote (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3541720673;
        Fri,  7 Dec 2018 16:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544198484;
        bh=DyCh/ImfW25UtduGv52DWcdbMI2LCSAyfqrW9bLJ6QI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Kz/8GLq3qkILKvNsb5J3J0QFzJv8BvpivmlJL5iA/pQJ2NQrX9/LJ8qScKYqhTVOC
         AzgGub58gcGIBd3fLrOQdJh88hfLqCi443cRGmgCMVivK1D21w9fECQohffuhuhia2
         j+rRJxSrzr8HAfuLwVuFnnZCxLYX73iMmzRlmhkY=
Date:   Sat, 8 Dec 2018 01:01:20 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Andrea Righi <righi.andrea@gmail.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Yonghong Song <yhs@fb.com>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kprobes: x86_64: blacklist non-attachable interrupt
 functions
Message-Id: <20181208010120.c3eda9042912068aecc68317@kernel.org>
In-Reply-To: <20181207234731.f52a8c1eff6c0e72c073ad40@kernel.org>
References: <20181206095648.GA8249@Dell>
        <20181207234731.f52a8c1eff6c0e72c073ad40@kernel.org>
X-Mailer: Sylpheed 3.5.0 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrea and Ingo,

Here is the patch what I meant. I just ran it on qemu-x86, and seemed working.
After introducing this patch, I will start adding arch_populate_kprobe_blacklist()
to some arches.

Thank you,

[RFC] kprobes: x86/kprobes: Blacklist symbols in arch-defined prohibited area

From: Masami Hiramatsu <mhiramat@kernel.org>

Blacklist symbols in arch-defined probe-prohibited areas.
With this change, user can see all symbols which are prohibited
to probe in debugfs.

All archtectures which have custom prohibit areas should define
its own arch_populate_kprobe_blacklist() function, but unless that,
all symbols marked __kprobes are blacklisted.

Reported-by: Andrea Righi <righi.andrea@gmail.com>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 arch/x86/kernel/kprobes/core.c |   27 ++++++++++++++++++
 include/linux/kprobes.h        |    2 +
 kernel/kprobes.c               |   60 +++++++++++++++++++++++++++++++---------
 3 files changed, 75 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index c33b06f..52771e3 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -1034,6 +1034,33 @@ bool arch_within_kprobe_blacklist(unsigned long addr)
 		 addr < (unsigned long)__entry_text_end);
 }
 
+int __init arch_populate_kprobe_blacklist(void)
+{
+	unsigned long entry;
+	int ret = 0;
+
+	for (entry = (unsigned long)__kprobes_text_start;
+	     entry < (unsigned long)__kprobes_text_end;
+	     entry += ret) {
+		ret = kprobe_add_ksym_blacklist(entry);
+		if (ret < 0)
+			return ret;
+		if (ret == 0)	/* In case of alias symbol */
+			ret = 1;
+	}
+
+	for (entry = (unsigned long)__entry_text_start;
+	     entry < (unsigned long)__entry_text_end;
+	     entry += ret) {
+		ret = kprobe_add_ksym_blacklist(entry);
+		if (ret < 0)
+			return ret;
+		if (ret == 0)	/* In case of alias symbol */
+			ret = 1;
+	}
+	return 0;
+}
+
 int __init arch_init_kprobes(void)
 {
 	return 0;
diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index e909413..a68cbbe 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -242,10 +242,12 @@ extern int arch_init_kprobes(void);
 extern void show_registers(struct pt_regs *regs);
 extern void kprobes_inc_nmissed_count(struct kprobe *p);
 extern bool arch_within_kprobe_blacklist(unsigned long addr);
+extern int arch_populate_kprobe_blacklist(void);
 extern bool arch_kprobe_on_func_entry(unsigned long offset);
 extern bool kprobe_on_func_entry(kprobe_opcode_t *addr, const char *sym, unsigned long offset);
 
 extern bool within_kprobe_blacklist(unsigned long addr);
+extern int kprobe_add_ksym_blacklist(unsigned long entry);
 
 struct kprobe_insn_cache {
 	struct mutex mutex;
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 90e98e2..8b2eb62 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -2093,6 +2093,44 @@ void dump_kprobe(struct kprobe *kp)
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
+	ent->start_addr = entry - offset;
+	ent->end_addr = entry - offset + size;
+	INIT_LIST_HEAD(&ent->list);
+	list_add_tail(&ent->list, &kprobe_blacklist);
+
+	return (int)size;
+}
+
+/* Add functions in arch defined probe-prohibited area */
+int __weak arch_populate_kprobe_blacklist(void)
+{
+	unsigned long entry;
+	int ret = 0;
+
+	for (entry = (unsigned long)__kprobes_text_start;
+	     entry < (unsigned long)__kprobes_text_end;
+	     entry += ret) {
+		ret = kprobe_add_ksym_blacklist(entry);
+		if (ret < 0)
+			return ret;
+		if (ret == 0)	/* In case of alias symbol */
+			ret = 1;
+	}
+	return 0;
+}
+
 /*
  * Lookup and populate the kprobe_blacklist.
  *
@@ -2104,26 +2142,20 @@ NOKPROBE_SYMBOL(dump_kprobe);
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
+	return arch_populate_kprobe_blacklist();
 }
 
 /* Module notifier call back, checking kprobes on the module */
