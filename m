Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ECF3C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 10:27:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14F2F21908
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 10:27:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389525AbeLUK1u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 05:27:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58246 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731787AbeLUK1s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 05:27:48 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 706273DDBE;
        Fri, 21 Dec 2018 10:27:48 +0000 (UTC)
Received: from f28server.default (ovpn-116-118.phx2.redhat.com [10.3.116.118])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4612D5D737;
        Fri, 21 Dec 2018 10:27:45 +0000 (UTC)
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Chris von Recklinghausen <crecklin@redhat.com>,
        Jason Baron <jbaron@akamai.com>, Scott Wood <swood@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Clark Williams <williams@redhat.com>, x86@kernel.org
Subject: [PATCH V3 1/9] jump_label: Add for_each_label_entry helper
Date:   Fri, 21 Dec 2018 11:27:26 +0100
Message-Id: <206640539a01e31b6f4ef4ef74962b1394e2f930.1545228276.git.bristot@redhat.com>
In-Reply-To: <cover.1545228276.git.bristot@redhat.com>
References: <cover.1545228276.git.bristot@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Fri, 21 Dec 2018 10:27:48 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a helper macro to make jump entry iteration code more readable.

Signed-off-by: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
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
 include/linux/jump_label.h | 3 +++
 kernel/jump_label.c        | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/jump_label.h b/include/linux/jump_label.h
index 5df6a621e464..c88d903befc0 100644
--- a/include/linux/jump_label.h
+++ b/include/linux/jump_label.h
@@ -231,6 +231,9 @@ extern void static_key_disable(struct static_key *key);
 extern void static_key_enable_cpuslocked(struct static_key *key);
 extern void static_key_disable_cpuslocked(struct static_key *key);
 
+#define for_each_label_entry(key, entry, stop)				  \
+	for (; (entry < stop) && (jump_entry_key(entry) == key); entry++)
+
 /*
  * We should be using ATOMIC_INIT() for initializing .enabled, but
  * the inclusion of atomic.h is problematic for inclusion of jump_label.h
diff --git a/kernel/jump_label.c b/kernel/jump_label.c
index b28028b08d44..65965eb1cf05 100644
--- a/kernel/jump_label.c
+++ b/kernel/jump_label.c
@@ -381,7 +381,7 @@ static void __jump_label_update(struct static_key *key,
 				struct jump_entry *stop,
 				bool init)
 {
-	for (; (entry < stop) && (jump_entry_key(entry) == key); entry++) {
+	for_each_label_entry(key, entry, stop) {
 		/*
 		 * An entry->code of 0 indicates an entry which has been
 		 * disabled because it was in an init text area.
-- 
2.17.1

