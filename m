Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D26BC0044C
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:33:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1970521780
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:33:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="KZS186eo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1970521780
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404499AbeKLIXw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:23:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:58408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391153AbeKLIXv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:23:51 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D225321707;
        Sun, 11 Nov 2018 22:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975634;
        bh=iGPnA6pxcK/b1SyVKQVv9UKIW1XKokgMAQKlwSzJyYs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KZS186eol0EVvsFQQLMk3wEFF+K4LFeaLnHTf6tsiN9wN5SckDN+wzeWPL1QhVlZE
         LUVsQ2KR0Cj8m65hk4Z9naVxqlMe/LNtvn2wSMkk9kqYYYTv03qSuJfDdnpENQi9TM
         UzVCLK4wrKuUvxqbcYprIyvVqHFl4uWgGDJJEh1A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sebastian Basierski <sebastianx.basierski@intel.com>,
        Andrew Bowers <andrewx.bowers@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 050/141] ixgbevf: VF2VF TCP RSS
Date:   Sun, 11 Nov 2018 14:25:09 -0800
Message-Id: <20181111221634.300816970@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221627.853046496@linuxfoundation.org>
References: <20181111221627.853046496@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -3419,6 +3419,10 @@ static void ixgbevf_tx_csum(struct ixgbe
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


