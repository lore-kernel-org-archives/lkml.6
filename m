Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF010C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:30:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87E682084C
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:30:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZG4pOKEC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87E682084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388867AbeKLJUu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 04:20:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:43864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388655AbeKLIUX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:20:23 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F89F2154B;
        Sun, 11 Nov 2018 22:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975427;
        bh=WSEfls8cTvfZeygyqzyMxfgBChJegQS4yJmMzN47isc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZG4pOKECnPvW9fIUfvohcVeIEn+0AZaBCeNckQC2tuLwBDCBZ1oN5uPU+y/Jr66S4
         wBdDAktwmbgNAQl+GT0H4rGqNSLi+V8fRLuZ8E8bJ5CWmXWL1R4UPO1RQ4QLIe2aoI
         Ny05EtjqC6VFGQ4Ejg7eaMMDA5pT/c81hOfZyKxo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Shannon Nelson <shannon.nelson@oracle.com>,
        Andrew Bowers <andrewx.bowers@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.18 129/350] ixgbe: disallow IPsec Tx offload when in SR-IOV mode
Date:   Sun, 11 Nov 2018 14:19:53 -0800
Message-Id: <20181111221713.165777244@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221707.043394111@linuxfoundation.org>
References: <20181111221707.043394111@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shannon Nelson <shannon.nelson@oracle.com>

[ Upstream commit 47b6f50077e68bcd544f657526dad4bfdce7e87d ]

There seems to be a problem in the x540's internal switch wherein if SR-IOV
mode is enabled and an offloaded IPsec packet is sent to a local VF,
the packet is silently dropped.  This might never be a problem as it is
somewhat a corner case, but if someone happens to be using IPsec offload
from the PF to a VF that just happens to get migrated to the local box,
communication will mysteriously fail.

Not good.

A simple way to protect from this is to simply not allow any IPsec offloads
for outgoing packets when num_vfs != 0.  This doesn't help any offloads that
were created before SR-IOV was enabled, but we'll get to that later.

Signed-off-by: Shannon Nelson <shannon.nelson@oracle.com>
Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
@@ -676,6 +676,9 @@ static int ixgbe_ipsec_add_sa(struct xfr
 	} else {
 		struct tx_sa tsa;
 
+		if (adapter->num_vfs)
+			return -EOPNOTSUPP;
+
 		/* find the first unused index */
 		ret = ixgbe_ipsec_find_empty_idx(ipsec, false);
 		if (ret < 0) {


