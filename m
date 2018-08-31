Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D6D4C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 09:36:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AF63205F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 09:36:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AF63205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727574AbeHaNmt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 09:42:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42536 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726990AbeHaNmt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 09:42:49 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 71A797DAC2;
        Fri, 31 Aug 2018 09:36:10 +0000 (UTC)
Received: from plouf.redhat.com (ovpn-116-59.ams2.redhat.com [10.36.116.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5A1632166B41;
        Fri, 31 Aug 2018 09:36:07 +0000 (UTC)
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        stable@vger.kernel.org
Subject: [PATCH] Partially revert "HID: generic: create one input report per application type"
Date:   Fri, 31 Aug 2018 11:36:04 +0200
Message-Id: <20180831093604.5915-1-benjamin.tissoires@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Fri, 31 Aug 2018 09:36:10 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Fri, 31 Aug 2018 09:36:10 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'benjamin.tissoires@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This partially reverts commit f07b3c1da92db108662f99417a212fc1eddc44d1.

It looks like some mice are not correctly treated by
HID_QUIRK_INPUT_PER_APP. Those mice have the following
report descriptor:

0x05, 0x01,                    // Usage Page (Generic Desktop)        0
0x09, 0x02,                    // Usage (Mouse)                       2
0xa1, 0x01,                    // Collection (Application)            4
0x85, 0x01,                    //  Report ID (1)                      6
0x09, 0x01,                    //  Usage (Pointer)                    8
0xa1, 0x00,                    //  Collection (Physical)              10
0x95, 0x05,                    //   Report Count (5)                  12
0x75, 0x01,                    //   Report Size (1)                   14
0x05, 0x09,                    //   Usage Page (Button)               16
0x19, 0x01,                    //   Usage Minimum (1)                 18
0x29, 0x05,                    //   Usage Maximum (5)                 20
0x15, 0x00,                    //   Logical Minimum (0)               22
0x25, 0x01,                    //   Logical Maximum (1)               24
0x81, 0x02,                    //   Input (Data,Var,Abs)              26
...
0xc0,                          //  End Collection                     57
0x85, 0x02,                    //  Report ID (2)                      58
0x09, 0x01,                    //  Usage (Consumer Control)           60
0xa1, 0x00,                    //  Collection (Physical)              62
0x75, 0x0c,                    //   Report Size (12)                  64
0x95, 0x02,                    //   Report Count (2)                  66
0x05, 0x01,                    //   Usage Page (Generic Desktop)      68
0x09, 0x30,                    //   Usage (X)                         70
0x09, 0x31,                    //   Usage (Y)                         72
0x16, 0x01, 0xf8,              //   Logical Minimum (-2047)           74
0x26, 0xff, 0x07,              //   Logical Maximum (2047)            77
0x81, 0x06,                    //   Input (Data,Var,Rel)              80
0xc0,                          //  End Collection                     82
0xc0,                          // End Collection                      83
...

Both the cursor position and the buttons are located in the
same application collection (Mouse) and the kernel should
only create one input device for those.

However, for an undetermined reason, the kernel splits the
device in 2, making systemd not tagging the second mouse
with the coordinates only as a mouse. And then userspace
ignores it which leads to a mouse where only the buttons
are working.

Until the quirk gets properly fixed, we should probably
revert applying it to all of the generic devices and
re-enable it when the root reason has been found.

link: https://bugzilla.kernel.org/show_bug.cgi?id=200847
link: https://bugzilla.kernel.org/show_bug.cgi?id=200849
link: https://bugs.archlinux.org/task/59699
link: https://github.com/NixOS/nixpkgs/issues/45165

Cc: stable@vger.kernel.org # v4.18+
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/hid-generic.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/drivers/hid/hid-generic.c b/drivers/hid/hid-generic.c
index 3b6eccbc2519..c25b4718de44 100644
--- a/drivers/hid/hid-generic.c
+++ b/drivers/hid/hid-generic.c
@@ -56,20 +56,6 @@ static bool hid_generic_match(struct hid_device *hdev,
 	return true;
 }
 
-static int hid_generic_probe(struct hid_device *hdev,
-			     const struct hid_device_id *id)
-{
-	int ret;
-
-	hdev->quirks |= HID_QUIRK_INPUT_PER_APP;
-
-	ret = hid_parse(hdev);
-	if (ret)
-		return ret;
-
-	return hid_hw_start(hdev, HID_CONNECT_DEFAULT);
-}
-
 static const struct hid_device_id hid_table[] = {
 	{ HID_DEVICE(HID_BUS_ANY, HID_GROUP_ANY, HID_ANY_ID, HID_ANY_ID) },
 	{ }
@@ -80,7 +66,6 @@ static struct hid_driver hid_generic = {
 	.name = "hid-generic",
 	.id_table = hid_table,
 	.match = hid_generic_match,
-	.probe = hid_generic_probe,
 };
 module_hid_driver(hid_generic);
 
-- 
2.14.3

