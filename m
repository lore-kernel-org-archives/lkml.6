Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DD47C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 13:31:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 550B020659
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 13:31:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 550B020659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbeIDR4u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 13:56:50 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46152 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727057AbeIDR4u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 13:56:50 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E039740241C8;
        Tue,  4 Sep 2018 13:31:40 +0000 (UTC)
Received: from plouf.redhat.com (ovpn-116-25.ams2.redhat.com [10.36.116.25])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DC6AEA9EFD;
        Tue,  4 Sep 2018 13:31:39 +0000 (UTC)
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] HID: input: do not append a suffix if the name already has it
Date:   Tue,  4 Sep 2018 15:31:13 +0200
Message-Id: <20180904133115.5111-3-benjamin.tissoires@redhat.com>
In-Reply-To: <20180904133115.5111-1-benjamin.tissoires@redhat.com>
References: <20180904133115.5111-1-benjamin.tissoires@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Tue, 04 Sep 2018 13:31:40 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Tue, 04 Sep 2018 13:31:40 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'benjamin.tissoires@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Or it creates some weird input names like:
"MI Dongle MI Wireless Mouse Mouse"

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/hid-input.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index ac201817a2dd..1e9ba8f7a16b 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -1516,6 +1516,7 @@ static struct hid_input *hidinput_allocate(struct hid_device *hid,
 	struct hid_input *hidinput = kzalloc(sizeof(*hidinput), GFP_KERNEL);
 	struct input_dev *input_dev = input_allocate_device();
 	const char *suffix = NULL;
+	size_t suffix_len, name_len;
 
 	if (!hidinput || !input_dev)
 		goto fail;
@@ -1559,10 +1560,15 @@ static struct hid_input *hidinput_allocate(struct hid_device *hid,
 	}
 
 	if (suffix) {
-		hidinput->name = kasprintf(GFP_KERNEL, "%s %s",
-					   hid->name, suffix);
-		if (!hidinput->name)
-			goto fail;
+		name_len = strlen(hid->name);
+		suffix_len = strlen(suffix);
+		if ((name_len < suffix_len) ||
+		    strcmp(hid->name + name_len - suffix_len, suffix)) {
+			hidinput->name = kasprintf(GFP_KERNEL, "%s %s",
+						   hid->name, suffix);
+			if (!hidinput->name)
+				goto fail;
+		}
 	}
 
 	input_set_drvdata(input_dev, hid);
-- 
2.14.3

