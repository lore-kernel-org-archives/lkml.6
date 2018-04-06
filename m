Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/M7HehaQ9IUu01si7T6MGRBlKtzAWvaC2LXYzfH8jNap7lvXgkD5KUVvqMr1YrYUVkeej5
ARC-Seal: i=1; a=rsa-sha256; t=1523021978; cv=none;
        d=google.com; s=arc-20160816;
        b=eJo9dFjLIkschbRBcUXWpKgR+cUV+9DkjLSGzYT0JL1IHxIRQlnYd6iJ0LTtBiON4o
         7oB5cFzdoaNeV2++6+ayX0UuwRV1Yrx6oJJUsrxcUgZdOW7fjzqpX4UZH4rA/CyWmVtX
         tfQv8kAKPq2n4z7kuuJqMZaCQjYsJ9LIlZp2/M3rO7HFSXp5csmfDwt5Ytx2vUCdTPOn
         yHNK2wkoqxxfgRgCYjqVcCAruIdSIHMe0fZ8w5llKtv6JEpCEA8mJ3kDvStUh5Dtxspy
         3NDVnODGG/MdoIwwurinSMgoVxHQOXzG/fuChHjNubypG8AL8mxxF+9u5xQq7FjMNBpS
         21uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=DsP8SOmKF031kuIBqjX275AqRUZfifrUf0zBWllaxNM=;
        b=wPNifM+eQSVfBt4M8ZEEdgn1PsWZ7T0Q//8ohEHPTxr5rmSgdkZYLv/Wldh/NBVRwe
         H03E+TOwi3jvUzRjloso+/paqEPPfELFumpvO39cy/gsPzWJgXm9iWeTDb+Q+2VqzrMy
         dburX12wsDWPKl4Atg2T+RIcJLiNoCxaePI+Wb+unNfUQXm3XhK+eO4L4ERVw+rcLOch
         ICu+Wuh+H9eCbPiNGfJLfXcqk/ohkvhNMo+kgP7qj/B9H126grog1gNxqAKhR5K9o0l9
         k7ub52ljI/87sZ2uO8Hn67cZAF1N75bFrbgwnH8MnHL71aCbjKcwzkJsnNkk8iZpmn/W
         V/8w==
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
Subject: [PATCH 4.14 54/67] Btrfs: fix unexpected cow in run_delalloc_nocow
Date: Fri,  6 Apr 2018 15:24:24 +0200
Message-Id: <20180406084347.892236354@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084341.225558262@linuxfoundation.org>
References: <20180406084341.225558262@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597004293765579483?=
X-GMAIL-MSGID: =?utf-8?q?1597004293765579483?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
