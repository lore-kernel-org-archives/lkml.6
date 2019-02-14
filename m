Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C8B3C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 23:03:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C96F21B68
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 23:03:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mailprotect.be header.i=@mailprotect.be header.b="tG8U1eRm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387958AbfBNXDo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 18:03:44 -0500
Received: from out002.mailprotect.be ([83.217.72.86]:37507 "EHLO
        out002.mailprotect.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727327AbfBNXBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 18:01:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mailprotect.be; s=mail; h=Content-Transfer-Encoding:MIME-Version:References
        :In-Reply-To:Message-Id:Date:Subject:Cc:To:From:reply-to:sender:bcc:
        content-type; bh=hsoeGDjUGXey8ONlL+laSe3sURvv4DnkGAvQi6DeVMc=; b=tG8U1eRmv23g
        /x+gNPD3GXx2WQf2J//IvABU6Klw4/K3C2WZauWgzxkgXaHEGaeNSRG9znRzXFqQFUlRSe4KkLyzM
        oRgh9eomLez0LBMyAItjYnO3k/VhU30/CP9gjHveY8BD8A5XKOb5AXMZyALJ+p7Dxzfp3BR96VAnx
        mplgWhEskt1qQzqSyIZNPTp8BUjdQsf/KW2bNCV7zyBwlBAltyldQlkL++NMnSlcxqdYieHCOIroJ
        ms8jv7K03J+9IDBqpTnrvkswdZ9iImsSE+atjOBGEG4P4vHPK6nG3TlrUTEyvWBrrddrI8F83BI9V
        c+boIterNr9KbRVmTrnraw==;
Received: from smtp-auth.mailprotect.be ([178.208.39.159])
        by com-mpt-out002.mailprotect.be with esmtp (Exim 4.89)
        (envelope-from <bvanassche@acm.org>)
        id 1guQ0S-0000Wr-L1; Fri, 15 Feb 2019 00:01:25 +0100
Received: from desktop-bart.svl.corp.google.com (unknown [104.133.8.89])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp-auth.mailprotect.be (Postfix) with ESMTPSA id 0EA84C0482;
        Fri, 15 Feb 2019 00:01:21 +0100 (CET)
From:   Bart Van Assche <bvanassche@acm.org>
To:     peterz@infradead.org
Cc:     mingo@redhat.com, will.deacon@arm.com, tj@kernel.org,
        longman@redhat.com, johannes.berg@intel.com,
        linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH v7 06/23] locking/lockdep: Make zap_class() remove all matching lock order entries
Date:   Thu, 14 Feb 2019 15:00:41 -0800
Message-Id: <20190214230058.196511-7-bvanassche@acm.org>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
In-Reply-To: <20190214230058.196511-1-bvanassche@acm.org>
References: <20190214230058.196511-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Originating-IP: 178.208.39.159
X-SpamExperts-Domain: mailprotect.be
X-SpamExperts-Username: 178.208.39.128/27
Authentication-Results: mailprotect.be; auth=pass smtp.auth=178.208.39.128/27@mailprotect.be
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: Combined (0.02)
X-Recommended-Action: accept
X-Filter-ID: EX5BVjFpneJeBchSMxfU5qFgSS9jCK3LSUoCav/J+cJ602E9L7XzfQH6nu9C/Fh9KJzpNe6xgvOx
 q3u0UDjvO1tLifGj39bI0bcPyaJsYTbXCyMe5v8y2H30acbVA7+CsLowAEMLnIs/c915wTAPANfX
 yKo+pvzCeHRww82sG/8HW2me2F11ZDpUG2A5Oiv0I5mALh2L1FvYZOvwUqXjvDk55wR+TsdsSUF6
 GKzdvFr/HXw7HB6/ASdSFy6HwS/kPXDwAtkmamZ68x0sIvfyXcDIKE+0kbt+hzad+8LmAP3D1N2U
 GbvmsuDbvpqB9SNial5u6w2P0n3AP5HxdAj+kw2FxVgE7SkvtWKxkgySOE3GN0ExaDjCWJE9qkQd
 cN59Y08C+1+ciJCAfwA+JGk4n3TFgIfDMShmlQFqCr5hA8xy+28pF/HE/UXip0YpvmqSgtBtsvjK
 9mpXvZ581yfqNVA0hlu/NpOnaXNvrIp4mRGgQUA9iOUB9gXW15it62GvKaV7puimXuHjFEy4159w
 b450J4XCXsfFdbMPgtsajKwG2cpJ3lvOyWe43aQJV0FQAw4GDaNi9opIpCCZlwPhCSifQg48iasD
 JL+gSQdpc7Qjle0LcSTVPooEuo2QsxqqSZrgzSd/y/UPcC3OGqi0VLzxDmzcG0iKavUv44HfPfc9
 3SsS4aMXJmiJ2G0eb5ahWSZS8itsoBzU38uNQrbb6O7J//0XCxCMJn8bXo41UD0XUeyeeLgoe8v3
 Ml5+IDYsxJeBk/os5j8abOYt1SAwFTiWFYSlhfdXoL2rBaBWqCutI4g+l6rCWbY0MZcgnbHshzjL
 mWRvvkZRtgBBWwxR0WH0EA9CFU+XZZAji6JOThI+k1ucVCQQ+dji/Nf3amyIr1x1RYIHNNee2LMZ
 auWd3bJLCnhUZijhyP+NAi4z4ocCHqI/c8KjUic/Eh5gmfm8Qixyw/DNQAInR1tPJCnqBScHL8+l
 TGBIVE9xbEkX79v7DEiBILyHFulTt8MZ+2FHzI2tRk9+5zIafXpAwSGPnS32oons44HyMUKLWR7N
 GVchu1/rdU1t/SWu+yxj6TsAI+iDD9vGjzLZdruisfuPhyICICyimEKZnywKt5h6ngx9mFmID8gM
 9QZDi01IhiaMMDRcCgYQIezXimM8MMGBqfqdqJBJSRulWz3lJxoVd7HeK8WDo27Oo9Jnn2NG+H38
 c/DXtHJOj+IrynVpkScfoGQWOPBVY82M8ECfDTyNS/J0MyNuDItEaHVAyCe015AGfC4N4YKcCY/W
 O55FSnHkew==
