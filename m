Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDFD9C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:40:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A51CE21470
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:40:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="kleY54ZV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A51CE21470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730171AbeJKXIF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:08:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:38180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726647AbeJKXIE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:08:04 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB39C20652;
        Thu, 11 Oct 2018 15:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539272420;
        bh=ALUdNC7Lg/1BGduDUQ/yZRges564JctWFqHMmkUjJ0g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kleY54ZVxPiJMaeDhXnh8OG8tdNIIEmRPJVtJhQBnIus/PKBetNFM2BRVuMwlzg/O
         zyAFqzW5HICEZ7FtNnL/D0FE71aivPu8pnyCb2+scCASxXKjdlkjgHTA0I3ZBXX/Dv
         l2TwermhgNPJ31yVdUnKXw3hNCzyql2pQ6BebU44=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bo Chen <chenbo@pdx.edu>,
        Alexander Duyck <alexander.h.duyck@intel.com>,
        Aaron Brown <aaron.f.brown@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 066/120] e1000: check on netif_running() before calling e1000_up()
Date:   Thu, 11 Oct 2018 17:34:07 +0200
Message-Id: <20181011152552.528250553@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181011152549.500488630@linuxfoundation.org>
References: <20181011152549.500488630@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bo Chen <chenbo@pdx.edu>

[ Upstream commit cf1acec008f8d7761aa3fd7c4bca7e17b2d2512d ]

When the device is not up, the call to 'e1000_up()' from the error handling path
of 'e1000_set_ringparam()' causes a kernel oops with a null-pointer
dereference. The null-pointer dereference is triggered in function
'e1000_alloc_rx_buffers()' at line 'buffer_info = &rx_ring->buffer_info[i]'.

This bug was reported by COD, a tool for testing kernel module binaries I am
building. This bug was also detected by KFI from Dr. Kai Cong.

This patch fixes the bug by checking on 'netif_running()' before calling
'e1000_up()' in 'e1000_set_ringparam()'.

Signed-off-by: Bo Chen <chenbo@pdx.edu>
Acked-by: Alexander Duyck <alexander.h.duyck@intel.com>
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/intel/e1000/e1000_ethtool.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
@@ -666,7 +666,8 @@ err_setup_rx:
 err_alloc_rx:
 	kfree(txdr);
 err_alloc_tx:
-	e1000_up(adapter);
+	if (netif_running(adapter->netdev))
+		e1000_up(adapter);
 err_setup:
 	clear_bit(__E1000_RESETTING, &adapter->flags);
 	return err;


