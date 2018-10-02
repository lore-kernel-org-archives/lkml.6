Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7050C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:29:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE4012089C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:29:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE4012089C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729985AbeJBUMy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:12:54 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33148 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729955AbeJBUMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:12:53 -0400
Received: from localhost (24-104-73-23-ip-static.hfc.comcastbusiness.net [24.104.73.23])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id CB346A67;
        Tue,  2 Oct 2018 13:29:30 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH 4.18 150/228] usb: roles: Take care of driver module reference counting
Date:   Tue,  2 Oct 2018 06:24:07 -0700
Message-Id: <20181002132509.254108157@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181002132459.032960735@linuxfoundation.org>
References: <20181002132459.032960735@linuxfoundation.org>
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

From: Heikki Krogerus <heikki.krogerus@linux.intel.com>

commit 5c54fcac9a9de559b444ac63ec3cd82f1d157a0b upstream.

This fixes potential "BUG: unable to handle kernel paging
request at ..." from happening.

Cc: <stable@vger.kernel.org>
Acked-by: Hans de Goede <hdegoede@redhat.com>
Tested-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/common/roles.c |   15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

--- a/drivers/usb/common/roles.c
+++ b/drivers/usb/common/roles.c
@@ -109,8 +109,15 @@ static void *usb_role_switch_match(struc
  */
 struct usb_role_switch *usb_role_switch_get(struct device *dev)
 {
-	return device_connection_find_match(dev, "usb-role-switch", NULL,
-					    usb_role_switch_match);
+	struct usb_role_switch *sw;
+
+	sw = device_connection_find_match(dev, "usb-role-switch", NULL,
+					  usb_role_switch_match);
+
+	if (!IS_ERR_OR_NULL(sw))
+		WARN_ON(!try_module_get(sw->dev.parent->driver->owner));
+
+	return sw;
 }
 EXPORT_SYMBOL_GPL(usb_role_switch_get);
 
@@ -122,8 +129,10 @@ EXPORT_SYMBOL_GPL(usb_role_switch_get);
  */
 void usb_role_switch_put(struct usb_role_switch *sw)
 {
-	if (!IS_ERR_OR_NULL(sw))
+	if (!IS_ERR_OR_NULL(sw)) {
 		put_device(&sw->dev);
+		module_put(sw->dev.parent->driver->owner);
+	}
 }
 EXPORT_SYMBOL_GPL(usb_role_switch_put);
 


