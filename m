Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6164C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 23:03:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97F5E218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 23:03:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mailprotect.be header.i=@mailprotect.be header.b="RV7BKO9l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387909AbfBNXDc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 18:03:32 -0500
Received: from com-out001.mailprotect.be ([83.217.72.83]:39207 "EHLO
        com-out001.mailprotect.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726220AbfBNXBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 18:01:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mailprotect.be; s=mail; h=Content-Transfer-Encoding:MIME-Version:References
        :In-Reply-To:Message-Id:Date:Subject:Cc:To:From:reply-to:sender:bcc:
        content-type; bh=p0b6jSMK1/ML8LhotEsGVy4EG8U7DKXGWBHPk2FaWLA=; b=RV7BKO9lrgYX
        PF/Mu6iFdurlpVhdLLkt3C9YpH+GDEFusf/10RAF6xdSmL/QAAFhvJI9An7KPOE7NULNak3Fr8zx7
        Lv4fntH0ZQkVyBBNUo2lGrmVegV4hCMD9emMs5rdFJlg9NL26IxvNHqVAPoURAyYmIEuHjf6wSSc5
        W6WOwsk+AXi8wJrOWYpqLcASwFevgrKtNc4MdCTJW/u91mmH5DtRCJ1BDm49ePGqMblSCMmS27EfV
        9uxjouBkEMoPNA6vErcEwKY5XL2MkDyahrvoFaXtbzZXnsKRX/Rf5u/Mrq/dap5lst2Kg06j1XtDI
        zYQ3BC7xOuB6mT+oJb1mLA==;
Received: from smtp-auth.mailprotect.be ([178.208.39.159])
        by com-mpt-out001.mailprotect.be with esmtp (Exim 4.89)
        (envelope-from <bvanassche@acm.org>)
        id 1guQ0U-000DIl-P6; Fri, 15 Feb 2019 00:01:27 +0100
Received: from desktop-bart.svl.corp.google.com (unknown [104.133.8.89])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp-auth.mailprotect.be (Postfix) with ESMTPSA id 5AF6BC08FC;
        Fri, 15 Feb 2019 00:01:24 +0100 (CET)
From:   Bart Van Assche <bvanassche@acm.org>
To:     peterz@infradead.org
Cc:     mingo@redhat.com, will.deacon@arm.com, tj@kernel.org,
        longman@redhat.com, johannes.berg@intel.com,
        linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH v7 07/23] locking/lockdep: Initialize the locks_before and locks_after lists earlier
Date:   Thu, 14 Feb 2019 15:00:42 -0800
Message-Id: <20190214230058.196511-8-bvanassche@acm.org>
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
X-SpamExperts-Outgoing-Evidence: Combined (0.01)
X-Recommended-Action: accept
X-Filter-ID: EX5BVjFpneJeBchSMxfU5gq0PbogXjxYUvo9S6zLJeh602E9L7XzfQH6nu9C/Fh9KJzpNe6xgvOx
 q3u0UDjvO1tLifGj39bI0bcPyaJsYTbXCyMe5v8y2H30acbVA7+CsLowAEMLnIs/c915wTAPANfX
 yKo+pvzCeHRww82sG/8HW2me2F11ZDpUG2A5Oiv0I5mALh2L1FvYZOvwUqXjvDk55wR+TsdsSUF6
 GKzdvFr/HXw7HB6/ASdSFy6HwS/kPXDwAtkmamZ68x0sIvfyXcDIKE+0kbt+hzad+8LmAP3D1N2U
 GbvmsuDbvpqB9SNial5u6w2P0n3AP5HxdAj+kw2FxVgE7SkvtWKxkgySOE3GN0ExaDjCWJE9qkQd
 cN59sAv1R3nS2Dc65UK1yMacy2LNKHZ/WtawTdmHJFHc4TJy+28pF/HE/UXip0YpvmqSgtBtsvjK
 9mpXvZ581yfqNeeYAkx3ZcmLZYF56A5GPA+gQUA9iOUB9gXW15it62GvKaV7puimXuHjFEy4159w
 b450J4XCXsfFdbMPgtsajKwG2cpJ3lvOyWe43aQJV0FQAw4GDaNi9opIpCCZlwPhCSifQg48iasD
 JL+gSQdpc7Qjle0LcSTVPooEuo2QsxqqSZrgzSd/y/UPcC3OGqi0VLzxDmzcG0iKavUv44HfPfc9
 3SsS4aMXJmiJ2G0eb5ahWSZS8itsoBzU38uNQrbb6O7J//0XCxCMJn8bXo41UD0XUeyeeLgoe8v3
 Ml5+IDYsxJeBk/os5j8abOYt1SAwFTiWFYSlhfdXoL2rBaBWqCutI4g+l6rCWbY0MZcgnbHshzjL
 mWRvvkZRtgBBWwxR0VpXCEqSenvCQusD//B2Ay/CclVJ/QEH1Yh/I4nbx0uQr1x1RYIHNNee2LMZ
 auWd3bJLCnhUZijhyP+NAi4z4ocCHqI/c8KjUic/Eh5gmfm8Qixyw/DNQAInR1tPJCnqBScHL8+l
 TGBIVE9xbEkX79v7DEiBILyHFulTt8MZ+2FHjjv/EZY5TtOkgIfOIRpKKoB81NMad4kJAsekLJIJ
 gwohu1/rdU1t/SWu+yxj6TsAI+iDD9vGjzLZdruisfuPhyICICyimEKZnywKt5h6ngx9mFmID8gM
 9QZDi01IhiaMMDRcCgYQIezXimM8MMGBqfqdqJBJSRulWz3lJxoVd7HeK8WDo27Oo9Jnn2NG+H38
 c/DXtHJOj+IrynVpkScfoGQWOPBVY82M8ECfDTyNS/J0MyNuDItEaHVAyCe015AGfC4N4YKcCY/W
 O55FSnHkew==
X-Report-Abuse-To: spam@com-mpt-mgt001.mailprotect.be
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch does not change any functionality. A later patch will reuse
lock classes that have been freed. In combination with that patch this
patch wil have the effect of initializing lock class order lists once
instead of every time a lock class structure is reinitialized.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 kernel/locking/lockdep.c | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 16657662ca4f..9967599d7864 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -735,6 +735,25 @@ static bool assign_lock_key(struct lockdep_map *lock)
 	return true;
 }
 
+/*
+ * Initialize the lock_classes[] array elements.
+ */
+static void init_data_structures_once(void)
+{
+	static bool initialization_happened;
+	int i;
+
+	if (likely(initialization_happened))
+		return;
+
+	initialization_happened = true;
+
+	for (i = 0; i < ARRAY_SIZE(lock_classes); i++) {
+		INIT_LIST_HEAD(&lock_classes[i].locks_after);
+		INIT_LIST_HEAD(&lock_classes[i].locks_before);
+	}
+}
+
 /*
  * Register a lock's class in the hash-table, if the class is not present
  * yet. Otherwise we look it up. We cache the result in the lock object
@@ -775,6 +794,8 @@ register_lock_class(struct lockdep_map *lock, unsigned int subclass, int force)
 			goto out_unlock_set;
 	}
 
+	init_data_structures_once();
+
 	/*
 	 * Allocate a new key from the static array, and add it to
 	 * the hash:
@@ -793,8 +814,8 @@ register_lock_class(struct lockdep_map *lock, unsigned int subclass, int force)
 	class->key = key;
 	class->name = lock->name;
 	class->subclass = subclass;
-	INIT_LIST_HEAD(&class->locks_before);
-	INIT_LIST_HEAD(&class->locks_after);
+	WARN_ON_ONCE(!list_empty(&class->locks_before));
+	WARN_ON_ONCE(!list_empty(&class->locks_after));
 	class->name_version = count_matching_names(class);
 	/*
 	 * We use RCU's safe list-add method to make
@@ -4167,6 +4188,8 @@ void lockdep_free_key_range(void *start, unsigned long size)
 	int i;
 	int locked;
 
+	init_data_structures_once();
+
 	raw_local_irq_save(flags);
 	locked = graph_lock();
 
@@ -4230,6 +4253,8 @@ void lockdep_reset_lock(struct lockdep_map *lock)
 	unsigned long flags;
 	int j, locked;
 
+	init_data_structures_once();
+
 	raw_local_irq_save(flags);
 	locked = graph_lock();
 
-- 
2.21.0.rc0.258.g878e2cd30e-goog

