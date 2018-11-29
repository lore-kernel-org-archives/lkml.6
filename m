Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B163C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:29:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 547422147C
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:29:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HLu8Zg96"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 547422147C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388318AbeK3Bej (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:34:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:35982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731995AbeK3Bei (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:34:38 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D628213A2;
        Thu, 29 Nov 2018 14:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501745;
        bh=iy/l3XAxRAjsruUfjy/yeQD7+NMW/Ox5IXayp7KMVjA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HLu8Zg969v+ttuiugmviJh6VvccaASb8noPDo3qyYwqG7zb124lxXiyE9OeJ2S7WD
         I46CaHNR4MllLh0T1A6c2D6ZHBsCTwwodi9G7emZDLBxD0BbANr1Qhy7qdchA02tb9
         JmDmxTqaHo3dEQKQFuOANfh+sbnUPa8SHyRdmgyo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Peter Chen <peter.chen@nxp.com>,
        Jack Pham <jackp@codeaurora.org>,
        Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [PATCH 4.19 009/110] xhci: handle port status events for removed USB3 hcd
Date:   Thu, 29 Nov 2018 15:11:40 +0100
Message-Id: <20181129135921.619729335@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129135921.231283053@linuxfoundation.org>
References: <20181129135921.231283053@linuxfoundation.org>
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

From: Mathias Nyman <mathias.nyman@linux.intel.com>

commit 1245374e9b8340fc255fd51b2015173a83050d03 upstream.

At xhci removal the USB3 hcd (shared_hcd) is removed before the primary
USB2 hcd. Interrupts for port status changes may still occur for USB3
ports after the shared_hcd is freed, causing  NULL pointer dereference.

Check if xhci->shared_hcd is still valid before handing USB3 port events

Cc: <stable@vger.kernel.org>
Reported-by: Peter Chen <peter.chen@nxp.com>
Tested-by: Jack Pham <jackp@codeaurora.org>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/host/xhci-ring.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -1552,6 +1552,13 @@ static void handle_port_status(struct xh
 		goto cleanup;
 	}
 
+	/* We might get interrupts after shared_hcd is removed */
+	if (port->rhub == &xhci->usb3_rhub && xhci->shared_hcd == NULL) {
+		xhci_dbg(xhci, "ignore port event for removed USB3 hcd\n");
+		bogus_port_status = true;
+		goto cleanup;
+	}
+
 	hcd = port->rhub->hcd;
 	bus_state = &xhci->bus_state[hcd_index(hcd)];
 	hcd_portnum = port->hcd_portnum;


