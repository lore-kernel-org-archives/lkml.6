Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/8Np6d/kw2irqg2paFtQo06MtgpA8dqTa+1IwLvoBVJzC4PQ8hMwgwnxagPnT5I5G6nUVr
ARC-Seal: i=1; a=rsa-sha256; t=1524406096; cv=none;
        d=google.com; s=arc-20160816;
        b=Yy6BqDZyRlje7eXWZ4dnuTNXdynVlbUWEYjx8P+32QAO4tJaAexzUK4SkyoPBF/VH5
         ZODRa+vQkIMQHjfpC04bg2TYUpdf9ahwYSuvGz5vsOLuuplBqcbkARFP0Do+M1bWyeTF
         5hAR4vrhi2bfqLM7PDSOYNQd5Y7FnbevqIr37Ks/NFUgHkpZtO1C1OAvD8GwTGItz/QV
         QvK5dTqSlCHRDi5S6Xc/2LVasr9WiMdox/LU+C5yOcGS/TWb7bxUe6OUYhf/cNiLRWS6
         xtBFTOkEubiBg1Zb2JXOlqgcTLFKBKBmCT9TxOFjO83HhqJ+bHesKoCx024+wVfoaM8s
         NtwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=KLt6BUTBXKuQZcSMvvE5X5K1NY0i0fLheCndGxIkWzk=;
        b=bWPLlWraUJQ0DddmiEgus2Gl67SFiG9UFoiiAWIGZoaQluLtqmNLWuXFCAoF2zcQi4
         rpVVXFd5YIwrGtwhloEGgoJQVK1os0qeExJC757MbgxyZA2dMZyrkvrW2s+E0D1ihSCv
         ROlbda+Vr/Qr55IM+OqW153XlIYeRMGdXm5e51pf9ciGx4+hFgH8a/eW7+D2thvo2swz
         Fl/uagMVtirnCm9xsBYnPn4DlfWgEbqZdSblSa/VE7Fw3SPP3ESwGJ1TJIFwmyOnBPAM
         8K5IhJSP4FUNIje4QecNQrzYkdu13xxEJQvUQhZcA+4rpZNa3d4Rpxp0J2xITjvbHt6Z
         ANmA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jan Kara <jack@suse.cz>,
	Eryu Guan <guaneryu@gmail.com>,
	Theodore Tso <tytso@mit.edu>
Subject: [PATCH 4.14 076/164] ext4: protect i_disksize update by i_data_sem in direct write path
Date: Sun, 22 Apr 2018 15:52:23 +0200
Message-Id: <20180422135138.566678732@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135135.400265110@linuxfoundation.org>
References: <20180422135135.400265110@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455118464446356?=
X-GMAIL-MSGID: =?utf-8?q?1598455647382870217?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eryu Guan <guaneryu@gmail.com>

commit 73fdad00b208b139cf43f3163fbc0f67e4c6047c upstream.

i_disksize update should be protected by i_data_sem, by either taking
the lock explicitly or by using ext4_update_i_disksize() helper. But the
i_disksize updates in ext4_direct_IO_write() are not protected at all,
which may be racing with i_disksize updates in writeback path in
delalloc buffer write path.

This is found by code inspection, and I didn't hit any i_disksize
corruption due to this bug. Thanks to Jan Kara for catching this bug and
suggesting the fix!

Reported-by: Jan Kara <jack@suse.cz>
Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Eryu Guan <guaneryu@gmail.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ext4/inode.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3614,7 +3614,6 @@ static ssize_t ext4_direct_IO_write(stru
 {
 	struct file *file = iocb->ki_filp;
 	struct inode *inode = file->f_mapping->host;
-	struct ext4_inode_info *ei = EXT4_I(inode);
 	ssize_t ret;
 	loff_t offset = iocb->ki_pos;
 	size_t count = iov_iter_count(iter);
@@ -3638,7 +3637,7 @@ static ssize_t ext4_direct_IO_write(stru
 			goto out;
 		}
 		orphan = 1;
-		ei->i_disksize = inode->i_size;
+		ext4_update_i_disksize(inode, inode->i_size);
 		ext4_journal_stop(handle);
 	}
 
@@ -3746,7 +3745,7 @@ static ssize_t ext4_direct_IO_write(stru
 		if (ret > 0) {
 			loff_t end = offset + ret;
 			if (end > inode->i_size) {
-				ei->i_disksize = end;
+				ext4_update_i_disksize(inode, end);
 				i_size_write(inode, end);
 				/*
 				 * We're going to return a positive `ret'
