Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11F93C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:10:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD293214D9
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:10:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="MRAmT++T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD293214D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388671AbeKVFpo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 00:45:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:40672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729195AbeKVFpo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 00:45:44 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C6AC2151B;
        Wed, 21 Nov 2018 19:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542827411;
        bh=Vzi33WsWqQZMBafQgO+hlLFgPyTJHP3c4DfrnkbCO9U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MRAmT++TUYI7Wy6hwXQGBkjlOYPzoOj0PmPD357I5+DXDEJoKFD6tmPSTNVzaF98I
         RWJXIIipOfSwP1y1E9+biX8mHQB5Se9H2WH4JbQ51rJMilF8zJGTuNbUMcGB+zMFT2
         ua++d0S3QskgNhtZAOJMnfJTdDKW3zfVy6eFQQqc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 02/59] ibmvnic: fix accelerated VLAN handling
Date:   Wed, 21 Nov 2018 20:06:17 +0100
Message-Id: <20181121183508.356241777@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181121183508.262873520@linuxfoundation.org>
References: <20181121183508.262873520@linuxfoundation.org>
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

From: "Michał Mirosław" <mirq-linux@rere.qmqm.pl>

[ Upstream commit e84b47941e15e6666afb8ee8b21d1c3fc1a013af ]

Don't request tag insertion when it isn't present in outgoing skb.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/ibm/ibmvnic.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -786,7 +786,7 @@ static int ibmvnic_xmit(struct sk_buff *
 	tx_crq.v1.sge_len = cpu_to_be32(skb->len);
 	tx_crq.v1.ioba = cpu_to_be64(data_dma_addr);
 
-	if (adapter->vlan_header_insertion) {
+	if (adapter->vlan_header_insertion && skb_vlan_tag_present(skb)) {
 		tx_crq.v1.flags2 |= IBMVNIC_TX_VLAN_INSERT;
 		tx_crq.v1.vlan_id = cpu_to_be16(skb->vlan_tci);
 	}


