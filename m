Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDB87C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 11:27:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A19220659
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 11:27:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A19220659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727631AbeLEL15 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 06:27:57 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53539 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727094AbeLEL1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 06:27:54 -0500
Received: by mail-wm1-f68.google.com with SMTP id y1so12797839wmi.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 03:27:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+4gkxmL4JQ6Pf/pljdJ8vi9h/ZXWn+MziXHbnPGjiCU=;
        b=uO2BjA1vC7fe4CFZN+R041KpiWW58HK0CLcXVsVR3mPOO20Jw2IoWxzhSxRQ/ahDnd
         PHKZDi6jNLiLfWkPiQAdIBHLj1+0Q39wYq4E4lLmT63mV98SIqDlbA579dPhhF0uh4eV
         W6+bdTwSXNxUCY0P9+03VkdhDP5WJixxEMRCFJ/yAsc11o7yW5Fm8DnC78ndnQR2jilL
         OTCuc1xq0t1iB9F4Db/CPjySM8ro8ne3FhY+D+xM81C6G+mPgeJumsnphdR04A4HyLyP
         9BusO+kCBZBk94y0UQ/vDmc3Ts6dx/7JtHQgZ51Sf4uTZBZqjqmv8XRqcWcEjRUG5PG/
         5uVQ==
X-Gm-Message-State: AA+aEWZg0OFXUxa0rf6DqKF74ISFoSLacbHz+4IyGH06W7c+Qd281W2k
        3l6KSUhOtWJWYaNc+kD1CbdVBA==
X-Google-Smtp-Source: AFSGD/Wqzi2/DKMPJ1Wek3I3iPeNQOLHRRc4sEwbwbMO1l44exvw4tsBB1xceZNmD3YOFGHNh0dJxw==
X-Received: by 2002:a1c:3a8d:: with SMTP id h135-v6mr15514901wma.92.1544009272305;
        Wed, 05 Dec 2018 03:27:52 -0800 (PST)
Received: from alatyr.usersys.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id d2sm14535027wrs.97.2018.12.05.03.27.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Dec 2018 03:27:51 -0800 (PST)
From:   Peter Rajnoha <prajnoha@redhat.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org, jeyu@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     msekleta@redhat.com, Peter Rajnoha <prajnoha@redhat.com>
Subject: [PATCH 1/2] kobject: return error code if writing /sys/.../uevent fails
Date:   Wed,  5 Dec 2018 12:27:44 +0100
Message-Id: <20181205112745.12276-2-prajnoha@redhat.com>
In-Reply-To: <20181205112745.12276-1-prajnoha@redhat.com>
References: <20181205112745.12276-1-prajnoha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Propagate error code back to userspace if writing the /sys/.../uevent
file fails. Before, the write operation always returned with success,
even if we failed to recognize the input string or if we failed to
generate the uevent itself.

With the error codes properly propagated back to userspace, we are
able to react in userspace accordingly by not assuming and awaiting
a uevent that is not delivered.

Signed-off-by: Peter Rajnoha <prajnoha@redhat.com>
---
 drivers/base/bus.c  | 12 ++++++++----
 drivers/base/core.c |  8 +++++++-
 kernel/module.c     |  6 ++++--
 3 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index 8bfd27ec73d6..b886b15cb53b 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -611,8 +611,10 @@ static void remove_probe_files(struct bus_type *bus)
 static ssize_t uevent_store(struct device_driver *drv, const char *buf,
 			    size_t count)
 {
-	kobject_synth_uevent(&drv->p->kobj, buf, count);
-	return count;
+	int rc;
+
+	rc = kobject_synth_uevent(&drv->p->kobj, buf, count);
+	return rc ? rc : count;
 }
 static DRIVER_ATTR_WO(uevent);
 
@@ -828,8 +830,10 @@ static void klist_devices_put(struct klist_node *n)
 static ssize_t bus_uevent_store(struct bus_type *bus,
 				const char *buf, size_t count)
 {
-	kobject_synth_uevent(&bus->p->subsys.kobj, buf, count);
-	return count;
+	int rc;
+
+	rc = kobject_synth_uevent(&bus->p->subsys.kobj, buf, count);
+	return rc ? rc : count;
 }
 static BUS_ATTR(uevent, S_IWUSR, NULL, bus_uevent_store);
 
diff --git a/drivers/base/core.c b/drivers/base/core.c
index ed145fbfeddf..92faafd03caf 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -1074,8 +1074,14 @@ static ssize_t uevent_show(struct device *dev, struct device_attribute *attr,
 static ssize_t uevent_store(struct device *dev, struct device_attribute *attr,
 			    const char *buf, size_t count)
 {
-	if (kobject_synth_uevent(&dev->kobj, buf, count))
+	int rc;
+
+	rc = kobject_synth_uevent(&dev->kobj, buf, count);
+
+	if (rc) {
 		dev_err(dev, "uevent: failed to send synthetic uevent\n");
+		return rc;
+	}
 
 	return count;
 }
diff --git a/kernel/module.c b/kernel/module.c
index 49a405891587..0812a7f80fa7 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -1207,8 +1207,10 @@ static ssize_t store_uevent(struct module_attribute *mattr,
 			    struct module_kobject *mk,
 			    const char *buffer, size_t count)
 {
-	kobject_synth_uevent(&mk->kobj, buffer, count);
-	return count;
+	int rc;
+
+	rc = kobject_synth_uevent(&mk->kobj, buffer, count);
+	return rc ? rc : count;
 }
 
 struct module_attribute module_uevent =
-- 
2.19.2

