Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49aKTdLcRoEvsjWRR+tBi/Eie5gsVUVLlQfyFcZmdof67tcOugCSyYNXBBwpAd6jr/aE2Sh
ARC-Seal: i=1; a=rsa-sha256; t=1524405508; cv=none;
        d=google.com; s=arc-20160816;
        b=FLZJBUENpg/xeTxPQMUHs5NpcuecTFyDifPX5rM/tz7X1FUpvEuRk1Rf8OoUIdT7cZ
         hSx8Cav1dgEbNW/a5MhcZJnkl5u8K64zmRDuYPG9T4yF93c0jH0VohTy+Xr6bcYZTZw+
         M+qo/j4bUYUjCx7dWLOUDgWSzEj8dihSP0fXYHR5mAGkaZzsfLXUYYAfWssJEmR3ZfIZ
         8s94beP0s30TFfZjYyLb4W/41T/TGZ6dm6MhAoy70220JlevLbreBTvt+qiBPYHI3aae
         xztwa1T4bBO24sD42a6JX3kiRv6WgVuA+gLrB/SiWKokhgvyyG5IjeVCQf28sMfHxsku
         Fd0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=LEl8P8sUqe22G8a80HgYz/zpCiDrIr8kL96L1HVyU50=;
        b=v+ziFMO+zxpkbl48YS7JXqCQMU7rMhdMnRJUBAAf1a6EMu6wKm4GQGoYhx9i9nI8RV
         SNhDGNjiQ13v0GkOr8X0N9S0LAxYTImUTOPeiapSuBg0IZgJAUCbjPDndidJxVtT3nb1
         NLSVtxcTMq1BP+CVEu8hF/7WQp45iJEdKYf1BR7vKTahSr2eqnhcZwcKk0AsWv+dRFqQ
         IcIKGN9fA+usTGPrp9xu5hfmfRPw8m227lz/h+n+g3H+4ESy+Q1+vkT8hPBRDHOvNeog
         736ZiSA1OMZj2sy99g3hPyMhtmxjCuiIVRQOQGYk4cTKTpBOsBZPnrxmDupfaGJS3lBg
         1hWA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Wen Xu <wen.xu@gatech.edu>,
	Theodore Tso <tytso@mit.edu>
Subject: [PATCH 4.16 093/196] ext4: fail ext4_iget for root directory if unallocated
Date: Sun, 22 Apr 2018 15:51:53 +0200
Message-Id: <20180422135109.102374209@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455030517761315?=
X-GMAIL-MSGID: =?utf-8?q?1598455030517761315?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Theodore Ts'o <tytso@mit.edu>

commit 8e4b5eae5decd9dfe5a4ee369c22028f90ab4c44 upstream.

If the root directory has an i_links_count of zero, then when the file
system is mounted, then when ext4_fill_super() notices the problem and
tries to call iput() the root directory in the error return path,
ext4_evict_inode() will try to free the inode on disk, before all of
the file system structures are set up, and this will result in an OOPS
caused by a NULL pointer dereference.

This issue has been assigned CVE-2018-1092.

https://bugzilla.kernel.org/show_bug.cgi?id=199179
https://bugzilla.redhat.com/show_bug.cgi?id=1560777

Reported-by: Wen Xu <wen.xu@gatech.edu>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ext4/inode.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4745,6 +4745,12 @@ struct inode *ext4_iget(struct super_blo
 		goto bad_inode;
 	raw_inode = ext4_raw_inode(&iloc);
 
+	if ((ino == EXT4_ROOT_INO) && (raw_inode->i_links_count == 0)) {
+		EXT4_ERROR_INODE(inode, "root inode unallocated");
+		ret = -EFSCORRUPTED;
+		goto bad_inode;
+	}
+
 	if (EXT4_INODE_SIZE(inode->i_sb) > EXT4_GOOD_OLD_INODE_SIZE) {
 		ei->i_extra_isize = le16_to_cpu(raw_inode->i_extra_isize);
 		if (EXT4_GOOD_OLD_INODE_SIZE + ei->i_extra_isize >
