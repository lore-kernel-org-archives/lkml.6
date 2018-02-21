Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226lG6/JFq7D73gAAcVlo1+AGZbJHVCV2qDp6FGOFh8Dx6cTvMl1iTlX51R+yf+hS5SlAW6p
ARC-Seal: i=1; a=rsa-sha256; t=1519217151; cv=none;
        d=google.com; s=arc-20160816;
        b=ymOtZGEpgUhNdUcLp2FEq3rRdJuiMSJoTrFS1c1lza3g78WIetBvMF1s+AXnfMuXAt
         BF9OVtaVT4jvRpidlB2z0Kc11Ui6EzRQXFzh5eHWzXo4Pi15S4uWzeTG2vNDopFz4Mi5
         0/mRUS/KFIclY4PNJLOnSvUZf3kS+IZOjbDTrKIhs7qT0LTJa6ZVTj+kzFJSsi80H3rE
         PLBWVibSgo1qs6BjZ8OZhAaQkMAtZlsacs1nlRmFe9zV/34FOzTJpFXJa1T/y/WQNCJU
         HbqGtxUa5B2NkBYrbLv0EItHlRkPyyLvGKJXaa49yG4xASgDT/F0TTD2tX5n2m7Khtvz
         +r4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=E2RiUa3t1kn/KpNChWtIfTStG05p5VE3EgJmkjPBfMw=;
        b=bAU+Edn/nfZ/QsDqa9vt6SeoXpDmvdT6cNymLryxc7/+88Z4dwBT5qdwWLaacQxVTt
         KiUDcWKxjN+cmuJBQfB5XCtKZwtrkImMxWdb9o0KFbRlzMxcVYiJvIwfnSMBl5t+dztd
         nc/h4V6WBc6fG731Q/HvtEzJZc0DuI1l8Y+Z+c6FkdVNzlg0aj5+rIYcSXJqZcMH7etm
         qfzZlpyTIMVgwsrcPgAiEY2PA9ZyCwHbCb0h78s/VgWmZWUwQFgVQmdMkscGYrnu1a5c
         HPb9raH4o02bnlTgES17jmUoAedxcAJmOVUUHO997WeQsLZRYwP+e/2db7vzC23ojFr9
         Adiw==
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
Subject: [PATCH 4.4 21/33] Btrfs: fix unexpected -EEXIST when creating new inode
Date: Wed, 21 Feb 2018 13:45:04 +0100
Message-Id: <20180221124410.701736732@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124409.564661689@linuxfoundation.org>
References: <20180221124409.564661689@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593014643316551271?=
X-GMAIL-MSGID: =?utf-8?q?1593014643316551271?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -26,6 +26,7 @@
 #include "print-tree.h"
 #include "backref.h"
 #include "hash.h"
+#include "inode-map.h"
 
 /* magic values for the inode_only field in btrfs_log_inode:
  *
@@ -5523,6 +5524,23 @@ again:
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
