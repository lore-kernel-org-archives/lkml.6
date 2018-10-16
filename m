Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6851C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:12:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B07252098A
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:12:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="D9B8GO67"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B07252098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728654AbeJQBEJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:04:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:46614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727734AbeJQBEI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:04:08 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C2622098A;
        Tue, 16 Oct 2018 17:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539709966;
        bh=cPsRsW+dIDFldRiruiDHsoQiooYM267YHZAYbI8Pcto=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D9B8GO678k61jnHH063q4FCx8hcx8FANna0D8dXMos3KIF23UqSuNTKLcyBe9m6EZ
         1x4XUbk7tr3wQKCA0pD3cBCZuR53puTlB0svsxSMlWpweU6iP5z9oan8lh9FddOCER
         WxZwKWIDosBy2zCWP+SlPBpXx/lkXZPFJfhir70A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, John Sperbeck <jsperbeck@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Mahesh Bandewar <maheshb@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.18 040/135] bonding: fix warning message
Date:   Tue, 16 Oct 2018 19:04:30 +0200
Message-Id: <20181016170517.633265348@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016170515.447235311@linuxfoundation.org>
References: <20181016170515.447235311@linuxfoundation.org>
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

From: Mahesh Bandewar <maheshb@google.com>

[ Upstream commit 0f3b914c9cfcd7bbedd445dc4ac5dd999fa213c2 ]

RX queue config for bonding master could be different from its slave
device(s). With the commit 6a9e461f6fe4 ("bonding: pass link-local
packets to bonding master also."), the packet is reinjected into stack
with skb->dev as bonding master. This potentially triggers the
message:

   "bondX received packet on queue Y, but number of RX queues is Z"

whenever the queue that packet is received on is higher than the
numrxqueues on bonding master (Y > Z).

Fixes: 6a9e461f6fe4 ("bonding: pass link-local packets to bonding master also.")
Reported-by: John Sperbeck <jsperbeck@google.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Mahesh Bandewar <maheshb@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/bonding/bond_main.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -1194,6 +1194,7 @@ static rx_handler_result_t bond_handle_f
 
 		if (nskb) {
 			nskb->dev = bond->dev;
+			nskb->queue_mapping = 0;
 			netif_rx(nskb);
 		}
 		return RX_HANDLER_PASS;


