Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225SRgdRArBL4I8jJW4EGPUhScJgNVeAUxIXkOkh19MZdsjk4xjanOhWG35kcfnNpB/PnmMj
ARC-Seal: i=1; a=rsa-sha256; t=1517590774; cv=none;
        d=google.com; s=arc-20160816;
        b=jt1YrD+qfDMtMFdoZEObKKAz+M/h0owQbqtwmw4eiQj4DfptHYd0Mnpqqe2moHcL0a
         o0uolNtYagavw3ODrkHKm+XARyLnCWxBZRoc6HTCEpaW7HQOslkdacGAl5+1rLB2dI1U
         Wf9Ez1fLuJGpCxzuTVnIyydssIOAfcrE9iHacvAl8i2DAMtRFkc90do8rs9Liu7qd8kP
         MQ6HixBieeSqd5pMBwZGQ1N7aNJRWdd5anQV4AUDBjA+ayMSZ09yPi1ZF2hxHrpZ7y7u
         mqOcyTiyo75IXD8gxB7F72Thi5GaTmeWtZhuRPMoqtU5s5is1r6AX0Pi2p1iLNtdoT4P
         Ckpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=k1yl26veiDdqfJKoLhjVyWDAwSeYIkvTRL5HHoWNpZw=;
        b=fRZQCO5Cxd3gexgh+kbAgOIIJdKX7axgfj3xjWJjbo4SNiyVukojkogqXCYU3dTi9E
         ecG2nq0i0ijUrL/kQNbY5oLs41sYVZky+DV3Sigmh3i14fIb6WjzUDxk186ibtGyI0Ob
         /pGSV/0uLmibJC94sx34+wsR/1cwXGcD08Mck58pCQ+XRW99fkMGypsD1X0wubH95ilQ
         /lrN3+pLVMWb70ic79shQAeuiXZFidaYP7X01hgyCe7ipYLz/FzEE87vOjdqFk8r7XxU
         JZPoOVbWMlTgOTGcKS9pnFOYT9rjRBeFeJIqurzwrupBZwoZr7GJ4FsRbBGcrzLpbcQO
         dl6w==
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
Subject: [PATCH 4.4 01/67] loop: fix concurrent lo_open/lo_release
Date: Fri,  2 Feb 2018 17:57:30 +0100
Message-Id: <20180202140815.352280243@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140815.091718203@linuxfoundation.org>
References: <20180202140815.091718203@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309264145802026?=
X-GMAIL-MSGID: =?utf-8?q?1591309264145802026?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1569,9 +1569,8 @@ out:
 	return err;
 }
 
-static void lo_release(struct gendisk *disk, fmode_t mode)
+static void __lo_release(struct loop_device *lo)
 {
-	struct loop_device *lo = disk->private_data;
 	int err;
 
 	if (atomic_dec_return(&lo->lo_refcnt))
@@ -1597,6 +1596,13 @@ static void lo_release(struct gendisk *d
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
