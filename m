Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B064AC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:45:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75D7C2087D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:45:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="z83dxgbD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75D7C2087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730943AbeJIB6T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 21:58:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:46370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730200AbeJIB6S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 21:58:18 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 39105214C2;
        Mon,  8 Oct 2018 18:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539024312;
        bh=lg6egftMDZkX1n/rSYS4HzLJUX9pmhr3mYFwxkGb/Jc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z83dxgbDBKM9xS1YANWiYXgsWpDmXiVlYX3P2ujIr5ZkAAw8GJmWxIG/1W1WAbsCk
         wrhjiHXkxjMUgOH99o3os//2ec1iSa5kTEYf1iGShrw7CSd/4nuZXC8AGiDOILc76d
         EV1ysD+bbtNRcWcT4X7kh7niRzzVHLKIKo9nUhTE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Song Liu <songliubraving@fb.com>,
        Andrew Bowers <andrewx.bowers@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 94/94] ixgbe: check return value of napi_complete_done()
Date:   Mon,  8 Oct 2018 20:32:15 +0200
Message-Id: <20181008175611.026362769@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181008175605.067676667@linuxfoundation.org>
References: <20181008175605.067676667@linuxfoundation.org>
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

From: Song Liu <songliubraving@fb.com>

commit 4233cfe6ec4683497d7318f55ce7617e97f2e610 upstream.

The NIC driver should only enable interrupts when napi_complete_done()
returns true. This patch adds the check for ixgbe.

Cc: stable@vger.kernel.org # 4.10+
Suggested-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Song Liu <songliubraving@fb.com>
Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |   12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -3108,11 +3108,13 @@ int ixgbe_poll(struct napi_struct *napi,
 		return budget;
 
 	/* all work done, exit the polling mode */
-	napi_complete_done(napi, work_done);
-	if (adapter->rx_itr_setting & 1)
-		ixgbe_set_itr(q_vector);
-	if (!test_bit(__IXGBE_DOWN, &adapter->state))
-		ixgbe_irq_enable_queues(adapter, BIT_ULL(q_vector->v_idx));
+	if (likely(napi_complete_done(napi, work_done))) {
+		if (adapter->rx_itr_setting & 1)
+			ixgbe_set_itr(q_vector);
+		if (!test_bit(__IXGBE_DOWN, &adapter->state))
+			ixgbe_irq_enable_queues(adapter,
+						BIT_ULL(q_vector->v_idx));
+	}
 
 	return min(work_done, budget - 1);
 }


