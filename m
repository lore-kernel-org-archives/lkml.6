Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225PpNGqlHZYEto/T4U6qXH2RnwhTWQrsXuUJOufsyWk3MrdR1fEiT1nJuL+Am7smutAJkO6
ARC-Seal: i=1; a=rsa-sha256; t=1517591263; cv=none;
        d=google.com; s=arc-20160816;
        b=Z0ztSQbeUnhXHuqcFW2czptuy1I1ufyc6JgbgLV29BQZir4S7kfEQ5M+sY3fWYp+6e
         Ijg5VZMHSUxLhSNdhpjLXpYtOD8Qg0PfHpTbOTQVZvlU9ogoChpWmwhZ2yl6EkTZSR4k
         Zknc46T0fmKreFSf5TDbjP5wptUdrG2yMLdwsbqfY2tGgNKBt0UwGAMU04c+Ff/GLV3C
         innzCEz1G/HIyKTpAzgOR9HFFpnFgpsPIWQy8qGr62SnmtzEnJKyzK0ntEz4AW0KQ+U+
         r/mH57uhU4ve6LdJeafKGNhXLq2hD/SDVUNKFHob7p73OGg/cr+jsqjW7HQJI8VhG8iX
         eZDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=hj5zx4468mlMEZGgLuhuzW5aUqKjCst4c3T4gJTUb1Y=;
        b=k6dd8QXs9xy15df/0cxgMMOfWPNrLpVQOhmuiSPFWA+hCpU0PnjWpLQwLyZJE6Y9B2
         MLFEb86vRb8OMke7Uv7znanLGj5Ir88TNodWETIt33prPx0tEPoqC/ysA9PWWoRp0YYX
         6PFUbii/ZuvHDYKGsf+NepzTS9Iv5YnvsLEHtS5dqa2bLWLzVpW/10TEhDFW+maj4qP/
         HH29ZQf/nyqMv3FNrsWxzpyDBCIQfOrdCSpDvP272eDU+KHTzlAIEJWcbBR65ez6W9Fk
         MLICdyvOYHnX8e5CfNBMDQqDwmt0haRsMNLJsWSAvMzt/+dAQS7/Y/S7Joe9bLTPkxyQ
         wWWQ==
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
Subject: [PATCH 4.14 002/156] loop: fix concurrent lo_open/lo_release
Date: Fri,  2 Feb 2018 17:56:23 +0100
Message-Id: <20180202140840.355211867@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140840.242829545@linuxfoundation.org>
References: <20180202140840.242829545@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309264145802026?=
X-GMAIL-MSGID: =?utf-8?q?1591309776806326057?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1576,9 +1576,8 @@ out:
 	return err;
 }
 
-static void lo_release(struct gendisk *disk, fmode_t mode)
+static void __lo_release(struct loop_device *lo)
 {
-	struct loop_device *lo = disk->private_data;
 	int err;
 
 	if (atomic_dec_return(&lo->lo_refcnt))
@@ -1605,6 +1604,13 @@ static void lo_release(struct gendisk *d
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
