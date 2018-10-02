Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BB75C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:48:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CFFA2064D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:48:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CFFA2064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732302AbeJBUcF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:32:05 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35262 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731002AbeJBURm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:17:42 -0400
Received: from localhost (24-104-73-23-ip-static.hfc.comcastbusiness.net [24.104.73.23])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A7B37BF0;
        Tue,  2 Oct 2018 13:34:18 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Lukasz Odzioba <lukasz.odzioba@intel.com>,
        "Michael J. Ruhl" <michael.j.ruhl@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 4.14 107/137] IB/hfi1: Fix context recovery when PBC has an UnsupportedVL
Date:   Tue,  2 Oct 2018 06:25:08 -0700
Message-Id: <20181002132505.986579553@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181002132458.446916963@linuxfoundation.org>
References: <20181002132458.446916963@linuxfoundation.org>
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

From: Michael J. Ruhl <michael.j.ruhl@intel.com>

commit d623500b3c4efd8d4e945ac9003c6b87b469a9ab upstream.

If a packet stream uses an UnsupportedVL (virtual lane), the send
engine will not send the packet, and it will not indicate that an
error has occurred.  This will cause the packet stream to block.

HFI has 8 virtual lanes available for packet streams.  Each lane can
be enabled or disabled using the UnsupportedVL mask.  If a lane is
disabled, adding a packet to the send context must be disallowed.

The current mask for determining unsupported VLs defaults to 0 (allow
all).  This is incorrect.  Only the VLs that are defined should be
allowed.

Determine which VLs are disabled (mtu == 0), and set the appropriate
unsupported bit in the mask.  The correct mask will allow the send
engine to error on the invalid VL, and error recovery will work
correctly.

Cc: <stable@vger.kernel.org> # 4.9.x+
Fixes: 7724105686e7 ("IB/hfi1: add driver files")
Reviewed-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Reviewed-by: Lukasz Odzioba <lukasz.odzioba@intel.com>
Signed-off-by: Michael J. Ruhl <michael.j.ruhl@intel.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/hw/hfi1/pio.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

--- a/drivers/infiniband/hw/hfi1/pio.c
+++ b/drivers/infiniband/hw/hfi1/pio.c
@@ -86,6 +86,7 @@ void pio_send_control(struct hfi1_devdat
 	unsigned long flags;
 	int write = 1;	/* write sendctrl back */
 	int flush = 0;	/* re-read sendctrl to make sure it is flushed */
+	int i;
 
 	spin_lock_irqsave(&dd->sendctrl_lock, flags);
 
@@ -95,9 +96,13 @@ void pio_send_control(struct hfi1_devdat
 		reg |= SEND_CTRL_SEND_ENABLE_SMASK;
 	/* Fall through */
 	case PSC_DATA_VL_ENABLE:
+		mask = 0;
+		for (i = 0; i < ARRAY_SIZE(dd->vld); i++)
+			if (!dd->vld[i].mtu)
+				mask |= BIT_ULL(i);
 		/* Disallow sending on VLs not enabled */
-		mask = (((~0ull) << num_vls) & SEND_CTRL_UNSUPPORTED_VL_MASK) <<
-				SEND_CTRL_UNSUPPORTED_VL_SHIFT;
+		mask = (mask & SEND_CTRL_UNSUPPORTED_VL_MASK) <<
+			SEND_CTRL_UNSUPPORTED_VL_SHIFT;
 		reg = (reg & ~SEND_CTRL_UNSUPPORTED_VL_SMASK) | mask;
 		break;
 	case PSC_GLOBAL_DISABLE:


