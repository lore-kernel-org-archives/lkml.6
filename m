Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A146BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 23:03:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66399218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 23:03:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mailprotect.be header.i=@mailprotect.be header.b="ZEjzwigf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728427AbfBNXDK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 18:03:10 -0500
Received: from com-out001.mailprotect.be ([83.217.72.83]:52033 "EHLO
        com-out001.mailprotect.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727914AbfBNXBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 18:01:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mailprotect.be; s=mail; h=Content-Transfer-Encoding:MIME-Version:References
        :In-Reply-To:Message-Id:Date:Subject:Cc:To:From:reply-to:sender:bcc:
        content-type; bh=fONbVAKCwII1ZfmV18ERiC4oYOuHDLnMEhJ3S25tJ9c=; b=ZEjzwigfqz0x
        6JliwAp8rox2c3GaIpbv/dtNQfBdlq7Lp1xEo8i3I7h+6stU+z14Bb5sqIVG2v/LiAmt2c/S3hKzS
        p9vNv3lZBSi3jLzrSTsUI8qncrf4JgISTwvr6VC+/39Oz/7WKZjGWdcC/6KKSquKnGEvwnI0Pqriv
        lkp+mgtQ2N7JpGxR1JK+Yvuk1Ntxf0LkXFOt+2jb7vHhTwcmmz7hcrD+ceHkTgBF3mCh2Ta7JFpsD
        svEqimlESgwwfw5JNLEeNnGUkBw+3cHGt5O1dl12b5YYEVB/INHsHI4BHPIPLXkubbJ1bxNYwdcNB
        pZobu+OqYP3c5RLjJKA6sA==;
Received: from smtp-auth.mailprotect.be ([178.208.39.159])
        by com-mpt-out001.mailprotect.be with esmtp (Exim 4.89)
        (envelope-from <bvanassche@acm.org>)
        id 1guQ0i-000DOW-0I; Fri, 15 Feb 2019 00:01:40 +0100
Received: from desktop-bart.svl.corp.google.com (unknown [104.133.8.89])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp-auth.mailprotect.be (Postfix) with ESMTPSA id B9843C04D0;
        Fri, 15 Feb 2019 00:01:37 +0100 (CET)
From:   Bart Van Assche <bvanassche@acm.org>
To:     peterz@infradead.org
Cc:     mingo@redhat.com, will.deacon@arm.com, tj@kernel.org,
        longman@redhat.com, johannes.berg@intel.com,
        linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH v7 13/23] locking/lockdep: Introduce lockdep_next_lockchain() and lock_chain_count()
Date:   Thu, 14 Feb 2019 15:00:48 -0800
Message-Id: <20190214230058.196511-14-bvanassche@acm.org>
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
X-SpamExperts-Outgoing-Evidence: SB/global_tokens (0.00656875294882)
X-Recommended-Action: accept
X-Filter-ID: EX5BVjFpneJeBchSMxfU5sVqTRcfNr4UkD2OFg4HM+l602E9L7XzfQH6nu9C/Fh9KJzpNe6xgvOx
 q3u0UDjvO1tLifGj39bI0bcPyaJsYTbXCyMe5v8y2H30acbVA7+CsLowAEMLnIs/c915wTAPANfX
 yKo+pvzCeHRww82sG/8HW2me2F11ZDpUG2A5Oiv0I5mALh2L1FvYZOvwUqXjvDk55wR+TsdsSUF6
 GKzdvFr/HXw7HB6/ASdSFy6HwS/kPXDwAtkmamZ68x0sIvfyXcDIKE+0kbt+hzad+8LmAP3D1N2U
 GbvmsuDbvpqB9SNial5u6w2P0n3AP5HxdAj+kw2FxVgE7SkvtWKxkgySOE3GN0ExaDjCWJE9qkQd
 cN59wZVe9nVWS33Rh/YQHh885XTFgIfDMShmlQFqCr5hA8xy+28pF/HE/UXip0YpvmqSgtBtsvjK
 9mpXvZ581yfqNeeYAkx3ZcmLZYF56A5GPA+gQUA9iOUB9gXW15it62GvKaV7puimXuHjFEy4159w
 b450J4XCXsfFdbMPgtsajKwG2cpJ3lvOyWe43aQJV0FQAw4GDaNi9opIpCCZlwPhCSifQg48iasD
 JL+gSQdpc7Qjle0LcSTVPooEuo2QsxqqSZrgzSd/y/UPcC3OGqi0VJ9oPeZuzI4YvGloR1iXZcQ6
 rDn0tTOVcmJwqI8Ju2ne/wwIwzyV/WMPB6zTEWzEncEKJtZE3p7YZqOA3SmjVruGpS+C6BPAIEs8
 PiiVo3Eboi+cbnT5PTDQNVG9E6gOGiUCAW1FDxcZal9mohvTtVuaBo55LoXJ38umBncoBPaTGplH
 cpVCCoX989hgB8R+yBNKgbPqM+gWqiGtLl4stWokc9uykHalFfjbaRfu7LxQrMk7ke+KUg0nkUNW
 WXYdlXbBteMJzAkMC43e8+sp9ik9r/0RENuxoUHLfdnX97lYWfNCwcrS0aokqY9q7nrY3hEVniih
 uDwEGDcmr6e3OPRLa16pGRvAB1MNCAVzZzPG/W30w/zDcz636yEnTyvlnaXYc5sCGBmhSF08PTuw
 vso4KeQfFnti6fvh3LUuzbNmctgzcDoFd+96Xw4QUNtTnfzp6yaSzf/mBOxmctH1xJW7ZqDnEZyA
 /o9yCJs753i5Anc+dePvuOLndsGRtxRwqudKEy7bP5gIt23U7fpAnNNWb77i3eb3c6Xj53IToZwL
 VabjergYMIEHYgna2Grb/XBEn95eECKi3gxjzXac2CKNL6Ugwa8G8LUBaMaYDRNMLxoq67wPPyTr
 tPptswtkm3vs+M4bivZGPOywGIoCFD0=
