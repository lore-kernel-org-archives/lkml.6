Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F31DC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 07:59:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C926C21473
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 07:59:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C926C21473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728516AbeHWL2A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 07:28:00 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42050 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726836AbeHWL17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 07:27:59 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D0B489D2;
        Thu, 23 Aug 2018 07:59:35 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Alexander Duyck <alexander.h.duyck@intel.com>,
        Shannon Nelson <shannon.nelson@oracle.com>,
        Andrew Bowers <andrewx.bowers@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 55/79] ixgbe: Be more careful when modifying MAC filters
Date:   Thu, 23 Aug 2018 09:53:31 +0200
Message-Id: <20180823074922.739954065@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823074918.641878835@linuxfoundation.org>
References: <20180823074918.641878835@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexander Duyck <alexander.h.duyck@intel.com>

[ Upstream commit d14c780c11fbc10f66c43e7b64eefe87ca442bd3 ]

This change makes it so that we are much more explicit about the ordering
of updates to the receive address register (RAR) table. Prior to this patch
I believe we may have been updating the table while entries were still
active, or possibly allowing for reordering of things since we weren't
explicitly flushing writes to either the lower or upper portion of the
register prior to accessing the other half.

Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
Reviewed-by: Shannon Nelson <shannon.nelson@oracle.com>
Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_common.c |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
@@ -1814,7 +1814,12 @@ s32 ixgbe_set_rar_generic(struct ixgbe_h
 	if (enable_addr != 0)
 		rar_high |= IXGBE_RAH_AV;
 
+	/* Record lower 32 bits of MAC address and then make
+	 * sure that write is flushed to hardware before writing
+	 * the upper 16 bits and setting the valid bit.
+	 */
 	IXGBE_WRITE_REG(hw, IXGBE_RAL(index), rar_low);
+	IXGBE_WRITE_FLUSH(hw);
 	IXGBE_WRITE_REG(hw, IXGBE_RAH(index), rar_high);
 
 	return 0;
@@ -1846,8 +1851,13 @@ s32 ixgbe_clear_rar_generic(struct ixgbe
 	rar_high = IXGBE_READ_REG(hw, IXGBE_RAH(index));
 	rar_high &= ~(0x0000FFFF | IXGBE_RAH_AV);
 
-	IXGBE_WRITE_REG(hw, IXGBE_RAL(index), 0);
+	/* Clear the address valid bit and upper 16 bits of the address
+	 * before clearing the lower bits. This way we aren't updating
+	 * a live filter.
+	 */
 	IXGBE_WRITE_REG(hw, IXGBE_RAH(index), rar_high);
+	IXGBE_WRITE_FLUSH(hw);
+	IXGBE_WRITE_REG(hw, IXGBE_RAL(index), 0);
 
 	/* clear VMDq pool/queue selection for this RAR */
 	hw->mac.ops.clear_vmdq(hw, index, IXGBE_CLEAR_VMDQ_ALL);


