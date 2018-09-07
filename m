Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9076CC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A89920645
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:23:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A89920645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728665AbeIHCGi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:06:38 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46724 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728125AbeIHCGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:06:38 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 75C18EF6;
        Fri,  7 Sep 2018 21:23:48 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>
Subject: [PATCH 4.18 102/145] NFSv4: Fix a sleep in atomic context in nfs4_callback_sequence()
Date:   Fri,  7 Sep 2018 23:09:28 +0200
Message-Id: <20180907210912.254880663@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180907210903.617721278@linuxfoundation.org>
References: <20180907210903.617721278@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Trond Myklebust <trondmy@gmail.com>

commit 8618289c46556fd4dd259a1af02ccc448032f48d upstream.

We must drop the lock before we can sleep in referring_call_exists().

Reported-by: Jia-Ju Bai <baijiaju1990@gmail.com>
Fixes: 045d2a6d076a ("NFSv4.1: Delay callback processing...")
Cc: stable@vger.kernel.org # v4.9+
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/nfs/callback_proc.c |   14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

--- a/fs/nfs/callback_proc.c
+++ b/fs/nfs/callback_proc.c
@@ -441,11 +441,14 @@ validate_seqid(const struct nfs4_slot_ta
  * a match.  If the slot is in use and the sequence numbers match, the
  * client is still waiting for a response to the original request.
  */
-static bool referring_call_exists(struct nfs_client *clp,
+static int referring_call_exists(struct nfs_client *clp,
 				  uint32_t nrclists,
-				  struct referring_call_list *rclists)
+				  struct referring_call_list *rclists,
+				  spinlock_t *lock)
+	__releases(lock)
+	__acquires(lock)
 {
-	bool status = false;
+	int status = 0;
 	int i, j;
 	struct nfs4_session *session;
 	struct nfs4_slot_table *tbl;
@@ -468,8 +471,10 @@ static bool referring_call_exists(struct
 
 		for (j = 0; j < rclist->rcl_nrefcalls; j++) {
 			ref = &rclist->rcl_refcalls[j];
+			spin_unlock(lock);
 			status = nfs4_slot_wait_on_seqid(tbl, ref->rc_slotid,
 					ref->rc_sequenceid, HZ >> 1) < 0;
+			spin_lock(lock);
 			if (status)
 				goto out;
 		}
@@ -546,7 +551,8 @@ __be32 nfs4_callback_sequence(void *argp
 	 * related callback was received before the response to the original
 	 * call.
 	 */
-	if (referring_call_exists(clp, args->csa_nrclists, args->csa_rclists)) {
+	if (referring_call_exists(clp, args->csa_nrclists, args->csa_rclists,
+				&tbl->slot_tbl_lock) < 0) {
 		status = htonl(NFS4ERR_DELAY);
 		goto out_unlock;
 	}