X-Report-Abuse-To: spam@com-mpt-mgt001.mailprotect.be
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch does not change any functionality but makes the next patch in
this series easier to read.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 kernel/locking/lockdep.c           | 16 +++++++++++++++-
 kernel/locking/lockdep_internals.h |  3 ++-
 kernel/locking/lockdep_proc.c      | 12 ++++++------
 3 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 4308f0b9ecd5..9c10fcf422f4 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -2107,7 +2107,7 @@ check_prevs_add(struct task_struct *curr, struct held_lock *next)
 	return 0;
 }
 
-unsigned long nr_lock_chains;
+static unsigned long nr_lock_chains;
 struct lock_chain lock_chains[MAX_LOCKDEP_CHAINS];
 int nr_chain_hlocks;
 static u16 chain_hlocks[MAX_LOCKDEP_CHAIN_HLOCKS];
@@ -2241,6 +2241,20 @@ static int check_no_collision(struct task_struct *curr,
 	return 1;
 }
 
+/*
+ * Given an index that is >= -1, return the index of the next lock chain.
+ * Return -2 if there is no next lock chain.
+ */
+long lockdep_next_lockchain(long i)
+{
+	return i + 1 < nr_lock_chains ? i + 1 : -2;
+}
+
+unsigned long lock_chain_count(void)
+{
+	return nr_lock_chains;
+}
+
 /*
  * Adds a dependency chain into chain hashtable. And must be called with
  * graph_lock held.
diff --git a/kernel/locking/lockdep_internals.h b/kernel/locking/lockdep_internals.h
index 88c847a41c8a..ba8a4ac7bd04 100644
--- a/kernel/locking/lockdep_internals.h
+++ b/kernel/locking/lockdep_internals.h
@@ -96,7 +96,8 @@ struct lock_class *lock_chain_get_class(struct lock_chain *chain, int i);
 
 extern unsigned long nr_lock_classes;
 extern unsigned long nr_list_entries;
-extern unsigned long nr_lock_chains;
+long lockdep_next_lockchain(long i);
+unsigned long lock_chain_count(void);
 extern int nr_chain_hlocks;
 extern unsigned long nr_stack_trace_entries;
 
diff --git a/kernel/locking/lockdep_proc.c b/kernel/locking/lockdep_proc.c
index 3d31f9b0059e..9c49ec645d8b 100644
--- a/kernel/locking/lockdep_proc.c
+++ b/kernel/locking/lockdep_proc.c
@@ -104,18 +104,18 @@ static const struct seq_operations lockdep_ops = {
 #ifdef CONFIG_PROVE_LOCKING
 static void *lc_start(struct seq_file *m, loff_t *pos)
 {
+	if (*pos < 0)
+		return NULL;
+
 	if (*pos == 0)
 		return SEQ_START_TOKEN;
 
-	if (*pos - 1 < nr_lock_chains)
-		return lock_chains + (*pos - 1);
-
-	return NULL;
+	return lock_chains + (*pos - 1);
 }
 
 static void *lc_next(struct seq_file *m, void *v, loff_t *pos)
 {
-	(*pos)++;
+	*pos = lockdep_next_lockchain(*pos - 1) + 1;
 	return lc_start(m, pos);
 }
 
@@ -268,7 +268,7 @@ static int lockdep_stats_show(struct seq_file *m, void *v)
 
 #ifdef CONFIG_PROVE_LOCKING
 	seq_printf(m, " dependency chains:             %11lu [max: %lu]\n",
-			nr_lock_chains, MAX_LOCKDEP_CHAINS);
+			lock_chain_count(), MAX_LOCKDEP_CHAINS);
 	seq_printf(m, " dependency chain hlocks:       %11d [max: %lu]\n",
 			nr_chain_hlocks, MAX_LOCKDEP_CHAIN_HLOCKS);
 #endif
-- 
2.21.0.rc0.258.g878e2cd30e-goog

