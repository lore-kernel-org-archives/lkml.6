Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrMk1ZPvScseW70UI3TfGDHYdNpIgvewaxQz7PrkkpM59FlGLl6J5ugVsJ8RlU4ZgO2UeKe
ARC-Seal: i=1; a=rsa-sha256; t=1526937576; cv=none;
        d=google.com; s=arc-20160816;
        b=tlXfBa5p+J/XJ2c8peo08Yd0KxCgSgg2MtrbWyA9YZkzVg4nwzF8qtBRonHLKmAlPG
         RyrmecvcPojnS4zsjj5F+952i+eKWMadGT9JBMmECczqzWeV3lnfuicnsJdS5Bsw7mz7
         GuUs/5V3lI1ujxw11xyMdn7LfqdlIH1e0ZAVJdaPMmfDJltLHn0wmxGh02d6Svm/lSg/
         XJBrohlTGlgNjqgZF5RGi5ay5dRjzRzB62MGiehkX3mFGb9Ur5OJpELEsu7HE24rAyCZ
         A8NT23FrMFsa/mSocLmWnjC5jit9uoDkkyPygngLk/z0q6sxYVs2vpPeZCM5kqgVAZ84
         cHdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=zVWRx+lY121QrQalBeNVzDt8oFAIjefT++JaNz+bip8=;
        b=k7yVgCINdGC8pm6JlcNjd1xNMQwmzAOffwizpVGrVY3qtGpBWS0xryTuXjIznIBxOB
         BRxB+E2EHngs+51OPfR6V/HiGAmB0GtuaHWkxCxNlhpLgkEvC7kI7moiZ5Au0jeBXVRa
         SEpUoSUBkkITjQZm4EBJOWV808BKjAI821DbvrIwNym5QsOn0LRcES+j7EGAXLPr8vRk
         YvaF4lilAj+k2cv3RAJh5fwlzshF5kKm7jaLL69iLrFb+QMS1k91IBd9LRTgkraPm3Rc
         EtJ2yu3dvVTjux/lNe5uHmDJ0jMncxyGh7LZAaSqrE2XTd/7FtAOn9woUk6wYEqLWV2s
         dFTg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=KAfrKlL8;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=KAfrKlL8;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Nikolay Borisov <nborisov@suse.com>,
	David Sterba <dsterba@suse.com>,
	Anand Jain <anand.jain@oracle.com>
Subject: [PATCH 4.14 45/95] btrfs: Split btrfs_del_delalloc_inode into 2 functions
Date: Mon, 21 May 2018 23:11:35 +0200
Message-Id: <20180521210457.195467686@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210447.219380974@linuxfoundation.org>
References: <20180521210447.219380974@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601110096070663284?=
X-GMAIL-MSGID: =?utf-8?q?1601110096070663284?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nikolay Borisov <nborisov@suse.com>

commit 2b8773313494ede83a26fb372466e634564002ed upstream.

This is in preparation of fixing delalloc inodes leakage on transaction
abort. Also export the new function.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Reviewed-by: Anand Jain <anand.jain@oracle.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/ctree.h |    2 ++
 fs/btrfs/inode.c |   13 ++++++++++---
 2 files changed, 12 insertions(+), 3 deletions(-)

--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3150,6 +3150,8 @@ noinline int can_nocow_extent(struct ino
 			      u64 *orig_start, u64 *orig_block_len,
 			      u64 *ram_bytes);
 
+void __btrfs_del_delalloc_inode(struct btrfs_root *root,
+				struct btrfs_inode *inode);
 struct inode *btrfs_lookup_dentry(struct inode *dir, struct dentry *dentry);
 int btrfs_set_inode_index(struct btrfs_inode *dir, u64 *index);
 int btrfs_unlink_inode(struct btrfs_trans_handle *trans,
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1754,12 +1754,12 @@ static void btrfs_add_delalloc_inodes(st
 	spin_unlock(&root->delalloc_lock);
 }
 
-static void btrfs_del_delalloc_inode(struct btrfs_root *root,
-				     struct btrfs_inode *inode)
+
+void __btrfs_del_delalloc_inode(struct btrfs_root *root,
+				struct btrfs_inode *inode)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->vfs_inode.i_sb);
 
-	spin_lock(&root->delalloc_lock);
 	if (!list_empty(&inode->delalloc_inodes)) {
 		list_del_init(&inode->delalloc_inodes);
 		clear_bit(BTRFS_INODE_IN_DELALLOC_LIST,
@@ -1772,6 +1772,13 @@ static void btrfs_del_delalloc_inode(str
 			spin_unlock(&fs_info->delalloc_root_lock);
 		}
 	}
+}
+
+static void btrfs_del_delalloc_inode(struct btrfs_root *root,
+				     struct btrfs_inode *inode)
+{
+	spin_lock(&root->delalloc_lock);
+	__btrfs_del_delalloc_inode(root, inode);
 	spin_unlock(&root->delalloc_lock);
 }
 
