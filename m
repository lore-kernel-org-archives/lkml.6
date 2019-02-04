Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74022C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 20:00:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46C652081B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 20:00:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727299AbfBDUAK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 15:00:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34280 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727247AbfBDUAK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 15:00:10 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CFF9C3D15;
        Mon,  4 Feb 2019 20:00:09 +0000 (UTC)
Received: from t460s.bristot.redhat.com (ovpn-117-55.phx2.redhat.com [10.3.117.55])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 302399DA8C;
        Mon,  4 Feb 2019 19:59:57 +0000 (UTC)
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     bristot@redhat.com, Thomas Gleixner <tglx@linutronix.de>,
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
Subject: [PATCH V4 2/9] jump_label: Add the jump_label_can_update_check() helper
Date:   Mon,  4 Feb 2019 20:58:55 +0100
Message-Id: <36237a0ee38d6c98d080d3fee2921501d8788e4d.1549308412.git.bristot@redhat.com>
In-Reply-To: <cover.1549308412.git.bristot@redhat.com>
References: <cover.1549308412.git.bristot@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Mon, 04 Feb 2019 20:00:10 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the check of if a jump_entry is valid to a function.

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
 kernel/jump_label.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/kernel/jump_label.c b/kernel/jump_label.c
index 288d630da22d..456c0d7cbb5b 100644
--- a/kernel/jump_label.c
+++ b/kernel/jump_label.c
@@ -374,22 +374,32 @@ static enum jump_label_type jump_label_type(struct jump_entry *entry)
 	return enabled ^ branch;
 }
 
+bool jump_label_can_update_check(struct jump_entry *entry, bool init)
+{
+	/*
+	 * An entry->code of 0 indicates an entry which has been
+	 * disabled because it was in an init text area.
+	 */
+	if (init || !jump_entry_is_init(entry)) {
+		if (!kernel_text_address(jump_entry_code(entry))) {
+			WARN_ONCE(1, "can't patch jump_label at %pS",
+				  (void *)jump_entry_code(entry));
+			return 0;
+		}
+		return 1;
+	}
+	return 0;
+}
+
 static void __jump_label_update(struct static_key *key,
 				struct jump_entry *entry,
 				struct jump_entry *stop,
 				bool init)
 {
 	for_each_label_entry(key, entry, stop) {
-		/*
-		 * An entry->code of 0 indicates an entry which has been
-		 * disabled because it was in an init text area.
-		 */
-		if (init || !jump_entry_is_init(entry)) {
-			if (kernel_text_address(jump_entry_code(entry)))
-				arch_jump_label_transform(entry, jump_label_type(entry));
-			else
-				WARN_ONCE(1, "can't patch jump_label at %pS",
-					  (void *)jump_entry_code(entry));
+		if (jump_label_can_update_check(entry, init)) {
+			arch_jump_label_transform(entry,
+						  jump_label_type(entry));
 		}
 	}
 }
-- 
2.17.1

