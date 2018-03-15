Return-Path: <arend.vanspriel@broadcom.com>
X-Google-Smtp-Source: AG47ELu4C2YWBSv92S/I2XJSfmtDFWZcDPAyaComuOOAEzMJz9v4dMQoqOIqu4uLvcB18MFT0y3X
ARC-Seal: i=1; a=rsa-sha256; t=1521107738; cv=none;
        d=google.com; s=arc-20160816;
        b=nl9dw6G8/cGMNVJKaGQeORRiI4Zq3wpNUikt/kfH5Nr0G7oBw8UeQZXKAaJlHEkijA
         n7iXRrvuLHPdwhQamFdcvgPE7Hw8PiqnFZyMCWaOoIdYKr3OeC5X+/HH6WgoIJlqY/Q8
         0rM1Xsp+O9sMjfU1RCVXG+lG2kML875YelsOAT8+8qxgats5/ZHNSYM54SbGqW2pUO4b
         a8DuMtdloXSYGOhTXs/+gGAF2LsupwFMgy2991+g+1fYSk0eZZLymTmxLekSa3ZseSQZ
         38PCbDohe5Ma6ziGcbjCWWmSA+XPb8alb6WVtgLDgzmdHhUdux97uELwTbQi7pl3CukW
         1j6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=Nh7r15nYjrnK+wWO/QQ26XQnfq9BwTtPyWzmmY9dEzg=;
        b=Jh9a9OwN15/XznzfrD/TeI0pNcsGnvw/DTp1lXAxcUAGbSO3uvHfpq8uxfxbkk3Pj1
         vq148BUSibWnOvg0aaeBqSk2tmXVfutgDSkWBDOATYoZ4xIHBMrIXGhXmWH/tm/DshRT
         IPQxjE8NUzdoueJhjGU0kp5MIEn2dmsgto7A68VhbYuZUmKp1ALT7QosLU7WP2gyq9TU
         yhB003VgUtK+UyRIlFXnI4XjuYLWQKwOJwihbylQTyy59bngERz5sdK9cEuCNfVbiStX
         Veh1RTP6aZ9HdVVLi4fdUat5gLWwXV7fz/0sQ4rwiuOL0/dScvdbone8KSaas9CVlyE3
         V00A==
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
Subject: [PATCH for-4.16 2/3] drivers: change struct device_driver::coredump() return type to void
Date: Thu, 15 Mar 2018 10:55:24 +0100
Message-Id: <1521107725-25027-3-git-send-email-aspriel@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1521107725-25027-1-git-send-email-aspriel@gmail.com>
References: <1521107725-25027-1-git-send-email-aspriel@gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594997067781625897?=
X-GMAIL-MSGID: =?utf-8?q?1594997067781625897?=
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
 include/linux/device.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/device.h b/include/linux/device.h
index b093405..f08c25b 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -256,6 +256,9 @@ enum probe_type {
  *		automatically.
  * @pm:		Power management operations of the device which matched
  *		this driver.
+ * @coredump:	Called when sysfs entry is written to. The device driver
+ *		is expected to call the dev_coredump API resulting in a
+ *		uevent.
  * @p:		Driver core's private data, no one other than the driver
  *		core can touch this.
  *
@@ -287,7 +290,7 @@ struct device_driver {
 	const struct attribute_group **groups;

 	const struct dev_pm_ops *pm;
-	int (*coredump) (struct device *dev);
+	void (*coredump) (struct device *dev);

 	struct driver_private *p;
 };
--
1.9.1
