Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6089FC0044C
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:28:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 227C120818
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:28:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 227C120818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731102AbeKLGRw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:17:52 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:50640 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730521AbeKLFsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:48:23 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsi-0000lJ-97; Sun, 11 Nov 2018 19:58:52 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsa-0001qs-0S; Sun, 11 Nov 2018 19:58:44 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Benjamin Tissoires" <benjamin.tissoires@redhat.com>,
        "Tomasz Kramkowski" <tk@the-tk.com>,
        "=?UTF-8?q?Valtteri=20Heikkil=C3=A4?=" <rnd@nic.fi>,
        "Jiri Kosina" <jkosina@suse.cz>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.463952421@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 333/366] HID: reject input outside logical range only
 if null state is set
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Valtteri Heikkilä <rnd@nic.fi>

commit 3f3752705dbd50b66b66ad7b4d54fe33d2f746ed upstream.

This patch fixes an issue in drivers/hid/hid-input.c where USB HID
control null state flag is not checked upon rejecting inputs outside
logical minimum-maximum range. The check should be made according to USB
HID specification 1.11, section 6.2.2.5, p.31. The fix will resolve
issues with some game controllers, such as:
https://bugzilla.kernel.org/show_bug.cgi?id=68621

[tk@the-tk.com: shortened and fixed spelling in commit message]
Signed-off-by: Valtteri Heikkilä <rnd@nic.fi>
Signed-off-by: Tomasz Kramkowski <tk@the-tk.com>
Acked-By: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/hid/hid-input.c | 1 +
 1 file changed, 1 insertion(+)

--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -1094,6 +1094,7 @@ void hidinput_hid_event(struct hid_devic
 	 * don't specify logical min and max.
 	 */
 	if ((field->flags & HID_MAIN_ITEM_VARIABLE) &&
+	    (field->flags & HID_MAIN_ITEM_NULL_STATE) &&
 	    (field->logical_minimum < field->logical_maximum) &&
 	    (value < field->logical_minimum ||
 	     value > field->logical_maximum)) {

