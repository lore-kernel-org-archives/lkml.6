Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0166DC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:40:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C76C9206B2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:40:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C76C9206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732926AbeJBUXm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:23:42 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36340 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731713AbeJBUUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:20:00 -0400
Received: from localhost (24-104-73-23-ip-static.hfc.comcastbusiness.net [24.104.73.23])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E816EC4D;
        Tue,  2 Oct 2018 13:36:35 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>,
        syzbot+19c3aaef85a89d451eac@syzkaller.appspotmail.com
Subject: [PATCH 4.9 65/94] USB: handle NULL config in usb_find_alt_setting()
Date:   Tue,  2 Oct 2018 06:25:19 -0700
Message-Id: <20181002132505.010262771@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181002132500.494838053@linuxfoundation.org>
References: <20181002132500.494838053@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alan Stern <stern@rowland.harvard.edu>

commit c9a4cb204e9eb7fa7dfbe3f7d3a674fa530aa193 upstream.

usb_find_alt_setting() takes a pointer to a struct usb_host_config as
an argument; it searches for an interface with specified interface and
alternate setting numbers in that config.  However, it crashes if the
usb_host_config pointer argument is NULL.

Since this is a general-purpose routine, available for use in many
places, we want to to be more robust.  This patch makes it return NULL
whenever the config argument is NULL.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Reported-by: syzbot+19c3aaef85a89d451eac@syzkaller.appspotmail.com
CC: <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/core/usb.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/usb/core/usb.c
+++ b/drivers/usb/core/usb.c
@@ -91,6 +91,8 @@ struct usb_host_interface *usb_find_alt_
 	struct usb_interface_cache *intf_cache = NULL;
 	int i;
 
+	if (!config)
+		return NULL;
 	for (i = 0; i < config->desc.bNumInterfaces; i++) {
 		if (config->intf_cache[i]->altsetting[0].desc.bInterfaceNumber
 				== iface_num) {


