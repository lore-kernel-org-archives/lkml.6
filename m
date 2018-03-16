Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuQMHfVz3qcZF71Pb07QYjyuXX/b+xj4s6JaOkkhcPjd9MNqqAIha1IEdcilusLcL1vzr/4
ARC-Seal: i=1; a=rsa-sha256; t=1521214454; cv=none;
        d=google.com; s=arc-20160816;
        b=h/oyGr60ZCowV7xb7Vk17BOQs5tfKZXh749+lWtFDfZFYOkQ7ifD7kJd3Anu1oWAm9
         /NDYlu2mCZV2Ih8QBDJM+IE4AiunEQWlCDF55TBVy2p0vBSkMkQ/yb/LrmT3UZpKFZkb
         Ivcr18PsmM9qqAbIHHzUonR0zuOD44jzzWhWSj5mGwECAdmQ591Rayfm0/wZX+J0u7wB
         m96l2ukfZfmsLYjpyQNpCsk9221k6bv87XklByfThTCZQPfHSOXulJpiNoLdGBs3sFlD
         W5/iLy5gXDtnTGiIZJYnsZYa1V18q4fBn35g8D88Bxs3hNx8idR1Y31/VOp32vAzeO3P
         DJOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=NIHdpCuGGhg6fKIOK1579xl2zD0hC61i02LMS7LSa4w=;
        b=A7Se8mTOIPqerxFifhhsyJv6NeaFEDxM+ELfZ2TBKJx9VGFj9zs57ierxENGDSY4ZX
         2GF9KSBnm7lgOAy6HDcCsCai93tvGt32dpafXprYE4SDkPgot42/dg7n+epH5ck1oNcI
         HpBvnyPXzw04bVcZ30KrpAW8vGnaNS6VswQSRoH9HJdhOiHLS8xPF3VioJd6GwfC5PEE
         dpMUZ0dBRbSE7YXnme3yV5dUSc6u7Ur+FmzXA3ouSmGEIBSLmI6gsZpqLLcCQ0162uyt
         FSxY9+fYPY4daUDQUNBq2lypB/0sNyt6HDlMiYDnxdPBNxm39Nsalk3rHVdBzmLWAxZM
         EsKw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Oliver Neukum <oneukum@suse.com>,
	stable@kernel.org,
	Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 4.14 013/109] uas: fix comparison for error code
Date: Fri, 16 Mar 2018 16:22:42 +0100
Message-Id: <20180316152330.645422547@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152329.844663293@linuxfoundation.org>
References: <20180316152329.844663293@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595108310839479923?=
X-GMAIL-MSGID: =?utf-8?q?1595108967640643593?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Oliver Neukum <oneukum@suse.com>

commit 9a513c905bb95bef79d96feb08621c1ec8d8c4bb upstream.

A typo broke the comparison.

Fixes: cbeef22fd611 ("usb: uas: unconditionally bring back host after reset")
Signed-off-by: Oliver Neukum <oneukum@suse.com>
CC: stable@kernel.org
Acked-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/storage/uas.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/usb/storage/uas.c
+++ b/drivers/usb/storage/uas.c
@@ -1076,7 +1076,7 @@ static int uas_post_reset(struct usb_int
 		return 0;
 
 	err = uas_configure_endpoints(devinfo);
-	if (err && err != ENODEV)
+	if (err && err != -ENODEV)
 		shost_printk(KERN_ERR, shost,
 			     "%s: alloc streams error %d after reset",
 			     __func__, err);
