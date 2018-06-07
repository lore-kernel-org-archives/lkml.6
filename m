Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id aQrxK+fkGFt5KgAAmS7hNA
	; Thu, 07 Jun 2018 07:55:37 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 8A117608B8; Thu,  7 Jun 2018 07:55:37 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 161C4607E7;
	Thu,  7 Jun 2018 07:55:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 161C4607E7
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932317AbeFGHzf (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 03:55:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41020 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932066AbeFGHzN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 03:55:13 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D342C4007855;
        Thu,  7 Jun 2018 07:55:12 +0000 (UTC)
Received: from plouf.banquise.eu.com (ovpn-116-40.ams2.redhat.com [10.36.116.40])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 943B22026DEF;
        Thu,  7 Jun 2018 07:55:11 +0000 (UTC)
From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
To: Jiri Kosina <jikos@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mario.Limonciello@dell.com,
        Peter Hutterer <peter.hutterer@who-t.net>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v2 12/13] HID: multitouch: touchscreens also use confidence reports
Date: Thu,  7 Jun 2018 09:54:47 +0200
Message-Id: <20180607075448.5706-13-benjamin.tissoires@redhat.com>
In-Reply-To: <20180607075448.5706-1-benjamin.tissoires@redhat.com>
References: <20180607075448.5706-1-benjamin.tissoires@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Thu, 07 Jun 2018 07:55:12 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Thu, 07 Jun 2018 07:55:12 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'benjamin.tissoires@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

According to [1] the confidence is used not only by touchpad devices,
but also by touchscreens.

[1] https://docs.microsoft.com/en-us/windows-hardware/design/component-guidelines/touchscreen-required-hid-top-level-collections

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
[rebased]
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

---

no changes in v2 (compared to Dmitry's initial submission)
---
 drivers/hid/hid-multitouch.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 36c8b67bb032..9c708aa261ee 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -734,7 +734,8 @@ static int mt_touch_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 		case HID_DG_CONFIDENCE:
 			if ((cls->name == MT_CLS_WIN_8 ||
 				cls->name == MT_CLS_WIN_8_DUAL) &&
-				field->application == HID_DG_TOUCHPAD)
+				(field->application == HID_DG_TOUCHPAD ||
+				 field->application == HID_DG_TOUCHSCREEN))
 				app->quirks |= MT_QUIRK_CONFIDENCE;
 
 			if (app->quirks & MT_QUIRK_CONFIDENCE)
-- 
2.14.3
