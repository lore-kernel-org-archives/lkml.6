Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FFFCC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:14:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B84E21019
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:14:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="kQxuobiK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B84E21019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728870AbeK3BTd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:19:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:40112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728198AbeK3BTd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:19:33 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1501121019;
        Thu, 29 Nov 2018 14:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543500842;
        bh=vLw5HkJ6FVT79IyvM8WKwfvk5uQMpW8pjtP+uqHbO50=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kQxuobiKYy/1YIfB/3f/IF7+EHqKZH+XeugTcKFcp7zIvZwWzKvIMLL0hgjGhzAG2
         o9NpKT03B3EHJ+jJ6wWyjb/oI8afO/nyKX0lAmD2Cm4yQsyUBTCXvx2eO+mbRMjIc8
         ZGl3VG1GOqnfYBT62cjW8TaRRV3AmT35nXGBGFt4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Aniroop Mathur <aniroop.mathur@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 20/83] Input: initialize device counter variables with -1
Date:   Thu, 29 Nov 2018 15:11:38 +0100
Message-Id: <20181129140139.206084060@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129140138.002176596@linuxfoundation.org>
References: <20181129140138.002176596@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 939ffb1712890ee22146d2dfc24adbc7da6afa84 ]

Let's initialize atomic_t variables keeping track of number of various
devices created so far with -1 in order to avoid extra subtraction
operation.

Signed-off-by: Aniroop Mathur <aniroop.mathur@gmail.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/gameport/gameport.c | 4 ++--
 drivers/input/joystick/xpad.c     | 8 ++++----
 drivers/input/misc/ims-pcu.c      | 4 ++--
 drivers/input/serio/serio.c       | 4 ++--
 drivers/input/serio/serio_raw.c   | 4 ++--
 5 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/input/gameport/gameport.c b/drivers/input/gameport/gameport.c
index e29c04e2aff4..e853a2134680 100644
--- a/drivers/input/gameport/gameport.c
+++ b/drivers/input/gameport/gameport.c
@@ -527,14 +527,14 @@ EXPORT_SYMBOL(gameport_set_phys);
  */
 static void gameport_init_port(struct gameport *gameport)
 {
-	static atomic_t gameport_no = ATOMIC_INIT(0);
+	static atomic_t gameport_no = ATOMIC_INIT(-1);
 
 	__module_get(THIS_MODULE);
 
 	mutex_init(&gameport->drv_mutex);
 	device_initialize(&gameport->dev);
 	dev_set_name(&gameport->dev, "gameport%lu",
-			(unsigned long)atomic_inc_return(&gameport_no) - 1);
+			(unsigned long)atomic_inc_return(&gameport_no));
 	gameport->dev.bus = &gameport_bus;
 	gameport->dev.release = gameport_release_port;
 	if (gameport->parent)
diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 1a728f310b27..9843c8cca2f7 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -888,8 +888,8 @@ static void xpad_led_set(struct led_classdev *led_cdev,
 
 static int xpad_led_probe(struct usb_xpad *xpad)
 {
-	static atomic_t led_seq	= ATOMIC_INIT(0);
-	long led_no;
+	static atomic_t led_seq	= ATOMIC_INIT(-1);
+	unsigned long led_no;
 	struct xpad_led *led;
 	struct led_classdev *led_cdev;
 	int error;
@@ -901,9 +901,9 @@ static int xpad_led_probe(struct usb_xpad *xpad)
 	if (!led)
 		return -ENOMEM;
 
-	led_no = (long)atomic_inc_return(&led_seq) - 1;
+	led_no = atomic_inc_return(&led_seq);
 
-	snprintf(led->name, sizeof(led->name), "xpad%ld", led_no);
+	snprintf(led->name, sizeof(led->name), "xpad%lu", led_no);
 	led->xpad = xpad;
 
 	led_cdev = &led->led_cdev;
diff --git a/drivers/input/misc/ims-pcu.c b/drivers/input/misc/ims-pcu.c
index 063898d429c7..b5304e264881 100644
--- a/drivers/input/misc/ims-pcu.c
+++ b/drivers/input/misc/ims-pcu.c
@@ -1871,7 +1871,7 @@ static int ims_pcu_identify_type(struct ims_pcu *pcu, u8 *device_id)
 
 static int ims_pcu_init_application_mode(struct ims_pcu *pcu)
 {
-	static atomic_t device_no = ATOMIC_INIT(0);
+	static atomic_t device_no = ATOMIC_INIT(-1);
 
 	const struct ims_pcu_device_info *info;
 	int error;
@@ -1902,7 +1902,7 @@ static int ims_pcu_init_application_mode(struct ims_pcu *pcu)
 	}
 
 	/* Device appears to be operable, complete initialization */
-	pcu->device_no = atomic_inc_return(&device_no) - 1;
+	pcu->device_no = atomic_inc_return(&device_no);
 
 	/*
 	 * PCU-B devices, both GEN_1 and GEN_2 do not have OFN sensor
diff --git a/drivers/input/serio/serio.c b/drivers/input/serio/serio.c
index d399b8b0f000..a05a5179da32 100644
--- a/drivers/input/serio/serio.c
+++ b/drivers/input/serio/serio.c
@@ -514,7 +514,7 @@ static void serio_release_port(struct device *dev)
  */
 static void serio_init_port(struct serio *serio)
 {
-	static atomic_t serio_no = ATOMIC_INIT(0);
+	static atomic_t serio_no = ATOMIC_INIT(-1);
 
 	__module_get(THIS_MODULE);
 
@@ -525,7 +525,7 @@ static void serio_init_port(struct serio *serio)
 	mutex_init(&serio->drv_mutex);
 	device_initialize(&serio->dev);
 	dev_set_name(&serio->dev, "serio%lu",
-		     (unsigned long)atomic_inc_return(&serio_no) - 1);
+		     (unsigned long)atomic_inc_return(&serio_no));
 	serio->dev.bus = &serio_bus;
 	serio->dev.release = serio_release_port;
 	serio->dev.groups = serio_device_attr_groups;
diff --git a/drivers/input/serio/serio_raw.c b/drivers/input/serio/serio_raw.c
index c9a02fe57576..71ef5d65a0c6 100644
--- a/drivers/input/serio/serio_raw.c
+++ b/drivers/input/serio/serio_raw.c
@@ -292,7 +292,7 @@ static irqreturn_t serio_raw_interrupt(struct serio *serio, unsigned char data,
 
 static int serio_raw_connect(struct serio *serio, struct serio_driver *drv)
 {
-	static atomic_t serio_raw_no = ATOMIC_INIT(0);
+	static atomic_t serio_raw_no = ATOMIC_INIT(-1);
 	struct serio_raw *serio_raw;
 	int err;
 
@@ -303,7 +303,7 @@ static int serio_raw_connect(struct serio *serio, struct serio_driver *drv)
 	}
 
 	snprintf(serio_raw->name, sizeof(serio_raw->name),
-		 "serio_raw%ld", (long)atomic_inc_return(&serio_raw_no) - 1);
+		 "serio_raw%ld", (long)atomic_inc_return(&serio_raw_no));
 	kref_init(&serio_raw->kref);
 	INIT_LIST_HEAD(&serio_raw->client_list);
 	init_waitqueue_head(&serio_raw->wait);
-- 
2.17.1



