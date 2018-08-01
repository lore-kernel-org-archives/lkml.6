Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37C25C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5D4A2083D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:07:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5D4A2083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732861AbeHATyl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:54:41 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49800 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405771AbeHATIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:08:36 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 65AD910A5;
        Wed,  1 Aug 2018 17:02:54 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dmitry Torokhov <dtor@chromium.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jkosina@suse.cz>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 185/336] HID: i2c-hid: check if device is there before really probing
Date:   Wed,  1 Aug 2018 18:48:40 +0200
Message-Id: <20180801165036.178075948@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801165028.930831994@linuxfoundation.org>
References: <20180801165028.930831994@linuxfoundation.org>
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

From: Dmitry Torokhov <dtor@chromium.org>

[ Upstream commit b3a81b6c4fc6730ac49e20d789a93c0faabafc98 ]

On many Chromebooks touch devices are multi-sourced; the components are
electrically compatible and one can be freely swapped for another without
changing the OS image or firmware.

To avoid bunch of scary messages when device is not actually present in the
system let's try testing basic communication with it and if there is no
response terminate probe early with -ENXIO.

Signed-off-by: Dmitry Torokhov <dtor@chromium.org>
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hid/i2c-hid/i2c-hid.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/drivers/hid/i2c-hid/i2c-hid.c
+++ b/drivers/hid/i2c-hid/i2c-hid.c
@@ -1054,6 +1054,14 @@ static int i2c_hid_probe(struct i2c_clie
 	pm_runtime_enable(&client->dev);
 	device_enable_async_suspend(&client->dev);
 
+	/* Make sure there is something at this address */
+	ret = i2c_smbus_read_byte(client);
+	if (ret < 0) {
+		dev_dbg(&client->dev, "nothing at this address: %d\n", ret);
+		ret = -ENXIO;
+		goto err_pm;
+	}
+
 	ret = i2c_hid_fetch_hid_descriptor(ihid);
 	if (ret < 0)
 		goto err_pm;


