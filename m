Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752787AbeB1NjA (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 08:39:00 -0500
Received: from mail-lf0-f65.google.com ([209.85.215.65]:37280 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752556AbeB1NiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 08:38:19 -0500
X-Google-Smtp-Source: AG47ELukmFxtdIfzq2GzZDtEDnDhhFrFb/LjU58p2QnT14h4BpWtBj67iszOt6SOA98hpV2t8Exyrw==
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marcus Folkesson <marcus.folkesson@gmail.com>
Subject: [RESEND PATCH 4/6] input: pegasus_notetaker: do not rely on input_dev->users
Date: Wed, 28 Feb 2018 14:38:01 +0100
Message-Id: <20180228133803.30040-5-marcus.folkesson@gmail.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180228133803.30040-1-marcus.folkesson@gmail.com>
References: <20180228133803.30040-1-marcus.folkesson@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the device is unused and suspended, a call to open will cause the
device to autoresume through the call to usb_autopm_get_interface().

input_dev->users is already incremented by the input subsystem,
therefore this expression will always be evaluated to true:

	if (pegasus->dev->users && usb_submit_urb(pegasus->irq, GFP_NOIO) < 0)
		retval = -EIO;

The same URB will then be fail when resubmitted in pegasus_open().

Introduce pegasus->is_open to keep track of the state instead.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 drivers/input/tablet/pegasus_notetaker.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/input/tablet/pegasus_notetaker.c b/drivers/input/tablet/pegasus_notetaker.c
index 9ab1ed5e20e7..74c93e09c337 100644
--- a/drivers/input/tablet/pegasus_notetaker.c
+++ b/drivers/input/tablet/pegasus_notetaker.c
@@ -80,6 +80,7 @@ struct pegasus {
 
 	/* serialize access to open/suspend */
 	struct mutex pm_mutex;
+	bool is_open;
 
 	char name[128];
 	char phys[64];
@@ -232,6 +233,7 @@ static int pegasus_open(struct input_dev *dev)
 	if (error)
 		goto err_kill_urb;
 
+	pegasus->is_open = 1;
 	mutex_unlock(&pegasus->pm_mutex);
 	return 0;
 
@@ -251,6 +253,7 @@ static void pegasus_close(struct input_dev *dev)
 	mutex_lock(&pegasus->pm_mutex);
 	usb_kill_urb(pegasus->irq);
 	cancel_work_sync(&pegasus->init);
+	pegasus->is_open = 0;
 	mutex_unlock(&pegasus->pm_mutex);
 
 	usb_autopm_put_interface(pegasus->intf);
@@ -415,7 +418,7 @@ static int pegasus_resume(struct usb_interface *intf)
 	int retval = 0;
 
 	mutex_lock(&pegasus->pm_mutex);
-	if (pegasus->dev->users && usb_submit_urb(pegasus->irq, GFP_NOIO) < 0)
+	if (pegasus->is_open && usb_submit_urb(pegasus->irq, GFP_NOIO) < 0)
 		retval = -EIO;
 	mutex_unlock(&pegasus->pm_mutex);
 
@@ -428,7 +431,7 @@ static int pegasus_reset_resume(struct usb_interface *intf)
 	int retval = 0;
 
 	mutex_lock(&pegasus->pm_mutex);
-	if (pegasus->dev->users) {
+	if (pegasus->is_open) {
 		retval = pegasus_set_mode(pegasus, PEN_MODE_XY,
 					  NOTETAKER_LED_MOUSE);
 		if (!retval && usb_submit_urb(pegasus->irq, GFP_NOIO) < 0)
-- 
2.16.2
