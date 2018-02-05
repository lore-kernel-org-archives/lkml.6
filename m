Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226lYt8zAXXX+dWfrF9W413/Gp+LudFEdmIxlHMSClhZmHvsgXP0jPIi50LwL4c10uKg8B+J
ARC-Seal: i=1; a=rsa-sha256; t=1517855206; cv=none;
        d=google.com; s=arc-20160816;
        b=sukbrHg3XWEXeJw8FAQE+uleLM/1FamrAtQFmipl7w85Qnfc0bxTZTHreC8vkF83RF
         MggXFTBydACpQd6Qn/tK6yHsO3emyzB+X+iDFSRrdPT2Ium3KgV+MMFRu6y+l7SMst7a
         ou1ZbDToOBl2x8qLN3RcDJ3ZLm9i9/LKxyTT4aqmFK9vencdNSt8IufBrIfBWzghe3qQ
         cpShZoZoHmW8Xa+GVpHej92VVrnBFp1JnK9oTRHk6w6mw6JBoigKBlipVNjgQvfW6FbM
         bEKobnN99dVqzN+Hu/PwlsE28e31c7zlSSAyhiF+s10yuSy7x9Np8Stb/EOg6gyiHCdr
         RCfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=LIubY83QVA5QVTlIsKFFdxRMlnT5E3AYpUCy+ud16Ls=;
        b=xARAGcmTV2k5z2kO3GW24Wu3BUtPFZgX/3Azq3WxKksSXIvwZ29g649sN/WAv7NT5r
         AuRL39sSAM8AdDKfh3FLo26ghX933ebuh3DkHFPspvkreOYMqoW5iC7GJI0d3yze5svj
         SK9APoZOlpA70dDKyztOFpr0yC2xnphPu/00SU54hpjWFsAxHNIMMM3jQYJvGIsyNJRz
         shDke9+Oy6U91SrDNRU0vSVEobiw5ZxBu+8KOWRFAGpuzo63AFrJw0QsS7m2H9cKa9BV
         TwnmNOhjq98F/lCbZCpnEA0fyNg+Jxewp6ZprJO/rXbNB0YD0IuoerTgQG68x43GiWNB
         mgsw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	=?UTF-8?q?=E8=8C=83=E9=BE=99=E9=A3=9E?= <long7573@126.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jens Axboe <axboe@kernel.dk>,
	Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 3.18 05/36] loop: fix concurrent lo_open/lo_release
Date: Mon,  5 Feb 2018 10:23:33 -0800
Message-Id: <20180205182352.000065756@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180205182351.774761393@linuxfoundation.org>
References: <20180205182351.774761393@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591586540486743447?=
X-GMAIL-MSGID: =?utf-8?q?1591586540486743447?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1512,9 +1512,8 @@ out:
 	return err;
 }
 
-static void lo_release(struct gendisk *disk, fmode_t mode)
+static void __lo_release(struct loop_device *lo)
 {
-	struct loop_device *lo = disk->private_data;
 	int err;
 
 	mutex_lock(&lo->lo_ctl_mutex);
@@ -1542,6 +1541,13 @@ out:
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
