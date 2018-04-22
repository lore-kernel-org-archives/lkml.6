Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+R0pJbKNT3n45E0TJguJenpq+0ZWqgYRmIdNtVD04iJqBwQXB0HO9GWFE04C/KnDHR4VgZ
ARC-Seal: i=1; a=rsa-sha256; t=1524406340; cv=none;
        d=google.com; s=arc-20160816;
        b=WBGfidw6MEjHwQBKUDQy1kmUWHxqqDsVLY7Olysz87i5mdXOxmTcVDgl8nrk3r2eEC
         He5WNGbNQ0zQyarZ3cKF5O64kydtvSFv/C05omWOt5GOTgQoVxSFEcGoRuNRnLcLoESc
         rKUJ/TUB2iZYFByfWsCAp2A4Ly5PInnjFgMxF8+1/UdcWFfPVW3Op+wO17WJCNoblTWW
         KpQw14KQ1nI1sNnHs7lPEhXbzm/v9nUQrM9/njZ9c+nzkxX1mdAiBQv735aXJ4HHdM0i
         gY+lge6rcKml1d/bwV3r216VTaXYtrapDcUsmROcTmPqdZ1bIY3Qy7gebpm71OAi3pWH
         sAVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=GVYRq4++jxyZ6OJmAv4CQvgZ+w4lPS4hk7lgBZ3DBu8=;
        b=h0HmCq2mdQB494IMDxyHmi79Agyb8TCl42yGUm+1dkBommQt2MMmee6jI6w1NmUj4M
         HLj9ZznsYNDFg6tF3jc2jTJkU+3ZkZAqHYazGLmu81N9Izh9Qui/N+a9ndNh6PyU0plG
         /5qJ2FsLFGzd1oHr8NOhwwN7W7TZ6FHXY8r1XGTQrbc33ffDhbh4L1a3y4P9IhSvWv9c
         /CyLsfqmDybkCsZ2sZ53WM+sUW+7guZEaVEViFZEjUegK5c1VhUdHgTNeLtxeHDPtgCW
         ZsiEc2yqaf0qT/zc87i1+14u1+LSqvmLje+LjjZJqG0ZSu0nzvHhav4HmjKzKReD8Mvt
         bs7w==
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
Subject: [PATCH 4.9 36/95] ext4: protect i_disksize update by i_data_sem in direct write path
Date: Sun, 22 Apr 2018 15:53:05 +0200
Message-Id: <20180422135211.902450766@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135210.432103639@linuxfoundation.org>
References: <20180422135210.432103639@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455118464446356?=
X-GMAIL-MSGID: =?utf-8?q?1598455903468384705?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -3396,7 +3396,6 @@ static ssize_t ext4_direct_IO_write(stru
 {
 	struct file *file = iocb->ki_filp;
 	struct inode *inode = file->f_mapping->host;
-	struct ext4_inode_info *ei = EXT4_I(inode);
 	ssize_t ret;
 	loff_t offset = iocb->ki_pos;
 	size_t count = iov_iter_count(iter);
@@ -3420,7 +3419,7 @@ static ssize_t ext4_direct_IO_write(stru
 			goto out;
 		}
 		orphan = 1;
-		ei->i_disksize = inode->i_size;
+		ext4_update_i_disksize(inode, inode->i_size);
 		ext4_journal_stop(handle);
 	}
 
@@ -3548,7 +3547,7 @@ static ssize_t ext4_direct_IO_write(stru
 		if (ret > 0) {
 			loff_t end = offset + ret;
 			if (end > inode->i_size) {
-				ei->i_disksize = end;
+				ext4_update_i_disksize(inode, end);
 				i_size_write(inode, end);
 				/*
 				 * We're going to return a positive `ret'
