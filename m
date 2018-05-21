Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqnzb50VG7Oq5zWTps96s1/xLAmXjg5BE+Z54mQjmGHyn6x/8WvjzbRleIJVRlLrgfSXSBU
ARC-Seal: i=1; a=rsa-sha256; t=1526937301; cv=none;
        d=google.com; s=arc-20160816;
        b=PVZ+OaAICQPUVY+ZE5qRGld6ueQypqQZlo/LRDrJOlWrTs66MCi1JN+68f0AUp7M2i
         4jLKq227BMvjktA3nDDBBeH7SFztNRaGJhvTLR5nprElyfH7l2pc8xvl0MUdtarCoL+P
         2aGUgO56kc2krFwEsU7oTvxzJVhXfkqgFwSmuhF7yh1RVeNlk1cE4WblJmZ6KrDibSuu
         Iz2nzfAXtRpPdbRfcPVKEvgIoGumlzDmq0D3vdUTo9UU0rH9NzVV+PLBm0QuZFS6o+1X
         DmGj40h4uqvGsXSpZh4F6CCMtCxsM6QfHC8ix9yDzpnmJxSuGHMQJUNeKBmYHkfMNsbK
         bj+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=W55mRlUg7z9Nxw0sfI5HJo9PB1aSz2Kh0xY7ZaORA4A=;
        b=YM1sRORhOiDy1JtPzb19pFvYJK6VLPoPNjYycXwwLZpu7KNPMMkJj13xrzVRqOJ4P8
         sfdOm3kPjQO9FIa3yzUmGDU8DWTDJpPk4u4huRm8KqnisdO81HEVwmgtVmCdaNLIP836
         tLYwZ/86ddPxLz2aJwuT2X5HPkbpNdM8dtLYtVECpYgC6gVo8X9woga8+GUpxYKnHdg9
         cUMShDA2oCLI7zqd5MeHljN4XL4WyWqMU2DJ8M/0MOcRVBu/gJT/AuzY1xVMSfVxSg+3
         RC1FGa2IYm+xfqCuikVI8RJSz47pmHhGkzLmkYZBf9W3AMfgIkjN5TYKd7WmnICWUVgE
         BVsA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=LGzL7cXA;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=LGzL7cXA;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>,
	David Sterba <dsterba@suse.com>
Subject: [PATCH 4.9 32/87] Btrfs: fix xattr loss after power failure
Date: Mon, 21 May 2018 23:11:08 +0200
Message-Id: <20180521210423.366984342@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210420.222671977@linuxfoundation.org>
References: <20180521210420.222671977@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109807672624155?=
X-GMAIL-MSGID: =?utf-8?q?1601109807672624155?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Filipe Manana <fdmanana@suse.com>

commit 9a8fca62aacc1599fea8e813d01e1955513e4fad upstream.

If a file has xattrs, we fsync it, to ensure we clear the flags
BTRFS_INODE_NEEDS_FULL_SYNC and BTRFS_INODE_COPY_EVERYTHING from its
inode, the current transaction commits and then we fsync it (without
either of those bits being set in its inode), we end up not logging
all its xattrs. This results in deleting all xattrs when replying the
log after a power failure.

Trivial reproducer

  $ mkfs.btrfs -f /dev/sdb
  $ mount /dev/sdb /mnt

  $ touch /mnt/foobar
  $ setfattr -n user.xa -v qwerty /mnt/foobar
  $ xfs_io -c "fsync" /mnt/foobar

  $ sync

  $ xfs_io -c "pwrite -S 0xab 0 64K" /mnt/foobar
  $ xfs_io -c "fsync" /mnt/foobar
  <power failure>

  $ mount /dev/sdb /mnt
  $ getfattr --absolute-names --dump /mnt/foobar
  <empty output>
  $

So fix this by making sure all xattrs are logged if we log a file's inode
item and neither the flags BTRFS_INODE_NEEDS_FULL_SYNC nor
BTRFS_INODE_COPY_EVERYTHING were set in the inode.

Fixes: 36283bf777d9 ("Btrfs: fix fsync xattr loss in the fast fsync path")
Cc: <stable@vger.kernel.org> # 4.2+
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/tree-log.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -4614,6 +4614,7 @@ static int btrfs_log_inode(struct btrfs_
 	struct extent_map_tree *em_tree = &BTRFS_I(inode)->extent_tree;
 	u64 logged_isize = 0;
 	bool need_log_inode_item = true;
+	bool xattrs_logged = false;
 
 	path = btrfs_alloc_path();
 	if (!path)
@@ -4918,6 +4919,7 @@ next_key:
 	err = btrfs_log_all_xattrs(trans, root, inode, path, dst_path);
 	if (err)
 		goto out_unlock;
+	xattrs_logged = true;
 	if (max_key.type >= BTRFS_EXTENT_DATA_KEY && !fast_search) {
 		btrfs_release_path(path);
 		btrfs_release_path(dst_path);
@@ -4930,6 +4932,11 @@ log_extents:
 	btrfs_release_path(dst_path);
 	if (need_log_inode_item) {
 		err = log_inode_item(trans, log, dst_path, inode);
+		if (!err && !xattrs_logged) {
+			err = btrfs_log_all_xattrs(trans, root, inode, path,
+						   dst_path);
+			btrfs_release_path(path);
+		}
 		if (err)
 			goto out_unlock;
 	}
