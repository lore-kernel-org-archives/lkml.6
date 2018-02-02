Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225MOQhgM2w1mUGpN0B6JtkeChtz6pqS85PWqAn0iP5ktBVnG56yohgnmsaqsRVcrv2af8nM
ARC-Seal: i=1; a=rsa-sha256; t=1517590971; cv=none;
        d=google.com; s=arc-20160816;
        b=IIzc1/kHfl0Qfv6/GOAedG7fbvG7yBOwisrtCIflC6YTXEFMEgq0MpzcKcipBKBJrn
         Q5x1FYhmXUD1U1rWvNNnviOP9VTSHL20gyJlNf8RfjncoK8y2UyAIOySGX7cdr5ymlVP
         ybdupLnesFdJHmKTs+2eX5SxpDA+SiPLguG3B3rGVF8qWo8wNtSgAm0ShgJfLPksZ5e+
         yOEhfIMsMrxkHAfddhxnzDqooglTUdj3Nbv8lvwXaev2g/HffK90SuAYnCKFBT9L+piH
         ayC2oMMDTcuk7JEOWyhdmyhF4wl0Y2euOo7GheGLWdaZp/Dv+N14upLmvpapdYNJisEw
         +M3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=F414iYEDXYGGVqQ/IouvCukMF6LpgP1s+AC6rOfze7g=;
        b=NCkZXfizhtaDxBvFrJzmeLLPjUUQIWQ3L+25BSZ1iPDOFSq/A7ZEeDydO0Jff4mKIK
         BwsmTFY4uaBg/PjNcZmnVYBvKHKr+pOEnq8372Nw067oN1Yw+Vg2wYBHwPc7LTIintdz
         puvLC5QVv3eORb3M8RFrfR8fMi4kz4+vtkE38gEmtJEVBN8OZrLEXtOHSsQx8KAJLgYG
         cYRlHktC7i9iOXF7tnhuoz02FcxOE+mRh+A8M7oTob59axHKLtxa7PVUorqjV+EX8Nia
         vZvrySxITD59H8JUQzHVfSPwbiOjUqWx0qpRY1dzC+b7y1PVucQHHWTy0FJ/Kvij94e/
         o5tQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	=?UTF-8?q?=E8=8C=83=E9=BE=99=E9=A3=9E?= <long7573@126.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jens Axboe <axboe@kernel.dk>,
	Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.9 01/86] loop: fix concurrent lo_open/lo_release
Date: Fri,  2 Feb 2018 17:57:21 +0100
Message-Id: <20180202140822.793620959@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140822.679101338@linuxfoundation.org>
References: <20180202140822.679101338@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309264145802026?=
X-GMAIL-MSGID: =?utf-8?q?1591309470312175331?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Linus Torvalds <torvalds@linux-foundation.org>

commit ae6650163c66a7eff1acd6eb8b0f752dcfa8eba5 upstream.

范龙飞 reports that KASAN can report a use-after-free in __lock_acquire.
The reason is due to insufficient serialization in lo_release(), which
will continue to use the loop device even after it has decremented the
lo_refcnt to zero.

In the meantime, another process can come in, open the loop device
again as it is being shut down. Confusion ensues.

Reported-by: 范龙飞 <long7573@126.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Cc: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/block/loop.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1558,9 +1558,8 @@ out:
 	return err;
 }
 
-static void lo_release(struct gendisk *disk, fmode_t mode)
+static void __lo_release(struct loop_device *lo)
 {
-	struct loop_device *lo = disk->private_data;
 	int err;
 
 	if (atomic_dec_return(&lo->lo_refcnt))
@@ -1586,6 +1585,13 @@ static void lo_release(struct gendisk *d
 	mutex_unlock(&lo->lo_ctl_mutex);
 }
 
+static void lo_release(struct gendisk *disk, fmode_t mode)
+{
+	mutex_lock(&loop_index_mutex);
+	__lo_release(disk->private_data);
+	mutex_unlock(&loop_index_mutex);
+}
+
 static const struct block_device_operations lo_fops = {
 	.owner =	THIS_MODULE,
 	.open =		lo_open,
