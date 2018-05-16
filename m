Return-Path: <flo@geekplace.eu>
X-Google-Smtp-Source: AB8JxZoURQiRL2GvPSBqljGk16USGTfpV89EIAZxLoY1dGrSfRmFUZ2uBhELoGmDt4nX3LgxiLTw
ARC-Seal: i=1; a=rsa-sha256; t=1526486897; cv=none;
        d=google.com; s=arc-20160816;
        b=eebIkDSJcDlntxM4v6SZ1W/TC3z8WeilBF3U9fVa+z6luOgIeg/Cf3rehNSAO3vBmx
         04Q2PfmgfohE+KTqImzSYH5a1eZy1tYxPoEc7uzN2l4eISlMfAMa622GccRRXRnr22tx
         EfB9aBlC0Oh2MMYhxvT3eZ/9HxHkE+msrTEOlRXBS/SF8IgMVotTwdTV60DjnqQOGmKi
         k8wwnNIilbYnvj0qx9Oo9z6/9k5MNSYLxJy17XFoVGs4AjfoSorzYafOV5pCGsk8o8Wh
         gJH8N0QvVq9k1FV6tJwMyUIFey3K8cuiKPyVz/IlDt5D2i72eJpeN9AtiZ4ReKnG0yN6
         U9uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=t7jyN1Vi99ddCLwHRt3HLhho/cu86YsGe3BxyFvlosQ=;
        b=rkbRherUi8YumVxbH4x9PhdfCSeXkIBrv9Dmz6lDsbKskZO+f+zZDsiyqXPtwXICHP
         sU9p+W9YpWXK+ziUW8AbYkQso4krgqLHfO5gcvxKKG8eOeLA7XSYKQpdP1e6vAZjTGvA
         UQI3OtSVH6tGO2P850r1QEsb+m/0f/9tZXnZldbF/2cSH3yphHPb1rI6+LL908FpMKAG
         ePkfPwMKZnqHkSyQ43Cn3l2hA6BFmxA1FVUpVBhXFuHDeq2M0ZWYEqFd/sID4lFc8u4F
         VG2WvjNONSFcEonBNr9A/kGpER43NMAQnvJotcG4IuaEyyg9nB60DNNBV/UQDVWlpVXM
         Qhww==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of flo@geekplace.eu designates 2a03:4000:6:3a8::1 as permitted sender) smtp.mailfrom=flo@geekplace.eu
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of flo@geekplace.eu designates 2a03:4000:6:3a8::1 as permitted sender) smtp.mailfrom=flo@geekplace.eu
From: Florian Schmaus <flo@geekplace.eu>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Florian Schmaus <flo@geekplace.eu>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 3/3] driver-core: print bus registration error value
Date: Wed, 16 May 2018 18:08:16 +0200
Message-Id: <20180516160816.20251-4-flo@geekplace.eu>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180516160816.20251-1-flo@geekplace.eu>
References: <20180516160816.20251-1-flo@geekplace.eu>
In-Reply-To: <20180516120527.29403-1-flo@geekplace.eu>
References: <20180516120527.29403-1-flo@geekplace.eu>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600538308576095679?=
X-GMAIL-MSGID: =?utf-8?q?1600637525322281967?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

If driver_register() is called with an device driver which previously
called bus_register() but failed, then print out the bus_register()
error code.

Signed-off-by: Florian Schmaus <flo@geekplace.eu>
---

Notes:
    - Do not split long strings across lines.

 drivers/base/driver.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/base/driver.c b/drivers/base/driver.c
index 16b81d1c6cb7..a1fe7cb43c7e 100644
--- a/drivers/base/driver.c
+++ b/drivers/base/driver.c
@@ -149,8 +149,14 @@ int driver_register(struct device_driver *drv)
 	struct device_driver *other;
 
 	if (!drv->bus->p) {
-		pr_err("Driver '%s' was unable to register with bus_type '%s' because it was not initialized.\n",
-			   drv->name, drv->bus->name);
+		if (drv->bus->bus_register_error) {
+			pr_err("Driver '%s' was unable to register with bus_type '%s' because of error: %d.\n",
+				   drv->name, drv->bus->name,
+				   drv->bus->bus_register_error);
+		} else {
+			pr_err("Driver '%s' was unable to register with bus_type '%s' because it was not initialized.\n",
+				   drv->name, drv->bus->name);
+		}
 		return -EINVAL;
 	}
 
-- 
2.16.1
