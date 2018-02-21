Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2262w1oELD7Zr0utOnYifiFbvRHgHn5t3XfnNxFTVt9zMM0K8cMrqvsgWhGI63s4sF9AQMKh
ARC-Seal: i=1; a=rsa-sha256; t=1519217148; cv=none;
        d=google.com; s=arc-20160816;
        b=pxy9BT9/Goboe6P5oXKLe5p0ufd14/q1DY/ek//Q4p8qisIYx1B0h8W4SWaNlGxbrj
         JtOlQdS9Ygb+k2wa8CJLT6NFXocaHRbe9gfUKj5yg+ojftjOoG55LWmRqnUpzC/ZDl8x
         Ft3ibcaYmwDLIY/fOnz24j8o8BxG/TeHnMGoFXEvunpxkIPKs3jFn5EyUHGujMcJIWAX
         e463QK5MZz4PyP2uT1yTsk18JhayXkHQouNbRXcKhT/x9CFxuS/QRd8Kg+OQQEcswGag
         I+etmhdoQrNWyv7QUHFX5lnuHXeopLLLezSKN6AxoAVRHh49NiT8CaXfKLfc2LJueq4I
         9VRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=tfiytU9hJOiuIEJJiEB1Wzm0ZQZQfy0epZ1v2NMD9M8=;
        b=jZbcFbOoYykgPIM3CP7YhqyiHFHZsNGsMEcZiVS7XLrsG7+Imt7UpjqwvvwimrCbfF
         ezuoagaxaOnIoATLbB0FiPSl2U8Zl+chN3zRgfRbeaJKymGAD9zVpcYz+xkvoaD0J/MC
         a4arap8TtDzaGmIwr01MjGDICoS0HKembX45PKDZErBmy5S/ct3H+czbr5/RJuDy4BEk
         TmeBNuVnejXOl3nmFho/RCSxytswu2yiBkGqUK6XFVWSlBZZku+LQqeD80vIKAdsw5mH
         WNEdYj19gTshq1BIqli/xOEgexwfEnT7lNbFfYGrDoorJ82BnULp0WA6qDuD/uEm+XY3
         ETCg==
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
Subject: [PATCH 4.4 20/33] Btrfs: fix crash due to not cleaning up tree log blocks dirty bits
Date: Wed, 21 Feb 2018 13:45:03 +0100
Message-Id: <20180221124410.645285301@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124409.564661689@linuxfoundation.org>
References: <20180221124409.564661689@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593014640364522424?=
X-GMAIL-MSGID: =?utf-8?q?1593014640364522424?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2445,6 +2445,9 @@ static noinline int walk_down_log_tree(s
 							next);
 					btrfs_wait_tree_block_writeback(next);
 					btrfs_tree_unlock(next);
+				} else {
+					if (test_and_clear_bit(EXTENT_BUFFER_DIRTY, &next->bflags))
+						clear_extent_buffer_dirty(next);
 				}
 
 				WARN_ON(root_owner !=
@@ -2524,6 +2527,9 @@ static noinline int walk_up_log_tree(str
 							next);
 					btrfs_wait_tree_block_writeback(next);
 					btrfs_tree_unlock(next);
+				} else {
+					if (test_and_clear_bit(EXTENT_BUFFER_DIRTY, &next->bflags))
+						clear_extent_buffer_dirty(next);
 				}
 
 				WARN_ON(root_owner != BTRFS_TREE_LOG_OBJECTID);
@@ -2600,6 +2606,9 @@ static int walk_log_tree(struct btrfs_tr
 				clean_tree_block(trans, log->fs_info, next);
 				btrfs_wait_tree_block_writeback(next);
 				btrfs_tree_unlock(next);
+			} else {
+				if (test_and_clear_bit(EXTENT_BUFFER_DIRTY, &next->bflags))
+					clear_extent_buffer_dirty(next);
 			}
 
 			WARN_ON(log->root_key.objectid !=
