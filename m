Return-Path: <flo@geekplace.eu>
X-Google-Smtp-Source: AB8JxZqblSgEI4sQrluEg1pcLdStTqCd+gZr91udmkv+keMRb9Vvsqd4rsvgAer2eYtCtY0w0XtV
ARC-Seal: i=1; a=rsa-sha256; t=1526486897; cv=none;
        d=google.com; s=arc-20160816;
        b=WakRyyU9XclFZltW3Z5aIKX+Tzv8sZl6YnM+qzhhhMk2c3uI0pFdkNb8P4Eg0vYHb1
         zhcbagdJEs7hICICB2tfxpeHpexKmraTskklVW0LqUE9i5fhKHrtqYEEu3zz++Gdfa/k
         9sNapoTZnxjGJwi5fAdqT5zjWfmhANqU897qj+vHO1eLvwbjICaY5Io2aqCxuNR0HKcm
         9VGb1Yn6j2dh+7SONFsQblNpZqB/d3ni9/HBmvZqG7PIWTcW0mswOhEZVaQINsKk7EsV
         uapXZMZrdIr0r3L3Rz7GKiwglBV3e+wENv47fQA3tOMQurZwVxFWtWSsJx0rOyuPPQrw
         xyog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=pkDEHwV6XlqiK3l2F0PHtjif049vz8pGSk02JWYgQUI=;
        b=VRxGcM/TQPDVUSYnQnnpQF1HFHcTT3RdftsxkmKle4VkFEGwb4lbUjQ/gT6VYW9arA
         NY2LG8BrFiJPOYvIqkLrQk0eeaX4t4gCQJYtc31WLF0Hl4rqT7uMmHmiDCDXBtQ0Dfu0
         sK9H4PBGqWx/nJH8ia59liGxbh0nuJv3Xah4oZpqKG7Ko15lKWbdVtc8UQkeibdRpPZM
         485tUouuJs6wthsH2NCxgG3RAHxHo2mrNI0bDpQu8nPR1iFgHzj/RlVrTTgYH8LLL3eC
         dsfD8fPz6nOwWgAS7cEf0UoEhK5m8XyQFh6hDKQrASwNRFWOqS40iMMDjT9PwC0do5g9
         nqmg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of flo@geekplace.eu designates 5.45.100.158 as permitted sender) smtp.mailfrom=flo@geekplace.eu
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of flo@geekplace.eu designates 5.45.100.158 as permitted sender) smtp.mailfrom=flo@geekplace.eu
From: Florian Schmaus <flo@geekplace.eu>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Florian Schmaus <flo@geekplace.eu>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/3] driver-core: return EINVAL error instead of BUG_ON()
Date: Wed, 16 May 2018 18:08:14 +0200
Message-Id: <20180516160816.20251-2-flo@geekplace.eu>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180516160816.20251-1-flo@geekplace.eu>
References: <20180516160816.20251-1-flo@geekplace.eu>
In-Reply-To: <20180516120527.29403-1-flo@geekplace.eu>
References: <20180516120527.29403-1-flo@geekplace.eu>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600538307173968753?=
X-GMAIL-MSGID: =?utf-8?q?1600637524875632768?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

I triggerd the BUG_ON() in driver_register() when booting a domU Xen
domain. Since there was no contextual information logged, I needed to
attach kgdb to determine the culprit (the wmi-bmof driver in my
case). The BUG_ON() was added in commit f48f3febb2cb ("driver-core: do
not register a driver with bus_type not registered").

Instead of running into a BUG_ON() we print an error message
identifying the, likely faulty, driver but continue booting.

Signed-off-by: Florian Schmaus <flo@geekplace.eu>
---

Notes:
    - Do not split long strings across lines.

 drivers/base/driver.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/base/driver.c b/drivers/base/driver.c
index ba912558a510..16b81d1c6cb7 100644
--- a/drivers/base/driver.c
+++ b/drivers/base/driver.c
@@ -148,7 +148,11 @@ int driver_register(struct device_driver *drv)
 	int ret;
 	struct device_driver *other;
 
-	BUG_ON(!drv->bus->p);
+	if (!drv->bus->p) {
+		pr_err("Driver '%s' was unable to register with bus_type '%s' because it was not initialized.\n",
+			   drv->name, drv->bus->name);
+		return -EINVAL;
+	}
 
 	if ((drv->bus->probe && drv->probe) ||
 	    (drv->bus->remove && drv->remove) ||
-- 
2.16.1
