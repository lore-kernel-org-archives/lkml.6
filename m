Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E72AECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:01:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C58C92146F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:01:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C58C92146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730141AbeIREaf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:30:35 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:48206 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729660AbeIREae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:30:34 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 795D2C77;
        Mon, 17 Sep 2018 23:01:06 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Anton Vasilyev <vasilyev@ispras.ru>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 030/126] media: dw2102: Fix memleak on sequence of probes
Date:   Tue, 18 Sep 2018 00:41:18 +0200
Message-Id: <20180917211706.765606744@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180917211703.481236999@linuxfoundation.org>
References: <20180917211703.481236999@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Anton Vasilyev <vasilyev@ispras.ru>

[ Upstream commit 299c7007e93645067e1d2743f4e50156de78c4ff ]

Each call to dw2102_probe() allocates memory by kmemdup for structures
p1100, s660, p7500 and s421, but there is no their deallocation.
dvb_usb_device_init() copies the corresponding structure into
dvb_usb_device->props, so there is no use of original structure after
dvb_usb_device_init().

The patch moves structures from global scope to local and adds their
deallocation.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Anton Vasilyev <vasilyev@ispras.ru>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/usb/dvb-usb/dw2102.c |   19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

--- a/drivers/media/usb/dvb-usb/dw2102.c
+++ b/drivers/media/usb/dvb-usb/dw2102.c
@@ -2103,14 +2103,12 @@ static struct dvb_usb_device_properties
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
@@ -2129,14 +2127,12 @@ static const struct dvb_usb_device_descr
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
@@ -2336,6 +2332,11 @@ static int dw2102_probe(struct usb_inter
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
@@ -2404,8 +2405,16 @@ static int dw2102_probe(struct usb_inter
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


