Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/+poj+xWHNsGynNZkJz4RqtMLhpU/sMa7ufQ9nre8hlgHa8dL65QHmadFpnkPBzFs/Yboh
ARC-Seal: i=1; a=rsa-sha256; t=1524652967; cv=none;
        d=google.com; s=arc-20160816;
        b=MsCPhIRySmMNWbwfWm8S8NsI+dD5CnIj1JNUPpOJl1Y8pvbEZbVs2sRoPf1AbLHAW6
         iNJv405YFhkvx9tOQJshSgNRIP0euvkfYmYDwPOc/eVPvTMLjjPmBeo6u32gvb4DH6zD
         pWshtu3g6J49s8n8cABEJlddV0piav6KEgEo60073LNdMr6Vg008D+ulQdocYVQxBO6T
         VrPgYp1RDO25Y1Umd8n+VeI9U3x3B2i5NPQILWppMCeIJkekPyGHhpgeKUhKMSmHM7wj
         PVOSOhqFGNTxBG6qbBWlPt5TLUIFt2Tt0eQuh2EOQ6kNMBDH3YXhKQ2kIUJ96wnd9tq/
         nS+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=mPCMXBmZNfp7GpPJIiW8ZtY8ccDrX+wDqPJnu2zp61M=;
        b=cVhsctc5A3fwvdSOHMA8W03mUSRwmz764YqJP0OIM4L2xBq+P+gPOjDw0Guh+kXs81
         at8mOXOKzrKEoc16sCSILI4iM47SWeUnodGxrYCd1OvY/SxOBYtGbswebaa/kvDhCveU
         ZUsXbWO3cAwwaSV62ZcxDqJv6x4uJZVanpTsVkD+ncEijblga2uyTtcpYhFla3oE3WbY
         HWUX79m4r2xzG//VQI8Sd0+FZ+swgJC1FAwl6/R39gogxuziJilNRuLZ97ANo8bZBZyo
         sRT3xeZ4f6HGdQMbHwJzzrwEwe/sqXB7SuLyg/jQv67nYcKVAU9YjqejLzewJvvTa6Tl
         fMDA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jun Piao <piaojun@huawei.com>,
	Alex Chen <alex.chen@huawei.com>,
	Joseph Qi <jiangqi903@gmail.com>,
	Changwei Ge <ge.changwei@h3c.com>,
	Gang He <ghe@suse.com>,
	Mark Fasheh <mfasheh@versity.com>,
	Joel Becker <jlbec@evilplan.org>,
	Junxiao Bi <junxiao.bi@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 108/183] ocfs2: return -EROFS to mount.ocfs2 if inode block is invalid
Date: Wed, 25 Apr 2018 12:35:28 +0200
Message-Id: <20180425103246.794868956@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598714509634182843?=
X-GMAIL-MSGID: =?utf-8?q?1598714509634182843?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: piaojun <piaojun@huawei.com>


[ Upstream commit 025bcbde3634b2c9b316f227fed13ad6ad6817fb ]

If metadata is corrupted such as 'invalid inode block', we will get
failed by calling 'mount()' and then set filesystem readonly as below:

  ocfs2_mount
    ocfs2_initialize_super
      ocfs2_init_global_system_inodes
        ocfs2_iget
          ocfs2_read_locked_inode
            ocfs2_validate_inode_block
	      ocfs2_error
	        ocfs2_handle_error
	          ocfs2_set_ro_flag(osb, 0);  // set readonly

In this situation we need return -EROFS to 'mount.ocfs2', so that user
can fix it by fsck.  And then mount again.  In addition, 'mount.ocfs2'
should be updated correspondingly as it only return 1 for all errno.
And I will post a patch for 'mount.ocfs2' too.

Link: http://lkml.kernel.org/r/5A4302FA.2010606@huawei.com
Signed-off-by: Jun Piao <piaojun@huawei.com>
Reviewed-by: Alex Chen <alex.chen@huawei.com>
Reviewed-by: Joseph Qi <jiangqi903@gmail.com>
Reviewed-by: Changwei Ge <ge.changwei@h3c.com>
Reviewed-by: Gang He <ghe@suse.com>
Cc: Mark Fasheh <mfasheh@versity.com>
Cc: Joel Becker <jlbec@evilplan.org>
Cc: Junxiao Bi <junxiao.bi@oracle.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ocfs2/super.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- a/fs/ocfs2/super.c
+++ b/fs/ocfs2/super.c
@@ -474,9 +474,8 @@ static int ocfs2_init_global_system_inod
 		new = ocfs2_get_system_file_inode(osb, i, osb->slot_num);
 		if (!new) {
 			ocfs2_release_system_inodes(osb);
-			status = -EINVAL;
+			status = ocfs2_is_soft_readonly(osb) ? -EROFS : -EINVAL;
 			mlog_errno(status);
-			/* FIXME: Should ERROR_RO_FS */
 			mlog(ML_ERROR, "Unable to load system inode %d, "
 			     "possibly corrupt fs?", i);
 			goto bail;
@@ -505,7 +504,7 @@ static int ocfs2_init_local_system_inode
 		new = ocfs2_get_system_file_inode(osb, i, osb->slot_num);
 		if (!new) {
 			ocfs2_release_system_inodes(osb);
-			status = -EINVAL;
+			status = ocfs2_is_soft_readonly(osb) ? -EROFS : -EINVAL;
 			mlog(ML_ERROR, "status=%d, sysfile=%d, slot=%d\n",
 			     status, i, osb->slot_num);
 			goto bail;
