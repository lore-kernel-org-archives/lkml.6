Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967822AbeE2W5O (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 18:57:14 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:38978 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935806AbeE2W5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 18:57:10 -0400
X-Google-Smtp-Source: ADUXVKIhj7oWmCeowd4sao/kPnf7llaKO7YKWeArWN2EhLbnufMJ3SDYi3JWlHyLtEcKv1Tw5DcgwQ==
From: Ben Chan <benchan@chromium.org>
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>, dtor@chromium.org,
        drinkcat@chromium.org
Subject: [PATCH] HID: multitouch: fix calculation of last slot field in multi-touch reports
Date: Tue, 29 May 2018 15:56:55 -0700
Message-Id: <20180529225655.214380-1-benchan@chromium.org>
X-Mailer: git-send-email 2.17.0.921.gf22659ad46-goog
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to [1] and also seemingly agreed by [2], the Scan Time usage
(0x0D 0x56) is a report level usage, not a contact level usage.

However, the hid-multitouch driver currently includes HID_DG_SCANTIME
when calculating `td->last_slot_field', which may lead to
mt_complete_slot() being prematurely called in certain cases (e.g. when
each touch input report includes more than one contact and the Scan Time
usage appears before any contact logical collection).

This patch fixes the issue by skipping mt_store_field() on
HID_DG_SCANTIME, similar to how HID_DG_CONTACTCOUNT and
HID_DG_CONTACTMAX are handled.

[1] https://docs.microsoft.com/en-us/windows-hardware/design/component-guidelines/windows-precision-touchpad-required-hid-top-level-collections#windows-precision-touchpad-input-reports
[2] https://patchwork.kernel.org/patch/1742181/

Fixes: 29cc309d8bf19 ("HID: hid-multitouch: forward MSC_TIMESTAMP")
Signed-off-by: Ben Chan <benchan@chromium.org>
---
 drivers/hid/hid-multitouch.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index dad2fbb0e3f8..161551aab496 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -620,13 +620,16 @@ static int mt_touch_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 			hid_map_usage(hi, usage, bit, max,
 				EV_MSC, MSC_TIMESTAMP);
 			input_set_capability(hi->input, EV_MSC, MSC_TIMESTAMP);
-			mt_store_field(usage, td, hi);
 			/* Ignore if indexes are out of bounds. */
 			if (field->index >= field->report->maxfield ||
 			    usage->usage_index >= field->report_count)
 				return 1;
 			td->scantime_index = field->index;
 			td->scantime_val_index = usage->usage_index;
+			/*
+			 * We don't set td->last_slot_field as scan time is
+			 * global to the report.
+			 */
 			return 1;
 		case HID_DG_CONTACTCOUNT:
 			/* Ignore if indexes are out of bounds. */
-- 
2.17.0.921.gf22659ad46-goog
