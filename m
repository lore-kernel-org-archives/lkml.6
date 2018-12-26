Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B018C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:38:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE8912054F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545863931;
	bh=9huvG3I/8nqB4FWklBwFSnPuSCgrHu0HbfFAv1vHFPQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=d10488nazvix5nnplO7FjW2RdN2xTS4PvLJA6mY/cQrZ32l8GB0om0cGrLfiwBssD
	 VSfdPwIrYCHIivNQdK2xyOo2LgdhRxDv68SuJ0pnjC7V2UWo+ZnD3eVLru1QwFnNXR
	 oLoGL5F9GzBAp0K5xM0GOtJpDP9Vf9LX++scIXPM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727727AbeLZWit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 17:38:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:38894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728839AbeLZWih (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 17:38:37 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3387C21741;
        Wed, 26 Dec 2018 22:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545863916;
        bh=9huvG3I/8nqB4FWklBwFSnPuSCgrHu0HbfFAv1vHFPQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Cejivx8K9xPWnDEt2i7y95uVVURX67DCf5i4FmrY0V5VP+W8Y9cJC2PuON5clhstL
         Pa0GfipbF09lFz9XFRgHriWp6EYokQDwgWB78z28NIz0LRcOF3fGRBgAo5hl2aQ44E
         mqKwVRdyrnLIbiaim7SwzBCFXyOPEkHNDj3p3Hsc=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Daniele Palmas <dnlplm@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 95/97] qmi_wwan: Fix qmap header retrieval in qmimux_rx_fixup
Date:   Wed, 26 Dec 2018 17:35:55 -0500
Message-Id: <20181226223557.149329-95-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181226223557.149329-1-sashal@kernel.org>
References: <20181226223557.149329-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniele Palmas <dnlplm@gmail.com>

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