X-Report-Abuse-To: spam@com-mpt-mgt001.mailprotect.be
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure that all lock order entries that refer to a class are removed
from the list_entries[] array when a kernel module is unloaded.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 include/linux/lockdep.h  |  1 +
 kernel/locking/lockdep.c | 19 +++++++++++++------
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 0c38bade84b7..b5e6bfe0ae4a 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -178,6 +178,7 @@ static inline void lockdep_copy_map(struct lockdep_map *to,
 struct lock_list {
 	struct list_head		entry;
 	struct lock_class		*class;
+	struct lock_class		*links_to;
 	struct stack_trace		trace;
 	int				distance;
 
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 404086b23fc7..16657662ca4f 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -859,7 +859,8 @@ static struct lock_list *alloc_list_entry(void)
 /*
  * Add a new dependency to the head of the list:
  */
-static int add_lock_to_list(struct lock_class *this, struct list_head *head,
+static int add_lock_to_list(struct lock_class *this,
+			    struct lock_class *links_to, struct list_head *head,
 			    unsigned long ip, int distance,
 			    struct stack_trace *trace)
 {
@@ -873,6 +874,7 @@ static int add_lock_to_list(struct lock_class *this, struct list_head *head,
 		return 0;
 
 	entry->class = this;
+	entry->links_to = links_to;
 	entry->distance = distance;
 	entry->trace = *trace;
 	/*
@@ -1918,14 +1920,14 @@ check_prev_add(struct task_struct *curr, struct held_lock *prev,
 	 * Ok, all validations passed, add the new lock
 	 * to the previous lock's dependency list:
 	 */
-	ret = add_lock_to_list(hlock_class(next),
+	ret = add_lock_to_list(hlock_class(next), hlock_class(prev),
 			       &hlock_class(prev)->locks_after,
 			       next->acquire_ip, distance, trace);
 
 	if (!ret)
 		return 0;
 
-	ret = add_lock_to_list(hlock_class(prev),
+	ret = add_lock_to_list(hlock_class(prev), hlock_class(next),
 			       &hlock_class(next)->locks_before,
 			       next->acquire_ip, distance, trace);
 	if (!ret)
@@ -4119,15 +4121,20 @@ void lockdep_reset(void)
  */
 static void zap_class(struct lock_class *class)
 {
+	struct lock_list *entry;
 	int i;
 
 	/*
 	 * Remove all dependencies this lock is
 	 * involved in:
 	 */
-	for (i = 0; i < nr_list_entries; i++) {
-		if (list_entries[i].class == class)
-			list_del_rcu(&list_entries[i].entry);
+	for (i = 0, entry = list_entries; i < nr_list_entries; i++, entry++) {
+		if (entry->class != class && entry->links_to != class)
+			continue;
+		list_del_rcu(&entry->entry);
+		/* Clear .class and .links_to to avoid double removal. */
+		WRITE_ONCE(entry->class, NULL);
+		WRITE_ONCE(entry->links_to, NULL);
 	}
 	/*
 	 * Unhash the class and remove it from the all_lock_classes list:
-- 
2.21.0.rc0.258.g878e2cd30e-goog

