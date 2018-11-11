Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45D12C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E46420839
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:59:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="viCcYDHl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E46420839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732665AbeKLJtq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 04:49:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:35400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732381AbeKLISF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:18:05 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F85A223C8;
        Sun, 11 Nov 2018 22:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975289;
        bh=v2c5qYNGsoZDpz4ZSLdHDz7pFmZbw1Enhyf5EpmDgqU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=viCcYDHlsujbwZWoSoC0sDBA/eF3GO4Vav3tLYpVS9QbgWquIRnOkijIoJ7euxyh4
         wZaJA811zQWSxNabiXnlItoHXd317X7ngXs/Xz4tQTcDHirSKUZjgZWg0kEb6ZRd1N
         GS7YlHI2OA4qR+jmQctk8Qt1r3p5ophnjYHovs/I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>
Subject: [PATCH 4.19 210/361] usb: gadget: udc: renesas_usb3: Fix b-device mode for "workaround"
Date:   Sun, 11 Nov 2018 14:19:17 -0800
Message-Id: <20181111221649.570219508@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221619.915519183@linuxfoundation.org>
References: <20181111221619.915519183@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

commit afc92514a34c7414b28047b1205a6b709103c699 upstream.

If the "workaround_for_vbus" is true, the driver will not call
usb_disconnect(). So, since the controller keeps some registers'
value, the driver doesn't re-enumarate suitable speed after
the b-device mode is disabled. To fix the issue, this patch
adds usb_disconnect() calling in renesas_usb3_b_device_write()
if workaround_for_vbus is true.

Fixes: 43ba968b00ea ("usb: gadget: udc: renesas_usb3: add debugfs to set the b-device mode")
Cc: <stable@vger.kernel.org> # v4.14+
Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/gadget/udc/renesas_usb3.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/usb/gadget/udc/renesas_usb3.c
+++ b/drivers/usb/gadget/udc/renesas_usb3.c
@@ -2437,6 +2437,9 @@ static ssize_t renesas_usb3_b_device_wri
 	else
 		usb3->forced_b_device = false;
 
+	if (usb3->workaround_for_vbus)
+		usb3_disconnect(usb3);
+
 	/* Let this driver call usb3_connect() anyway */
 	usb3_check_id(usb3);
 


