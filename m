Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D732AC43142
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 15:46:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B661250AC
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 15:46:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B661250AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933714AbeFXPq4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 11:46:56 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33050 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932073AbeFXPqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 11:46:54 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id AC7DB49F;
        Sun, 24 Jun 2018 15:46:52 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sean Young <sean@mess.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH 4.17 62/70] media: rc: ensure input/lirc device can be opened after register
Date:   Sun, 24 Jun 2018 23:22:54 +0800
Message-Id: <20180624142744.341416386@linuxfoundation.org>
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

From: Sean Young <sean@mess.org>

commit d7832cd2a3c87eb6ae1e802c88b6fc56c5823f6d upstream.

Since commit cb84343fced1 ("media: lirc: do not call close() or open() on
unregistered devices") rc_open() will return -ENODEV if rcdev->registered
is false. Ensure this is set before we register the input device and the
lirc device, else we have a short window where the neither the lirc or
input device can be opened.

Fixes: cb84343fced1 ("media: lirc: do not call close() or open() on unregistered devices")

Cc: stable@vger.kernel.org # v4.16+
Signed-off-by: Sean Young <sean@mess.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/rc/rc-main.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/media/rc/rc-main.c
+++ b/drivers/media/rc/rc-main.c
@@ -1860,6 +1860,8 @@ int rc_register_device(struct rc_dev *de
 		 dev->device_name ?: "Unspecified device", path ?: "N/A");
 	kfree(path);
 
+	dev->registered = true;
+
 	if (dev->driver_type != RC_DRIVER_IR_RAW_TX) {
 		rc = rc_setup_rx_device(dev);
 		if (rc)
@@ -1879,8 +1881,6 @@ int rc_register_device(struct rc_dev *de
 			goto out_lirc;
 	}
 
-	dev->registered = true;
-
 	dev_dbg(&dev->dev, "Registered rc%u (driver: %s)\n", dev->minor,
 		dev->driver_name ? dev->driver_name : "unknown");
 


