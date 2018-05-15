Return-Path: <flo@geekplace.eu>
X-Google-Smtp-Source: AB8JxZqUriui//aLj1REpDl+wmlKMADV5XOSH+EyE6687hZINY5B7p3b5nqeW9r2KBQnocPwTRwt
ARC-Seal: i=1; a=rsa-sha256; t=1526392276; cv=none;
        d=google.com; s=arc-20160816;
        b=cP8DL8JlVva35wJoIK2z16MW+a3uobR2JbRoXD0uTvlYDc8gOl6AYDrWon08XsltlP
         mAtJxrKZ1i5ImMHkGFCNuX7LzVNA9FDr5BH7JLojIToFoBZIO7pa/e3maefrve2i/dxC
         csDmfiH+syA/AVaFY3GWOfM0a9A6OzWIVmPrs3o1kX48CA6XXOICrkF9ISpQtusvOc5l
         mr/PcQnI3/3JNQyHsYmxOCqgmPzCAfyKl640ZXqYkXrXhTgsuUvJ2GsAG94XlIeLWyUV
         F/PRMlQaw2Hm9o/oitBeWysBPNP9JbV0V01YcbhWcRAI6Fu7auqF8ba0nVYvzk3/Fm6h
         OOAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=i0UZ3flhActjorl9oOhlRqA8FBRXJiRcYG0KSzO8t/k=;
        b=a4EpncbeNh+6od4OZgf07Dx/oduCVy6oqUFowQdsk6YZFVuBqNQkWjnJWALBx5e3iX
         xwSkHVHid1KNmTakhtcZMbeOaF0fQP+U8SDqRGZ0GkI5qhZMnB3zZfS0AhBhc3gKnwpW
         h6V2Xbcxd/tBNJfo52kyfU8QTeGiGk6smN4lq8Qe/Bg37Zei0gV/ZY4xmlvhY4coxlP7
         PJrmcjT2q3guwrT+wxioCg6dkA9R5iqSrpbYEe/4M9v/EHgJhSVkY0TwzN2MGEkSw4JK
         q6Dlxsr57pO7SwD3wi1aaa4y7KKC9r4xaQxhVwqorCIvm1y5+O1wL/Mpb/Ta8VGosAUr
         NoWQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of flo@geekplace.eu designates 5.45.100.158 as permitted sender) smtp.mailfrom=flo@geekplace.eu
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of flo@geekplace.eu designates 5.45.100.158 as permitted sender) smtp.mailfrom=flo@geekplace.eu
From: Florian Schmaus <flo@geekplace.eu>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Florian Schmaus <flo@geekplace.eu>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] driver-core: record error on bus registration
Date: Tue, 15 May 2018 15:51:13 +0200
Message-Id: <20180515135114.31939-3-flo@geekplace.eu>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180515135114.31939-1-flo@geekplace.eu>
References: <20180515135114.31939-1-flo@geekplace.eu>
In-Reply-To: <20180504132357.31771-1-flo@geekplace.eu>
References: <20180504132357.31771-1-flo@geekplace.eu>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600538307840439356?=
X-GMAIL-MSGID: =?utf-8?q?1600538307840439356?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

If bus_register() fails on a driver then record the error code so that
it can be inspected later on.

Signed-off-by: Florian Schmaus <flo@geekplace.eu>
---
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
