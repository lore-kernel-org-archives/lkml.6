Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89299C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:36:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 554FD208E8
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:36:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 554FD208E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390079AbeGJSg6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 14:36:58 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:48658 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390064AbeGJSg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 14:36:57 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 34FBCECB;
        Tue, 10 Jul 2018 18:36:43 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mario Limonciello <mario.limonciello@dell.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH 4.17 44/56] HID: core: allow concurrent registration of drivers
Date:   Tue, 10 Jul 2018 20:25:26 +0200
Message-Id: <20180710182505.683450110@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180710182503.544433950@linuxfoundation.org>
References: <20180710182503.544433950@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Benjamin Tissoires <benjamin.tissoires@redhat.com>

commit 8f732850df1b2b4d8d719f7e606dfb3050e7ea11 upstream.

Detected on the Dell XPS 9365.

The laptop has 2 devices that benefit from the hid-generic auto-unbinding.
When those 2 devices are presented to the userspace, udev loads both wacom and
hid-multitouch. When this happens, the code in __hid_bus_reprobe_drivers() is
called concurrently and the second device gets reprobed twice.

An other bug in the power_supply subsystem prevent to remove the wacom driver
if it just finished its initialization, which basically kills the wacom node.

[jkosina@suse.cz: reformat changelog a bit]
Fixes c17a7476e4c4 ("HID: core: rewrite the hid-generic automatic unbind")
Cc: stable@vger.kernel.org # v4.17
Tested-by: Mario Limonciello <mario.limonciello@dell.com>
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/hid/hid-core.c |    5 ++++-
 include/linux/hid.h    |    3 ++-
 2 files changed, 6 insertions(+), 2 deletions(-)

--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1942,6 +1942,8 @@ static int hid_device_probe(struct devic
 	}
 	hdev->io_started = false;
 
+	clear_bit(ffs(HID_STAT_REPROBED), &hdev->status);
+
 	if (!hdev->driver) {
 		id = hid_match_device(hdev, hdrv);
 		if (id == NULL) {
@@ -2205,7 +2207,8 @@ static int __hid_bus_reprobe_drivers(str
 	struct hid_device *hdev = to_hid_device(dev);
 
 	if (hdev->driver == hdrv &&
-	    !hdrv->match(hdev, hid_ignore_special_drivers))
+	    !hdrv->match(hdev, hid_ignore_special_drivers) &&
+	    !test_and_set_bit(ffs(HID_STAT_REPROBED), &hdev->status))
 		return device_reprobe(dev);
 
 	return 0;
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -502,6 +502,7 @@ struct hid_output_fifo {
 
 #define HID_STAT_ADDED		BIT(0)
 #define HID_STAT_PARSED		BIT(1)
+#define HID_STAT_REPROBED	BIT(3)
 
 struct hid_input {
 	struct list_head list;
@@ -568,7 +569,7 @@ struct hid_device {							/* device repo
 	bool battery_avoid_query;
 #endif
 
-	unsigned int status;						/* see STAT flags above */
+	unsigned long status;						/* see STAT flags above */
 	unsigned claimed;						/* Claimed by hidinput, hiddev? */
 	unsigned quirks;						/* Various quirks the device can pull on us */
 	bool io_started;						/* If IO has started */


