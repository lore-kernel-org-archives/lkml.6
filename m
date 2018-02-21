Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225yJz3g4b/NtfZvqlRy7ZyLYmeOhdkpgXU93bbClRsKhD8fKKteON759OrYGeHKtrH3MZHo
ARC-Seal: i=1; a=rsa-sha256; t=1519218248; cv=none;
        d=google.com; s=arc-20160816;
        b=SQFnfaBTO085xT/smJ9fENAnGusAsV+17T5F4JISoyq2++qPoTrQ8bG4gCgjlDJwsq
         tWpLeeUAu1vZCRju75Qm7CEXrILZwAdA9Oap4vND/i3vJ4UOx6vt+6cha7tyoGo7QgaV
         VRi8ytL1hyRLW1pVw93JefyF3ND0CvapmcLXmFLlo2Pm5tM2qOSPDK74CpzPnvlvS4UJ
         NwaBK70ewOVd9ELSrmEpfez5YhVcoPHA+16Uqj4Ga8FgzK4RdG4SCpYrhBF5/fTMlV3q
         yh/bbl6kAq1mp9o5UnSRlh3+yF0wCnhywbm9MCNUh+POE2Ywz9p3rn+HW9gk1ZnLfpdN
         qptA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=UQPlcDH8j6xo1QkpeDzgpHqN2e3AOMGKC2GxHsozpTk=;
        b=KHwj4/T+AIeg5/mUNz9UuTiy0iu/kJE7vH0w/9c3KOL9GmnRN/fs68zsrjA6qsxrn3
         dJpbAXtzfusWrwQTMrvDTsLgepaHb0TfUkTEmw2YDsex2KYPDNXYodMCX8ZAClE/lPCH
         0nome50R4aZ9HIcjF77jetZVkJja+3WS5aG40mxqiIuN927f2gcpkXnZQGo0YOYAmHeu
         Im7dS37jlVcGLOyEJTclB94z2QufSTcdBOOvu1hCSLP0KE4fNxYQYe2iixpi34tam5dB
         +OwBw2X0sy55wR08pO5AGm26vaKoFNk/vuV0r4w4NIvPO0I30mdW578IfdA/ZIZenK4n
         gtUw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Liu Bo <bo.li.liu@oracle.com>,
	Josef Bacik <jbacik@fb.com>,
	David Sterba <dsterba@suse.com>
Subject: [PATCH 4.14 138/167] Btrfs: fix use-after-free on root->orphan_block_rsv
Date: Wed, 21 Feb 2018 13:49:09 +0100
Message-Id: <20180221124532.199522834@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124524.639039577@linuxfoundation.org>
References: <20180221124524.639039577@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015793947174912?=
X-GMAIL-MSGID: =?utf-8?q?1593015793947174912?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Liu Bo <bo.li.liu@oracle.com>

commit 1a932ef4e47984dee227834667b5ff5a334e4805 upstream.

I got these from running generic/475,

WARNING: CPU: 0 PID: 26384 at fs/btrfs/inode.c:3326 btrfs_orphan_commit_root+0x1ac/0x2b0 [btrfs]
BUG: unable to handle kernel NULL pointer dereference at 0000000000000010
IP: btrfs_block_rsv_release+0x1c/0x70 [btrfs]
Call Trace:
  btrfs_orphan_release_metadata+0x9f/0x200 [btrfs]
  btrfs_orphan_del+0x10d/0x170 [btrfs]
  btrfs_setattr+0x500/0x640 [btrfs]
  notify_change+0x7ae/0x870
  do_truncate+0xca/0x130
  vfs_truncate+0x2ee/0x3d0
  do_sys_truncate+0xaf/0xf0
  SyS_truncate+0xe/0x10
  entry_SYSCALL_64_fastpath+0x1f/0x96

The race is between btrfs_orphan_commit_root and btrfs_orphan_del,
        t1                                        t2
btrfs_orphan_commit_root                     btrfs_orphan_del
   spin_lock
   check (&root->orphan_inodes)
   root->orphan_block_rsv = NULL;
   spin_unlock
                                             atomic_dec(&root->orphan_inodes);
                                             access root->orphan_block_rsv

Accessing root->orphan_block_rsv must be done before decreasing
root->orphan_inodes.

cc: <stable@vger.kernel.org> v3.12+
Fixes: 703c88e03524 ("Btrfs: fix tracking of orphan inode count")
Signed-off-by: Liu Bo <bo.li.liu@oracle.com>
Reviewed-by: Josef Bacik <jbacik@fb.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/inode.c |   34 +++++++++++++++++++++-------------
 1 file changed, 21 insertions(+), 13 deletions(-)

--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3371,6 +3371,11 @@ int btrfs_orphan_add(struct btrfs_trans_
 		ret = btrfs_orphan_reserve_metadata(trans, inode);
 		ASSERT(!ret);
 		if (ret) {
+			/*
+			 * dec doesn't need spin_lock as ->orphan_block_rsv
+			 * would be released only if ->orphan_inodes is
+			 * zero.
+			 */
 			atomic_dec(&root->orphan_inodes);
 			clear_bit(BTRFS_INODE_ORPHAN_META_RESERVED,
 				  &inode->runtime_flags);
@@ -3385,12 +3390,17 @@ int btrfs_orphan_add(struct btrfs_trans_
 	if (insert >= 1) {
 		ret = btrfs_insert_orphan_item(trans, root, btrfs_ino(inode));
 		if (ret) {
-			atomic_dec(&root->orphan_inodes);
 			if (reserve) {
 				clear_bit(BTRFS_INODE_ORPHAN_META_RESERVED,
 					  &inode->runtime_flags);
 				btrfs_orphan_release_metadata(inode);
 			}
+			/*
+			 * btrfs_orphan_commit_root may race with us and set
+			 * ->orphan_block_rsv to zero, in order to avoid that,
+			 * decrease ->orphan_inodes after everything is done.
+			 */
+			atomic_dec(&root->orphan_inodes);
 			if (ret != -EEXIST) {
 				clear_bit(BTRFS_INODE_HAS_ORPHAN_ITEM,
 					  &inode->runtime_flags);
@@ -3422,28 +3432,26 @@ static int btrfs_orphan_del(struct btrfs
 {
 	struct btrfs_root *root = inode->root;
 	int delete_item = 0;
-	int release_rsv = 0;
 	int ret = 0;
 
-	spin_lock(&root->orphan_lock);
 	if (test_and_clear_bit(BTRFS_INODE_HAS_ORPHAN_ITEM,
 			       &inode->runtime_flags))
 		delete_item = 1;
 
+	if (delete_item && trans)
+		ret = btrfs_del_orphan_item(trans, root, btrfs_ino(inode));
+
 	if (test_and_clear_bit(BTRFS_INODE_ORPHAN_META_RESERVED,
 			       &inode->runtime_flags))
-		release_rsv = 1;
-	spin_unlock(&root->orphan_lock);
+		btrfs_orphan_release_metadata(inode);
 
-	if (delete_item) {
+	/*
+	 * btrfs_orphan_commit_root may race with us and set ->orphan_block_rsv
+	 * to zero, in order to avoid that, decrease ->orphan_inodes after
+	 * everything is done.
+	 */
+	if (delete_item)
 		atomic_dec(&root->orphan_inodes);
-		if (trans)
-			ret = btrfs_del_orphan_item(trans, root,
-						    btrfs_ino(inode));
-	}
-
-	if (release_rsv)
-		btrfs_orphan_release_metadata(inode);
 
 	return ret;
 }
