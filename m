Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AC34C04E86
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:31:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4EDE2147A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:31:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4EDE2147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731522AbeHWMAV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:00:21 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:48010 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728915AbeHWMAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:00:20 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 64A3BC74;
        Thu, 23 Aug 2018 08:31:47 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Chan <michael.chan@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 163/217] bnxt_en: Always set output parameters in bnxt_get_max_rings().
Date:   Thu, 23 Aug 2018 09:54:36 +0200
Message-Id: <20180823075512.906496161@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823075505.090246914@linuxfoundation.org>
References: <20180823075505.090246914@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Chan <michael.chan@broadcom.com>

[ Upstream commit 78f058a4aa0f2280dc4d45d2c4a95728398ef857 ]

The current code returns -ENOMEM and does not bother to set the output
parameters to 0 when no rings are available.  Some callers, such as
bnxt_get_channels() will display garbage ring numbers when that happens.
Fix it by always setting the output parameters.

Fixes: 6e6c5a57fbe1 ("bnxt_en: Modify bnxt_get_max_rings() to support shared or non shared rings.")
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -7866,11 +7866,11 @@ int bnxt_get_max_rings(struct bnxt *bp,
 	int rx, tx, cp;
 
 	_bnxt_get_max_rings(bp, &rx, &tx, &cp);
+	*max_rx = rx;
+	*max_tx = tx;
 	if (!rx || !tx || !cp)
 		return -ENOMEM;
 
-	*max_rx = rx;
-	*max_tx = tx;
 	return bnxt_trim_rings(bp, max_rx, max_tx, cp, shared);
 }
 


