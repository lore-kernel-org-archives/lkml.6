Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 395ABC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E808E20870
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:15:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xTYBVdy1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E808E20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729164AbeJYWsu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:48:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:57636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728220AbeJYWss (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:48:48 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 441CA20854;
        Thu, 25 Oct 2018 14:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540476951;
        bh=POHAzoGDiuPlkXKyz0qs7MSHsjkg1bLPPmFWnt1XtyE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xTYBVdy1rsj/o8hxeHODFBF4dsHEM9jVd2EjbA7SA6CJ4LzDhiINGgG//U0kuXbDG
         SjG0fj647hI8BuEbcBGJkvLBIorfBKj8jeSLEVPJHSTFj8MdzL4bh/W8tgPOSOguG9
         hKejk2hZo48oMQAWSBmNSskR1Q5NtI3IKyBZWdaU=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
        Enrico Mioso <mrkiko.rs@gmail.com>,
        Christian Panton <christian@panton.org>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 59/98] net: cdc_ncm: GetNtbFormat endian fix
Date:   Thu, 25 Oct 2018 10:13:44 -0400
Message-Id: <20181025141423.213774-59-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141423.213774-1-sashal@kernel.org>
References: <20181025141423.213774-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjørn Mork <bjorn@mork.no>

[ Upstream commit 6314dab4b8fb8493d810e175cb340376052c69b6 ]

The GetNtbFormat and SetNtbFormat requests operate on 16 bit little
endian values. We get away with ignoring this most of the time, because
we only care about USB_CDC_NCM_NTB16_FORMAT which is 0x0000.  This
fails for USB_CDC_NCM_NTB32_FORMAT.

Fix comparison between LE value from device and constant by converting
the constant to LE.

Reported-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Fixes: 2b02c20ce0c2 ("cdc_ncm: Set NTB format again after altsetting switch for Huawei devices")
Cc: Enrico Mioso <mrkiko.rs@gmail.com>
Cc: Christian Panton <christian@panton.org>
Signed-off-by: Bjørn Mork <bjorn@mork.no>
Acked-By: Enrico Mioso <mrkiko.rs@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/usb/cdc_ncm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/usb/cdc_ncm.c b/drivers/net/usb/cdc_ncm.c
index 3086cae62fdc..7b158674ceed 100644
--- a/drivers/net/usb/cdc_ncm.c
+++ b/drivers/net/usb/cdc_ncm.c
@@ -772,7 +772,7 @@ int cdc_ncm_bind_common(struct usbnet *dev, struct usb_interface *intf, u8 data_
 	int err;
 	u8 iface_no;
 	struct usb_cdc_parsed_header hdr;
-	u16 curr_ntb_format;
+	__le16 curr_ntb_format;
 
 	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
 	if (!ctx)
@@ -890,7 +890,7 @@ int cdc_ncm_bind_common(struct usbnet *dev, struct usb_interface *intf, u8 data_
 			goto error2;
 		}
 
-		if (curr_ntb_format == USB_CDC_NCM_NTB32_FORMAT) {
+		if (curr_ntb_format == cpu_to_le16(USB_CDC_NCM_NTB32_FORMAT)) {
 			dev_info(&intf->dev, "resetting NTB format to 16-bit");
 			err = usbnet_write_cmd(dev, USB_CDC_SET_NTB_FORMAT,
 					       USB_TYPE_CLASS | USB_DIR_OUT
-- 
2.17.1

