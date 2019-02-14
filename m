Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76D33C10F04
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 23:01:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4521821B68
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 23:01:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mailprotect.be header.i=@mailprotect.be header.b="tiKdylaq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727476AbfBNXBd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 18:01:33 -0500
Received: from out002.mailprotect.be ([83.217.72.86]:51405 "EHLO
        out002.mailprotect.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726220AbfBNXBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 18:01:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mailprotect.be; s=mail; h=Content-Transfer-Encoding:MIME-Version:References
        :In-Reply-To:Message-Id:Date:Subject:Cc:To:From:reply-to:sender:bcc:
        content-type; bh=1Iz88d4QAWrYeeL6gnyeucrpsEnM10vj39V4CMGhx6w=; b=tiKdylaq3Lvp
        k3jfoyJZff6nDD+gFnh0wRzvaY1fsKfx7L2i9jKSdH/sLRegNJx2lLm1/FqY3IKQZIdWDGF0bbsLP
        EGX4Mhcre0IkhFijNWyrX2YctGY+JTzvRQlWicHf6AKm7DiBv93QshlHcj4UThnZHJRbLD8Y4tbCp
        hUMik5KBIt2LZ7VfSfMCXUGCeBu+bKKJG18pbyp7k2+uCBuSZtY0l4w6sGG/F2wN3QgymoMO0gEIC
        0IAFAP2pXKrpyoLlFRHx9skN56Sc5u86fM8ZjIY54iybpaMTKJW3JlJCv5NNYBE5xofVbVNIa71Bo
        bKZgJc1g5k0tQP2SfGBCzA==;
Received: from smtp-auth.mailprotect.be ([178.208.39.159])
        by com-mpt-out002.mailprotect.be with esmtp (Exim 4.89)
        (envelope-from <bvanassche@acm.org>)
        id 1guQ0H-0000Nn-RC; Fri, 15 Feb 2019 00:01:14 +0100
Received: from desktop-bart.svl.corp.google.com (unknown [104.133.8.89])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp-auth.mailprotect.be (Postfix) with ESMTPSA id 4C7F2C0926;
        Fri, 15 Feb 2019 00:01:11 +0100 (CET)
From:   Bart Van Assche <bvanassche@acm.org>
To:     peterz@infradead.org
Cc:     mingo@redhat.com, will.deacon@arm.com, tj@kernel.org,
        longman@redhat.com, johannes.berg@intel.com,
        linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH v7 02/23] locking/lockdep: Fix reported required memory size (1/2)
