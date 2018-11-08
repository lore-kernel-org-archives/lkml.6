Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 558A6C0044B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:34:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 112FA20844
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:34:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="2Kn5m1zx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 112FA20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729415AbeKIILk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 03:11:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:55158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730169AbeKIHhS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:37:18 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7FE462146D;
        Thu,  8 Nov 2018 21:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714390;
        bh=fDAXGmdFOH0dYlE/vo6yrtZNBCOCKEnKPvD8wuoxm64=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2Kn5m1zx11ucvXkjNCqdPJt4VcRcBDAG6419LyNhAHOybPZhzNDdtQ5uN3hKlUPcK
         0ee+IQPI7f1qx9Lki2T5pTvRVQxzgbenUXgjx7iU7sDHEJLCfsG40dbfcLuRGiQo+6
         G4dqU7q49RfKvLSbxs59Hx+iosrvj8ao/lXgbxYA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, William Dauchy <william@gandi.net>,
        Phil Schmitt <phillip.j.schmitt@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 054/114] ixgbevf: Fix handling of NAPI budget when multiple queues are enabled per vector
Date:   Thu,  8 Nov 2018 13:51:09 -0800
Message-Id: <20181108215106.020910985@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215059.051093652@linuxfoundation.org>
References: <20181108215059.051093652@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit d0f71afffa1c3d5a36a4a278f1dbbd2643176dc3 ]

This is the same patch as for ixgbe but applied differently according to
busy polling.  See commit 5d6002b7b822c74 ("ixgbe: Fix handling of NAPI
budget when multiple queues are enabled per vector")

Signed-off-by: William Dauchy <william@gandi.net>
Tested-by: Phil Schmitt <phillip.j.schmitt@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
index 50bbad37d640..723bda33472a 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -1014,6 +1014,8 @@ static int ixgbevf_poll(struct napi_struct *napi, int budget)
 	ixgbevf_for_each_ring(ring, q_vector->tx)
 		clean_complete &= ixgbevf_clean_tx_irq(q_vector, ring);
 
+	if (budget <= 0)
+		return budget;
 #ifdef CONFIG_NET_RX_BUSY_POLL
 	if (!ixgbevf_qv_lock_napi(q_vector))
 		return budget;
-- 
2.17.1



