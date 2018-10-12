Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF588C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 09:17:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1BF32086A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 09:17:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1BF32086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=codethink.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728365AbeJLQtC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 12:49:02 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:49435 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728102AbeJLQsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 12:48:25 -0400
Received: from [148.252.241.226] (helo=rainbowdash)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1gAtYz-0006u5-En; Fri, 12 Oct 2018 10:16:53 +0100
Received: from ben by rainbowdash with local (Exim 4.91)
        (envelope-from <ben@rainbowdash.codethink.co.uk>)
        id 1gAtYy-0005Yb-Jr; Fri, 12 Oct 2018 10:16:52 +0100
From:   Ben Dooks <ben.dooks@codethink.co.uk>
To:     davem@davemloft.net, netdev@vger.kernel.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel@lists.codethink.co.uk, gregkh@linuxfoundation.org,
        bjorn@mork.no, steve.glendinning@shawell.net,
        Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH 6/7] net: huawei_cdc_ncm: add usbnet -> priv function
Date:   Fri, 12 Oct 2018 10:16:41 +0100
Message-Id: <20181012091642.21294-7-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181012091642.21294-1-ben.dooks@codethink.co.uk>
References: <20181012091642.21294-1-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are a number of places in the huawei driver where it gets the
private-data from the usbnet passed in. It would be sensible to have
one inline function to convert it and change all points in the driver
to use that.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
---
 drivers/net/usb/huawei_cdc_ncm.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/net/usb/huawei_cdc_ncm.c b/drivers/net/usb/huawei_cdc_ncm.c
index 63f28908afda..d290b8c318be 100644
--- a/drivers/net/usb/huawei_cdc_ncm.c
+++ b/drivers/net/usb/huawei_cdc_ncm.c
@@ -38,9 +38,14 @@ struct huawei_cdc_ncm_state {
 	struct usb_interface *data;
 };
 
+static inline struct huawei_cdc_ncm_state *usbnet_to_state(struct usbnet *usb)
+{
+	return (struct huawei_cdc_ncm_state *)&usb->data;
+}
+
 static int huawei_cdc_ncm_manage_power(struct usbnet *usbnet_dev, int on)
 {
-	struct huawei_cdc_ncm_state *drvstate = (void *)&usbnet_dev->data;
+	struct huawei_cdc_ncm_state *drvstate = usbnet_to_state(usbnet_dev);
 	int rv;
 
 	if ((on && atomic_add_return(1, &drvstate->pmcount) == 1) ||
@@ -72,7 +77,7 @@ static int huawei_cdc_ncm_bind(struct usbnet *usbnet_dev,
 	struct cdc_ncm_ctx *ctx;
 	struct usb_driver *subdriver = ERR_PTR(-ENODEV);
 	int ret = -ENODEV;
-	struct huawei_cdc_ncm_state *drvstate = (void *)&usbnet_dev->data;
+	struct huawei_cdc_ncm_state *drvstate = usbnet_to_state(usbnet_dev);
 	int drvflags = 0;
 
 	/* altsetting should always be 1 for NCM devices - so we hard-coded
@@ -119,7 +124,7 @@ static int huawei_cdc_ncm_bind(struct usbnet *usbnet_dev,
 static void huawei_cdc_ncm_unbind(struct usbnet *usbnet_dev,
 				  struct usb_interface *intf)
 {
-	struct huawei_cdc_ncm_state *drvstate = (void *)&usbnet_dev->data;
+	struct huawei_cdc_ncm_state *drvstate = usbnet_to_state(usbnet_dev);
 	struct cdc_ncm_ctx *ctx = drvstate->ctx;
 
 	if (drvstate->subdriver && drvstate->subdriver->disconnect)
@@ -134,7 +139,7 @@ static int huawei_cdc_ncm_suspend(struct usb_interface *intf,
 {
 	int ret = 0;
 	struct usbnet *usbnet_dev = usb_get_intfdata(intf);
-	struct huawei_cdc_ncm_state *drvstate = (void *)&usbnet_dev->data;
+	struct huawei_cdc_ncm_state *drvstate = usbnet_to_state(usbnet_dev);
 	struct cdc_ncm_ctx *ctx = drvstate->ctx;
 
 	if (ctx == NULL) {
@@ -161,7 +166,7 @@ static int huawei_cdc_ncm_resume(struct usb_interface *intf)
 {
 	int ret = 0;
 	struct usbnet *usbnet_dev = usb_get_intfdata(intf);
-	struct huawei_cdc_ncm_state *drvstate = (void *)&usbnet_dev->data;
+	struct huawei_cdc_ncm_state *drvstate = usbnet_to_state(usbnet_dev);
 	bool callsub;
 	struct cdc_ncm_ctx *ctx = drvstate->ctx;
 
-- 
2.19.1

