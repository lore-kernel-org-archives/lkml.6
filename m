Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrSD7p5U68WyHXdbFnrCA82ncw/TKeBuSbvTT70YAH8iLIjlZFO6Qc2J2pYXaqyV+IwL4kl
ARC-Seal: i=1; a=rsa-sha256; t=1526937311; cv=none;
        d=google.com; s=arc-20160816;
        b=H7ZCF/6FVcGrzyFmOBbzFnnJPjw1NJmFOLr6pl+pTVJSKn5m751/lQMrvSjdk+/pqf
         g9doLaiSEUSw4s+zOojoRjBiiQ5s9zVm1IK1N0O9p4e8dlsM4ZlFRHkcLhVBJHnYnNLG
         YVXU6ZwVyMqSvF5weZ3GDQSP/Z8qiHlu4PpNlKWwc0i5NPADdQWNDr3TAijON1Cpi6XC
         V/yn5MaZQC1l6IqiQlMI+G20dB72799kBBmc/CL2HZ/9At1gbp+cx0b5VpgyxO7Iqzzw
         SAdI2dxV+/9PZXupjv4Jc3fzGLsPbI7bh9tEohLLsga+z5sGdNmuf+uyE7SVawS/Oiqk
         3IjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=qX+2uSxOL3gP5veP9RbjdaDO/rSoFxZ3f+V1E3Yg1m4=;
        b=OhSsslm401LbQ31kjt5EtzChCzW5/u2FUDFTYj9QxNr7Qs06hkKUNj1FpoAxfHZs9i
         /38LKiNodHT/CB1SFR1GOo5RyMrbxCiACmvt3GTtKcOrWB3tUcLVKxbZoSFlH0TajZbS
         JM17og393n0nb8SWweQuHWx5tUun6Hs/1glP0r7+nDzc3JGkvutSqFwYR8FKGePLVglU
         9AwJb6YzDlH1EM9R+sDaPurNxH+i/3pHKEdYgPk2hNQYxoPAcyjJUZ26KiAjm9OQY4Dz
         S0CDt2Qpk9GkMXcj7WBL/2nPzQ2Za5c4g50MrpDOtFHU/IKk5B2AFPhFWJQq326Q0bD2
         Ov5g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=moDEHufH;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=moDEHufH;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Liu Bo <bo.liu@linux.alibaba.com>,
	Filipe Manana <fdmanana@suse.com>,
	Qu Wenruo <wqu@suse.com>,
	David Sterba <dsterba@suse.com>,
	Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 4.9 35/87] btrfs: fix reading stale metadata blocks after degraded raid1 mounts
Date: Mon, 21 May 2018 23:11:11 +0200
Message-Id: <20180521210423.747857310@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210420.222671977@linuxfoundation.org>
References: <20180521210420.222671977@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109818430995354?=
X-GMAIL-MSGID: =?utf-8?q?1601109818430995354?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Liu Bo <bo.liu@linux.alibaba.com>

commit 02a3307aa9c20b4f6626255b028f07f6cfa16feb upstream.

If a btree block, aka. extent buffer, is not available in the extent
buffer cache, it'll be read out from the disk instead, i.e.

btrfs_search_slot()
  read_block_for_search()  # hold parent and its lock, go to read child
    btrfs_release_path()
    read_tree_block()  # read child

Unfortunately, the parent lock got released before reading child, so
commit 5bdd3536cbbe ("Btrfs: Fix block generation verification race") had
used 0 as parent transid to read the child block.  It forces
read_tree_block() not to check if parent transid is different with the
generation id of the child that it reads out from disk.

A simple PoC is included in btrfs/124,

0. A two-disk raid1 btrfs,

1. Right after mkfs.btrfs, block A is allocated to be device tree's root.

2. Mount this filesystem and put it in use, after a while, device tree's
   root got COW but block A hasn't been allocated/overwritten yet.

3. Umount it and reload the btrfs module to remove both disks from the
   global @fs_devices list.

4. mount -odegraded dev1 and write some data, so now block A is allocated
   to be a leaf in checksum tree.  Note that only dev1 has the latest
   metadata of this filesystem.

5. Umount it and mount it again normally (with both disks), since raid1
   can pick up one disk by the writer task's pid, if btrfs_search_slot()
   needs to read block A, dev2 which does NOT have the latest metadata
   might be read for block A, then we got a stale block A.

6. As parent transid is not checked, block A is marked as uptodate and
   put into the extent buffer cache, so the future search won't bother
   to read disk again, which means it'll make changes on this stale
   one and make it dirty and flush it onto disk.

To avoid the problem, parent transid needs to be passed to
read_tree_block().

In order to get a valid parent transid, we need to hold the parent's
lock until finishing reading child.

This patch needs to be slightly adapted for stable kernels, the
&first_key parameter added to read_tree_block() is from 4.16+
(581c1760415c4). The fix is to replace 0 by 'gen'.

Fixes: 5bdd3536cbbe ("Btrfs: Fix block generation verification race")
CC: stable@vger.kernel.org # 4.4+
Signed-off-by: Liu Bo <bo.liu@linux.alibaba.com>
Reviewed-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: Qu Wenruo <wqu@suse.com>
[ update changelog ]
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/ctree.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -2486,10 +2486,8 @@ read_block_for_search(struct btrfs_trans
 	if (p->reada != READA_NONE)
 		reada_for_search(root, p, level, slot, key->objectid);
 
-	btrfs_release_path(p);
-
 	ret = -EAGAIN;
-	tmp = read_tree_block(root, blocknr, 0);
+	tmp = read_tree_block(root, blocknr, gen);
 	if (!IS_ERR(tmp)) {
 		/*
 		 * If the read above didn't mark this buffer up to date,
@@ -2503,6 +2501,8 @@ read_block_for_search(struct btrfs_trans
 	} else {
 		ret = PTR_ERR(tmp);
 	}
+
+	btrfs_release_path(p);
 	return ret;
 }
 
