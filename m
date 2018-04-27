Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZob04QsPxcOXamwUyesdQ+ry1KOR35hkMa4F6gbXcQvLwo6dfqNk7L7+7RfFLU04LBlPtzB
ARC-Seal: i=1; a=rsa-sha256; t=1524838340; cv=none;
        d=google.com; s=arc-20160816;
        b=GbqSPXSa7j2IkzmUMLgMpHLve1Msn5NWxHwSrFdTAu2DPuk9dUxgVmC8qgzAUAi1k2
         GMBZbIfMHddKOQ/uWrlWhYmYX3fofeDvyF8k/tnWdTJO0ICrbwSGxykeFy5uTYIxundq
         evL2geFZCdB6rMkGlo20esgpFIqjEzLYxA2ZvzGk11pnLx9P0+sy+fi/qf47lYevYpvq
         C83tyZ0OlRDER+6ElzVgjpbX/rWbsTMq2wTHXgKGvrB1yPqSi1Ufcw/unCTNUZ2NKvlG
         7WHJl28V7BO5/NqR3DAxwe0nNdYllw3m6BqoOOztxVHU8TnbtAIbJkk94GK3mDm6Z/bp
         9sdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=4tOoQJMUstGnZStWZBU7mbJhIP80Dwqc3rHA2wch6O0=;
        b=jJoW9qYtEtblHe8W91UwYSgzPaLmIIT/zdZrl+n1oBf+bdk+pDqQ/LYqL+v/xT39Qz
         YDBzu/nwUPDkGWa77p4SupJkmyzN9X+FRc0undExIcBB9C89jUe9zDD6TzTjbv0W6WXg
         44emD02koCnZ2At4TIB1buUDF43RW2TpkVxdbHse2aHNSj+rUY4WQfSrObda8S0SXq5e
         lQLI9K4lygeQck34M78UubERDbFG7phOvSuI1MBX5/pI1OEw3IEMV41SoxRbEDVamEg8
         ps08BM5MP6MofJ6BY3Qw2alSxWHnBZWI/cwi2x5jhnYJpRXD0FMPC3T2j/rIputBDBJ7
         oskw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C14121864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Laurent Vivier <lvivier@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Stan Johnson <userm57@yahoo.com>,
	Finn Thain <fthain@telegraphics.com.au>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 4.16 67/81] block/swim: Dont log an error message for an invalid ioctl
Date: Fri, 27 Apr 2018 15:59:09 +0200
Message-Id: <20180427135747.198744729@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135743.216853156@linuxfoundation.org>
References: <20180427135743.216853156@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908664259086459?=
X-GMAIL-MSGID: =?utf-8?q?1598908887733699761?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Finn Thain <fthain@telegraphics.com.au>

commit 8e2ab5a4efaac77fb93e5b5b109d0b3976fdd3a0 upstream.

The 'eject' shell command may send various different ioctl commands.
This leads to error messages on the console even though the FDEJECT
ioctl succeeds.

~# eject floppy
SWIM floppy_ioctl: unknown cmd 21257
SWIM floppy_ioctl: unknown cmd 1

Don't log an error message for an invalid ioctl, just do as the
swim3 driver does and return -ENOTTY.

Cc: Laurent Vivier <lvivier@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: stable@vger.kernel.org # v4.14+
Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
Acked-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/block/swim.c |    9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

--- a/drivers/block/swim.c
+++ b/drivers/block/swim.c
@@ -727,14 +727,9 @@ static int floppy_ioctl(struct block_dev
 		if (copy_to_user((void __user *) param, (void *) &floppy_type,
 				 sizeof(struct floppy_struct)))
 			return -EFAULT;
-		break;
-
-	default:
-		printk(KERN_DEBUG "SWIM floppy_ioctl: unknown cmd %d\n",
-		       cmd);
-		return -ENOSYS;
+		return 0;
 	}
-	return 0;
+	return -ENOTTY;
 }
 
 static int floppy_getgeo(struct block_device *bdev, struct hd_geometry *geo)
