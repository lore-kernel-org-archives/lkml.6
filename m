Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 985DBC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:53:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ACFB206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547218422;
	bh=ktjunxAMDNSKvrfGGu41//aG6qlpCLjgjI3vWo9AEeE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UIuQUIioz956pPtrcdyTcT5LIqHV/NpcL4yGaUj0TLRMlVu9T6RGXluusQ9LmBol8
	 dbzPAN0AOEYtzvrzxnmb0FZsJlVTfHTV1bQtPEKqoZfhK8k26ZSdVKqilcnWL8/RL5
	 DO7yqPdzA6JksjNxX8Q11eZYnPVebRcx8Oi1c4I8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390736AbfAKOh7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:37:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:58468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390717AbfAKOhy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:37:54 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF630204EC;
        Fri, 11 Jan 2019 14:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217473;
        bh=ktjunxAMDNSKvrfGGu41//aG6qlpCLjgjI3vWo9AEeE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=egvC0tNrflldTPbaEPtCLH4KnYKSLHtBXp3PpMWCrMTZ5IjCKT+LHoDiIImBbJ6Dr
         +gGf/BOpHCvdexUUrHHDDG04NRj1a/AcwKMWo3fROGTiVK6auAvH84G/TOBfmuSf9K
         1jF5Tzm1/SaOtiV/+qLiVHk4VjQbADE0Ik3QY9wY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniele Palmas <dnlplm@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 074/148] qmi_wwan: Fix qmap header retrieval in qmimux_rx_fixup
Date:   Fri, 11 Jan 2019 15:14:12 +0100
Message-Id: <20190111131117.195178565@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131114.337122649@linuxfoundation.org>
References: <20190111131114.337122649@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit d667044f49513d55fcfefe4fa8f8d96091782901 ]

This patch fixes qmap header retrieval when modem is configured for
dl data aggregation.

Signed-off-by: Daniele Palmas <dnlplm@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/usb/qmi_wwan.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/net/usb/qmi_wwan.c b/drivers/net/usb/qmi_wwan.c
index f5bac5075386..774e1ff01c9a 100644
--- a/drivers/net/usb/qmi_wwan.c
+++ b/drivers/net/usb/qmi_wwan.c
@@ -151,17 +151,18 @@ static bool qmimux_has_slaves(struct usbnet *dev)
 
 static int qmimux_rx_fixup(struct usbnet *dev, struct sk_buff *skb)
 {
-	unsigned int len, offset = sizeof(struct qmimux_hdr);
+	unsigned int len, offset = 0;
 	struct qmimux_hdr *hdr;
 	struct net_device *net;
 	struct sk_buff *skbn;
+	u8 qmimux_hdr_sz = sizeof(*hdr);
 
-	while (offset < skb->len) {
-		hdr = (struct qmimux_hdr *)skb->data;
+	while (offset + qmimux_hdr_sz < skb->len) {
+		hdr = (struct qmimux_hdr *)(skb->data + offset);
 		len = be16_to_cpu(hdr->pkt_len);
 
 		/* drop the packet, bogus length */
-		if (offset + len > skb->len)
+		if (offset + len + qmimux_hdr_sz > skb->len)
 			return 0;
 
 		/* control packet, we do not know what to do */
@@ -176,7 +177,7 @@ static int qmimux_rx_fixup(struct usbnet *dev, struct sk_buff *skb)
 			return 0;
 		skbn->dev = net;
 
-		switch (skb->data[offset] & 0xf0) {
+		switch (skb->data[offset + qmimux_hdr_sz] & 0xf0) {
 		case 0x40:
 			skbn->protocol = htons(ETH_P_IP);
 			break;
@@ -188,12 +189,12 @@ static int qmimux_rx_fixup(struct usbnet *dev, struct sk_buff *skb)
 			goto skip;
 		}
 
-		skb_put_data(skbn, skb->data + offset, len);
+		skb_put_data(skbn, skb->data + offset + qmimux_hdr_sz, len);
 		if (netif_rx(skbn) != NET_RX_SUCCESS)
 			return 0;
 
 skip:
-		offset += len + sizeof(struct qmimux_hdr);
+		offset += len + qmimux_hdr_sz;
 	}
 	return 1;
 }
-- 
2.19.1



