Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A090CC433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 16:50:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64AFA20867
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 16:50:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64AFA20867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728021AbeICVLt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:11:49 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36200 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727570AbeICVLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:11:48 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B8719CF5;
        Mon,  3 Sep 2018 16:50:51 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 21/56] net: axienet: Fix double deregister of mdio
Date:   Mon,  3 Sep 2018 18:49:11 +0200
Message-Id: <20180903164925.146907768@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180903164924.078355019@linuxfoundation.org>
References: <20180903164924.078355019@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>

[ Upstream commit 03bc7cab7d7218088412a75e141696a89059ab00 ]

If the registration fails then mdio_unregister is called.
However at unbind the unregister ia attempted again resulting
in the below crash

[   73.544038] kernel BUG at drivers/net/phy/mdio_bus.c:415!
[   73.549362] Internal error: Oops - BUG: 0 [#1] SMP
[   73.554127] Modules linked in:
[   73.557168] CPU: 0 PID: 2249 Comm: sh Not tainted 4.14.0 #183
[   73.562895] Hardware name: xlnx,zynqmp (DT)
[   73.567062] task: ffffffc879e41180 task.stack: ffffff800cbe0000
[   73.572973] PC is at mdiobus_unregister+0x84/0x88
[   73.577656] LR is at axienet_mdio_teardown+0x18/0x30
[   73.582601] pc : [<ffffff80085fa4cc>] lr : [<ffffff8008616858>]
pstate: 20000145
[   73.589981] sp : ffffff800cbe3c30
[   73.593277] x29: ffffff800cbe3c30 x28: ffffffc879e41180
[   73.598573] x27: ffffff8008a21000 x26: 0000000000000040
[   73.603868] x25: 0000000000000124 x24: ffffffc879efe920
[   73.609164] x23: 0000000000000060 x22: ffffffc879e02000
[   73.614459] x21: ffffffc879e02800 x20: ffffffc87b0b8870
[   73.619754] x19: ffffffc879e02800 x18: 000000000000025d
[   73.625050] x17: 0000007f9a719ad0 x16: ffffff8008195bd8
[   73.630345] x15: 0000007f9a6b3d00 x14: 0000000000000010
[   73.635640] x13: 74656e7265687465 x12: 0000000000000030
[   73.640935] x11: 0000000000000030 x10: 0101010101010101
[   73.646231] x9 : 241f394f42533300 x8 : ffffffc8799f6e98
[   73.651526] x7 : ffffffc8799f6f18 x6 : ffffffc87b0ba318
[   73.656822] x5 : ffffffc87b0ba498 x4 : 0000000000000000
[   73.662117] x3 : 0000000000000000 x2 : 0000000000000008
[   73.667412] x1 : 0000000000000004 x0 : ffffffc8799f4000
[   73.672708] Process sh (pid: 2249, stack limit = 0xffffff800cbe0000)

Fix the same by making the bus NULL on unregister.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/xilinx/xilinx_axienet_mdio.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/net/ethernet/xilinx/xilinx_axienet_mdio.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_mdio.c
@@ -219,6 +219,7 @@ issue:
 	ret = of_mdiobus_register(bus, np1);
 	if (ret) {
 		mdiobus_free(bus);
+		lp->mii_bus = NULL;
 		return ret;
 	}
 	return 0;


