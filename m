Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A3DFC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:42:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E8582083A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:42:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E8582083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732580AbeHWMKk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:10:40 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49962 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729381AbeHWMKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:10:40 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C89167F6;
        Thu, 23 Aug 2018 08:42:03 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Minas Harutyunyan <hminas@synopsys.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 057/324] dwc2: gadget: Fix ISOC IN DDMA PID bitfield value calculation
Date:   Thu, 23 Aug 2018 09:52:03 +0200
Message-Id: <20180823074958.690820408@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823074955.885811006@linuxfoundation.org>
References: <20180823074955.885811006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>

[ Upstream commit 1d8e5c00275825fc42aaa5597dab1d0b5b26bb64 ]

PID bitfield in descriptor should be set based on particular request
length, not based on EP's mc value. PID value can't be set to 0 even
request length is 0.

Signed-off-by: Minas Harutyunyan <hminas@synopsys.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/dwc2/gadget.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/drivers/usb/dwc2/gadget.c
+++ b/drivers/usb/dwc2/gadget.c
@@ -808,6 +808,7 @@ static int dwc2_gadget_fill_isoc_desc(st
 	u32 index;
 	u32 maxsize = 0;
 	u32 mask = 0;
+	u8 pid = 0;
 
 	maxsize = dwc2_gadget_get_desc_params(hs_ep, &mask);
 	if (len > maxsize) {
@@ -853,7 +854,11 @@ static int dwc2_gadget_fill_isoc_desc(st
 			 ((len << DEV_DMA_NBYTES_SHIFT) & mask));
 
 	if (hs_ep->dir_in) {
-		desc->status |= ((hs_ep->mc << DEV_DMA_ISOC_PID_SHIFT) &
+		if (len)
+			pid = DIV_ROUND_UP(len, hs_ep->ep.maxpacket);
+		else
+			pid = 1;
+		desc->status |= ((pid << DEV_DMA_ISOC_PID_SHIFT) &
 				 DEV_DMA_ISOC_PID_MASK) |
 				((len % hs_ep->ep.maxpacket) ?
 				 DEV_DMA_SHORT : 0) |


