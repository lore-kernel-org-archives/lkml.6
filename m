Return-Path: <flo@geekplace.eu>
X-Google-Smtp-Source: AB8JxZq+GF0LHrtKo9p2D2HXnZJ4RyKIR/cg6PTosaSXcC9JJJ1MRkGblRmuDpc7Ma55+J/HK4gj
ARC-Seal: i=1; a=rsa-sha256; t=1526486897; cv=none;
        d=google.com; s=arc-20160816;
        b=XaeIp62aXpFCNa0t8GRoeKpF4KljPbY49jWHKXGdvPueT0BqzvTDq005qzoV0Khwd8
         ZHi1MeTJVaxG3YZZvJPiiWjrx3GY60IrqC83z3MzSGcYfLzcckauwrUqH/hWSwykN3ef
         IZJEjwhrP9EnwrWTh6VsR6XP9+OZrWxNXsthwE1MDDIWpflZwQccaGx80sI7Q6TXkEWv
         1RKzRNWpECVClDzzlUwJ92C2lMzYuxvtgiD3CUQhkkDcMvf5KbNldDrHXDtP23Htmuj/
         YD1twkr/EBLSDrZ9+vO2GTfS/9VZh3oeg/zrF6NdaMMo1RkmjWpsYZ/Iz7etUWVRX8To
         1QbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=M2fbVabCr5u8t/AkISKV6d3Df7dVm4hhUIF1cevzte8=;
        b=MA+By+XLfxgcdHG8ERCg21IaspMAMfK5VN/1o+C34qLtHz+ubX6NubwELClRsXddpE
         SJnHIS9izQaKe2yHEsQkgJbve8NI4YzlFpdGkaZcCVYM8lbv8GRD9znBBhP4ihMm4N99
         NdT/h055+kUty1oNeMCSJjNaHvJ1SXxHtT3eQWKycTI3CxH+a71G/moOCHwUyWsz/MUw
         PQlBJfSjaRjVBzJtv80/BRgPfejSKQ9/zzODMO1yBygxmQVCur8+A09gn4Aj5vUADobN
         yHzgBIkA6xRiTlQmB3yWyKJJ76LVQEPIVwvKXRR8Rzj9mcrGHNxKahNwUVOvac7jFtDx
         UMYg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of flo@geekplace.eu designates 5.45.100.158 as permitted sender) smtp.mailfrom=flo@geekplace.eu
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of flo@geekplace.eu designates 5.45.100.158 as permitted sender) smtp.mailfrom=flo@geekplace.eu
From: Florian Schmaus <flo@geekplace.eu>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Florian Schmaus <flo@geekplace.eu>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/3] driver-core: record error on bus registration
Date: Wed, 16 May 2018 18:08:15 +0200
Message-Id: <20180516160816.20251-3-flo@geekplace.eu>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180516160816.20251-1-flo@geekplace.eu>
References: <20180516160816.20251-1-flo@geekplace.eu>
In-Reply-To: <20180516120527.29403-1-flo@geekplace.eu>
References: <20180516120527.29403-1-flo@geekplace.eu>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600538307840439356?=
X-GMAIL-MSGID: =?utf-8?q?1600637525522197097?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

If bus_register() fails on a driver then record the error code so that
it can be inspected later on.

Signed-off-by: Florian Schmaus <flo@geekplace.eu>
---

Notes:
    - Also record ENOMEM error code.

 drivers/base/bus.c     | 6 +++++-
 include/linux/device.h | 1 +
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index ef6183306b40..5814ecb07648 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -152,6 +152,7 @@ static void bus_release(struct kobject *kobj)
 
 	kfree(priv);
 	bus->p = NULL;
+	bus->bus_register_error = 0;
 }
 
 static struct kobj_type bus_ktype = {
@@ -848,8 +849,10 @@ int bus_register(struct bus_type *bus)
 	struct lock_class_key *key = &bus->lock_key;
 
 	priv = kzalloc(sizeof(struct subsys_private), GFP_KERNEL);
-	if (!priv)
+	if (!priv) {
+		bus->bus_register_error = -ENOMEM;
 		return -ENOMEM;
+	}
 
 	priv->bus = bus;
 	bus->p = priv;
@@ -915,6 +918,7 @@ int bus_register(struct bus_type *bus)
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
