Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752803AbeB1NjZ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 08:39:25 -0500
Received: from mail-lf0-f66.google.com ([209.85.215.66]:32990 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752346AbeB1NiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 08:38:16 -0500
X-Google-Smtp-Source: AG47ELt5V9PdrIJg5FSTEq4DHNm3oTtt+Jx33xASLYcw0xtRs6ekNcsuRVWtLsTD+pBzs23SPgxwWg==
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marcus Folkesson <marcus.folkesson@gmail.com>
Subject: [RESEND PATCH 2/6] input: synaptics_usb: do not rely on input_dev->users
Date: Wed, 28 Feb 2018 14:37:59 +0100
Message-Id: <20180228133803.30040-3-marcus.folkesson@gmail.com>
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

	if ((input_dev->users || (synusb->flags & SYNUSB_IO_ALWAYS)) &&
	    usb_submit_urb(synusb->urb, GFP_NOIO) < 0) {
		retval = -EIO;
	}

The same URB will then be fail when resubmitted in synusb_open().

Introduce synusb->is_open to keep track of the state instead.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 drivers/input/mouse/synaptics_usb.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/input/mouse/synaptics_usb.c b/drivers/input/mouse/synaptics_usb.c
index 2c66913cf5a2..e2b726751220 100644
--- a/drivers/input/mouse/synaptics_usb.c
+++ b/drivers/input/mouse/synaptics_usb.c
@@ -84,6 +84,7 @@ struct synusb {
 
 	/* serialize access to open/suspend */
 	struct mutex pm_mutex;
+	bool is_open;
 
 	/* input device related data structures */
 	struct input_dev *input;
@@ -266,6 +267,7 @@ static int synusb_open(struct input_dev *dev)
 	}
 
 	synusb->intf->needs_remote_wakeup = 1;
+	synusb->is_open = 1;
 
 out:
 	mutex_unlock(&synusb->pm_mutex);
@@ -283,6 +285,7 @@ static void synusb_close(struct input_dev *dev)
 	mutex_lock(&synusb->pm_mutex);
 	usb_kill_urb(synusb->urb);
 	synusb->intf->needs_remote_wakeup = 0;
+	synusb->is_open = 0;
 	mutex_unlock(&synusb->pm_mutex);
 
 	if (!autopm_error)
@@ -485,12 +488,11 @@ static int synusb_suspend(struct usb_interface *intf, pm_message_t message)
 static int synusb_resume(struct usb_interface *intf)
 {
 	struct synusb *synusb = usb_get_intfdata(intf);
-	struct input_dev *input_dev = synusb->input;
 	int retval = 0;
 
 	mutex_lock(&synusb->pm_mutex);
 
-	if ((input_dev->users || (synusb->flags & SYNUSB_IO_ALWAYS)) &&
+	if ((synusb->is_open || (synusb->flags & SYNUSB_IO_ALWAYS)) &&
 	    usb_submit_urb(synusb->urb, GFP_NOIO) < 0) {
 		retval = -EIO;
 	}
@@ -513,10 +515,9 @@ static int synusb_pre_reset(struct usb_interface *intf)
 static int synusb_post_reset(struct usb_interface *intf)
 {
 	struct synusb *synusb = usb_get_intfdata(intf);
-	struct input_dev *input_dev = synusb->input;
 	int retval = 0;
 
-	if ((input_dev->users || (synusb->flags & SYNUSB_IO_ALWAYS)) &&
+	if ((synusb->is_open || (synusb->flags & SYNUSB_IO_ALWAYS)) &&
 	    usb_submit_urb(synusb->urb, GFP_NOIO) < 0) {
 		retval = -EIO;
 	}
-- 
2.16.2
