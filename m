Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49I4NK2yOaSYq1IhdFq5P/Ta23MoVskgaTffWQFLroDhpw6GSY7hShn83kpjVyNeSSAuUm1
ARC-Seal: i=1; a=rsa-sha256; t=1524405445; cv=none;
        d=google.com; s=arc-20160816;
        b=BdZlnnLCgpwAhVCBqPBp5G6uyfueucK6L6vH6j4HanvNzU0flL9lqy9HCG0ktHK5JH
         oy1KnePuK3qmjeBx4ES4lQN7nwmoPE3qL7mF12rmxlTvum0ywGltlwoetInIwtAPS9so
         nzopIVaPVnZVd2VRm4Xz9oU9uxlymICO9+bNsEm0nAdf9QknRWzs10qiz6yqrxD3I5na
         ew36jOZlS2X3QcrEJIygDCYv6G8beIwDaWijuXQfP90s2sFelbh+B2UKrZ0coBQIbEcF
         OQBA2v9YWYfKQNfJc1u6xx13PaigdnILzWWurZ6D4G0WokjCeP5kYH9tXZ1Zt/PsD1vO
         IxWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=gt/fMyuqI4jNRFOcimV3EzgXM6GWHFC/uaf188fOQwU=;
        b=va8SxenoK9yK5A202BT1zZ3Zv8IDw6zqYeIaOmpSxYoazdXDS0RM3uRWzRl8IFux1e
         WfwXjIHE8jbyT6LHLTP449lH1d8CU4Sv2Tu+QycT/Zxm1yawIynsGT+f5SkrHOMViRbD
         HVCdmMUYWorVfC7jxhTEDyg1U5LMCJitoCi3t1DF4T9LyTN4Mt+A1upGF0S4eu3mcfaQ
         To4y3FksUxMLi7R9yqE302KVsSBt0EpeKsCWwrM4jLXpe8JMYXUPSUwlx+7Ts571zy6h
         1g+zBZlZTfYQYpAas1aDxhFyYP8Z030Fg+Wk4kUtLhA28t4qwo79c+D1/yJIapuAlZ2G
         n90A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	stable@kernel.org,
	"Yan, Zheng" <zyan@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 4.16 069/196] ceph: always update atime/mtime/ctime for new inode
Date: Sun, 22 Apr 2018 15:51:29 +0200
Message-Id: <20180422135107.835501117@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598454964910712280?=
X-GMAIL-MSGID: =?utf-8?q?1598454964910712280?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yan, Zheng <zyan@redhat.com>

commit ffdeec7aa41aa61ca4ee68fddf4669df9ce661d1 upstream.

For new inode, atime/mtime/ctime are uninitialized.  Don't compare
against them.

Cc: stable@kernel.org
Signed-off-by: "Yan, Zheng" <zyan@redhat.com>
Reviewed-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ceph/inode.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -660,13 +660,15 @@ void ceph_fill_file_time(struct inode *i
 		      CEPH_CAP_FILE_BUFFER|
 		      CEPH_CAP_AUTH_EXCL|
 		      CEPH_CAP_XATTR_EXCL)) {
-		if (timespec_compare(ctime, &inode->i_ctime) > 0) {
+		if (ci->i_version == 0 ||
+		    timespec_compare(ctime, &inode->i_ctime) > 0) {
 			dout("ctime %ld.%09ld -> %ld.%09ld inc w/ cap\n",
 			     inode->i_ctime.tv_sec, inode->i_ctime.tv_nsec,
 			     ctime->tv_sec, ctime->tv_nsec);
 			inode->i_ctime = *ctime;
 		}
-		if (ceph_seq_cmp(time_warp_seq, ci->i_time_warp_seq) > 0) {
+		if (ci->i_version == 0 ||
+		    ceph_seq_cmp(time_warp_seq, ci->i_time_warp_seq) > 0) {
 			/* the MDS did a utimes() */
 			dout("mtime %ld.%09ld -> %ld.%09ld "
 			     "tw %d -> %d\n",
@@ -786,7 +788,6 @@ static int fill_inode(struct inode *inod
 	new_issued = ~issued & le32_to_cpu(info->cap.caps);
 
 	/* update inode */
-	ci->i_version = le64_to_cpu(info->version);
 	inode->i_rdev = le32_to_cpu(info->rdev);
 	inode->i_blkbits = fls(le32_to_cpu(info->layout.fl_stripe_unit)) - 1;
 
@@ -857,6 +858,9 @@ static int fill_inode(struct inode *inod
 		xattr_blob = NULL;
 	}
 
+	/* finally update i_version */
+	ci->i_version = le64_to_cpu(info->version);
+
 	inode->i_mapping->a_ops = &ceph_aops;
 
 	switch (inode->i_mode & S_IFMT) {
