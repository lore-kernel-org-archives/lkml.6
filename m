Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89A92ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:19:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 460E92086D
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:19:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="N22X9GFe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 460E92086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730729AbeJYWwr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:52:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:34952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730693AbeJYWwp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:52:45 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B7482085B;
        Thu, 25 Oct 2018 14:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540477188;
        bh=lB9iFnmaCE1uRYbd11p/04pyejKHA5Tt0L7wpvCZphA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N22X9GFeBVXa1A2V+LBl2uC/q2tDvzwvBmVUorbz28W8uusN7a4qMe7NG+MIZRLkN
         a46sBdaAvs85rqQ6gP5wmwpUr1tIwBD59mmCHLe12TMiFvZMI9Jt1I3RFKcEEZwaR0
         Nj7GAIfKs2VYIYysqqKudtaCYt9bQ/B/7SPw/1M4=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jeremiah Mahler <jmmahler@gmail.com>,
        Johan Hovold <johan@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 3.18 36/98] usb: serial: handle -ENODEV quietly in generic_submit_read_urb
Date:   Thu, 25 Oct 2018 10:17:51 -0400
Message-Id: <20181025141853.214051-36-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141853.214051-1-sashal@kernel.org>
References: <20181025141853.214051-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeremiah Mahler <jmmahler@gmail.com>

[ Upstream commit 04f9c6e6d17584340fb6c8a9469a0e6df28876d2 ]

If a USB serial device (e.g. /dev/ttyUSB0) with an active program is
unplugged, an -ENODEV (19) error will be produced after it gives up
trying to resubmit a read.

  usb_serial_generic_submit_read_urb - usb_submit_urb failed: -19

Add -ENODEV as one of the permanent errors along with -EPERM that
usb_serial_generic_submit_read_urb() handles quietly without an error.

Signed-off-by: Jeremiah Mahler <jmmahler@gmail.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/serial/generic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/serial/generic.c b/drivers/usb/serial/generic.c
index c44b911937e8..54e170dd3dad 100644
--- a/drivers/usb/serial/generic.c
+++ b/drivers/usb/serial/generic.c
@@ -287,7 +287,7 @@ static int usb_serial_generic_submit_read_urb(struct usb_serial_port *port,
 
 	res = usb_submit_urb(port->read_urbs[index], mem_flags);
 	if (res) {
-		if (res != -EPERM) {
+		if (res != -EPERM && res != -ENODEV) {
 			dev_err(&port->dev,
 					"%s - usb_submit_urb failed: %d\n",
 					__func__, res);
-- 
2.17.1

