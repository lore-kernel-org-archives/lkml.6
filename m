Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EB7BC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 08:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E79A520855
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 08:47:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="E8mw/8ut"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E79A520855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbeLJIrF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 03:47:05 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42315 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbeLJIrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 03:47:05 -0500
Received: by mail-ed1-f66.google.com with SMTP id j6so8730109edp.9
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 00:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PyJg/7OGI94QojOV1ZOHnTNv87np2XPFaVlKIJxUtoY=;
        b=E8mw/8ut8Z0dWiBP6nQm5dzsopAXWZ2OhyZbJ4gkoqACeBt70ZYxrJ9GeDZrpezTkr
         s+MYN3DiQSW+vnD9cRa1pWhqs6TKjQbGGzQwAI714JoGWOvlTfwmWFfNn3HNhJlBGAef
         H2Ohn/CGYlxp8Ujq0+vbTwvxlt+kFVnwYenWg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PyJg/7OGI94QojOV1ZOHnTNv87np2XPFaVlKIJxUtoY=;
        b=Y6rO4kyJkiTCCEzhog8uTWL1B2Qtz8eczY0zSzFyBIMIeSmkbx3HVXiDssQ04CBEQC
         mc4EiBbZVEXzmSLLv0prC2CNw9N4hJWFNZqinLxDY3birF87/yFRU7MstE1zD8wtmn9y
         DXsHOZCxavEushjAO5Bn8P7Nar/ZdsXbvzkVAIGmYxaC8KPx+OuZQUTwK4YV9fFm6pz+
         3lkXj9IlGRrAYB6vGsTG2fzFLUDWPDS25muEs1s4uvnxsrc0/pLyGvpesS3PR6cpGfcI
         nRpGUUkotUYEeqbtB4rtZhyIv5zng6uslzgiArnLsWQ/s1/k+PFnZyyy+9DYmaWCM7jB
         XZqg==
X-Gm-Message-State: AA+aEWZeZvNiT3Cw87U7Im3yq0Gfgh62BHUImaMPqJYu38fg8sl1m47d
        dfmBVJLRdbj1gR21Ko7XnhqDdfunTLA=
X-Google-Smtp-Source: AFSGD/V/rTQ5VrYlje6awFauHZaB1Rnnxt9n2Ys6kGkzZ45KuQ0erc4Cd5E3Mb4vPwlxE0GKjXdlcw==
X-Received: by 2002:a17:906:4bd7:: with SMTP id x23-v6mr9160287ejv.105.1544431622947;
        Mon, 10 Dec 2018 00:47:02 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id j31sm3237338eda.46.2018.12.10.00.47.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 00:47:01 -0800 (PST)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Ramalingam C <ramalingam.c@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: [PATCH] drivers/base: use a worker for sysfs unbind
Date:   Mon, 10 Dec 2018 09:46:53 +0100
Message-Id: <20181210084653.7268-1-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.20.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drivers might want to remove some sysfs files, which needs the same
locks and ends up angering lockdep. Relevant snippet of the stack
trace:

  kernfs_remove_by_name_ns+0x3b/0x80
  bus_remove_driver+0x92/0xa0
  acpi_video_unregister+0x24/0x40
  i915_driver_unload+0x42/0x130 [i915]
  i915_pci_remove+0x19/0x30 [i915]
  pci_device_remove+0x36/0xb0
  device_release_driver_internal+0x185/0x250
  unbind_store+0xaf/0x180
  kernfs_fop_write+0x104/0x190

I've stumbled over this because some new patches by Ram connect the
snd-hda-intel unload (where we do use sysfs unbind) with the locking
chains in the i915 unload code (but without creating a new loop),
which upset our CI. But the bug is already there and can be easily
reproduced by unbind i915 directly.

No idea whether this is the correct place to fix this, should at least
get CI happy again. Also not sure whether we should do the same on the
bind side, there we have the additional complication that the current
code forwards the driver load errno.

Note that the bus locking is already done by
device_release_driver_internal (if you give it the parent), so I
dropped that part. Also note that we don't recheck that the device is
still bound by the same driver, but neither does the current code do
that without races. And I figured that's a obscure enough corner case
to not bother.

v2: Use a task work. An entirely async work leads to impressive
fireworks in our CI, notably in the vtcon bind/unbind code. Task work
will be as synchronous as the current code, and so keep all these
preexisting races neatly tugged under the rug.

Cc: Ramalingam C <ramalingam.c@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
---
 drivers/base/bus.c | 35 +++++++++++++++++++++++++++++------
 1 file changed, 29 insertions(+), 6 deletions(-)

diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index 8bfd27ec73d6..095c4a140d76 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -17,6 +17,7 @@
 #include <linux/string.h>
 #include <linux/mutex.h>
 #include <linux/sysfs.h>
+#include <linux/task_work.h>
 #include "base.h"
 #include "power/power.h"
 
@@ -174,22 +175,44 @@ static const struct kset_uevent_ops bus_uevent_ops = {
 
 static struct kset *bus_kset;
 
+struct unbind_work {
+	struct callback_head twork;
+	struct device *dev;
+};
+
+void unbind_work_fn(struct callback_head *work)
+{
+	struct unbind_work *unbind_work =
+		container_of(work, struct unbind_work, twork);
+
+	device_release_driver_internal(unbind_work->dev, NULL,
+				       unbind_work->dev->parent);
+	put_device(unbind_work->dev);
+	kfree(unbind_work);
+}
+
 /* Manually detach a device from its associated driver. */
 static ssize_t unbind_store(struct device_driver *drv, const char *buf,
 			    size_t count)
 {
 	struct bus_type *bus = bus_get(drv->bus);
+	struct unbind_work *unbind_work;
 	struct device *dev;
 	int err = -ENODEV;
 
 	dev = bus_find_device_by_name(bus, NULL, buf);
 	if (dev && dev->driver == drv) {
-		if (dev->parent && dev->bus->need_parent_lock)
-			device_lock(dev->parent);
-		device_release_driver(dev);
-		if (dev->parent && dev->bus->need_parent_lock)
-			device_unlock(dev->parent);
-		err = count;
+		unbind_work = kmalloc(sizeof(*unbind_work), GFP_KERNEL);
+		if (unbind_work) {
+			unbind_work->dev = dev;
+			get_device(dev);
+			init_task_work(&unbind_work->twork, unbind_work_fn);
+			task_work_add(current, &unbind_work->twork, true);
+
+			err = count;
+		} else {
+			err = -ENOMEM;
+		}
 	}
 	put_device(dev);
 	bus_put(bus);
-- 
2.20.0.rc1

