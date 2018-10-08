Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FCBDC676D2
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 12:53:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D60B72084D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 12:53:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D60B72084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbeJHUFE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 16:05:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35720 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725893AbeJHUFE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 16:05:04 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A89EF308424D;
        Mon,  8 Oct 2018 12:53:29 +0000 (UTC)
Received: from f28server.default (ovpn-116-135.phx2.redhat.com [10.3.116.135])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4677A6530E;
        Mon,  8 Oct 2018 12:53:24 +0000 (UTC)
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
Subject: [RFC PATCH 1/6] jump_label: Add for_each_label_entry helper
Date:   Mon,  8 Oct 2018 14:53:00 +0200
Message-Id: <f2bfbd846f05fa10701bac9fde44d0d5bb736c4d.1539001620.git.bristot@redhat.com>
In-Reply-To: <cover.1539001620.git.bristot@redhat.com>
References: <cover.1539001620.git.bristot@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Mon, 08 Oct 2018 12:53:29 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the helper:
	for_each_label_entry(key, entry, stop)

For the "for each jump label entry" for defined as:
	for (; (entry < stop) && (jump_entry_key(entry) == key); entry++)

Simplifying the reading and usage.

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
 include/linux/jump_label.h | 3 +++
 kernel/jump_label.c        | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/jump_label.h b/include/linux/jump_label.h
index 1a0b6f17a5d6..cd3bed880ca0 100644
--- a/include/linux/jump_label.h
+++ b/include/linux/jump_label.h
@@ -170,6 +170,9 @@ extern void static_key_disable(struct static_key *key);
 extern void static_key_enable_cpuslocked(struct static_key *key);
 extern void static_key_disable_cpuslocked(struct static_key *key);
 
+#define for_each_label_entry(key, entry, stop)				  \
+	for (; (entry < stop) && (jump_entry_key(entry) == key); entry++)
+
 /*
  * We should be using ATOMIC_INIT() for initializing .enabled, but
  * the inclusion of atomic.h is problematic for inclusion of jump_label.h
diff --git a/kernel/jump_label.c b/kernel/jump_label.c
index 2e62503bea0d..e853916a3b46 100644
--- a/kernel/jump_label.c
+++ b/kernel/jump_label.c
@@ -365,7 +365,7 @@ static void __jump_label_update(struct static_key *key,
 				struct jump_entry *entry,
 				struct jump_entry *stop)
 {
-	for (; (entry < stop) && (jump_entry_key(entry) == key); entry++) {
+	for_each_label_entry(key, entry, stop) {
 		/*
 		 * An entry->code of 0 indicates an entry which has been
 		 * disabled because it was in an init text area.
-- 
2.17.1

