Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B47BC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:09:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 509DA20871
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:09:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="INe9R6J4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 509DA20871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731712AbeKLJ7f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 04:59:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:60278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731081AbeKLIR3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:17:29 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E17CE214E0;
        Sun, 11 Nov 2018 22:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975253;
        bh=CCzxzbPyMAAOKeeO4ZqUxRoWQx882FITFFQF+lJP94A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=INe9R6J40b1njn2N9NN+B6F2woLxJYNchMpHdzl2KLG2FfQOFlyJ5cQwKk48qkFdv
         YI6sWLfLosa9D5ewvT9YtKipcB3/5rAVax4MvOzhnPieLjc7cPRNf06GpI3C+wopfs
         bSDJ/zmOWDJLLhvnVcOuaxSumsGtbYRBgYiT+fKE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Shannon Nelson <shannon.nelson@oracle.com>,
        Andrew Bowers <andrewx.bowers@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 123/361] ixgbe: disallow IPsec Tx offload when in SR-IOV mode
Date:   Sun, 11 Nov 2018 14:17:50 -0800
Message-Id: <20181111221637.329600549@linuxfoundation.org>
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


