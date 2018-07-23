Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFAD7ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 17:05:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 632E720854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 17:05:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 632E720854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ispras.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388932AbeGWSHX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 14:07:23 -0400
Received: from bran.ispras.ru ([83.149.199.196]:13965 "EHLO smtp.ispras.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388200AbeGWSHX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 14:07:23 -0400
Received: from myklebust.intra.ispras.ru (unknown [10.10.2.207])
        by smtp.ispras.ru (Postfix) with ESMTP id 0B365203C3;
        Mon, 23 Jul 2018 20:05:11 +0300 (MSK)
From:   Anton Vasilyev <vasilyev@ispras.ru>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Anton Vasilyev <vasilyev@ispras.ru>,
        Jonathan Corbet <corbet@lwn.net>,
        Enrico Mioso <mrkiko.rs@gmail.com>,
        Bhumika Goyal <bhumirks@gmail.com>, Sean Young <sean@mess.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org
Subject: [PATCH] media: dw2102: Fix memleak on sequence of probes
Date:   Mon, 23 Jul 2018 20:04:54 +0300
Message-Id: <20180723170454.25905-1-vasilyev@ispras.ru>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Each call to dw2102_probe() allocates memory by kmemdup for structures
p1100, s660, p7500 and s421, but there is no their deallocation.
dvb_usb_device_init() copies the corresponding structure into
dvb_usb_device->props, so there is no use of original structure after
dvb_usb_device_init().

The patch moves structures from global scope to local and adds their
deallocation.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Anton Vasilyev <vasilyev@ispras.ru>
---
 drivers/media/usb/dvb-usb/dw2102.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/media/usb/dvb-usb/dw2102.c b/drivers/media/usb/dvb-usb/dw2102.c
index 0d4fdd34a710..9ce8b4d79d1f 100644
--- a/drivers/media/usb/dvb-usb/dw2102.c
+++ b/drivers/media/usb/dvb-usb/dw2102.c
@@ -2101,14 +2101,12 @@ static struct dvb_usb_device_properties s6x0_properties = {
 	}
 };
 
-static struct dvb_usb_device_properties *p1100;
 static const struct dvb_usb_device_description d1100 = {
 	"Prof 1100 USB ",
 	{&dw2102_table[PROF_1100], NULL},
 	{NULL},
 };
 
-static struct dvb_usb_device_properties *s660;
 static const struct dvb_usb_device_description d660 = {
 	"TeVii S660 USB",
 	{&dw2102_table[TEVII_S660], NULL},
@@ -2127,14 +2125,12 @@ static const struct dvb_usb_device_description d480_2 = {
 	{NULL},
 };
 
-static struct dvb_usb_device_properties *p7500;
 static const struct dvb_usb_device_description d7500 = {
 	"Prof 7500 USB DVB-S2",
 	{&dw2102_table[PROF_7500], NULL},
 	{NULL},
 };
 
-static struct dvb_usb_device_properties *s421;
 static const struct dvb_usb_device_description d421 = {
 	"TeVii S421 PCI",
 	{&dw2102_table[TEVII_S421], NULL},
@@ -2334,6 +2330,11 @@ static int dw2102_probe(struct usb_interface *intf,
 		const struct usb_device_id *id)
 {
 	int retval = -ENOMEM;
+	struct dvb_usb_device_properties *p1100;
+	struct dvb_usb_device_properties *s660;
+	struct dvb_usb_device_properties *p7500;
+	struct dvb_usb_device_properties *s421;
+
 	p1100 = kmemdup(&s6x0_properties,
 			sizeof(struct dvb_usb_device_properties), GFP_KERNEL);
 	if (!p1100)
@@ -2402,8 +2403,16 @@ static int dw2102_probe(struct usb_interface *intf,
 	    0 == dvb_usb_device_init(intf, &t220_properties,
 			 THIS_MODULE, NULL, adapter_nr) ||
 	    0 == dvb_usb_device_init(intf, &tt_s2_4600_properties,
-			 THIS_MODULE, NULL, adapter_nr))
+			 THIS_MODULE, NULL, adapter_nr)) {
+
+		/* clean up copied properties */
+		kfree(s421);
+		kfree(p7500);
+		kfree(s660);
+		kfree(p1100);
+
 		return 0;
+	}
 
 	retval = -ENODEV;
 	kfree(s421);
-- 
2.18.0

