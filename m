Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032171AbeEZQBT (ORCPT <rfc822;w@1wt.eu>);
        Sat, 26 May 2018 12:01:19 -0400
Received: from spacedout.fries.net ([47.47.3.166]:56388 "EHLO
        SpacedOut.fries.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032084AbeEZQBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 May 2018 12:01:16 -0400
Date: Sat, 26 May 2018 10:50:46 -0500
From: David Fries <David@Fries.net>
To: linux-kernel@vger.kernel.org
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        stable@vger.kernel.org
Subject: [PATCH 1/1] media: uvc_driver: fix USB Camera ref leak denial of
 service
Message-ID: <20180526155046.GA3327@spacedout.fries.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 9d15cd958c17 ("media: uvcvideo: Convert from using an atomic
variable to a reference count")
didn't take into account that while the old counter was initialized to
0 (no stream open), kref_init starts with a reference of 1.  The
reference count on unplug no longer reaches 0, uvc_delete isn't
called, and evdev doesn't release /dev/input/event*.  Plug and unplug
enough times and it runs out of device minors preventing any new input
device and the use of newly plugged in USB video cameras until the
system is rebooted.

Signed-off-by: David Fries <David@Fries.net>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Cc: stable@vger.kernel.org
---
 drivers/media/usb/uvc/uvc_driver.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index 2469b49..3cbdc87 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -1871,13 +1871,6 @@ static void uvc_unregister_video(struct uvc_device *dev)
 {
 	struct uvc_streaming *stream;
 
-	/* Unregistering all video devices might result in uvc_delete() being
-	 * called from inside the loop if there's no open file handle. To avoid
-	 * that, increment the refcount before iterating over the streams and
-	 * decrement it when done.
-	 */
-	kref_get(&dev->ref);
-
 	list_for_each_entry(stream, &dev->streams, list) {
 		if (!video_is_registered(&stream->vdev))
 			continue;
@@ -1888,6 +1881,10 @@ static void uvc_unregister_video(struct uvc_device *dev)
 		uvc_debugfs_cleanup_stream(stream);
 	}
 
+	/* Release the reference implicit in kref_init from uvc_probe,
+	 * the UVC device won't be deleted until the last file descriptor
+	 * is also closed.
+	 */
 	kref_put(&dev->ref, uvc_delete);
 }
 
-- 
2.1.4


>From 32a612bc06a2a1b9215f3b7166342c98043bd925 Mon Sep 17 00:00:00 2001
From: David Fries <David@Fries.net>
Date: Thu, 24 May 2018 23:43:15 -0500
Subject: [PATCH] uvc_driver: UVC kref never reaches zero leading to denial of
 service

Commit 9d15cd958c17 ("media: uvcvideo: Convert from using an atomic
variable to a reference count")
didn't take into account that while the counter was
initialized to 0 (no stream open), kref_init starts with a reference
of 1, leading to the device
never reaching 0 and uvc_delete never getting called.  This leads to
evdev never getting released and /dev/input/event* eventually running
out of minors preventing any new event devices and new USB cameras from
being usable until the system is rebooted.

In my case "disabled by hub (EMI?), re-enabling..." kept
removing/inserting the device until days later it ran out of minors
and I lost the video security feed.

Now that the device is actually being removed other problems are
showing up.  Specifically the following if the camera is removed or
`rmmod ehci_pci` while an application is getting video from it.  It
doesn't happen if the camera is not in use.  How do I track that down?

sysfs group 'power' not found for kobject 'event10'
sysfs group 'power' not found for kobject 'input32'
sysfs group 'id' not found for kobject 'input32'
sysfs group 'capabilities' not found for kobject 'input32'
sysfs group 'power' not found for kobject 'media0'

Signed-off-by: David Fries <David@Fries.net>
---
 drivers/media/usb/uvc/uvc_driver.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index 2469b49..3cbdc87 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -1871,13 +1871,6 @@ static void uvc_unregister_video(struct uvc_device *dev)
 {
 	struct uvc_streaming *stream;
 
-	/* Unregistering all video devices might result in uvc_delete() being
-	 * called from inside the loop if there's no open file handle. To avoid
-	 * that, increment the refcount before iterating over the streams and
-	 * decrement it when done.
-	 */
-	kref_get(&dev->ref);
-
 	list_for_each_entry(stream, &dev->streams, list) {
 		if (!video_is_registered(&stream->vdev))
 			continue;
@@ -1888,6 +1881,10 @@ static void uvc_unregister_video(struct uvc_device *dev)
 		uvc_debugfs_cleanup_stream(stream);
 	}
 
+	/* Release the reference implicit in kref_init from uvc_probe,
+	 * the UVC device won't be deleted until the last file descriptor
+	 * is also closed.
+	 */
 	kref_put(&dev->ref, uvc_delete);
 }
 
-- 
2.1.4
