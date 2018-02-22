Return-Path: <jsarha@ti.com>
X-Google-Smtp-Source: AH8x227k9VoK5uEc8WwVxh0phyuHvFHN8pZChZ3EZSpFuts289MG/0AICCEnbFY9bAeYRutA0T+a
ARC-Seal: i=1; a=rsa-sha256; t=1519321373; cv=none;
        d=google.com; s=arc-20160816;
        b=rHVUbhQdsEKSxYAOWTRJa7qMRHwSsdbWLf1lyVn3tQPyjoyKazYeMhERCEG6BuKOfv
         m4GTCsxYESBl2H7MfFSUP6SerpHlsPn7ehEerUy+RZDSYQ56Wv4AhL9DosPeyd9kcyiC
         5hfMsR+Nyugq0jKrrv0APc+fnGd7TMeVv+Vm3vXiYrBy0P2QgRheaXNUP/DrXmOcT3sH
         Lc9UF/ItGtYu8iPyb1vBaVEM4aaJrjLENaCvnO1e9FeBiK3U4tNTmQl6XuUxgM7AYN5b
         cfNAykvLWJtdnpRMemnKnRvMEK7Ht7S6FcMF6k3fU4VfeBv5lAoJw0iuD/EVhlKj6QxU
         IKdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:dkim-signature:arc-authentication-results;
        bh=5eyDzkaxWkZyLpGnC4Anqfy0nvrS6zYLg8JrEJ4yY/U=;
        b=nawQMpH/WoOh4ZxHe4pRbKU1pLwKNjcweT67FRQIouCRhEVljWHbE17ZQu0rA49FTx
         7QOr5C0USEa9w3oDxgRbe/VlfNbzj4dIMvY1qNqSSMrn6CkF3L040a5U0fHzf4A0NXo4
         x8+RAgi3Em/u1VIlU4gDrylCgSncBzMLJdpOT+eiMXa8rhLaeAMwyyi7VVacQyzcZQuC
         EXXRvy07t7S+rgc8dK9i952aXyuJpQTwuSyb978jIcFklPvx4sGCz9zCjuWDpoKl5N5p
         2R7Cf/IIaKPFh1U48dCfdkTx7KRkdUIoQUj2WVgQvvN1U7/GpGIupxxNGMvPPu2Qdgdr
         0Pzw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@ti.com header.s=ti-com-17Q1 header.b=hSy89EaG;
       spf=pass (google.com: domain of jsarha@ti.com designates 198.47.27.77 as permitted sender) smtp.mailfrom=jsarha@ti.com;
       dmarc=pass (p=QUARANTINE sp=NONE dis=NONE) header.from=ti.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@ti.com header.s=ti-com-17Q1 header.b=hSy89EaG;
       spf=pass (google.com: domain of jsarha@ti.com designates 198.47.27.77 as permitted sender) smtp.mailfrom=jsarha@ti.com;
       dmarc=pass (p=QUARANTINE sp=NONE dis=NONE) header.from=ti.com
From: Jyri Sarha <jsarha@ti.com>
To: <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>
CC: <tomi.valkeinen@ti.com>, <thierry.reding@gmail.com>, <lukas@wunner.de>,
        <gregkh@linuxfoundation.org>, Jyri Sarha <jsarha@ti.com>,
        "Rafael J .
 Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH RFC] driver core: Reprobe consumer if it was unbound by dropped device_link
Date: Thu, 22 Feb 2018 19:42:46 +0200
Message-ID: <57c1d52a5a8f5985dc1dd53260d7d68795be8ea2.1519321145.git.jsarha@ti.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1519321145.git.jsarha@ti.com>
References: <cover.1519321145.git.jsarha@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593123928219045407?=
X-GMAIL-MSGID: =?utf-8?q?1593123928219045407?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Put consumer device to deferred probe list if it is unbound due to a
dropped link to a supplier.

When a device link supplier is unbound (either manually or because one
of its own suppliers was unbound), its consumers are unbound as
well. Currently if the supplier binds again after this the consumer
does not automatically probe again. With this patch it does.

If this patch is not acceptable as such, how about adding this
behavior behind a new device link flag?

The idea to this patch was gotten from this post by Lucas Wunner:
https://www.spinics.net/lists/dri-devel/msg166318.html

Part of the code and the description is borrowed from him.

cc: Lukas Wunner <lukas@wunner.de>
cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
cc: Thierry Reding <thierry.reding@gmail.com>
Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 drivers/base/base.h | 1 +
 drivers/base/core.c | 2 ++
 drivers/base/dd.c   | 2 +-
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/base/base.h b/drivers/base/base.h
index d800de6..39370eb 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -114,6 +114,7 @@ extern void device_release_driver_internal(struct device *dev,
 
 extern void driver_detach(struct device_driver *drv);
 extern int driver_probe_device(struct device_driver *drv, struct device *dev);
+extern void driver_deferred_probe_add(struct device *dev);
 extern void driver_deferred_probe_del(struct device *dev);
 static inline int driver_match_device(struct device_driver *drv,
 				      struct device *dev)
diff --git a/drivers/base/core.c b/drivers/base/core.c
index b2261f9..0964ed5 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -570,6 +570,8 @@ void device_links_unbind_consumers(struct device *dev)
 
 			device_release_driver_internal(consumer, NULL,
 						       consumer->parent);
+			driver_deferred_probe_add(consumer);
+
 			put_device(consumer);
 			goto start;
 		}
diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index de6fd09..846ae78 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -140,7 +140,7 @@ static void deferred_probe_work_func(struct work_struct *work)
 }
 static DECLARE_WORK(deferred_probe_work, deferred_probe_work_func);
 
-static void driver_deferred_probe_add(struct device *dev)
+void driver_deferred_probe_add(struct device *dev)
 {
 	mutex_lock(&deferred_probe_mutex);
 	if (list_empty(&dev->p->deferred_probe)) {
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
