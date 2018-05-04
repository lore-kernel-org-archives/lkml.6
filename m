Return-Path: <flo@geekplace.eu>
X-Google-Smtp-Source: AB8JxZpPzyfEgWeSdQqOBDrnsPEN+n1CVUjNWQ9qj45jHGiyceqiDGq0Mi85BrTVGJFyyMrpcDrz
ARC-Seal: i=1; a=rsa-sha256; t=1525440239; cv=none;
        d=google.com; s=arc-20160816;
        b=SnEd9HvTqeBaBKGE4PkKKlTHZ8y6OdDC484riN63fYv7gJ8TE9x5LXoe0eycLajeu6
         u8ekoT3904f/PF8lwBd+iBiRty6N5hnI+zc+9mICmZ/nbd8+M9rduknFGGumXyomeg/T
         DUsqluNCfvrlo6zdb914HwaS4/KPxGS0x67EnH19RNLDZLvDfSBbJ5vF9dm80ryEfjjq
         qPZrpS1+iI/fKWqQrw8xEfy+/03pzfg9FtNxRQsRBnI76LxxYumriEkDiPuuoqKoK1Cy
         W8vQNs/z9HSq/awRrgkvR5oQmUOc79xI/51ths3sRXFwLwNBfXd29g8qGZ9qE5QcdUCK
         GT9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=5KLABqp84uxk5G+0vwm6jkgsOfC/8ixE9KU6vvYXLG0=;
        b=zjCZrnilLxIrHdyiw/+aDwkozzfhQRreebRUqaPTRcYG0DJZ+MyRXrnUVxFmds7X60
         5QiexFjMNPMjOz7ykkQg/Zi7rEb7O1SnHBl14o42NDiVoOtvsQ/cWskdK6iA331b7N7b
         Ty3xwowbBpEBj+CgjlvzztHBq9fnBHgmM1muwXc2kZ1GFxkBaDES6CqK/YS+WmQuVWeV
         6ZsDpWIgo/EGElrMek31f+K8jY0j7yFgBdw5Ds3u9mxRKwn9LFRy3vVp4tgyPkc5zLHq
         puuZoBHQnQzYWg3soH3cD2SDS59jgOx3sIMgtjdjhHTjHJ9ZIkB/iQOqef4mlqNowYGj
         I8zQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of flo@geekplace.eu designates 2a03:4000:6:3a8::1 as permitted sender) smtp.mailfrom=flo@geekplace.eu
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of flo@geekplace.eu designates 2a03:4000:6:3a8::1 as permitted sender) smtp.mailfrom=flo@geekplace.eu
From: Florian Schmaus <flo@geekplace.eu>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org,
	Florian Schmaus <flo@geekplace.eu>
Subject: [PATCH v2] driver-core: Return EBUSY error instead of BUG_ON()
Date: Fri,  4 May 2018 15:23:57 +0200
Message-Id: <20180504132357.31771-1-flo@geekplace.eu>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180307094902.20316-1-flo@geekplace.eu>
References: <20180307094902.20316-1-flo@geekplace.eu>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599540024221458723?=
X-GMAIL-MSGID: =?utf-8?q?1599540024221458723?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

I triggerd the BUG_ON() in driver_register(), which was added in
f48f3febb2cbfd0f2ecee7690835ba745c1034a4, when booting a domU Xen
domain. Since there was no contextual information logged, I needed to
attach kgdb to determine the culprit (the wmi-bmof driver in my case).

Instead of running into a BUG_ON() we print an error message
identifying the driver but continue booting.

Signed-off-by: Florian Schmaus <flo@geekplace.eu>
---
 drivers/base/driver.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/base/driver.c b/drivers/base/driver.c
index ba912558a510..63baec586eba 100644
--- a/drivers/base/driver.c
+++ b/drivers/base/driver.c
@@ -148,7 +148,11 @@ int driver_register(struct device_driver *drv)
 	int ret;
 	struct device_driver *other;
 
-	BUG_ON(!drv->bus->p);
+	if (!drv->bus->p) {
+		printk(KERN_ERR "Driver '%s' was unable to register bus_type\n",
+			   drv->name);
+		return -EBUSY;
+	}
 
 	if ((drv->bus->probe && drv->probe) ||
 	    (drv->bus->remove && drv->remove) ||
-- 
2.16.1
