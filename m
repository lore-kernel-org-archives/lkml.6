Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CB528605BD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932201AbeFFGLX (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 02:11:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:52273 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932150AbeFFGLW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 02:11:22 -0400
From: NeilBrown <neilb@suse.com>
To: Oleg Drokin <oleg.drokin@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Simmons <jsimmons@infradead.org>,
        Andreas Dilger <andreas.dilger@intel.com>
Date: Wed, 06 Jun 2018 16:05:18 +1000
Subject: [PATCH 02/11] staging: lustre: change lock_matches() to return bool.
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lustre Development List <lustre-devel@lists.lustre.org>
Message-ID: <152826511895.16761.11859115039331359491.stgit@noble>
In-Reply-To: <152826510267.16761.14361003167157833896.stgit@noble>
References: <152826510267.16761.14361003167157833896.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The name of the function lock_matches() sounds like it
performs a test (it does) and so should return a bool.
Returning a bool gives a slight code simplification (in
search_queue) and more simplification in future patches.

Signed-off-by: NeilBrown <neilb@suse.com>
---
 drivers/staging/lustre/lustre/ldlm/ldlm_lock.c |   37 ++++++++++++------------
 1 file changed, 18 insertions(+), 19 deletions(-)

diff --git a/drivers/staging/lustre/lustre/ldlm/ldlm_lock.c b/drivers/staging/lustre/lustre/ldlm/ldlm_lock.c
index 13b1b5fdada9..034935e06393 100644
--- a/drivers/staging/lustre/lustre/ldlm/ldlm_lock.c
+++ b/drivers/staging/lustre/lustre/ldlm/ldlm_lock.c
@@ -1053,20 +1053,20 @@ struct lock_match_data {
  * \param lock	test-against this lock
  * \param data	parameters
  */
-static int lock_matches(struct ldlm_lock *lock, struct lock_match_data *data)
+static bool lock_matches(struct ldlm_lock *lock, struct lock_match_data *data)
 {
 	union ldlm_policy_data *lpol = &lock->l_policy_data;
 	enum ldlm_mode match;
 
 	if (lock == data->lmd_old)
-		return INTERVAL_ITER_STOP;
+		return true;
 
 	/*
 	 * Check if this lock can be matched.
 	 * Used by LU-2919(exclusive open) for open lease lock
 	 */
 	if (ldlm_is_excl(lock))
-		return INTERVAL_ITER_CONT;
+		return false;
 
 	/*
 	 * llite sometimes wants to match locks that will be
@@ -1078,26 +1078,26 @@ static int lock_matches(struct ldlm_lock *lock, struct lock_match_data *data)
 	 */
 	if (ldlm_is_cbpending(lock) &&
 	    !(data->lmd_flags & LDLM_FL_CBPENDING))
-		return INTERVAL_ITER_CONT;
+		return false;
 
 	if (!data->lmd_unref && ldlm_is_cbpending(lock) &&
 	    !lock->l_readers && !lock->l_writers)
-		return INTERVAL_ITER_CONT;
+		return false;
 
 	if (!(lock->l_req_mode & *data->lmd_mode))
-		return INTERVAL_ITER_CONT;
+		return false;
 	match = lock->l_req_mode;
 
 	switch (lock->l_resource->lr_type) {
 	case LDLM_EXTENT:
 		if (lpol->l_extent.start > data->lmd_policy->l_extent.start ||
 		    lpol->l_extent.end < data->lmd_policy->l_extent.end)
-			return INTERVAL_ITER_CONT;
+			return false;
 
 		if (unlikely(match == LCK_GROUP) &&
 		    data->lmd_policy->l_extent.gid != LDLM_GID_ANY &&
 		    lpol->l_extent.gid != data->lmd_policy->l_extent.gid)
-			return INTERVAL_ITER_CONT;
+			return false;
 		break;
 	case LDLM_IBITS:
 		/*
@@ -1107,7 +1107,7 @@ static int lock_matches(struct ldlm_lock *lock, struct lock_match_data *data)
 		if ((lpol->l_inodebits.bits &
 		     data->lmd_policy->l_inodebits.bits) !=
 		    data->lmd_policy->l_inodebits.bits)
-			return INTERVAL_ITER_CONT;
+			return false;
 		break;
 	default:
 		break;
@@ -1117,10 +1117,10 @@ static int lock_matches(struct ldlm_lock *lock, struct lock_match_data *data)
 	 * of bits.
 	 */
 	if (!data->lmd_unref && LDLM_HAVE_MASK(lock, GONE))
-		return INTERVAL_ITER_CONT;
+		return false;
 
 	if (!equi(data->lmd_flags & LDLM_FL_LOCAL_ONLY, ldlm_is_local(lock)))
-		return INTERVAL_ITER_CONT;
+		return false;
 
 	if (data->lmd_flags & LDLM_FL_TEST_LOCK) {
 		LDLM_LOCK_GET(lock);
@@ -1132,15 +1132,17 @@ static int lock_matches(struct ldlm_lock *lock, struct lock_match_data *data)
 	*data->lmd_mode = match;
 	data->lmd_lock = lock;
 
-	return INTERVAL_ITER_STOP;
+	return true;
 }
 
 static enum interval_iter itree_overlap_cb(struct interval_node *in, void *args)
 {
 	struct lock_match_data *data = args;
-	struct ldlm_lock *lock = container_of(in, struct ldlm_lock, l_tree_node);
+	struct ldlm_lock *lock = container_of(in, struct ldlm_lock,
+					      l_tree_node);
 
-	return lock_matches(lock, data);
+	return lock_matches(lock, data) ?
+		INTERVAL_ITER_STOP : INTERVAL_ITER_CONT;
 }
 
 /**
@@ -1187,13 +1189,10 @@ static struct ldlm_lock *search_queue(struct list_head *queue,
 				      struct lock_match_data *data)
 {
 	struct ldlm_lock *lock;
-	int rc;
 
-	list_for_each_entry(lock, queue, l_res_link) {
-		rc = lock_matches(lock, data);
-		if (rc == INTERVAL_ITER_STOP)
+	list_for_each_entry(lock, queue, l_res_link)
+		if (lock_matches(lock, data))
 			return data->lmd_lock;
-	}
 	return NULL;
 }
 
