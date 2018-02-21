Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226bOwsJ6uP2eeH+LU1CEpRf7wesaprIl+8Ra1RJo87RJ3LwsqO80HMnZ+PHDJeQs7LTN3Fz
ARC-Seal: i=1; a=rsa-sha256; t=1519218719; cv=none;
        d=google.com; s=arc-20160816;
        b=UtWyL4yDmxrFm+Ugu10S5DM8QYiAp/lPaOssAy0VxC08raj3Gs+DmWQmY+6UslhDBR
         ovm+sxl8KS4TJBf9XdMmyvTCBQL/8ILhzQ65252DYKJSeq4VDfkyMXiy1gFAdo2korig
         pwvCjjHAh1yEGLdw82kbHTRFC+vJhedVPJvd/voovb2IfgTY5lOhgjdUICMynqrzAEn2
         gZwZxtTmbAng9Sq/cjnGMLb8Pla4QsdUG2j5w3v6bMG6FakRUpuK5U1FVavDvaJEWJqm
         RJbdmtoBKUGPZ8EwU+4+0vfKeibN6ECaT/Rt3cM8nQ20jhy0G6Ae9KHytrD0mNL1hAIR
         6eqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=fq97V0IvyheZAOsKjczYKWEHIF5XT+saDchIHb6aA/0=;
        b=kInS1PAFgtj4rRngpiN/85l8i5Q85V6EeL5jNVmpQJChk9MqI+Nezfofb/rglDie7/
         7soNeVdLpXCcyEkESwRe9WAztT41WKU4/2EuuqeZAtYw4K9ZECvq9u6eZtu9MqiYKUeR
         xjnF8Lp+iDRPm7+6GFOReVS/sXEkVhObNOC+DOiWkQ28Wta9Nj37fwevwCxgkpGYS+qE
         99et48cLtyZvKQaev4FjRYGFIdbEbOVMUehaBp1RG0EJzKSfVB65SiHbChPwD3Gq8m1d
         VFPopC0ww3SWESjo6hkQqV9/l3hRDo9w8f0F7eQQRaoULrBN2PVbWKvn0CgU5i538qNO
         U66Q==
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
Subject: [PATCH 4.15 140/163] Btrfs: fix unexpected -EEXIST when creating new inode
Date: Wed, 21 Feb 2018 13:49:29 +0100
Message-Id: <20180221124537.888018974@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124529.931834518@linuxfoundation.org>
References: <20180221124529.931834518@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593014643316551271?=
X-GMAIL-MSGID: =?utf-8?q?1593016287583731759?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -5715,6 +5716,23 @@ again:
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
