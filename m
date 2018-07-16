Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23965ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:43:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA33E206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:43:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA33E206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389100AbeGPIJk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 04:09:40 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:48030 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731619AbeGPIJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 04:09:39 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A6562C03;
        Mon, 16 Jul 2018 07:43:36 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH 4.9 15/32] USB: serial: mos7840: fix status-register error handling
Date:   Mon, 16 Jul 2018 09:36:23 +0200
Message-Id: <20180716073506.246221923@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180716073504.433996952@linuxfoundation.org>
References: <20180716073504.433996952@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Hovold <johan@kernel.org>

commit 794744abfffef8b1f3c0c8a4896177d6d13d653d upstream.

Add missing transfer-length sanity check to the status-register
completion handler to avoid leaking bits of uninitialised slab data to
user space.

Fixes: 3f5429746d91 ("USB: Moschip 7840 USB-Serial Driver")
Cc: stable <stable@vger.kernel.org>     # 2.6.19
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/serial/mos7840.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/usb/serial/mos7840.c
+++ b/drivers/usb/serial/mos7840.c
@@ -482,6 +482,9 @@ static void mos7840_control_callback(str
 	}
 
 	dev_dbg(dev, "%s urb buffer size is %d\n", __func__, urb->actual_length);
+	if (urb->actual_length < 1)
+		goto out;
+
 	dev_dbg(dev, "%s mos7840_port->MsrLsr is %d port %d\n", __func__,
 		mos7840_port->MsrLsr, mos7840_port->port_num);
 	data = urb->transfer_buffer;


