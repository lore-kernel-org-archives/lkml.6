Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 833E6C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:15:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35892208D5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:15:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35892208D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934109AbeFRIPu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:15:50 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52878 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933970AbeFRIPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:15:48 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 6DFC6C50;
        Mon, 18 Jun 2018 08:15:47 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Dirk van der Merwe <dirk.vandermerwe@netronome.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 009/279] nfp: ignore signals when communicating with management FW
Date:   Mon, 18 Jun 2018 10:09:54 +0200
Message-Id: <20180618080609.220814929@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618080608.851973560@linuxfoundation.org>
References: <20180618080608.851973560@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jakub Kicinski <jakub.kicinski@netronome.com>

[ Upstream commit 5496295aefe86995e41398b0f76de601308fc3f5 ]

We currently allow signals to interrupt the wait for management FW
commands.  Exiting the wait should not cause trouble, the FW will
just finish executing the command in the background and new commands
will wait for the old one to finish.

However, this may not be what users expect (Ctrl-C not actually stopping
the command).  Moreover some systems routinely request link information
with signals pending (Ubuntu 14.04 runs a landscape-sysinfo python tool
from MOTD) worrying users with errors like these:

nfp 0000:04:00.0: nfp_nsp: Error -512 waiting for code 0x0007 to start
nfp 0000:04:00.0: nfp: reading port table failed -512

Make the wait for management FW responses non-interruptible.

Fixes: 1a64821c6af7 ("nfp: add support for service processor access")
Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Reviewed-by: Dirk van der Merwe <dirk.vandermerwe@netronome.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/netronome/nfp/nfpcore/nfp_nsp.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_nsp.c
+++ b/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_nsp.c
@@ -281,8 +281,7 @@ nfp_nsp_wait_reg(struct nfp_cpp *cpp, u6
 		if ((*reg & mask) == val)
 			return 0;
 
-		if (msleep_interruptible(25))
-			return -ERESTARTSYS;
+		msleep(25);
 
 		if (time_after(start_time, wait_until))
 			return -ETIMEDOUT;


