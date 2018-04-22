Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx498ydMoumQfSaeJ6ws8KPTq41PhukkbpHpFTsVTTf73LwRZ0J3yLiwK5es80sAqh7pKWibB
ARC-Seal: i=1; a=rsa-sha256; t=1524406783; cv=none;
        d=google.com; s=arc-20160816;
        b=JPJ5c+UrTv6x6xFJ0vUohY7wupFMZn9OyplYy0Bn8LypbLyG611TKrhFaCT0KCnJYG
         y+IQXbvd8JRUnAxHiZFMQ58hFrXz6tHMakxS0YI3dJ23EDodjZ+5MeHYtlIzzNZa/D8y
         YXWdm68g+G4lLiNSNVD7eA48tKKWTyN66YUeGzAlGlx3p7m79ietCz6+L0ECePa/vrJy
         t+4O1WYuNYFTvy32PM1+ej+hJ1pcCkFDAqxbs/fM4UeMT8AsrFfPZHbWYn9/vZMeHVfQ
         vZ9kWn/JRi/T2AsytRXUp0qAKQ7LIzGkCkXvOoIlchNYaZB3FvaVjsCXYJLKKP7j+zE7
         AIww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=f0VGSEOtkZ/kuuHkRfcG3VeuzphAhV/ZmoSdQ/u4LaA=;
        b=flq6w4tSeQIKv28nl41JW5GX2gJ1gSk0C1pfgcnDx3lHaSg7dHMJ+lcCKjPx0Nc5Iv
         xBmbHsn+t2WuhCqbCPyyEfUc5GKL43XRVa58KtGjslTeRqzHwYjPSbTt6gtv/ONk3LCD
         EwsvAiZ0vsd1c5GxY6EPznp9MdxbpuuiLpjK6YtVvFI/m0apMhACX/cDJuThYHa5tgRX
         jGUtz8py/rtuosRClMtFVys4ZsywGMa5aKAaphwtKpEq1OmAhpmjRtqUimdVMrKM3pQQ
         9Z3nOMqON7AtiDNLZ04YGLAI5g2tS7n/Jt6uInv3a+qNKHsJs6YbEq+3StQs1Ri10Udm
         hwvg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jan Kara <jack@suse.cz>,
	Theodore Tso <tytso@mit.edu>,
	Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH 4.4 76/97] ext4: fix crashes in dioread_nolock mode
Date: Sun, 22 Apr 2018 15:53:54 +0200
Message-Id: <20180422135309.388978783@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135304.577223025@linuxfoundation.org>
References: <20180422135304.577223025@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598456367593353051?=
X-GMAIL-MSGID: =?utf-8?q?1598456367593353051?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jan Kara <jack@suse.cz>

commit 74dae4278546b897eb81784fdfcce872ddd8b2b8 upstream.

Competing overwrite DIO in dioread_nolock mode will just overwrite
pointer to io_end in the inode. This may result in data corruption or
extent conversion happening from IO completion interrupt because we
don't properly set buffer_defer_completion() when unlocked DIO races
with locked DIO to unwritten extent.

Since unlocked DIO doesn't need io_end for anything, just avoid
allocating it and corrupting pointer from inode for locked DIO.
A cleaner fix would be to avoid these games with io_end pointer from the
inode but that requires more intrusive changes so we leave that for
later.

Cc: stable@vger.kernel.org
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ext4/inode.c |   40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3256,29 +3256,29 @@ static ssize_t ext4_ext_direct_IO(struct
 	 * case, we allocate an io_end structure to hook to the iocb.
 	 */
 	iocb->private = NULL;
-	ext4_inode_aio_set(inode, NULL);
-	if (!is_sync_kiocb(iocb)) {
-		io_end = ext4_init_io_end(inode, GFP_NOFS);
-		if (!io_end) {
-			ret = -ENOMEM;
-			goto retake_lock;
-		}
-		/*
-		 * Grab reference for DIO. Will be dropped in ext4_end_io_dio()
-		 */
-		iocb->private = ext4_get_io_end(io_end);
-		/*
-		 * we save the io structure for current async direct
-		 * IO, so that later ext4_map_blocks() could flag the
-		 * io structure whether there is a unwritten extents
-		 * needs to be converted when IO is completed.
-		 */
-		ext4_inode_aio_set(inode, io_end);
-	}
-
 	if (overwrite) {
 		get_block_func = ext4_get_block_write_nolock;
 	} else {
+		ext4_inode_aio_set(inode, NULL);
+		if (!is_sync_kiocb(iocb)) {
+			io_end = ext4_init_io_end(inode, GFP_NOFS);
+			if (!io_end) {
+				ret = -ENOMEM;
+				goto retake_lock;
+			}
+			/*
+			 * Grab reference for DIO. Will be dropped in
+			 * ext4_end_io_dio()
+			 */
+			iocb->private = ext4_get_io_end(io_end);
+			/*
+			 * we save the io structure for current async direct
+			 * IO, so that later ext4_map_blocks() could flag the
+			 * io structure whether there is a unwritten extents
+			 * needs to be converted when IO is completed.
+			 */
+			ext4_inode_aio_set(inode, io_end);
+		}
 		get_block_func = ext4_get_block_write;
 		dio_flags = DIO_LOCKING;
 	}
