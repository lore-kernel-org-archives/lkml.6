Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06866C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:47:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB0F9218A2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:47:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727462AbeLRQrt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 11:47:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36965 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726548AbeLRQrr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 11:47:47 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D6BBC89AC1;
        Tue, 18 Dec 2018 16:47:46 +0000 (UTC)
Received: from f28server.default (ovpn-116-118.phx2.redhat.com [10.3.116.118])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 417E565959;
        Tue, 18 Dec 2018 16:47:43 +0000 (UTC)
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Zhou Chengming <zhouchengming1@huawei.com>,
        Jiri Kosina <jkosina@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Chris von Recklinghausen <crecklin@redhat.com>,
        Jason Baron <jbaron@akamai.com>, Scott Wood <swood@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Clark Williams <williams@redhat.com>, x86@kernel.org
Subject: [PATCH V2 8/9] x86/jump_label: Batch jump label updates
Date:   Tue, 18 Dec 2018 17:46:37 +0100
Message-Id: <d8e131bb2af8b44999cdc0dd16f056cf8c0976af.1545149539.git.bristot@redhat.com>
In-Reply-To: <cover.1545149539.git.bristot@redhat.com>
References: <cover.1545149539.git.bristot@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Tue, 18 Dec 2018 16:47:47 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the jump label of a static key is transformed via the arch
specific function:

    void arch_jump_label_transform(struct jump_entry *entry,
                                   enum jump_label_type type)

The new approach (batch mode) uses two arch functions, the first has the
same arguments of the arch_jump_label_transform(), and is the function:

    void arch_jump_label_transform_queue(struct jump_entry *entry,
					 enum jump_label_type type)

Rather than transforming the code, it adds the jump_entry in a queue of
entries to be updated. This functions returns 1 in the case of a
successful enqueue of an entry. If it returns 0, the caller must to
apply the queue and then try to queue again, for instance, because the
queue is full.

This function expects the caller to sort the entries by the address before
enqueueuing then. This is already done by the arch independent code, though.

After queuing all jump_entries, the function:

    void arch_jump_label_transform_apply(void)

Applies the changes in the queue.

Signed-off-by: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Pavel Tatashin <pasha.tatashin@oracle.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Cc: Zhou Chengming <zhouchengming1@huawei.com>
Cc: Jiri Kosina <jkosina@suse.cz>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc: Chris von Recklinghausen <crecklin@redhat.com>
Cc: Jason Baron <jbaron@akamai.com>
Cc: Scott Wood <swood@redhat.com>
Cc: Marcelo Tosatti <mtosatti@redhat.com>
Cc: Clark Williams <williams@redhat.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
---
 arch/x86/include/asm/jump_label.h |  2 +
 arch/x86/kernel/jump_label.c      | 88 +++++++++++++++++++++++++++++++
 2 files changed, 90 insertions(+)

diff --git a/arch/x86/include/asm/jump_label.h b/arch/x86/include/asm/jump_label.h
index a5fb34fe56a4..39f908e8c0d1 100644
--- a/arch/x86/include/asm/jump_label.h
+++ b/arch/x86/include/asm/jump_label.h
@@ -2,6 +2,8 @@
 #ifndef _ASM_X86_JUMP_LABEL_H
 #define _ASM_X86_JUMP_LABEL_H
 
+#define HAVE_JUMP_LABEL_BATCH
+
 #define JUMP_LABEL_NOP_SIZE 5
 
 #ifdef CONFIG_X86_64
diff --git a/arch/x86/kernel/jump_label.c b/arch/x86/kernel/jump_label.c
index a039ac4ca5bf..633c103412e1 100644
--- a/arch/x86/kernel/jump_label.c
+++ b/arch/x86/kernel/jump_label.c
@@ -15,6 +15,7 @@
 #include <asm/kprobes.h>
 #include <asm/alternative.h>
 #include <asm/text-patching.h>
+#include <linux/slab.h>
 
 #ifdef HAVE_JUMP_LABEL
 
@@ -132,6 +133,93 @@ void arch_jump_label_transform(struct jump_entry *entry,
 	mutex_unlock(&text_mutex);
 }
 
+struct text_to_poke *entry_vector;
+unsigned int entry_vector_max_elem __read_mostly;
+unsigned int entry_vector_nr_elem;
+
+void arch_jump_label_init(void)
+{
+	entry_vector = (void *) __get_free_page(GFP_KERNEL);
+
+	if (WARN_ON_ONCE(!entry_vector))
+		return;
+
+	entry_vector_max_elem = PAGE_SIZE / sizeof(struct text_to_poke);
+	return;
+}
+
+int arch_jump_label_transform_queue(struct jump_entry *entry,
+				     enum jump_label_type type)
+{
+	void *entry_code;
+	struct text_to_poke *tp;
+
+	/*
+	 * Batch mode disabled before being able to allocate memory:
+	 * Fallback to the non-batching mode.
+	 */
+	if (unlikely(!entry_vector_max_elem)) {
+		if (!slab_is_available() || early_boot_irqs_disabled)
+			goto fallback;
+
+		arch_jump_label_init();
+	}
+
+	/*
+	 * No more space in the vector, tell upper layer to apply
+	 * the queue before continuing.
+	 */
+	if (entry_vector_nr_elem == entry_vector_max_elem)
+		return 0;
+
+	tp = &entry_vector[entry_vector_nr_elem];
+
+	entry_code = (void *)jump_entry_code(entry);
+
+	/*
+	 * The int3 handler will do a bsearch in the queue, so we need entries
+	 * to be sorted. We can survive an unsorted list by rejecting the entry,
+	 * forcing the generic jump_label code to apply the queue. Warning once,
+	 * to raise the attention to the case of an unsorted entry that is
+	 * better not happen, because, in the worst case we will perform in the
+	 * same way as we do without batching - with some more overhead.
+	 */
+	if (entry_vector_nr_elem > 0) {
+		int prev_idx = entry_vector_nr_elem - 1;
+		struct text_to_poke *prev_tp = &entry_vector[prev_idx];
+
+		if (WARN_ON_ONCE(prev_tp->addr > entry_code))
+			return 0;
+	}
+
+	__jump_label_set_jump_code(entry, type,
+				   (union jump_code_union *) &tp->opcode, 0);
+
+	tp->addr = entry_code;
+	tp->handler = entry_code + JUMP_LABEL_NOP_SIZE;
+	tp->len = JUMP_LABEL_NOP_SIZE;
+
+	entry_vector_nr_elem++;
+
+	return 1;
+
+fallback:
+	arch_jump_label_transform(entry, type);
+	return 1;
+}
+
+void arch_jump_label_transform_apply(void)
+{
+	if (early_boot_irqs_disabled || !entry_vector_nr_elem)
+		return;
+
+	mutex_lock(&text_mutex);
+	text_poke_bp_batch(entry_vector, entry_vector_nr_elem);
+	mutex_unlock(&text_mutex);
+
+	entry_vector_nr_elem = 0;
+}
+
 static enum {
 	JL_STATE_START,
 	JL_STATE_NO_UPDATE,
-- 
2.17.1

