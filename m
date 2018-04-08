Return-Path: <arend.vanspriel@broadcom.com>
X-Google-Smtp-Source: AIpwx494p7/GjgQy6RopszazL94Sn3LQydTV16u/AuWBUd20U306OmaE5dLL1cBtQqNoCgnqMAiB
ARC-Seal: i=1; a=rsa-sha256; t=1523224660; cv=none;
        d=google.com; s=arc-20160816;
        b=DUiYvQ/WKtvRt7Nv9aywmSDjIl9VdM6jEHc7Zs80pJFWVdRNOnxhypI7VadvPOSrvT
         V1nB1cECw9RdBkPZi25a9gZEospBOdV6xByjwJDt/q98Ix6NZf9719TMgs7dwftZDJeF
         jCUgjKlfe5RthCxt/qVlWoIIwtsBAHV15j4/yhVtE8uKgR2HCICX8fLq2sjBLDTnopr/
         85WxzCwoS2zAAK43jwQKh9/qks7QZqFWGb9QvN6Ra3g/M5D1f8LM6Rsn3wMuX5u3s9oe
         vBWSPR+hx2iG/qYZnW5KhZF+zQoL3dxmyJ/xdXcfKI19p8AbI2VarPBDd4zaqgqFgmOT
         ZjcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=PrK7FhpT4rzuiAe6sZu8ZDGdoYut3Z5VpXt289UJ/J4=;
        b=wgkucwHZpoOqiQFCldgcTEtTB9d1UHQBy5x+uBRGHO+UoJt48Cd26U/LmwavBMwME8
         KHXDZYbvyjv/1FWawFWBmOUqCQ/8tRlvpruev5PhIXJr1EjZTjGlzspjZaxvXNmqNbMX
         ajMYfp8LyBDCrhRVWnPAFn0txqYo4nKgCLkZhS9dWj+MiASN/mTpCNTNygEL6kBtT33S
         MpsYuBCEGI5F/WN3UI/X2IPsC7giHAKSRfw8QpOu1i9RwlwKKTVF1NEr813PkmQiHC7Y
         g2dlawXLTtOcDeapT7876vfkhdOn6OBtXcKbmz+f4fmKE0C99I1CGbEH1kbAuU4rod8D
         C+tg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of arend.vanspriel@broadcom.com designates 192.19.229.170 as permitted sender) smtp.mailfrom=arend.vanspriel@broadcom.com;
       dmarc=fail (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of arend.vanspriel@broadcom.com designates 192.19.229.170 as permitted sender) smtp.mailfrom=arend.vanspriel@broadcom.com;
       dmarc=fail (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
From: Arend van Spriel <aspriel@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Brian Norris <briannorris@chromium.org>,
	Arend van Spriel <aspriel@gmail.com>
Subject: [RESEND PATCH] drivers: change struct device_driver::coredump() return type to void
Date: Sun,  8 Apr 2018 23:57:07 +0200
Message-Id: <1523224627-24136-1-git-send-email-aspriel@gmail.com>
X-Mailer: git-send-email 1.9.1
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597216821863949278?=
X-GMAIL-MSGID: =?utf-8?q?1597216821863949278?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Upon submitting a patch for mwifiex [1] it was discussed whether this
callback function could fail. To keep things simple there is no need
for the error code so the driver can do the task synchronous or not
without worries. Currently the device driver core already ignores the
return value so changing it to void.

[1] https://patchwork.kernel.org/patch/10231933/

Signed-off-by: Arend van Spriel <aspriel@gmail.com>
---
Hi Greg,

Here is a resend of my patch that got lost. See if it makes it
this time ;-)

Regards,
Arend
---
 include/linux/device.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/linux/device.h b/include/linux/device.h
index 0059b99..4779569 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -256,7 +256,9 @@ enum probe_type {
  *		automatically.
  * @pm:		Power management operations of the device which matched
  *		this driver.
- * @coredump:	Called through sysfs to initiate a device coredump.
+ * @coredump:	Called when sysfs entry is written to. The device driver
+ *		is expected to call the dev_coredump API resulting in a
+ *		uevent.
  * @p:		Driver core's private data, no one other than the driver
  *		core can touch this.
  *
@@ -288,7 +290,7 @@ struct device_driver {
 	const struct attribute_group **groups;
 
 	const struct dev_pm_ops *pm;
-	int (*coredump) (struct device *dev);
+	void (*coredump) (struct device *dev);
 
 	struct driver_private *p;
 };
-- 
2.7.4
