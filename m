Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CB43C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:06:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 251E120658
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:06:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="quR4fDo2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 251E120658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730561AbeJSCIz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 22:08:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:58144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729926AbeJSCIy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 22:08:54 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 31D3E2148D;
        Thu, 18 Oct 2018 18:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539886007;
        bh=10ZxONM01KTTzfcJEaLscfeJ4CrzGFLkir2HeyntUf0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=quR4fDo2udpA/6Sc1wHXgwwxaT56UBIHF0/g3amydHhChlGji9wW9s8rRxjFB8zAt
         It5KuI7m1YkmXv+XMmZkKA64tUhpBxKiuORrfP/jDeBy45/xD8hDg7rmX6t6FloFnn
         cY8Ug4tikKqhi6qZeQMOkdasMcK0DuSW/ly/dMVI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stephen Warren <swarren@nvidia.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 4.4 44/48] usb: gadget: serial: fix oops when data rxd after close
Date:   Thu, 18 Oct 2018 19:55:19 +0200
Message-Id: <20181018175430.254334473@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181018175427.133690306@linuxfoundation.org>
References: <20181018175427.133690306@linuxfoundation.org>
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

From: Stephen Warren <swarren@nvidia.com>

commit daa35bd95634a2a2d72d1049c93576a02711cb1a upstream.

When the gadget serial device has no associated TTY, do not pass any
received data into the TTY layer for processing; simply drop it instead.
This prevents the TTY layer from calling back into the gadget serial
driver, which will then crash in e.g. gs_write_room() due to lack of
gadget serial device to TTY association (i.e. a NULL pointer dereference).

Signed-off-by: Stephen Warren <swarren@nvidia.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/gadget/function/u_serial.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/usb/gadget/function/u_serial.c
+++ b/drivers/usb/gadget/function/u_serial.c
@@ -518,7 +518,7 @@ static void gs_rx_push(unsigned long _po
 		}
 
 		/* push data to (open) tty */
-		if (req->actual) {
+		if (req->actual && tty) {
 			char		*packet = req->buf;
 			unsigned	size = req->actual;
 			unsigned	n;


