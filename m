Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FFAAC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 09:01:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEA6C208CC
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 09:01:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEA6C208CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388422AbeHWMaG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:30:06 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55634 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbeHWMaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:30:05 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 6AC49CA0;
        Thu, 23 Aug 2018 09:01:22 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Alexander Duyck <alexander.h.duyck@intel.com>,
        Shannon Nelson <shannon.nelson@oracle.com>,
        Andrew Bowers <andrewx.bowers@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 249/324] ixgbe: Be more careful when modifying MAC filters
Date:   Thu, 23 Aug 2018 09:55:15 +0200
Message-Id: <20180823075008.521718421@linuxfoundation.org>
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
@@ -1897,7 +1897,12 @@ s32 ixgbe_set_rar_generic(struct ixgbe_h
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
@@ -1929,8 +1934,13 @@ s32 ixgbe_clear_rar_generic(struct ixgbe
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