Date:   Thu, 14 Feb 2019 15:00:37 -0800
Message-Id: <20190214230058.196511-3-bvanassche@acm.org>
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
X-SpamExperts-Outgoing-Evidence: Combined (0.04)
X-Recommended-Action: accept
X-Filter-ID: EX5BVjFpneJeBchSMxfU5nUHQRQmcaQO0lddqGZEoSp602E9L7XzfQH6nu9C/Fh9KJzpNe6xgvOx
 q3u0UDjvO1tLifGj39bI0bcPyaJsYTbXCyMe5v8y2H30acbVA7+CsLowAEMLnIs/c915wTAPANfX
 yKo+pvzCeHRww82sG/8HW2me2F11ZDpUG2A5Oiv0I5mALh2L1FvYZOvwUqXjvDk55wR+TsdsSUF6
 GKzdvFr/HXw7HB6/ASdSFy6HwS/kPXDwAtkmamZ68x0sIvfyXcDIKE+0kbt+hzad+8LmAP3D1N2U
 GbvmsuDbvpqB9SNial5u6w2P0n3AP5HxdAj+kw2FxVgE7SkvtWKxkgySOE3GN0ExaDjCWJE9qkQd
 cN596LaZ+u/NjurJu6QD3yZ+voKfehkVKEa4ZVzO+ecxC7Jy+28pF/HE/UXip0YpvmqSgtBtsvjK
 9mpXvZ581yfqNVA0hlu/NpOnaXNvrIp4mRGgQUA9iOUB9gXW15it62GvKaV7puimXuHjFEy4159w
 b450J4XCXsfFdbMPgtsajKwG2cpJ3lvOyWe43aQJV0FQAw4GDaNi9opIpCCZlwPhCSifQg48iasD
 JL+gSQdpc7Qjle0LcSTVPooEuo2QsxqqSZrgzSd/y/UPcC3OGqi0VLzxDmzcG0iKavUv44HfPfc9
 3SsS4aMXJmiJ2G0eb5ahWSZS8itsoBzU38uNQrbb6O7J//0XCxCMJn8bXo41UD0XUeyeeLgoe8v3
 Ml5+IDYsxJeBk/os5j8abOYt1SAwFTiWFYSlhfdXoL2rBaBWqCutI4g+l6rCWbY0MZcgnbHshzjL
 mWRvvkZRtgBBWwxR0WH0EA9CFU+XZZAji6JOThLlsCvlbF48Xjxh9R6nG38hr1x1RYIHNNee2LMZ
 auWd3bJLCnhUZijhyP+NAi4z4ocCHqI/c8KjUic/Eh5gmfm8Qixyw/DNQAInR1tPJCnqBScHL8+l
 TGBIVE9xbEkX79v7DEiBILyHFulTt8MZ+2FH9H9QHy+fwfn4W3xA0qNI1D2SGRof6dcaK6MmZ8gx
 /VMhu1/rdU1t/SWu+yxj6TsAI+iDD9vGjzLZdruisfuPhyICICyimEKZnywKt5h6ngx9mFmID8gM
 9QZDi01IhiaMMDRcCgYQIezXimM8MMGBqfqdqJBJSRulWz3lJxoVd7HeK8WDo27Oo9Jnn2NG+H38
 c/DXtHJOj+IrynVpkScfoGQWOPBVY82M8ECfDTyNS/J0MyNuDItEaHVAyCe015AGfC4N4YKcCY/W
 O55FSnHkew==
X-Report-Abuse-To: spam@com-mpt-mgt001.mailprotect.be
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the sizeof(array element time) * (array size) expressions into
sizeof(array). This fixes the size computations of the classhash_table[]
and chainhash_table[] arrays. Commit a63f38cc4ccf ("locking/lockdep:
Convert hash tables to hlists") namely changed the type of the elements
of that array from struct list_head into struct hlist_head.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 kernel/locking/lockdep.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 9cdb6292b3c0..193fef487a15 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -4279,19 +4279,19 @@ void __init lockdep_init(void)
 	printk("... CHAINHASH_SIZE:          %lu\n", CHAINHASH_SIZE);
 
 	printk(" memory used by lock dependency info: %zu kB\n",
-		(sizeof(struct lock_class) * MAX_LOCKDEP_KEYS +
-		sizeof(struct list_head) * CLASSHASH_SIZE +
-		sizeof(struct lock_list) * MAX_LOCKDEP_ENTRIES +
-		sizeof(struct lock_chain) * MAX_LOCKDEP_CHAINS +
-		sizeof(struct list_head) * CHAINHASH_SIZE
+	       (sizeof(lock_classes) +
+		sizeof(classhash_table) +
+		sizeof(list_entries) +
+		sizeof(lock_chains) +
+		sizeof(chainhash_table)
 #ifdef CONFIG_PROVE_LOCKING
-		+ sizeof(struct circular_queue)
+		+ sizeof(lock_cq)
 #endif
 		) / 1024
 		);
 
 	printk(" per task-struct memory footprint: %zu bytes\n",
-		sizeof(struct held_lock) * MAX_LOCK_DEPTH);
+	       sizeof(((struct task_struct *)NULL)->held_locks));
 }
 
 static void
-- 
2.21.0.rc0.258.g878e2cd30e-goog

