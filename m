Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF1F6C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:41:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C003C2054F
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547570495;
	bh=kzGylFrcEZVYht18mhXNED4vPBlEhmmT5LHy0RkNvcc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BYi756UOrcdPilzVUZ30vapDmFti6Mjyvh2oMapQE5lEXxaXGefd46/SmQVWFB4mk
	 p8la8PFaY80Wv7b6Pd2V7NRJ98nVHBNH8jUboANx6jTUtpVddlXCXIAVI8rX62xwFn
	 OZwEPObeFU0rnOwcFLnPnwQtVWuxIOOUtAcWYAvA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732820AbfAOQle (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:41:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:58278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732807AbfAOQlb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 11:41:31 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5FAFB20675;
        Tue, 15 Jan 2019 16:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547570490;
        bh=kzGylFrcEZVYht18mhXNED4vPBlEhmmT5LHy0RkNvcc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S/hepAQUMgjIvzF79NuR0AXxew/f9yJDiJ7gub15vVDGV9QpUQmIv6Bej+YSd0f+0
         K47X43S1nnVSfEr3zapuJIyLAgEXut2L8P3kAhYwWbsVu+t+4EKKPqpJ8zBHT0g6c6
         qSepnoFbN5dELnGQHYRDQ6coXAHzH5Ko7/z0NZUA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniele Palmas <dnlplm@gmail.com>
Subject: [PATCH 4.19 14/50] usb: cdc-acm: send ZLP for Telit 3G Intel based modems
Date:   Tue, 15 Jan 2019 17:35:50 +0100
Message-Id: <20190115154910.778031607@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190115154909.933241945@linuxfoundation.org>
References: <20190115154909.933241945@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniele Palmas <dnlplm@gmail.com>

commit 34aabf918717dd14e05051896aaecd3b16b53d95 upstream.

Telit 3G Intel based modems require zero packet to be sent if
out data size is equal to the endpoint max packet size.

Signed-off-by: Daniele Palmas <dnlplm@gmail.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/class/cdc-acm.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/drivers/usb/class/cdc-acm.c
+++ b/drivers/usb/class/cdc-acm.c
@@ -1880,6 +1880,13 @@ static const struct usb_device_id acm_id
 	.driver_info = IGNORE_DEVICE,
 	},
 
+	{ USB_DEVICE(0x1bc7, 0x0021), /* Telit 3G ACM only composition */
+	.driver_info = SEND_ZERO_PACKET,
+	},
+	{ USB_DEVICE(0x1bc7, 0x0023), /* Telit 3G ACM + ECM composition */
+	.driver_info = SEND_ZERO_PACKET,
+	},
+
 	/* control interfaces without any protocol set */
 	{ USB_INTERFACE_INFO(USB_CLASS_COMM, USB_CDC_SUBCLASS_ACM,
 		USB_CDC_PROTO_NONE) },


