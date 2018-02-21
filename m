Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2277EZjCZqMZzO4bR/nt7Mo2FMLJxwjY2GAkvVV8XAYdQMQkTZlIiHl4iSZF0d07KYwCC1yz
ARC-Seal: i=1; a=rsa-sha256; t=1519218239; cv=none;
        d=google.com; s=arc-20160816;
        b=Nh90Bqg3iTIzIc8mqP8ENgf7a5pV+/fW8/sfn7QpQXwUXa9hqmqni8oWo7IK42BR2D
         3vfDEnK3f6hGVLEgb2fpTWifJju6yxC0yytTb8XCt3AS9lr1y48/50ujqakB9S5p7tGW
         AIschaLN1wIBtN84ogqPHpqGh5p7NbB8UnMGOnIRRvMLXD91RhjTjFpsh3JFm7mbRpwZ
         zX85Su771KX27BFcn+M9GYDZebmIO5KGvwMcuJWdmqWEF6tMBeX0tpX66GULc46Orcro
         zXkU9Tc/KbevwrPer3Wm/Q+GWvLvkQ1yRJ9gAqSukc2ekN66J19cueWXeaUSK/UiU6d/
         TioQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=lKj4z0WeJJtMSpgo7REdUVwNjwZ6VTBgUaa6Vl+AN1U=;
        b=OJhlmImdcxDZPQNT5i33ueF4y6/sHv8QxMZEaugT/4YKL52Vj31Ra8+SfU28dbVaYG
         ms4pL5otAqC94M8hVKgOaKnm1eMFcCX0UoOBLCWsTFsCVhoDdLmPnI+AHGCwK8wSsgd+
         C6w1nJsAph1oHSU/MSAEfF4zRan2nBZl14roeDThueKcMYhB9+EG7HatMQUJSnXfPTkM
         2v3GP+kNEpOw0u/0n0iu4ipcr+v3gaIU8dHkYrqbguG+BJGrRT+Nr0+M2CizSinlCBLI
         tpnfKdknMeCTk1MYtJTq6mEjJ38AWVRm44URUS+WoOEseiCfi6CrbyX5erIorcwGRAo7
         kFOA==
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
Subject: [PATCH 4.14 135/167] Btrfs: fix crash due to not cleaning up tree log blocks dirty bits
Date: Wed, 21 Feb 2018 13:49:06 +0100
Message-Id: <20180221124532.026430446@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124524.639039577@linuxfoundation.org>
References: <20180221124524.639039577@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593014640364522424?=
X-GMAIL-MSGID: =?utf-8?q?1593015784633291895?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2494,6 +2494,9 @@ static noinline int walk_down_log_tree(s
 					clean_tree_block(fs_info, next);
 					btrfs_wait_tree_block_writeback(next);
 					btrfs_tree_unlock(next);
+				} else {
+					if (test_and_clear_bit(EXTENT_BUFFER_DIRTY, &next->bflags))
+						clear_extent_buffer_dirty(next);
 				}
 
 				WARN_ON(root_owner !=
@@ -2574,6 +2577,9 @@ static noinline int walk_up_log_tree(str
 					clean_tree_block(fs_info, next);
 					btrfs_wait_tree_block_writeback(next);
 					btrfs_tree_unlock(next);
+				} else {
+					if (test_and_clear_bit(EXTENT_BUFFER_DIRTY, &next->bflags))
+						clear_extent_buffer_dirty(next);
 				}
 
 				WARN_ON(root_owner != BTRFS_TREE_LOG_OBJECTID);
@@ -2652,6 +2658,9 @@ static int walk_log_tree(struct btrfs_tr
 				clean_tree_block(fs_info, next);
 				btrfs_wait_tree_block_writeback(next);
 				btrfs_tree_unlock(next);
+			} else {
+				if (test_and_clear_bit(EXTENT_BUFFER_DIRTY, &next->bflags))
+					clear_extent_buffer_dirty(next);
 			}
 
 			WARN_ON(log->root_key.objectid !=
