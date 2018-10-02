Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15B40C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:57:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEB902064A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:57:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEB902064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730897AbeJBUOh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:14:37 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34006 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730838AbeJBUOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:14:33 -0400
Received: from localhost (24-104-73-23-ip-static.hfc.comcastbusiness.net [24.104.73.23])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 318995AA;
        Tue,  2 Oct 2018 13:31:11 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bo Chen <chenbo@pdx.edu>,
        Alexander Duyck <alexander.h.duyck@intel.com>,
        Aaron Brown <aaron.f.brown@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 205/228] e1000: ensure to free old tx/rx rings in set_ringparam()
Date:   Tue,  2 Oct 2018 06:25:02 -0700
Message-Id: <20181002132511.673729560@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181002132459.032960735@linuxfoundation.org>
References: <20181002132459.032960735@linuxfoundation.org>
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

From: Bo Chen <chenbo@pdx.edu>

[ Upstream commit ee400a3f1bfe7004a3e14b81c38ccc5583c26295 ]

In 'e1000_set_ringparam()', the tx_ring and rx_ring are updated with new value
and the old tx/rx rings are freed only when the device is up. There are resource
leaks on old tx/rx rings when the device is not up. This bug is reported by COD,
a tool for testing kernel module binaries I am building.

This patch fixes the bug by always calling 'kfree()' on old tx/rx rings in
'e1000_set_ringparam()'.

Signed-off-by: Bo Chen <chenbo@pdx.edu>
Reviewed-by: Alexander Duyck <alexander.h.duyck@intel.com>
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/intel/e1000/e1000_ethtool.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
@@ -624,14 +624,14 @@ static int e1000_set_ringparam(struct ne
 		adapter->tx_ring = tx_old;
 		e1000_free_all_rx_resources(adapter);
 		e1000_free_all_tx_resources(adapter);
-		kfree(tx_old);
-		kfree(rx_old);
 		adapter->rx_ring = rxdr;
 		adapter->tx_ring = txdr;
 		err = e1000_up(adapter);
 		if (err)
 			goto err_setup;
 	}
+	kfree(tx_old);
+	kfree(rx_old);
 
 	clear_bit(__E1000_RESETTING, &adapter->flags);
 	return 0;


