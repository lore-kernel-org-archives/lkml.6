Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA068C46465
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 05:10:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB5302086A
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 05:10:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB5302086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728940AbeKHOoG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 09:44:06 -0500
Received: from smtp2.provo.novell.com ([137.65.250.81]:45010 "EHLO
        smtp2.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbeKHOoG (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Thu, 8 Nov 2018 09:44:06 -0500
Received: from linux-r8p5.suse.de (prv-ext-foundry1int.gns.novell.com [137.65.251.240])
        by smtp2.provo.novell.com with ESMTP (TLS encrypted); Wed, 07 Nov 2018 22:10:17 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     akpm@linux-foundation.org
Cc:     jbaron@akamai.com, viro@zeniv.linux.org.uk, dave@stgolabs.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH 1/6] fs/epoll: remove max_nests argument from ep_call_nested()
Date:   Wed,  7 Nov 2018 21:10:01 -0800
Message-Id: <20181108051006.18751-2-dave@stgolabs.net>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20181108051006.18751-1-dave@stgolabs.net>
References: <20181108051006.18751-1-dave@stgolabs.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All callers pass the EP_MAX_NESTS constant already, so lets
simplify this a tad and get rid of the redundant parameter
for nested eventpolls.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 fs/eventpoll.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 42bbe6824b4b..7ad020f1353b 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -471,7 +471,6 @@ static inline void ep_set_busy_poll_napi_id(struct epitem *epi)
  *                  no re-entered.
  *
  * @ncalls: Pointer to the nested_calls structure to be used for this call.
- * @max_nests: Maximum number of allowed nesting calls.
  * @nproc: Nested call core function pointer.
  * @priv: Opaque data to be passed to the @nproc callback.
  * @cookie: Cookie to be used to identify this nested call.
@@ -480,7 +479,7 @@ static inline void ep_set_busy_poll_napi_id(struct epitem *epi)
  * Returns: Returns the code returned by the @nproc callback, or -1 if
  *          the maximum recursion limit has been exceeded.
  */
-static int ep_call_nested(struct nested_calls *ncalls, int max_nests,
+static int ep_call_nested(struct nested_calls *ncalls,
 			  int (*nproc)(void *, void *, int), void *priv,
 			  void *cookie, void *ctx)
 {
@@ -499,7 +498,7 @@ static int ep_call_nested(struct nested_calls *ncalls, int max_nests,
 	 */
 	list_for_each_entry(tncur, lsthead, llink) {
 		if (tncur->ctx == ctx &&
-		    (tncur->cookie == cookie || ++call_nests > max_nests)) {
+		    (tncur->cookie == cookie || ++call_nests > EP_MAX_NESTS)) {
 			/*
 			 * Ops ... loop detected or maximum nest level reached.
 			 * We abort this wake by breaking the cycle itself.
@@ -573,7 +572,7 @@ static void ep_poll_safewake(wait_queue_head_t *wq)
 {
 	int this_cpu = get_cpu();
 
-	ep_call_nested(&poll_safewake_ncalls, EP_MAX_NESTS,
+	ep_call_nested(&poll_safewake_ncalls,
 		       ep_poll_wakeup_proc, NULL, wq, (void *) (long) this_cpu);
 
 	put_cpu();
@@ -1333,7 +1332,6 @@ static int reverse_path_check_proc(void *priv, void *cookie, int call_nests)
 				}
 			} else {
 				error = ep_call_nested(&poll_loop_ncalls,
-							EP_MAX_NESTS,
 							reverse_path_check_proc,
 							child_file, child_file,
 							current);
@@ -1367,7 +1365,7 @@ static int reverse_path_check(void)
 	/* let's call this for all tfiles */
 	list_for_each_entry(current_file, &tfile_check_list, f_tfile_llink) {
 		path_count_init();
-		error = ep_call_nested(&poll_loop_ncalls, EP_MAX_NESTS,
+		error = ep_call_nested(&poll_loop_ncalls,
 					reverse_path_check_proc, current_file,
 					current_file, current);
 		if (error)
@@ -1876,7 +1874,7 @@ static int ep_loop_check_proc(void *priv, void *cookie, int call_nests)
 			ep_tovisit = epi->ffd.file->private_data;
 			if (ep_tovisit->visited)
 				continue;
-			error = ep_call_nested(&poll_loop_ncalls, EP_MAX_NESTS,
+			error = ep_call_nested(&poll_loop_ncalls,
 					ep_loop_check_proc, epi->ffd.file,
 					ep_tovisit, current);
 			if (error != 0)
@@ -1916,7 +1914,7 @@ static int ep_loop_check(struct eventpoll *ep, struct file *file)
 	int ret;
 	struct eventpoll *ep_cur, *ep_next;
 
-	ret = ep_call_nested(&poll_loop_ncalls, EP_MAX_NESTS,
+	ret = ep_call_nested(&poll_loop_ncalls,
 			      ep_loop_check_proc, file, ep, current);
 	/* clear visited list */
 	list_for_each_entry_safe(ep_cur, ep_next, &visited_list,
-- 
2.16.4

