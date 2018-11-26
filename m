Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CB00C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:03:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26D1621104
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:03:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="foQYdowx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26D1621104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730851AbeKZV5e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:57:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:41876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730204AbeKZV5e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:57:34 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0264820645;
        Mon, 26 Nov 2018 11:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543230228;
        bh=gJ8xo3BQlJ5AMYxi8He1cLGh+anOk19pA1JjIdWeiYQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=foQYdowxcw86cSRWSmP19r9kTizO5p8svyWhZyBT3usRsLrjBmrEXh2HIBNqHv4ZC
         ZCEADLKTdYmci2mM3XHd/hcuMju/Bzw90rbFLwfZHO+9OifRrRg8w4Tx+ToJ5krjX2
         i7+KkGzpHAcxAXuUkW6h+VPKi5nqZESkTtCTEBV4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jkosina@suse.cz>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 039/118] HID: alps: allow incoming reports when only the trackstick is opened
Date:   Mon, 26 Nov 2018 11:50:33 +0100
Message-Id: <20181126105102.345581109@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181126105059.832485122@linuxfoundation.org>
References: <20181126105059.832485122@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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



