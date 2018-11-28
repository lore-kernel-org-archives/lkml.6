Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 431F0C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 23:44:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F32C72081B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 23:44:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mailprotect.be header.i=@mailprotect.be header.b="MWQ7vKlk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F32C72081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbeK2Krk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 05:47:40 -0500
Received: from com-out001.mailprotect.be ([83.217.72.83]:56655 "EHLO
        com-out001.mailprotect.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727500AbeK2Krh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 05:47:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mailprotect.be; s=mail; h=Content-Transfer-Encoding:MIME-Version:References
        :In-Reply-To:Message-Id:Date:Subject:Cc:To:From:reply-to:sender:bcc:
        content-type; bh=MbN6whuVcS6SWA4yiLk9YcOMhNynN/T72qxsZs0qFi0=; b=MWQ7vKlk17Lv
        Av97YkeJxSlWtUdyWJhx5eDvQ42oRn+1pCrEXUXYB0zSeCWQKHXUoiUWVwLTSwdvlNjjTM5Djt/zM
        D1fJM3554Dxe7nEalfC90P0WaKpewJn4lpkrtWkdNrFwLpCb6PhWjNhVNl2mNG2xirhd7n6eUrRMV
        zD9PgIShBOgUtSULCFx7b5RFdxVVhsM2Z2cBBHlb+dORYeiyC8Wm4GiuitztvXXMJFekoQ7Gikmdf
        vOOi9ox0eA0hPeK/h+0+16Z7/juzo4tmpIE0IxVdyAMdEx0UfoVEoBqMsSCzyLH0vpamjPetJguxw
        QVCQdCH69LoWfF4+wkhRNQ==;
Received: from smtp-auth.mailprotect.be ([178.208.39.159])
        by com-mpt-out001.mailprotect.be with esmtp (Exim 4.89)
        (envelope-from <bvanassche@acm.org>)
        id 1gS9V3-000241-AM; Thu, 29 Nov 2018 00:44:09 +0100
Received: from desktop-bart.svl.corp.google.com (unknown [104.133.8.89])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp-auth.mailprotect.be (Postfix) with ESMTPSA id 2FF2AC11D1;
        Thu, 29 Nov 2018 00:44:07 +0100 (CET)
From:   Bart Van Assche <bvanassche@acm.org>
To:     mingo@redhat.com
Cc:     peterz@infradead.org, tj@kernel.org, johannes.berg@intel.com,
        linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 17/27] locking/lockdep: Make zap_class() remove all matching lock order entries
