Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3278C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 12:18:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4D9620675
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 12:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545999519;
	bh=FnRDY1OXTCm55v5r/xPzm8qumVYpk8/DOuLCPxDkxac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aCDdt+GHHytSegW9BFdnbGY20adID7UKQVHJo0YmGfF+E7QxYZJ+i1pZryCy2YMBN
	 OqQD3KvdcTfGWBW3iBJgjfLAnLlnSbU9Lp2J9I1uGewFZw7V+FgLZ44t9u6jYMAJ29
	 Dk7GZJifiKbKxZ8EpQeti8Sqi7GQ8BHHsC4WbWNw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733163AbeL1MSi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 07:18:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:37020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733055AbeL1MRz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 07:17:55 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49996218FE;
        Fri, 28 Dec 2018 12:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545999474;
        bh=FnRDY1OXTCm55v5r/xPzm8qumVYpk8/DOuLCPxDkxac=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JeuwilvZHL0oa0EVcHWISt22qt+P3CRBYQPebCfsg/SETTNUApPxM+X6S4Yf3XG9Y
         rM7bRKEjpPRYOn02mI0rA3xtmUDeAq7B4kb90JFhSoLQXRXpweQK1FxKEjHkMOlLGj
         qM8xAzh6aEsixnEoUCfZqhFjXFvsNB56y6m/IyPo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hui Peng <benquike@gmail.com>,
        Mathias Payer <mathias.payer@nebelwelt.net>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 04/22] USB: hso: Fix OOB memory access in hso_probe/hso_get_config_data
Date:   Fri, 28 Dec 2018 12:52:41 +0100
Message-Id: <20181228113126.447124983@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181228113126.144310132@linuxfoundation.org>
References: <20181228113126.144310132@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hui Peng <benquike@gmail.com>

commit 5146f95df782b0ac61abde36567e718692725c89 upstream.

The function hso_probe reads if_num from the USB device (as an u8) and uses
it without a length check to index an array, resulting in an OOB memory read
in hso_probe or hso_get_config_data.

Add a length check for both locations and updated hso_probe to bail on
error.

This issue has been assigned CVE-2018-19985.

Reported-by: Hui Peng <benquike@gmail.com>
Reported-by: Mathias Payer <mathias.payer@nebelwelt.net>
Signed-off-by: Hui Peng <benquike@gmail.com>
Signed-off-by: Mathias Payer <mathias.payer@nebelwelt.net>
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/usb/hso.c |   18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

--- a/drivers/net/usb/hso.c
+++ b/drivers/net/usb/hso.c
@@ -2808,6 +2808,12 @@ static int hso_get_config_data(struct us
 		return -EIO;
 	}
 
+	/* check if we have a valid interface */
+	if (if_num > 16) {
+		kfree(config_data);
+		return -EINVAL;
+	}
+
 	switch (config_data[if_num]) {
 	case 0x0:
 		result = 0;
@@ -2878,10 +2884,18 @@ static int hso_probe(struct usb_interfac
 
 	/* Get the interface/port specification from either driver_info or from
 	 * the device itself */
-	if (id->driver_info)
+	if (id->driver_info) {
+		/* if_num is controlled by the device, driver_info is a 0 terminated
+		 * array. Make sure, the access is in bounds! */
+		for (i = 0; i <= if_num; ++i)
+			if (((u32 *)(id->driver_info))[i] == 0)
+				goto exit;
 		port_spec = ((u32 *)(id->driver_info))[if_num];
-	else
+	} else {
 		port_spec = hso_get_config_data(interface);
+		if (port_spec < 0)
+			goto exit;
+	}
 
 	/* Check if we need to switch to alt interfaces prior to port
 	 * configuration */


