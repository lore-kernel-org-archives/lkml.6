Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3E30C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 12:23:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 899AC20877
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 12:23:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 899AC20877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729080AbeIYSad (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 14:30:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51484 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728468AbeIYSad (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 14:30:33 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2288C81F12;
        Tue, 25 Sep 2018 12:23:15 +0000 (UTC)
Received: from rules.brq.redhat.com (dhcp-10-40-5-28.brq.redhat.com [10.40.5.28])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3117710021B2;
        Tue, 25 Sep 2018 12:23:13 +0000 (UTC)
From:   Vladis Dronov <vdronov@redhat.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Oliver Neukum <oneukum@suse.com>,
        Hans de Goede <hdegoede@redhat.com>,
        syzkaller@googlegroups.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     stable <stable@vger.kernel.org>, Vladis Dronov <vdronov@redhat.com>
Subject: [PATCH] usb: usbfs: fix crash in check_ctrlrecip()->usb_find_alt_setting()
Date:   Tue, 25 Sep 2018 14:22:42 +0200
Message-Id: <20180925122242.10950-1-vdronov@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Tue, 25 Sep 2018 12:23:15 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ps->dev->actconfig can be NULL and cause NULL-deref in usb_find_alt_setting()
before c9a4cb204e9e. fix this anyway by checking that ps->dev->actconfig is not
NULL, so usb_find_alt_setting() is not called with a known-bad argument.

Signed-off-by: Vladis Dronov <vdronov@redhat.com>
Reported-by: syzbot+19c3aaef85a89d451eac@syzkaller.appspotmail.com
---
 drivers/usb/core/devio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/core/devio.c b/drivers/usb/core/devio.c
index 6ce77b33da61..26047620b003 100644
--- a/drivers/usb/core/devio.c
+++ b/drivers/usb/core/devio.c
@@ -824,7 +824,7 @@ static int check_ctrlrecip(struct usb_dev_state *ps, unsigned int requesttype,
 	 * class specification, which we always want to allow as it is used
 	 * to query things like ink level, etc.
 	 */
-	if (requesttype == 0xa1 && request == 0) {
+	if (requesttype == 0xa1 && request == 0 && ps->dev->actconfig) {
 		alt_setting = usb_find_alt_setting(ps->dev->actconfig,
 						   index >> 8, index & 0xff);
 		if (alt_setting
-- 
2.14.4
