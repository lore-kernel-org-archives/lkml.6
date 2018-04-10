Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+3nO5v2YWtrp3at0CxdBx4shygl9aVwf8pqr24avSFbUVnwrX0JLWt+vkal0j7JQ6d2reL
ARC-Seal: i=1; a=rsa-sha256; t=1523399245; cv=none;
        d=google.com; s=arc-20160816;
        b=r1mINuNkXLWBPrLakgpjqR2SZBsAKYIMsbrXjsIK8g/uk3gfiSOwB7mRwJbaqryK4n
         DoTuZX7SFK95S7z5ByZHUcWnI3VdZYA9lpjM92wUjTaTWzVbS6MbbnPR3lGEdZuwx7/L
         +v6U8kpuCvfmVQ9E08zeb2nt65aOPMPqO+q7FCCd6XyC4AcZyMls7xq02ybDClKdSxx3
         c+UHaDQ2ued+xJox+Vsr0hB0ika3wvnULF0ykc5EHx1l9rfLzqu0dpKVPLtiCdAGJvgc
         Nxqu3OxfmRdypIUGaNJZC8IE/d8ADA7zwQj3F1cvFXiVP5N8u7IfD29VX0Ci6GHzR4KK
         +87g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=mn0KZ/l8MEsNtIR6yNaW7ulCulvRTdZrDtPBTmwDX2Y=;
        b=H7a+TZWfYUk4NV9wEif9NxUge43agl1+iwPnRXfo/p2CDCDIMuccmnQPtfAZ7lXCJ8
         6J2Za1qc2PVAceFjFANiOwnajWkbY8oSuJJzPbTOkisDQy5zk8V7SIEo8W8Lr/yT3oiF
         ZqedAXLCpuKnmgshz4HgTlItltQfhKaa1qO1Yjz/ASxgXewSyronSA5y3e7qyK4Yjpg1
         HQqVRHIWvyUPALZ7TlDJ1NWSgQHoUS9kVAgIULzLVcPOZkeWlmUMa+IssixkxaFhMRzh
         INmEszCs9wscewQqDVDvJKjsYfAoozvfMXYjnemKLjSagjxZs1HS9rJfvPbSQfyKnSH1
         KwRw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Chao Yu <yuchao0@huawei.com>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 031/168] f2fs: fix lock dependency in between dio_rwsem & i_mmap_sem
Date: Wed, 11 Apr 2018 00:22:53 +0200
Message-Id: <20180410212801.523191136@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212800.144079021@linuxfoundation.org>
References: <20180410212800.144079021@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597399887053156628?=
X-GMAIL-MSGID: =?utf-8?q?1597399887053156628?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chao Yu <yuchao0@huawei.com>


[ Upstream commit 21020812c9e1ab593367fad9ce579f842a0b406d ]

test/generic/208 reports a potential deadlock as below:

Chain exists of:
  &mm->mmap_sem --> &fi->i_mmap_sem --> &fi->dio_rwsem[WRITE]

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&fi->dio_rwsem[WRITE]);
                               lock(&fi->i_mmap_sem);
                               lock(&fi->dio_rwsem[WRITE]);
  lock(&mm->mmap_sem);

This patch changes the lock dependency as below in fallocate() to
fix this issue:
- dio_rwsem
 - i_mmap_sem

Fixes: bb06664a534b ("f2fs: avoid race in between GC and block exchange")
Signed-off-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/f2fs/file.c |   20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1186,14 +1186,14 @@ static int f2fs_collapse_range(struct in
 	pg_start = offset >> PAGE_SHIFT;
 	pg_end = (offset + len) >> PAGE_SHIFT;
 
+	/* avoid gc operation during block exchange */
+	down_write(&F2FS_I(inode)->dio_rwsem[WRITE]);
+
 	down_write(&F2FS_I(inode)->i_mmap_sem);
 	/* write out all dirty pages from offset */
 	ret = filemap_write_and_wait_range(inode->i_mapping, offset, LLONG_MAX);
 	if (ret)
-		goto out;
-
-	/* avoid gc operation during block exchange */
-	down_write(&F2FS_I(inode)->dio_rwsem[WRITE]);
+		goto out_unlock;
 
 	truncate_pagecache(inode, offset);
 
@@ -1212,9 +1212,8 @@ static int f2fs_collapse_range(struct in
 	if (!ret)
 		f2fs_i_size_write(inode, new_size);
 out_unlock:
-	up_write(&F2FS_I(inode)->dio_rwsem[WRITE]);
-out:
 	up_write(&F2FS_I(inode)->i_mmap_sem);
+	up_write(&F2FS_I(inode)->dio_rwsem[WRITE]);
 	return ret;
 }
 
@@ -1385,6 +1384,9 @@ static int f2fs_insert_range(struct inod
 
 	f2fs_balance_fs(sbi, true);
 
+	/* avoid gc operation during block exchange */
+	down_write(&F2FS_I(inode)->dio_rwsem[WRITE]);
+
 	down_write(&F2FS_I(inode)->i_mmap_sem);
 	ret = truncate_blocks(inode, i_size_read(inode), true);
 	if (ret)
@@ -1395,9 +1397,6 @@ static int f2fs_insert_range(struct inod
 	if (ret)
 		goto out;
 
-	/* avoid gc operation during block exchange */
-	down_write(&F2FS_I(inode)->dio_rwsem[WRITE]);
-
 	truncate_pagecache(inode, offset);
 
 	pg_start = offset >> PAGE_SHIFT;
@@ -1425,10 +1424,9 @@ static int f2fs_insert_range(struct inod
 
 	if (!ret)
 		f2fs_i_size_write(inode, new_size);
-
-	up_write(&F2FS_I(inode)->dio_rwsem[WRITE]);
 out:
 	up_write(&F2FS_I(inode)->i_mmap_sem);
+	up_write(&F2FS_I(inode)->dio_rwsem[WRITE]);
 	return ret;
 }
 
