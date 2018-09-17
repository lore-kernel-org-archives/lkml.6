Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42489ECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:08:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01A12214AB
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:08:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01A12214AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731744AbeIREh7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:37:59 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49914 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729762AbeIREh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:37:59 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 884A6707;
        Mon, 17 Sep 2018 23:08:28 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH 4.18 004/158] HID: core: fix grouping by application
Date:   Tue, 18 Sep 2018 00:40:34 +0200
Message-Id: <20180917211710.715214718@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180917211710.383360696@linuxfoundation.org>
References: <20180917211710.383360696@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Benjamin Tissoires <benjamin.tissoires@redhat.com>

commit 0d6c3011409135ea84e2a231b013a22017ff999a upstream.

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
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/hid/hid-input.c      |    4 ++--
 drivers/hid/hid-multitouch.c |    3 +++
 include/linux/hid.h          |    1 +
 3 files changed, 6 insertions(+), 2 deletions(-)

--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -1579,6 +1579,7 @@ static struct hid_input *hidinput_alloca
 	input_dev->dev.parent = &hid->dev;
 
 	hidinput->input = input_dev;
+	hidinput->application = application;
 	list_add_tail(&hidinput->list, &hid->inputs);
 
 	INIT_LIST_HEAD(&hidinput->reports);
@@ -1674,8 +1675,7 @@ static struct hid_input *hidinput_match_
 	struct hid_input *hidinput;
 
 	list_for_each_entry(hidinput, &hid->inputs, list) {
-		if (hidinput->report &&
-		    hidinput->report->application == report->application)
+		if (hidinput->application == report->application)
 			return hidinput;
 	}
 
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -1488,6 +1488,9 @@ static int mt_probe(struct hid_device *h
 	 */
 	hdev->quirks |= HID_QUIRK_INPUT_PER_APP;
 
+	if (id->group != HID_GROUP_MULTITOUCH_WIN_8)
+		hdev->quirks |= HID_QUIRK_MULTI_INPUT;
+
 	timer_setup(&td->release_timer, mt_expired_timeout, 0);
 
 	ret = hid_parse(hdev);
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -520,6 +520,7 @@ struct hid_input {
 	const char *name;
 	bool registered;
 	struct list_head reports;	/* the list of reports */
+	unsigned int application;	/* application usage for this input */
 };
 
 enum hid_type {


