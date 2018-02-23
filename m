Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224THthxogEaU6ggfWi+8y9Gp9MwiuH0eg7P1h2WkvpXpL+A3+lxnai1d/Cx5pLO5kCVitCn
ARC-Seal: i=1; a=rsa-sha256; t=1519410615; cv=none;
        d=google.com; s=arc-20160816;
        b=pZp8cVIzoVuOui6dFB80u2Y3LdERCmzSrgaSsxGDT+PSCOW1rL6gYT+QK8mBJgTonz
         if8qPRkMpxOh1bEggenuhJCB51Qm/TgOCQK28rATPEDwl8wb1fjUSvJcqBAjRPKxplFC
         q7ObZN38uy2JF3rlo6U4e67T5azvEO71/7XxscyfKKY+HFm4rfHMsJYfGcoI0yUyUW9k
         yZWnP54NW2OR8vpO07U1ou+anoyqQtOz+sz2n3wuNO/ZWA1MjA63n1q/UxmwJ2Dl7pro
         oAtGSCv2FQoYauUsfkmcH3AqQoN/5JwOQHM+YPNuRI7Ommk/mW6N6v4m+1MrNAR51P2e
         DPjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=QP/BpXolnQMQ9Nih/Pw11RAJaf0n64vQGc4bnsaoecY=;
        b=KrDXeu3KIN7o8rtgEE+PXGzLFjEv6LrUQ62frDXns0ROzW13CrqPioPUNJ7CTbEZ8t
         Zj1nLFsdixOg9+PzkNPsQLSwGri9SJBVptyT4Flv1MN+V3s2J9Q6dClh/PLXZo3/gdJi
         7Qnw6t+qLfV6HloBMBJ0LDv7dXzT/cPY6+wJ7Ll8cGHj47UTFla5dmqEzHQZioYh3mPx
         N8bZLfOgwHjGhy0ocjON0bHKFnSmiRf7kxm8vYLgWBjlhfV/M26VSfomhSFBuFWaHgTw
         Cup2CUIlG+MSoIhIfxFrf9xpCSWmYGvy9amb8cy+Z/Hd2mXLe5CzByAAxXkU0P7V/UNK
         Z5LA==
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
Subject: [PATCH 3.18 14/58] Btrfs: fix crash due to not cleaning up tree log blocks dirty bits
Date: Fri, 23 Feb 2018 19:26:13 +0100
Message-Id: <20180223170208.937026859@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170206.724655284@linuxfoundation.org>
References: <20180223170206.724655284@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217505219610791?=
X-GMAIL-MSGID: =?utf-8?q?1593217505219610791?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Liu Bo <bo.li.liu@oracle.com>

commit 1846430c24d66e85cc58286b3319c82cd54debb2 upstream.

In cases that the whole fs flips into readonly status due to failures in
critical sections, then log tree's blocks are still dirty, and this leads
to a crash during umount time, the crash is about use-after-free,

umount
 -> close_ctree
    -> stop workers
    -> iput(btree_inode)
       -> iput_final
          -> write_inode_now
	     -> ...
	       -> queue job on stop'd workers

cc: <stable@vger.kernel.org> v3.12+
Fixes: 681ae50917df ("Btrfs: cleanup reserved space when freeing tree log on error")
Signed-off-by: Liu Bo <bo.li.liu@oracle.com>
Reviewed-by: Josef Bacik <jbacik@fb.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/tree-log.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -2201,6 +2201,9 @@ static noinline int walk_down_log_tree(s
 					clean_tree_block(trans, root, next);
 					btrfs_wait_tree_block_writeback(next);
 					btrfs_tree_unlock(next);
+				} else {
+					if (test_and_clear_bit(EXTENT_BUFFER_DIRTY, &next->bflags))
+						clear_extent_buffer_dirty(next);
 				}
 
 				WARN_ON(root_owner !=
@@ -2279,6 +2282,9 @@ static noinline int walk_up_log_tree(str
 					clean_tree_block(trans, root, next);
 					btrfs_wait_tree_block_writeback(next);
 					btrfs_tree_unlock(next);
+				} else {
+					if (test_and_clear_bit(EXTENT_BUFFER_DIRTY, &next->bflags))
+						clear_extent_buffer_dirty(next);
 				}
 
 				WARN_ON(root_owner != BTRFS_TREE_LOG_OBJECTID);
@@ -2355,6 +2361,9 @@ static int walk_log_tree(struct btrfs_tr
 				clean_tree_block(trans, log, next);
 				btrfs_wait_tree_block_writeback(next);
 				btrfs_tree_unlock(next);
+			} else {
+				if (test_and_clear_bit(EXTENT_BUFFER_DIRTY, &next->bflags))
+					clear_extent_buffer_dirty(next);
 			}
 
 			WARN_ON(log->root_key.objectid !=
