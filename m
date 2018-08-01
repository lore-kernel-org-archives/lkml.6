Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98BA0C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:53:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BD25208A4
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:53:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BD25208A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405180AbeHATk2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:40:28 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50150 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405977AbeHATIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:08:41 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 27A9313CF;
        Wed,  1 Aug 2018 17:16:01 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 084/246] btrfs: add barriers to btrfs_sync_log before log_commit_wait wakeups
Date:   Wed,  1 Aug 2018 18:49:54 +0200
Message-Id: <20180801165015.746720201@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801165011.700991984@linuxfoundation.org>
References: <20180801165011.700991984@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Sterba <dsterba@suse.com>

[ Upstream commit 3d3a2e610ea5e7c6d4f9481ecce5d8e2d8317843 ]

Currently the code assumes that there's an implied barrier by the
sequence of code preceding the wakeup, namely the mutex unlock.

As Nikolay pointed out:

I think this is wrong (not your code) but the original assumption that
the RELEASE semantics provided by mutex_unlock is sufficient.
According to memory-barriers.txt:

Section 'LOCK ACQUISITION FUNCTIONS' states:

 (2) RELEASE operation implication:

     Memory operations issued before the RELEASE will be completed before the
     RELEASE operation has completed.

     Memory operations issued after the RELEASE *may* be completed before the
     RELEASE operation has completed.

(I've bolded the may portion)

The example given there:

As an example, consider the following:

    *A = a;
    *B = b;
    ACQUIRE
    *C = c;
    *D = d;
    RELEASE
    *E = e;
    *F = f;

The following sequence of events is acceptable:

    ACQUIRE, {*F,*A}, *E, {*C,*D}, *B, RELEASE

So if we assume that *C is modifying the flag which the waitqueue is checking,
and *E is the actual wakeup, then those accesses can be re-ordered...

IMHO this code should be considered broken...
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---

To be on the safe side, add the barriers. The synchronization logic
around log using the mutexes and several other threads does not make it
easy to reason for/against the barrier.

CC: Nikolay Borisov <nborisov@suse.com>
Link: https://lkml.kernel.org/r/6ee068d8-1a69-3728-00d1-d86293d43c9f@suse.com
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>

Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/tree-log.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -3041,8 +3041,11 @@ out_wake_log_root:
 	mutex_unlock(&log_root_tree->log_mutex);
 
 	/*
-	 * The barrier before waitqueue_active is implied by mutex_unlock
+	 * The barrier before waitqueue_active is needed so all the updates
+	 * above are seen by the woken threads. It might not be necessary, but
+	 * proving that seems to be hard.
 	 */
+	smp_mb();
 	if (waitqueue_active(&log_root_tree->log_commit_wait[index2]))
 		wake_up(&log_root_tree->log_commit_wait[index2]);
 out:
@@ -3053,8 +3056,11 @@ out:
 	mutex_unlock(&root->log_mutex);
 
 	/*
-	 * The barrier before waitqueue_active is implied by mutex_unlock
+	 * The barrier before waitqueue_active is needed so all the updates
+	 * above are seen by the woken threads. It might not be necessary, but
+	 * proving that seems to be hard.
 	 */
+	smp_mb();
 	if (waitqueue_active(&root->log_commit_wait[index1]))
 		wake_up(&root->log_commit_wait[index1]);
 	return ret;


