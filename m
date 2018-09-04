Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0849C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 13:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 944212075E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 13:31:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 944212075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727510AbeIDR44 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 13:56:56 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60400 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727057AbeIDR4z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 13:56:55 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 640FC4023842;
        Tue,  4 Sep 2018 13:31:46 +0000 (UTC)
Received: from plouf.redhat.com (ovpn-116-25.ams2.redhat.com [10.36.116.25])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6F8E8A9EF7;
        Tue,  4 Sep 2018 13:31:43 +0000 (UTC)
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: [PATCH 3/4] HID: core: fix grouping by application
Date:   Tue,  4 Sep 2018 15:31:14 +0200
Message-Id: <20180904133115.5111-4-benjamin.tissoires@redhat.com>
In-Reply-To: <20180904133115.5111-1-benjamin.tissoires@redhat.com>
References: <20180904133115.5111-1-benjamin.tissoires@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Tue, 04 Sep 2018 13:31:46 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Tue, 04 Sep 2018 13:31:46 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'benjamin.tissoires@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit f07b3c1da92d ("HID: generic: create one input report per
application type") was effectively the same as MULTI_INPUT:
hidinput->report was never set, so hidinput_match_application()
always returned null.

Fix that by testing against the real application.

Note that this breaks some old eGalax touchscreens that expect MULTI_INPUT
instead of HID_QUIRK_INPUT_PER_APP. Enable this quirk for backward
compatibility on all non-Win8 touchscreens.

link: https://bugzilla.kernel.org/show_bug.cgi?id=200847
link: https://bugzilla.kernel.org/show_bug.cgi?id=200849
link: https://bugs.archlinux.org/task/59699
link: https://github.com/NixOS/nixpkgs/issues/45165

Cc: stable@vger.kernel.org # v4.18+
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---

This replaces https://patchwork.kernel.org/patch/10583471/
A proper fix is better than a revert.

 drivers/hid/hid-input.c      | 4 ++--
 drivers/hid/hid-multitouch.c | 3 +++
 include/linux/hid.h          | 1 +
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index 1e9ba8f7a16b..907b08e50a9b 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -1588,6 +1588,7 @@ static struct hid_input *hidinput_allocate(struct hid_device *hid,
 	input_dev->dev.parent = &hid->dev;
 
 	hidinput->input = input_dev;
+	hidinput->application = application;
 	list_add_tail(&hidinput->list, &hid->inputs);
 
 	INIT_LIST_HEAD(&hidinput->reports);
@@ -1683,8 +1684,7 @@ static struct hid_input *hidinput_match_application(struct hid_report *report)
 	struct hid_input *hidinput;
 
 	list_for_each_entry(hidinput, &hid->inputs, list) {
-		if (hidinput->report &&
-		    hidinput->report->application == report->application)
+		if (hidinput->application == report->application)
 			return hidinput;
 	}
 
diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 88da991ef256..da954f3f4da7 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -1697,6 +1697,9 @@ static int mt_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	 */
 	hdev->quirks |= HID_QUIRK_INPUT_PER_APP;
 
+	if (id->group != HID_GROUP_MULTITOUCH_WIN_8)
+		hdev->quirks |= HID_QUIRK_MULTI_INPUT;
+
 	timer_setup(&td->release_timer, mt_expired_timeout, 0);
 
 	ret = hid_parse(hdev);
diff --git a/include/linux/hid.h b/include/linux/hid.h
index 834e6461a690..d44a78362942 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -526,6 +526,7 @@ struct hid_input {
 	const char *name;
 	bool registered;
 	struct list_head reports;	/* the list of reports */
+	unsigned int application;	/* application usage for this input */
 };
 
 enum hid_type {
-- 
2.14.3

