Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79B78C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:46:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E2922243E
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:46:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="E4TwyMAE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E2922243E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbeKOI1O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 03:27:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:34392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726951AbeKOI1N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 03:27:13 -0500
Received: from sasha-vm.mshome.net (unknown [64.114.255.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F3A72251D;
        Wed, 14 Nov 2018 22:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542234130;
        bh=x7X1c8A6r8/bHN0lud/9N8j8eN673u6N18scvyv55as=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E4TwyMAEytVEm5HsV6OF0X33X0W3XJcCH1USbPoDeL7tYD9u2GwsXZV7ZKvSU3Kjx
         9JJEEaFFkQFoPLSpBA+lGJwICfjksLOThmxMMY1q0qH5ZYebGfF2zbzNJ+hWHCCxev
         3ip4iuI/4aA4++en7Diei69nRXqSNyj8g2/G9Wnw=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jkosina@suse.cz>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 08/73] HID: alps: allow incoming reports when only the trackstick is opened
Date:   Wed, 14 Nov 2018 17:21:02 -0500
Message-Id: <20181114222207.98701-8-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181114222207.98701-1-sashal@kernel.org>
References: <20181114222207.98701-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benjamin Tissoires <benjamin.tissoires@redhat.com>

[ Upstream commit 7dd8db68949a7acc5bd528ee0ecb8f8720f49921 ]

If userspace only reads the trackstick node, and no one is listening to
the touchpad nor the hidraw node then, the device is not powered on.

Add open/close callbacks to allow users to disable the touchpad in Gnome
while keeping the trackstick active.

Link: https://bugzilla.redhat.com/show_bug.cgi?id=1559632
Link: https://gitlab.gnome.org/GNOME/mutter/issues/128
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-alps.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/hid/hid-alps.c b/drivers/hid/hid-alps.c
index aec253b44156..3cd7229b6e54 100644
--- a/drivers/hid/hid-alps.c
+++ b/drivers/hid/hid-alps.c
@@ -660,6 +660,20 @@ exit:
 	return ret;
 }
 
+static int alps_sp_open(struct input_dev *dev)
+{
+	struct hid_device *hid = input_get_drvdata(dev);
+
+	return hid_hw_open(hid);
+}
+
+static void alps_sp_close(struct input_dev *dev)
+{
+	struct hid_device *hid = input_get_drvdata(dev);
+
+	hid_hw_close(hid);
+}
+
 static int alps_input_configured(struct hid_device *hdev, struct hid_input *hi)
 {
 	struct alps_dev *data = hid_get_drvdata(hdev);
@@ -733,6 +747,10 @@ static int alps_input_configured(struct hid_device *hdev, struct hid_input *hi)
 		input2->id.version = input->id.version;
 		input2->dev.parent = input->dev.parent;
 
+		input_set_drvdata(input2, hdev);
+		input2->open = alps_sp_open;
+		input2->close = alps_sp_close;
+
 		__set_bit(EV_KEY, input2->evbit);
 		data->sp_btn_cnt = (data->sp_btn_info & 0x0F);
 		for (i = 0; i < data->sp_btn_cnt; i++)
-- 
2.17.1

