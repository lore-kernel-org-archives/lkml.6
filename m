Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD2C0C677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:38:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A46692098A
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:38:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="VzEZIGUV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A46692098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729546AbeJKXFv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:05:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:34438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727569AbeJKXFu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:05:50 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 677A520652;
        Thu, 11 Oct 2018 15:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539272287;
        bh=wGPtUcbwqhNtV2wdvCtnWjKaqwoO6vfdW7iTkY5h444=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VzEZIGUV6B6wfn32HiQLDOb1l3QoXIe4pkEEaKXgkKlH3BwZlNnxtRlvV9RwXOAj3
         0NChQ6uAyVbR6Kfx+TaIxJicreUX/vy/r+jTkQoBs0c9LFTHIz9Mel7coZU9ofnRWY
         llQvv4EqjtxaSLaqXsvwu5kVRvYRcBzKdSH77Xmg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>,
        syzbot+19c3aaef85a89d451eac@syzkaller.appspotmail.com
Subject: [PATCH 3.18 054/120] USB: handle NULL config in usb_find_alt_setting()
Date:   Thu, 11 Oct 2018 17:33:55 +0200
Message-Id: <20181011152551.994700709@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181011152549.500488630@linuxfoundation.org>
References: <20181011152549.500488630@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -79,6 +79,8 @@ struct usb_host_interface *usb_find_alt_
 	struct usb_interface_cache *intf_cache = NULL;
 	int i;
 
+	if (!config)
+		return NULL;
 	for (i = 0; i < config->desc.bNumInterfaces; i++) {
 		if (config->intf_cache[i]->altsetting[0].desc.bInterfaceNumber
 				== iface_num) {


