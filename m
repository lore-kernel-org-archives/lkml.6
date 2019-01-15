Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE99EC43612
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:38:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A29E72054F
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547570293;
	bh=lAdmIhEy4hgehvb4+trendWJjkwfNDnJApwZ+lvDSAc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VG+MxCSUF4+F2NL57nmECGwqy4WjQg6CqRpE5jlOpByiJBaNKVl4Ho/cnOTc+8uW9
	 NqDvxhQ1KZkDOoMVv0hkwABzLQvDXmTy0F2qjDkFjVckcl2ghDT4JzBPaRDM4ZeoPn
	 s2NDul3pvyDndjUVJOzUjNxDvS4OlXlss9enMAQo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732030AbfAOQiK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:38:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:53812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730038AbfAOQiD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 11:38:03 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A2192054F;
        Tue, 15 Jan 2019 16:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547570283;
        bh=lAdmIhEy4hgehvb4+trendWJjkwfNDnJApwZ+lvDSAc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Awtgj919KUMcg95XB9Us82bOcpzz/p493ZV77FYvlPivvnlejhZtxcFY6sGFQljMg
         ykzL+fMX1uQgdZSx63mg3LgG25H+SCZNyKQl9g+bx7q7CnNZ6J00l/3eVWCgMBUmMb
         3mRAvp0HBJh00tkcGIIpu6QK2F1u2Mz/vR9lE8kQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniele Palmas <dnlplm@gmail.com>
Subject: [PATCH 4.4 35/51] usb: cdc-acm: send ZLP for Telit 3G Intel based modems
Date:   Tue, 15 Jan 2019 17:35:31 +0100
Message-Id: <20190115154851.947316285@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190115154846.928796000@linuxfoundation.org>
References: <20190115154846.928796000@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1885,6 +1885,13 @@ static const struct usb_device_id acm_id
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


