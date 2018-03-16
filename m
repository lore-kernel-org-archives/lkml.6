Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsCikH5YK7AIstMz+EryQBouGQ5jHgJMU3LJUIc+ak/YXgjAYsVTPrvQEv+CajBi7KDbDh4
ARC-Seal: i=1; a=rsa-sha256; t=1521214249; cv=none;
        d=google.com; s=arc-20160816;
        b=Zp6uozc/FQRjrbjkqRohVO2HnOmZPBRF6IPB0JzlYMYcaV2H0kCkqUnWNPElJi/SiE
         QXfNQiKuYzrgdu3PuR1kNr3awBYUjkxdFzc6vZIiHkxwVArxRlpr41RHurXx849EOX0/
         IXy1YIGn34uNKb9/gUE2UB09w65P7k4UyO1KQIUlLhfBEpc07r6Vr8mXX3wnPYBj0YTq
         k3KceONbBMIq5gSuvJopToQjDIWMoZJ+P9VhwvDY89bCkKrof3eaDCears1pXY4BvNV0
         edI+vgYVtFR/KDyjFS/Mc4rYYJZkIlFyT5dg28gXuyKXQtsKO2W9SqhFSrigPqB7cKsf
         B6yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ay5ZyH9giRV/DPrXL70suTAgdNmnVnLSj9RMxjcT16c=;
        b=KbzI3S1f/Mj3XjFBfnIpuJvaMQOY0CToG84G+CvnlGps4mX8JRu7+IOM80QeH9WMno
         PFzzRt+EFwWNXY3BRHRbQAH6QD2AIbnfNPbP0fV5N3GN9R/gZvwDj872VqmUj1oafSpi
         aPPmM/tTavi3+jCu4597ty8AKunQkjIPEXS9kZHAxJwvY5UPWflySpOroVLmKVRiVY8I
         Z4jTVwKtJuwIGUALlPPWMu0QF5asz+rG2XdIC473GXmjejBox5JoBDWr4wN1u6MRyZLW
         /tz7sa0e+CiBTPohN0vDWIoGspIU2gs/1TMF3PE4a4pNs0483xn+z3QLerRAmk4H4afC
         J3iQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Michael Lyle <mlyle@lyle.org>,
	Tang Junhui <tang.junhui@zte.com.cn>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.9 27/86] bcache: dont attach backing with duplicate UUID
Date: Fri, 16 Mar 2018 16:22:50 +0100
Message-Id: <20180316152319.238331761@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152317.167709497@linuxfoundation.org>
References: <20180316152317.167709497@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595108530772028561?=
X-GMAIL-MSGID: =?utf-8?q?1595108752787981765?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Lyle <mlyle@lyle.org>

commit 86755b7a96faed57f910f9e6b8061e019ac1ec08 upstream.

This can happen e.g. during disk cloning.

This is an incomplete fix: it does not catch duplicate UUIDs earlier
when things are still unattached.  It does not unregister the device.
Further changes to cope better with this are planned but conflict with
Coly's ongoing improvements to handling device errors.  In the meantime,
one can manually stop the device after this has happened.

Attempts to attach a duplicate device result in:

[  136.372404] loop: module loaded
[  136.424461] bcache: register_bdev() registered backing device loop0
[  136.424464] bcache: bch_cached_dev_attach() Tried to attach loop0 but duplicate UUID already attached

My test procedure is:

  dd if=/dev/sdb1 of=imgfile bs=1024 count=262144
  losetup -f imgfile

Signed-off-by: Michael Lyle <mlyle@lyle.org>
Reviewed-by: Tang Junhui <tang.junhui@zte.com.cn>
Cc: <stable@vger.kernel.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/md/bcache/super.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -937,6 +937,7 @@ int bch_cached_dev_attach(struct cached_
 	uint32_t rtime = cpu_to_le32(get_seconds());
 	struct uuid_entry *u;
 	char buf[BDEVNAME_SIZE];
+	struct cached_dev *exist_dc, *t;
 
 	bdevname(dc->bdev, buf);
 
@@ -960,6 +961,16 @@ int bch_cached_dev_attach(struct cached_
 		return -EINVAL;
 	}
 
+	/* Check whether already attached */
+	list_for_each_entry_safe(exist_dc, t, &c->cached_devs, list) {
+		if (!memcmp(dc->sb.uuid, exist_dc->sb.uuid, 16)) {
+			pr_err("Tried to attach %s but duplicate UUID already attached",
+				buf);
+
+			return -EINVAL;
+		}
+	}
+
 	u = uuid_find(c, dc->sb.uuid);
 
 	if (u &&
