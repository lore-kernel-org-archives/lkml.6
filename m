Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EAC3C43610
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:24:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D83572145D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:24:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wo8gQuYG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D83572145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732762AbeK3BaU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:30:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:57280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728616AbeK3BaT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:30:19 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 930002145D;
        Thu, 29 Nov 2018 14:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501487;
        bh=15ZDFBeCbi4PNIHf+9wWO3hJKWfkyB7RXha/rb/wyis=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wo8gQuYGS4R6gchep5OswLWAkO3RWvkMqMgPuPJ2BPedcaOJjx/UPp20jpKJLr7TH
         vBeNPu/ljehSWSu2Su3MqzvFwpMYi/6+kS3z0qWTLgnLPeZ+kB3WD4natPEX7Z5m1X
         ny5YrKUlEfKYJHtDm7A95N/vfK1oeQgyCGfpqpPQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sandeep Singh <sandeep.singh@amd.com>,
        Nehal Shah <Nehal-bakulchandra.Shah@amd.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [PATCH 4.14 010/100] xhci: Add check for invalid byte size error when UAS devices are connected.
Date:   Thu, 29 Nov 2018 15:11:40 +0100
Message-Id: <20181129140059.851469378@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129140058.768942700@linuxfoundation.org>
References: <20181129140058.768942700@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sandeep Singh <sandeep.singh@amd.com>

commit d9193efba84fe4c4aa22a569fade5e6ca971f8af upstream.

Observed "TRB completion code (27)" error which corresponds to Stopped -
Length Invalid error(xhci spec section 4.17.4) while connecting USB to
SATA bridge.

Looks like this case was not considered when the following patch[1] was
committed. Hence adding this new check which can prevent
the invalid byte size error.

[1] ade2e3a xhci: handle transfer events without TRB pointer

Cc: <stable@vger.kernel.org>
Signed-off-by: Sandeep Singh <sandeep.singh@amd.com>
cc: Nehal Shah <Nehal-bakulchandra.Shah@amd.com>
cc: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/host/xhci-ring.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -2335,6 +2335,7 @@ static int handle_tx_event(struct xhci_h
 			goto cleanup;
 		case COMP_RING_UNDERRUN:
 		case COMP_RING_OVERRUN:
+		case COMP_STOPPED_LENGTH_INVALID:
 			goto cleanup;
 		default:
 			xhci_err(xhci, "ERROR Transfer event for unknown stream ring slot %u ep %u\n",


