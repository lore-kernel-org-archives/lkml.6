Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C416C5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:12:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 165B22089E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:12:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="L+5VxWS/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 165B22089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728667AbeJQBEL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:04:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:46670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727734AbeJQBEL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:04:11 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2ED7720866;
        Tue, 16 Oct 2018 17:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539709968;
        bh=4sP+66H4p21i5G4qg8cESRE/ri5v0a7QCqUxTQl5b1c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L+5VxWS/sPSLTig62hPwQznehdlOrH3xQg77/UD8AKEQC6aV4KZQEs+WMlhpthRis
         hNTIyPe4VfqXwX4dNjxawfn9wcz0pOnJUscWsBAFDuTHg4+klIwOSDqqVz1AwJjWxA
         2dQNPs5LIaxSyjlFJArZfoVq95ul4etnMWmIWXSE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.18 058/135] net: mscc: fix the frame extraction into the skb
Date:   Tue, 16 Oct 2018 19:04:48 +0200
Message-Id: <20181016170518.572328578@linuxfoundation.org>
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

From: Antoine Tenart <antoine.tenart@bootlin.com>

[ Upstream commit 652ef42c134da1bbb03bd4c9b4291dfaf8d7febb ]

When extracting frames from the Ocelot switch, the frame check sequence
(FCS) is present at the end of the data extracted. The FCS was put into
the sk buffer which introduced some issues (as length related ones), as
the FCS shouldn't be part of an Rx sk buffer.

This patch fixes the Ocelot switch extraction behaviour by discarding
the FCS.

Fixes: a556c76adc05 ("net: mscc: Add initial Ocelot switch support")
Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mscc/ocelot_board.c |   12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

--- a/drivers/net/ethernet/mscc/ocelot_board.c
+++ b/drivers/net/ethernet/mscc/ocelot_board.c
@@ -91,7 +91,7 @@ static irqreturn_t ocelot_xtr_irq_handle
 		struct sk_buff *skb;
 		struct net_device *dev;
 		u32 *buf;
-		int sz, len;
+		int sz, len, buf_len;
 		u32 ifh[4];
 		u32 val;
 		struct frame_info info;
@@ -116,14 +116,20 @@ static irqreturn_t ocelot_xtr_irq_handle
 			err = -ENOMEM;
 			break;
 		}
-		buf = (u32 *)skb_put(skb, info.len);
+		buf_len = info.len - ETH_FCS_LEN;
+		buf = (u32 *)skb_put(skb, buf_len);
 
 		len = 0;
 		do {
 			sz = ocelot_rx_frame_word(ocelot, grp, false, &val);
 			*buf++ = val;
 			len += sz;
-		} while ((sz == 4) && (len < info.len));
+		} while (len < buf_len);
+
+		/* Read the FCS and discard it */
+		sz = ocelot_rx_frame_word(ocelot, grp, false, &val);
+		/* Update the statistics if part of the FCS was read before */
+		len -= ETH_FCS_LEN - sz;
 
 		if (sz < 0) {
 			err = sz;


