Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 239E6C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 12:53:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3A872084D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 12:53:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3A872084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbeJHUFI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 16:05:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52752 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725893AbeJHUFH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 16:05:07 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 73FB088312;
        Mon,  8 Oct 2018 12:53:33 +0000 (UTC)
Received: from f28server.default (ovpn-116-135.phx2.redhat.com [10.3.116.135])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E51B663756;
        Mon,  8 Oct 2018 12:53:29 +0000 (UTC)
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
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
        Clark Williams <williams@redhat.com>
Subject: [RFC PATCH 2/6] jump_label: Add the jump_label_can_update_check() helper
Date:   Mon,  8 Oct 2018 14:53:01 +0200
Message-Id: <6323276163587de071cd830f9f4def97cf222550.1539001620.git.bristot@redhat.com>
In-Reply-To: <cover.1539001620.git.bristot@redhat.com>
References: <cover.1539001620.git.bristot@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Mon, 08 Oct 2018 12:53:33 +0000 (UTC)
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
 kernel/jump_label.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/kernel/jump_label.c b/kernel/jump_label.c
index e853916a3b46..940ba7819c87 100644
--- a/kernel/jump_label.c
+++ b/kernel/jump_label.c
@@ -361,22 +361,29 @@ static enum jump_label_type jump_label_type(struct jump_entry *entry)
 	return enabled ^ branch;
 }
 
+bool jump_label_can_update_check(struct jump_entry *entry)
+{
+	/*
+	 * An entry->code of 0 indicates an entry which has been
+	 * disabled because it was in an init text area.
+	 */
+	if (entry->code) {
+		if (kernel_text_address(entry->code))
+			return 1;
+		else
+			WARN_ONCE(1, "can't patch jump_label at %pS",
+				  (void *)(unsigned long)entry->code);
+	}
+	return 0;
+}
+
 static void __jump_label_update(struct static_key *key,
 				struct jump_entry *entry,
 				struct jump_entry *stop)
 {
 	for_each_label_entry(key, entry, stop) {
-		/*
-		 * An entry->code of 0 indicates an entry which has been
-		 * disabled because it was in an init text area.
-		 */
-		if (entry->code) {
-			if (kernel_text_address(entry->code))
-				arch_jump_label_transform(entry, jump_label_type(entry));
-			else
-				WARN_ONCE(1, "can't patch jump_label at %pS",
-					  (void *)(unsigned long)entry->code);
-		}
+		if (jump_label_can_update_check(entry))
+			arch_jump_label_transform(entry, jump_label_type(entry));
 	}
 }
 
-- 
2.17.1

