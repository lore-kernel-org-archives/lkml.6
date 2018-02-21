Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224qLNM9mYxWNujhAXOiuP1AeGmvvmO4yPElG3E5yHWb4+C4UOWwXzH8yZvLe7F0JT3bxpqT
ARC-Seal: i=1; a=rsa-sha256; t=1519217694; cv=none;
        d=google.com; s=arc-20160816;
        b=F/kAwXk08jhJ3oSNN0BwhrvBdMWSbFgEpm410/1bBg8nZocl/9Ff9UKuDBUeDtJDlc
         MLuh234bE+pXA6MIa/V1xEbfIqGatafOwsLkWTO9qokgd4O0fjZitNqO/iMR1zpD3ATO
         EdopHYSmRckROJFAU+E6PG4yXzXTEYYIPWMHC7HGho4nfv11D2CR8O43arU42x3KygKG
         +JqPbW8X6h/zlmjjSCR9UHGHCWNWC3z7kBk43y8FEZYNqUI+mwFwj/81r3SeS8QoRqQl
         wSMWBfWbpZvEpEvRlFPmvekuU6Xue51UIYWlvHl6FSDAF827wK1zegt2UCM5Y85RhFdj
         /itA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=9YAqP6IvgLPZO1wS2FuJn2a/6/pBUBKbts6yDX0/BCM=;
        b=kB7kBGKfvQsTCCxuwIyGVahRHCbZq9eALR5r6hiP70BjO6iOVcv5zIM/aPIbPsviUT
         ohIqPL5xS8hb7vWhfOabtT4irVX3Rad01hDbjNibiGDIjVZ8V7GQuG88zv99lpTLomi+
         wCJMbMpSH1+Sy1AoYqTDGOTgxW4X5wNvPeN3r0FNCij0ra67BcryS+rZYCyDdmnxiU8l
         f4mCvsI8n3R4XrBfnZknUXUkfxz7v6Pnp3aHQLEi8eQp7umiTthwwjESJ01LyZbU9V03
         j0KVHCaDkhLkPIikCZ9Qmi30J5tbbrwPu5Wl7kyLEcEghT08rnbWV3JhQjYfspLQrVoc
         1DTA==
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
Subject: [PATCH 4.9 22/77] Btrfs: fix unexpected -EEXIST when creating new inode
Date: Wed, 21 Feb 2018 13:48:31 +0100
Message-Id: <20180221124433.121005103@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124432.172390020@linuxfoundation.org>
References: <20180221124432.172390020@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593014643316551271?=
X-GMAIL-MSGID: =?utf-8?q?1593015213930796928?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Liu Bo <bo.li.liu@oracle.com>

commit 900c9981680067573671ecc5cbfa7c5770be3a40 upstream.

The highest objectid, which is assigned to new inode, is decided at
the time of initializing fs roots.  However, in cases where log replay
gets processed, the btree which fs root owns might be changed, so we
have to search it again for the highest objectid, otherwise creating
new inode would end up with -EEXIST.

cc: <stable@vger.kernel.org> v4.4-rc6+
Fixes: f32e48e92596 ("Btrfs: Initialize btrfs_root->highest_objectid when loading tree root and subvolume roots")
Signed-off-by: Liu Bo <bo.li.liu@oracle.com>
Reviewed-by: Josef Bacik <jbacik@fb.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/tree-log.c |   18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -28,6 +28,7 @@
 #include "hash.h"
 #include "compression.h"
 #include "qgroup.h"
+#include "inode-map.h"
 
 /* magic values for the inode_only field in btrfs_log_inode:
  *
@@ -5661,6 +5662,23 @@ again:
 						      path);
 		}
 
+		if (!ret && wc.stage == LOG_WALK_REPLAY_ALL) {
+			struct btrfs_root *root = wc.replay_dest;
+
+			btrfs_release_path(path);
+
+			/*
+			 * We have just replayed everything, and the highest
+			 * objectid of fs roots probably has changed in case
+			 * some inode_item's got replayed.
+			 *
+			 * root->objectid_mutex is not acquired as log replay
+			 * could only happen during mount.
+			 */
+			ret = btrfs_find_highest_objectid(root,
+						  &root->highest_objectid);
+		}
+
 		key.offset = found_key.offset - 1;
 		wc.replay_dest->log_root = NULL;
 		free_extent_buffer(log->node);
