Return-Path: <flo@geekplace.eu>
X-Google-Smtp-Source: AB8JxZq1D6HP7JcheoBxxUx38Cs4TqnPhU3j0f8Y318P2RAQDrzRYCpUBtsPRljBEZ6Nu5tOjIII
ARC-Seal: i=1; a=rsa-sha256; t=1526472331; cv=none;
        d=google.com; s=arc-20160816;
        b=ljXftigtj6tZnDI+R1EbdP2Up6epfUHjGSKp5vxgF+cxzvW8WjmHYCIm2KrVy9mxFl
         gdMgh7XUme6LxpineI7R6EwvrDV7QEMRjEWibk9/CDMOCmFwHSSmmo1yBKkHqCkEmBYd
         Zt27IH5I3obJNiUPXk2mWwmzHECjNVAiAignZB9fnLgbw3Uk3/qfBgghEM+DjzXOwPQT
         IvqMLAPrqKafrSMrxCgadu4NTJ5cF7+qyzRmDCZavfb7U8BKTWpOvCvMoyAo1eo4RuDS
         c6pi8qmZch7X2J+vC93JMarxFe/LxBGrZ0TTurLuMPP0yBRhY7VPsHBaTUIhcNR6eKEI
         JVRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=l5JbfXSiu2lBDxjaLwPAjHcKQyXXJOBa7Wje581f21k=;
        b=E+YbjWEngk6DFja0iI4IxJiQH+Fn/5cXZ+C5mv5pm8KEhdhzAXNNSdeEdx1H9zL1NZ
         PmUkh0zFmc7wjdiAQUxbjw/9m5MbH77+hddslWkIZttZUeghe1/VFMizM+lh2ZkdKxf8
         qzK3B0S7XcIWKuM33xGdlCCMch8a/wx8UeGxiiD4WN4/1CMWYPU64Ctl0rBArjpR7l38
         rXNH7Vmw8nkgdD+Kc8YzEJe9Wu8k3s58CmLk7RWKGxF/mGklxpZmFM5CXbU+ncP7rai0
         bDfoBa5zpXvyR9DOjS/C1b93DYfcNh46kj57BIW3r3G9wWLh+Hoj0maJ9+3r/MvLSKpc
         bknA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of flo@geekplace.eu designates 2a03:4000:6:3a8::1 as permitted sender) smtp.mailfrom=flo@geekplace.eu
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of flo@geekplace.eu designates 2a03:4000:6:3a8::1 as permitted sender) smtp.mailfrom=flo@geekplace.eu
From: Florian Schmaus <flo@geekplace.eu>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Florian Schmaus <flo@geekplace.eu>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/3] driver-core: record error on bus registration
Date: Wed, 16 May 2018 14:05:26 +0200
Message-Id: <20180516120527.29403-3-flo@geekplace.eu>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180516120527.29403-1-flo@geekplace.eu>
References: <20180516120527.29403-1-flo@geekplace.eu>
In-Reply-To: <20180515135114.31939-1-flo@geekplace.eu>
References: <20180515135114.31939-1-flo@geekplace.eu>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600538307840439356?=
X-GMAIL-MSGID: =?utf-8?q?1600622251043557770?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

If bus_register() fails on a driver then record the error code so that
it can be inspected later on.

Signed-off-by: Florian Schmaus <flo@geekplace.eu>
---

Notes:
    - Also record ENOMEM error if initial alloc fails

 drivers/base/bus.c     | 2 ++
 include/linux/device.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index ef6183306b40..dce677dddba4 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -152,6 +152,7 @@ static void bus_release(struct kobject *kobj)
 
 	kfree(priv);
 	bus->p = NULL;
+	bus->bus_register_error = 0;
 }
 
 static struct kobj_type bus_ktype = {
@@ -915,6 +916,7 @@ int bus_register(struct bus_type *bus)
 out:
 	kfree(bus->p);
 	bus->p = NULL;
+	bus->bus_register_error = retval;
 	return retval;
 }
 EXPORT_SYMBOL_GPL(bus_register);
diff --git a/include/linux/device.h b/include/linux/device.h
index 0059b99e1f25..5b1f3c08bebe 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -135,6 +135,7 @@ struct bus_type {
 	const struct iommu_ops *iommu_ops;
 
 	struct subsys_private *p;
+	int bus_register_error;
 	struct lock_class_key lock_key;
 
 	bool force_dma;
-- 
2.16.1
