Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADEECC677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:36:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7863220C0A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:36:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vjIMf1vU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7863220C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728483AbeJIBtH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 21:49:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:33742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726989AbeJIBtG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 21:49:06 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4BAEF2064A;
        Mon,  8 Oct 2018 18:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539023763;
        bh=wH/wT8v9JQ8ilQF3RqX/7747rondeYCeTzZvtMGfGvc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vjIMf1vUTHaVVcWEuX7jaCRbkiNHVVmxc6gxrAgKZKPpzW7Bsb3DHIp//fFKinbcP
         GPJTOsK0DNstV4UYiFPhZZpzMgd/IO3eJ09U0oxAhgJl5WwqktudHicmhdfhL5jXzE
         Cip6cMObEQ+r8YCf7ZpPl0xNUpJmClT6EYhssZ+U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>,
        syzbot+19c3aaef85a89d451eac@syzkaller.appspotmail.com
Subject: [PATCH 4.4 051/113] USB: handle NULL config in usb_find_alt_setting()
Date:   Mon,  8 Oct 2018 20:30:52 +0200
Message-Id: <20181008175533.611043597@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181008175530.864641368@linuxfoundation.org>
References: <20181008175530.864641368@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -95,6 +95,8 @@ struct usb_host_interface *usb_find_alt_
 	struct usb_interface_cache *intf_cache = NULL;
 	int i;
 
+	if (!config)
+		return NULL;
 	for (i = 0; i < config->desc.bNumInterfaces; i++) {
 		if (config->intf_cache[i]->altsetting[0].desc.bInterfaceNumber
 				== iface_num) {