Date:   Wed, 28 Nov 2018 15:43:15 -0800
Message-Id: <20181128234325.110011-18-bvanassche@acm.org>
X-Mailer: git-send-email 2.20.0.rc0.387.gc7a69e6b6c-goog
In-Reply-To: <20181128234325.110011-1-bvanassche@acm.org>
References: <20181128234325.110011-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Originating-IP: 178.208.39.159
X-SpamExperts-Domain: mailprotect.be
X-SpamExperts-Username: 178.208.39.128/27
Authentication-Results: mailprotect.be; auth=pass smtp.auth=178.208.39.128/27@mailprotect.be
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: Combined (0.07)
X-Recommended-Action: accept
X-Filter-ID: EX5BVjFpneJeBchSMxfU5q0ketDKHPpWrzsJJYdJASN602E9L7XzfQH6nu9C/Fh9KJzpNe6xgvOx
 q3u0UDjvO1tLifGj39bI0bcPyaJsYTb/+zriNZuqQk0xRpGwjn+MTR8dtByWYYhgj25jR+mEA3YO
 AtfhCcV13BpIh8lqRXSSiFVwqwU9VgKUrYQ0lqWyB41b1wEpWO6ik9HITpMsqebHcXK5F5szpMR3
 ucwUCaulpCLw+Xb9GLNy0GASgpn9t8C9mOBdONdnsxgsk1D2p09kN7MM31r8n6t5T2S20aU1a2Vw
 rhk/M88YeS7fblpdq2ydL+V39l/HBScm+SV6be+d9aVwS6cHCn1lU19HAi2wFVccsCAZ2dyI5DAR
 qfkZNCNwpGn8jfSb3NCl2WUq09dCYgcgr835yVjKQZA6hJL1LiMHCxRezvZaFOrUVh8zaVyj66M1
 yz85ZZhpUrhTRbASVYnBhdKUnGmBdHG7BUn2dK6UtSEdwn3yFtfkzf2g6K04cY809V1JdCwiLdDQ
 Dow7RSjhmGOVelXQaHGaUkCLb5mum9xAXSaS3KKPtTZXWZip9+GhedmPokL8D3vhvY6dhwYzYMxd
 D9vfHZcjDv9O+eyolGM4l8rlxuGfhU+3NYPzMyldJaF5xZTjcWEFHpu0VYQwuqxmozzkDLIpUMoG
 SJj2/VGV7PqOahGXkaU4twU/8XGrHu5QsNBEHc0tEDNi5zR1WYi0E09NG6GB18n4mJSlGpCLjjP2
 TVCcvwpqdwsOoOSHozvtmzhyoaMCnpPtRVkPryfKs6DA7QYq3G1BRp7ylSZxUEGgJw4nFzgd7yt3
 7BfpyvvZ6l+boZNfkk++GRKi3fJfRTPr/PuJHE36okpX82/BtXToloueSaXs0TK8OQ3cB9QF11y7
 2DRSHKQElPJyNJdgFsJFEs/93MUoOhbCKps/LI3znTQUt+hZ5AnI+wExEi2ZXZcwFmj/G9G9XUMB
 gNDO+NkNGowFW+REN2PQUubU67h4IQuWPMZ4HKssSJVidkER7VZq4yeVz8oBMMMFnt8VzQUPDSXZ
 uD7+tXK85NWt4CYBo2l7vp9TheM8Ply7UNk9s+JR29DmIqQBJ7TPMihJUfmPOEFZaWOoGwSHnDFQ
 4P4YDtlBXByrTecUvjKvjZONtLXg4KjauZafx+OvKcOyQvUosS9CO/I=
X-Report-Abuse-To: spam@com-mpt-mgt001.mailprotect.be
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure that all entries that refer to a class are removed from the
list_entries[] array when a kernel module is unloaded.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 include/linux/lockdep.h  |  1 +
 kernel/locking/lockdep.c | 17 +++++++++++------
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 1fd82ff99c65..6d0f8d1c2bee 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -180,6 +180,7 @@ static inline void lockdep_copy_map(struct lockdep_map *to,
 struct lock_list {
 	struct list_head		entry;
 	struct lock_class		*class;
+	struct lock_class		*links_to;
 	struct stack_trace		trace;
 	int				distance;
 
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 96fc8e92c2a6..fc10302d34fd 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -857,7 +857,8 @@ static struct lock_list *alloc_list_entry(void)
 /*
  * Add a new dependency to the head of the list:
  */
-static int add_lock_to_list(struct lock_class *this, struct list_head *head,
+static int add_lock_to_list(struct lock_class *this,
+			    struct lock_class *links_to, struct list_head *head,
 			    unsigned long ip, int distance,
 			    struct stack_trace *trace)
 {
@@ -870,7 +871,9 @@ static int add_lock_to_list(struct lock_class *this, struct list_head *head,
 	if (!entry)
 		return 0;
 
+	WARN_ON_ONCE(this == links_to);
 	entry->class = this;
+	entry->links_to = links_to;
 	entry->distance = distance;
 	entry->trace = *trace;
 	/*
@@ -1916,14 +1919,14 @@ check_prev_add(struct task_struct *curr, struct held_lock *prev,
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
@@ -4126,15 +4129,17 @@ void lockdep_reset(void)
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
 	}
 	/*
 	 * Unhash the class and remove it from the all_lock_classes list:
-- 
2.20.0.rc0.387.gc7a69e6b6c-goog

