Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225e3t+uOiOnkoFxbF7tBI1u2t5V38YG8CKwQq5Gpa6SfIE2aPjztLKHsQB+zntuBv/9yicK
ARC-Seal: i=1; a=rsa-sha256; t=1519217686; cv=none;
        d=google.com; s=arc-20160816;
        b=FA/rOsHDkTLV3OXFrqIBmK/d6CNtWyI7AR35A6wM1IvtoU9Bith/VGYJSoVrLYhgPN
         bC+w/bcflEQAGz0pvM8kgHpP+TgvJ+tzDbHgBgvL20+lOOWyOuuOwPJVwbSN+gElnDVX
         zNZtsxsEHha4ksA/wSU9OE+r2HEF+J5USQZD+dRivAWkR0/c3Am9YAG9dVkFQh6pbIe5
         AsX7s/dHnJ4f1JzL7QtlKDRA1kkoollyfuGOGvITtWB0Lb9fV6nirX/BWmAiNDEf6sin
         o4RwOxHmMhwl+yMj6sCbLxn3B7OVndvjRAT0Q2Ccms4NRKLkpW0rF4P3I9BiHPpqR9tf
         6fEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=vZkjUDRuSCSRA2oQgEw6xt+M4FpfXhIoQDBgkfykEnA=;
        b=fuWpMf9mcsLZn4rak3M7SUUNdLNKrmPwd1zX9RMkdmWK2mz5oWTnt7Z7eSbOsvyvou
         FPnwhz09ouM1C+ZMkmm0TeQLo+UcBGM//F9Vb/RyCm4ct+jRBz1g5mqq/uiHjS4NEBUm
         H4GsyUA4LcUpBsby9DnAx/sQ130Yr/s82MXMyd1IfzQc8zvBb0x7FuwQe5cOqJ8ufpoU
         lxVUpMg8A4H6u1Gf3PRCsS/d22kQXCoukLg7wTM/+GOdQu0SZL06iKwo/fZ4imx5aDyC
         hy5COtQ4VX5c1q8h241NhuX2lIpTYC839w2oUmRCxjH6xcq+DTKTyxYaTmJ3ovx0w/Dw
         4RWQ==
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
Subject: [PATCH 4.9 19/77] Btrfs: fix crash due to not cleaning up tree log blocks dirty bits
Date: Wed, 21 Feb 2018 13:48:28 +0100
Message-Id: <20180221124432.992166373@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124432.172390020@linuxfoundation.org>
References: <20180221124432.172390020@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593014640364522424?=
X-GMAIL-MSGID: =?utf-8?q?1593015205343085035?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2463,6 +2463,9 @@ static noinline int walk_down_log_tree(s
 							next);
 					btrfs_wait_tree_block_writeback(next);
 					btrfs_tree_unlock(next);
+				} else {
+					if (test_and_clear_bit(EXTENT_BUFFER_DIRTY, &next->bflags))
+						clear_extent_buffer_dirty(next);
 				}
 
 				WARN_ON(root_owner !=
@@ -2542,6 +2545,9 @@ static noinline int walk_up_log_tree(str
 							next);
 					btrfs_wait_tree_block_writeback(next);
 					btrfs_tree_unlock(next);
+				} else {
+					if (test_and_clear_bit(EXTENT_BUFFER_DIRTY, &next->bflags))
+						clear_extent_buffer_dirty(next);
 				}
 
 				WARN_ON(root_owner != BTRFS_TREE_LOG_OBJECTID);
@@ -2618,6 +2624,9 @@ static int walk_log_tree(struct btrfs_tr
 				clean_tree_block(trans, log->fs_info, next);
 				btrfs_wait_tree_block_writeback(next);
 				btrfs_tree_unlock(next);
+			} else {
+				if (test_and_clear_bit(EXTENT_BUFFER_DIRTY, &next->bflags))
+					clear_extent_buffer_dirty(next);
 			}
 
 			WARN_ON(log->root_key.objectid !=
