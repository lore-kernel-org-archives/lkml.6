Return-Path: <flo@geekplace.eu>
X-Google-Smtp-Source: AB8JxZq9hV55huJSpu1CvBoe1I06AV7EuCLmoPZjn1/qfptkze7DZQGMee5atuYXJkr4vR1l9oG4
ARC-Seal: i=1; a=rsa-sha256; t=1526392276; cv=none;
        d=google.com; s=arc-20160816;
        b=Q1zIm9ZhteeNUrn13QLHEh8MojbmMSsA0UQQk6vzNG0BJ3lnUb/FjaRJ6MzR7c8PqN
         oZu3Vr3bE4TaHVzxYl3+LkhPZ0AtTflUxkmom8yvOqeQ+U01Qy9CvegxuZ/yvCz+OVso
         Fg+nztQGhhHnAK7zKtWItBuvhCh2mIOc2N+x+2W4FTX7GEqiDWWZN2SjASAdMrpN4vUd
         x/HAD0wkwVVeWF4U3N/oQQ9w5AuVpsonkPtyI35kGi1zVx+sX8X9iuc+jSKmnEUD7/au
         LbNF6/WbeecUu55MHghH8wy307A8JzSBlnXF1rGXNhEV6a+g4EovMg//w9spgfEf8Fxc
         ZAeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=70tiiFE1vjIgBsKKQlGLu6egHmuZy8MBSKvgTPM52o4=;
        b=mIUv917gQU5/zKToHAPTfgcJvQ/ZzPmXP6Vmzpkbb2pvZiKqiGLu0EhjOBf2IH1BUg
         R47G1aY3PzskAphYgPWUPoDEG8AwjI9hbgEJIjnDGQ4GLVnu0e+Vi9+1YSh0NSUyvp2F
         wHIBi1Q3P0S9PTR1OnNrQePrVLDgs4cftrlcUC2QF0vOe1sD5sH8a07YvGXHFOG3IMt7
         6lgC0oYv4M8jvF1aJc2VGDN8aLDAluLGxXIdpSz4E0z4ps+CWuPK/5/5+kMfqfhXfewl
         V/DW6dkcLS8zCXOY/8f3VJViAGRYfLp1NLLeDGNfQESCS4vFPURaF3AhbrtgiKOwZmcM
         KBrQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of flo@geekplace.eu designates 2a03:4000:6:3a8::1 as permitted sender) smtp.mailfrom=flo@geekplace.eu
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of flo@geekplace.eu designates 2a03:4000:6:3a8::1 as permitted sender) smtp.mailfrom=flo@geekplace.eu
From: Florian Schmaus <flo@geekplace.eu>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Florian Schmaus <flo@geekplace.eu>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/3] driver-core: return EINVAL error instead of BUG_ON()
Date: Tue, 15 May 2018 15:51:12 +0200
Message-Id: <20180515135114.31939-2-flo@geekplace.eu>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180515135114.31939-1-flo@geekplace.eu>
References: <20180515135114.31939-1-flo@geekplace.eu>
In-Reply-To: <20180504132357.31771-1-flo@geekplace.eu>
References: <20180504132357.31771-1-flo@geekplace.eu>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600538307173968753?=
X-GMAIL-MSGID: =?utf-8?q?1600538307173968753?=
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
    - return EINVAL (instead of EBUSY)
    - follow common pattern when quoting commits in commit messages

 drivers/base/driver.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/base/driver.c b/drivers/base/driver.c
index ba912558a510..afd5b08b7677 100644
--- a/drivers/base/driver.c
+++ b/drivers/base/driver.c
@@ -148,7 +148,11 @@ int driver_register(struct device_driver *drv)
 	int ret;
 	struct device_driver *other;
 
-	BUG_ON(!drv->bus->p);
+	if (!drv->bus->p) {
+		printk(KERN_ERR "Driver '%s' was unable to register bus_type\n",
+			   drv->name);
+		return -EINVAL;
+	}
 
 	if ((drv->bus->probe && drv->probe) ||
 	    (drv->bus->remove && drv->remove) ||
-- 
2.16.1
