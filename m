Return-Path: <flo@geekplace.eu>
X-Google-Smtp-Source: AB8JxZq0Y9A6HdeCYSY+ZUYxMkVvVtK8YNXuv5gykS1Ls7ux1Y6SXGt/8eKbGpsoDB6znqjXMVvr
ARC-Seal: i=1; a=rsa-sha256; t=1526472331; cv=none;
        d=google.com; s=arc-20160816;
        b=MZgRmnIrlJcH9+t1MWzeWSv/cMhJ9ac5EAwZ+hb3RvAk+0lrAaAnpdoT8teeysSu1R
         uMwqrOPmYO5+rm/Lhs0x9X8Nf0WxH1XnSJdYwYQ44ACGasEJ68aYHu370Iw7/aNy7l3E
         DWJs2PBcm4RqsKu9J6K+6ZxxiOZtt6L3cLC2aonRnXyzE5jbe1ir9kgRTs4LwB73/R6H
         6NRh+7Lwh63GbrKqwG97aJvdtHo2Ed92zgaBHmDmjlaQ7wR8ulloOqBh/NdWIRNoPKlW
         f+/VW3BbNmlUm2YxwHKTIQBBNo1fIFfTzUtkYtqvId3VJEO7f1aSt2+pdq30I06nYAsc
         6Yxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ANdANjTL8H1y7mQyx9S1YbsGp3GnIy6d2tJNexQVGMk=;
        b=a1aczkFLu6NHdkZxdt5smA+kCjGRrI4rFlaVEGJ3XIgBlmjPyCMaO7lynS3nfJ8vrA
         Cgj5ayMHR43ALl2J/eZUDb1V1s/W38J9nQQ35OpM8ZJTNbQ5Y9PsBrwyl/ftsH5dVpb6
         X18ZtDpDrWtCErpUQIP0JjUMILMgnvDH5QtQQtX15N/ofycCjVIfMNcrsaSsG6CDBvjP
         6gVRdUFaRLQkqQdZeL2DDAdsXXXIPcInB8pYAeR7+lvfztTUCSugUddmCwSQ54GZs9Jd
         LvVBQlnjgdqxS6orEFbbiA8E2ETl0FuCNApSHVkFxAo00j9iCJRdf3yTRcnKcuoVoxmP
         B3/w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of flo@geekplace.eu designates 5.45.100.158 as permitted sender) smtp.mailfrom=flo@geekplace.eu
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of flo@geekplace.eu designates 5.45.100.158 as permitted sender) smtp.mailfrom=flo@geekplace.eu
From: Florian Schmaus <flo@geekplace.eu>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Florian Schmaus <flo@geekplace.eu>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/3] driver-core: print bus registration error value
Date: Wed, 16 May 2018 14:05:27 +0200
Message-Id: <20180516120527.29403-4-flo@geekplace.eu>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180516120527.29403-1-flo@geekplace.eu>
References: <20180516120527.29403-1-flo@geekplace.eu>
In-Reply-To: <20180515135114.31939-1-flo@geekplace.eu>
References: <20180515135114.31939-1-flo@geekplace.eu>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600538308576095679?=
X-GMAIL-MSGID: =?utf-8?q?1600622251700462662?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Signed-off-by: Florian Schmaus <flo@geekplace.eu>
---

Notes:
    - Use correct member name 'bus_register_error'
    - Only print out error code if it is non-zero

 drivers/base/bus.c    |  4 +++-
 drivers/base/driver.c | 13 ++++++++++---
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index dce677dddba4..5814ecb07648 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -849,8 +849,10 @@ int bus_register(struct bus_type *bus)
 	struct lock_class_key *key = &bus->lock_key;
 
 	priv = kzalloc(sizeof(struct subsys_private), GFP_KERNEL);
-	if (!priv)
+	if (!priv) {
+		bus->bus_register_error = -ENOMEM;
 		return -ENOMEM;
+	}
 
 	priv->bus = bus;
 	bus->p = priv;
diff --git a/drivers/base/driver.c b/drivers/base/driver.c
index 203fa731e3ee..a798aeae08c7 100644
--- a/drivers/base/driver.c
+++ b/drivers/base/driver.c
@@ -149,9 +149,16 @@ int driver_register(struct device_driver *drv)
 	struct device_driver *other;
 
 	if (!drv->bus->p) {
-		pr_err("Driver '%s' was unable to register with bus_type '%s'"
-			   " because it was not initialized.\n",
-			   drv->name, drv->bus->name);
+		if (drv->bus->bus_register_error) {
+			pr_err("Driver '%s' was unable to register with bus_type '%s'",
+				   " (error: %d).\n",
+				   drv->name, drv->bus->name,
+				   drv->bus->bus_register_error);
+		} else {
+			pr_err("Driver '%s' was unable to register with bus_type '%s'",
+				   " because it was not initialized.\n",
+				   drv->name, drv->bus->name);
+		}
 		return -EINVAL;
 	}
 
-- 
2.16.1
