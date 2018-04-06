Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+RdEvGnCY2gvL7JNPUsc2pVGbFbQKbjjZz/vx5K1VQZqnZlE6/i60r8o6pMxVv3+U5TLFl
ARC-Seal: i=1; a=rsa-sha256; t=1523022249; cv=none;
        d=google.com; s=arc-20160816;
        b=zDt9VmIA2tGeQPdxuBnmAVeYiqx75F5iVsqZRAARZ26Z2NcG7PNf2wV2NQfpvAmrJq
         XUQzDnhSSzYADII/zjdY+mqpwyu4tzuD9rbjq8FpVbr/9JGX3BKCyyHcEKLB/Z/ppdnO
         5JlBTpLlweq95h+iPcuXV2aLAha99vZEkUkvDKjbJopCyBzjZT8n0ijCVz2N2aKaUzFx
         9FiSkhdKwoiiqxpWNzk8wa6iMRqz5CI4wKho9KpcKvYMKdLWXp1RSfRIc90DpyJz2+TW
         XoQ0CEp10/m49lz/j0QBlYocJLpGnhyPzUtakXqOIvte/vgbI9EFb6I+BOTmK0xSH/2a
         k5AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=vMUulpLTVMIyhEToy4hSGIVX6HfDu6NSW2hpYpY8H3M=;
        b=SD0JFmQ6Xy7DebZDI7OmAM+ssFPNfVfwarZLEtk6kexZz6/lrY0DR/0qCqI4SA4aSk
         +WK6+KUCVfOrL5FGUQdmwicSbP/3P2jfsFcekEFWmTGeVnzxSXbNyxNtz/Vs7vVGyskQ
         TOZZa7TXsS0osR7AcsyZ4l1YYfUSgUrRiLBFYetWrUIuiuXTn5PkdT+jJPGtGHF2IMtR
         s5xELb630tjVSFaQYusEsZT6rJBnsV+J1ml2NWw59wndhCzI9WROHfpJ9O1YWuFF2323
         CXu5kXQdNDB9RuxIvqnv5g5kAtZezvIpFcx6Higw13rbuR+l3bWsp7jr5IZTN3CXB7ic
         RcUA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Liu Bo <bo.li.liu@oracle.com>,
	David Sterba <dsterba@suse.com>
Subject: [PATCH 4.15 59/72] Btrfs: fix unexpected cow in run_delalloc_nocow
Date: Fri,  6 Apr 2018 15:24:34 +0200
Message-Id: <20180406084353.408086466@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084349.367583460@linuxfoundation.org>
References: <20180406084349.367583460@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597004293765579483?=
X-GMAIL-MSGID: =?utf-8?q?1597004578274782117?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Liu Bo <bo.li.liu@oracle.com>

commit 5811375325420052fcadd944792a416a43072b7f upstream.

Fstests generic/475 provides a way to fail metadata reads while
checking if checksum exists for the inode inside run_delalloc_nocow(),
and csum_exist_in_range() interprets error (-EIO) as inode having
checksum and makes its caller enter the cow path.

In case of free space inode, this ends up with a warning in
cow_file_range().

The same problem applies to btrfs_cross_ref_exist() since it may also
read metadata in between.

With this, run_delalloc_nocow() bails out when errors occur at the two
places.

cc: <stable@vger.kernel.org> v2.6.28+
Fixes: 17d217fe970d ("Btrfs: fix nodatasum handling in balancing code")
Signed-off-by: Liu Bo <bo.li.liu@oracle.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/inode.c |   37 ++++++++++++++++++++++++++++++++-----
 1 file changed, 32 insertions(+), 5 deletions(-)

--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1257,6 +1257,8 @@ static noinline int csum_exist_in_range(
 		list_del(&sums->list);
 		kfree(sums);
 	}
+	if (ret < 0)
+		return ret;
 	return 1;
 }
 
@@ -1389,10 +1391,23 @@ next_slot:
 				goto out_check;
 			if (btrfs_extent_readonly(fs_info, disk_bytenr))
 				goto out_check;
-			if (btrfs_cross_ref_exist(root, ino,
-						  found_key.offset -
-						  extent_offset, disk_bytenr))
+			ret = btrfs_cross_ref_exist(root, ino,
+						    found_key.offset -
+						    extent_offset, disk_bytenr);
+			if (ret) {
+				/*
+				 * ret could be -EIO if the above fails to read
+				 * metadata.
+				 */
+				if (ret < 0) {
+					if (cow_start != (u64)-1)
+						cur_offset = cow_start;
+					goto error;
+				}
+
+				WARN_ON_ONCE(nolock);
 				goto out_check;
+			}
 			disk_bytenr += extent_offset;
 			disk_bytenr += cur_offset - found_key.offset;
 			num_bytes = min(end + 1, extent_end) - cur_offset;
@@ -1410,10 +1425,22 @@ next_slot:
 			 * this ensure that csum for a given extent are
 			 * either valid or do not exist.
 			 */
-			if (csum_exist_in_range(fs_info, disk_bytenr,
-						num_bytes)) {
+			ret = csum_exist_in_range(fs_info, disk_bytenr,
+						  num_bytes);
+			if (ret) {
 				if (!nolock)
 					btrfs_end_write_no_snapshotting(root);
+
+				/*
+				 * ret could be -EIO if the above fails to read
+				 * metadata.
+				 */
+				if (ret < 0) {
+					if (cow_start != (u64)-1)
+						cur_offset = cow_start;
+					goto error;
+				}
+				WARN_ON_ONCE(nolock);
 				goto out_check;
 			}
 			if (!btrfs_inc_nocow_writers(fs_info, disk_bytenr)) {
