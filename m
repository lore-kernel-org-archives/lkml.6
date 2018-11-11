Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4552AC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:08:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CCD3214DB
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:08:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="fNBUZ851"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CCD3214DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731315AbeKLIRb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:17:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:60776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731139AbeKLIRa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:17:30 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35A062154B;
        Sun, 11 Nov 2018 22:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975254;
        bh=gUlUMFCbu2eyAZujayFadvHKRIZwW7hie+FtCsYDTzU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fNBUZ851dUBltl7j+RVky9NzNRpB2sa7lId6C5HT/oLuGi2BsHr/XkU0spJu2Bv6P
         ppLcWrQ3eqsDICeaPQGrSJ4Ci1VJt++qJtqWKoEQnWRSGp2VqpxabjsoR6cKEtU3nJ
         SDI8OnG4F8ZfSCg8wyaVTpNsSiI8M1L11BbD1lCM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sebastian Basierski <sebastianx.basierski@intel.com>,
        Andrew Bowers <andrewx.bowers@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 124/361] ixgbevf: VF2VF TCP RSS
Date:   Sun, 11 Nov 2018 14:17:51 -0800
Message-Id: <20181111221637.522413371@linuxfoundation.org>
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

From: Sebastian Basierski <sebastianx.basierski@intel.com>

[ Upstream commit 7fb94bd58dd6650a0158e68d414e185077d8b57a ]

While VF2VF with RSS communication, RSS Type were wrongly recognized
and RSS hash was not calculated as it should be. Packets was
distributed on various queues by accident.
This commit fixes that behaviour and causes proper RSS Type recognition.

Signed-off-by: Sebastian Basierski <sebastianx.basierski@intel.com>
Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -3849,6 +3849,10 @@ static void ixgbevf_tx_csum(struct ixgbe
 		skb_checksum_help(skb);
 		goto no_csum;
 	}
+
+	if (first->protocol == htons(ETH_P_IP))
+		type_tucmd |= IXGBE_ADVTXD_TUCMD_IPV4;
+
 	/* update TX checksum flag */
 	first->tx_flags |= IXGBE_TX_FLAGS_CSUM;
 	vlan_macip_lens = skb_checksum_start_offset(skb) -


