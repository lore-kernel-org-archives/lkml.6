Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/zdehbkOtQTOCNw4n0m3xWkEJ6WBciHJ4L7rJlrMR5Ams/RVzXpYtytzeRts2RTYlNtTQf
ARC-Seal: i=1; a=rsa-sha256; t=1524405592; cv=none;
        d=google.com; s=arc-20160816;
        b=V3Psf52Lu6Ga9nXcGrSoRPfMz8dpecRzNxKDNdQDJYI+V9vhAMp9MnrQTEkhuFtyal
         I0qDCi4B7doF1PaeDH/UNpLHU5Xm7O3C+TRYOzfeVkE5zHLXIjbGhu+XsivgQvRQGVNT
         5ubdpSSV9Yfm4HRwX48abdMZ3y6RN3myFQEsljgr759tvB0R2tX91Vnd1Sh/vIWbUXWS
         6l+h81sWSLSJhR/NPXcVkCuhY4AD6ZPf/hdY8bLoXJZIW5RAijTdQIhD4QLj7uyiu+N+
         AoMttP9JEcaW6THZuA501FLN/REvVVCErKj3E2dWfon0sh4x2hFdiHV7UcxfeDBpv+ex
         UH+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=u8HTTyj2tzazjkZU6pHgYixFODBkixxa6GJ65wQU3R8=;
        b=COvU0F/3WZozvzseUM+p5ZEIgzZ+Gy8cV8l3AHDhHbqUnfnSCW5oMTd9wI4aF/vMtm
         EZEzfxmVn/F3aO+263Msb+U8wOPRDNOwcti+XrUzMWHLE/LyFnxuDLDmHf6DkwBL/f1b
         OkYNxblMszVCI+Ygk7/I/F7Tm4zgTRJl0F6MfqTpA7ybjbtAsGbyJIzG5yLdqhqkPauI
         5Z4s++uCYjHCu7EUFgDz5QsofnZmHh8R7yhHXQ+hkSpeYbvew7JwoEq/H8DO/I1xw0tx
         y2ElsZH0Sp66Gghrdr4iIa2DVYW87mHBi4iqiMs46SdAVgytcYT10DPW+J/mhoBYBFTX
         FJ2w==
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
Subject: [PATCH 4.16 089/196] ext4: protect i_disksize update by i_data_sem in direct write path
Date: Sun, 22 Apr 2018 15:51:49 +0200
Message-Id: <20180422135108.905407465@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455118464446356?=
X-GMAIL-MSGID: =?utf-8?q?1598455118464446356?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
@@ -3658,7 +3658,6 @@ static ssize_t ext4_direct_IO_write(stru
 {
 	struct file *file = iocb->ki_filp;
 	struct inode *inode = file->f_mapping->host;
-	struct ext4_inode_info *ei = EXT4_I(inode);
 	ssize_t ret;
 	loff_t offset = iocb->ki_pos;
 	size_t count = iov_iter_count(iter);
@@ -3682,7 +3681,7 @@ static ssize_t ext4_direct_IO_write(stru
 			goto out;
 		}
 		orphan = 1;
-		ei->i_disksize = inode->i_size;
+		ext4_update_i_disksize(inode, inode->i_size);
 		ext4_journal_stop(handle);
 	}
 
@@ -3790,7 +3789,7 @@ static ssize_t ext4_direct_IO_write(stru
 		if (ret > 0) {
 			loff_t end = offset + ret;
 			if (end > inode->i_size) {
-				ei->i_disksize = end;
+				ext4_update_i_disksize(inode, end);
 				i_size_write(inode, end);
 				/*
 				 * We're going to return a positive `ret'
