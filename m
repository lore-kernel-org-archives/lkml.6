Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E785C43144
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 15:48:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 083F1250C9
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 15:48:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 083F1250C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933948AbeFXPsa (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 11:48:30 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33242 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932073AbeFXPs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 11:48:27 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 32DD82C;
        Sun, 24 Jun 2018 15:48:25 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jason Gerecke <jason.gerecke@wacom.com>,
        Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH 4.17 67/70] HID: wacom: Correct logical maximum Y for 2nd-gen Intuos Pro large
Date:   Sun, 24 Jun 2018 23:22:59 +0800
Message-Id: <20180624142744.673870112@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180624142740.481662434@linuxfoundation.org>
References: <20180624142740.481662434@linuxfoundation.org>
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

From: Jason Gerecke <killertofu@gmail.com>

commit d471b6b22d37bf9928c6d0202bdaaf76583b8b61 upstream.

The HID descriptor for the 2nd-gen Intuos Pro large (PTH-860) contains
a typo which defines an incorrect logical maximum Y value. This causes
a small portion of the bottom of the tablet to become unusable (both
because the area is below the "bottom" of the tablet and because
'wacom_wac_event' ignores out-of-range values). It also results in a
skewed aspect ratio.

To fix this, we add a quirk to 'wacom_usage_mapping' which overwrites
the data with the correct value.

Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
CC: stable@vger.kernel.org # v4.10+
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/hid/wacom_sys.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -395,6 +395,14 @@ static void wacom_usage_mapping(struct h
 		}
 	}
 
+	/* 2nd-generation Intuos Pro Large has incorrect Y maximum */
+	if (hdev->vendor == USB_VENDOR_ID_WACOM &&
+	    hdev->product == 0x0358 &&
+	    WACOM_PEN_FIELD(field) &&
+	    wacom_equivalent_usage(usage->hid) == HID_GD_Y) {
+		field->logical_maximum = 43200;
+	}
+
 	switch (usage->hid) {
 	case HID_GD_X:
 		features->x_max = field->logical_maximum;


