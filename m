Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZryZUvMhluiItxqkPaq8m23DCuYUnFQeZqB1B3X3Nb//PeR+LYtwzrlEWuAMcJFhyEiChQj
ARC-Seal: i=1; a=rsa-sha256; t=1524838127; cv=none;
        d=google.com; s=arc-20160816;
        b=FJC0c0Xtz8n3BV/OVn4JbVISLq2mBTl+VJQMYPWuctv70mhGmyZoqo4RrlSy3oDA3L
         neTO9/PHp43nz4ifkR9GGwXRiPDMwSyO9DBmHCfe79L46TM2epcntMaKr9uKWxmORXYQ
         X2B3M60xRCy9YqEouS3WGX8hDr43HaeSee1+N2MC1YE2Ex6ClDo+ppo8T3ndsvwwEW1X
         rg8dL8uFkGvpkZ3zrK+uMynMPpuWVE7PFHIDcgq2o82YlKp/2bQ1wdN4PLb99q0N5ivU
         a7emArK2MNs2RPlJRxTAb0/GaGK5k3jHv5K1Gy+m8qyEsbfx4km9o6uffk67EijT/QcW
         u90w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=fO1TumWz13SRbQ1jQI6eaPuSAaJ44WohMm03gXiAhfc=;
        b=D5/YJ0jWhKTaGNZtel+OQbIYXey13DOYrVI2sFDrQkFQ1U4aIYuwWb7loSL0EtdX8C
         v3dW0L3E4YcoP0dJpHpk3TFUCo+Si+VE66PmmBVbLO231tlSN991sHbIZxTz0gdsuK1o
         FZcMYEF/qV/FopUqh6Ny/qIfVdYSN8XgBWzDNcKJ1YBfxBzuozEj9cfmwcjFXjPNqP9p
         oD6NRP0i03NwieuFwKXqaM7NkwxjRJdn6FLDJfjN0BLHXYNOT9oA7aTah62qA4ThRfKc
         EW/6zAqF2CNvIjaTHWYGc3IeCSMhhghRAfl90pGzGLEC59wL02xE6w5TZ1gSQ7DzOHg/
         c5Sg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 917F321864
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
Subject: [PATCH 4.14 70/80] block/swim: Dont log an error message for an invalid ioctl
Date: Fri, 27 Apr 2018 15:59:03 +0200
Message-Id: <20180427135736.527909791@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135732.928644313@linuxfoundation.org>
References: <20180427135732.928644313@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908664259086459?=
X-GMAIL-MSGID: =?utf-8?q?1598908664259086459?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
