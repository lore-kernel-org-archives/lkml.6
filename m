Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A855C43441
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4286620844
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:33:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="v+C6VU9y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4286620844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729788AbeKIIKk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 03:10:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:55750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730282AbeKIHh3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:37:29 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B36F21479;
        Thu,  8 Nov 2018 22:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714401;
        bh=4RgqZNm+Eje2qleYdiDI4V/CEzmxU4jd04Uq7e1WigM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=v+C6VU9yXYqEfMZ4UDuSB+p5DKWLts6i1tImDfBizxxJeB0w09YTtoeldnyoUnAc9
         K6znMO7XJv0RpacIK4w9g+F4/Kr57cqviRjg7gycnlDRYI/Aia27TdDP2pYdYkDVAH
         R6O2n7V3JZ/4cnIEDNxlUXS8k8w5TJy5FXcF1pZE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Peter S. Housel" <housel@acm.org>,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 062/114] brcmfmac: Fix glom_skb leak in brcmf_sdiod_recv_chain
Date:   Thu,  8 Nov 2018 13:51:17 -0800
Message-Id: <20181108215106.708059832@linuxfoundation.org>
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

[ Upstream commit 5ea59db8a375216e6c915c5586f556766673b5a7 ]

An earlier change to this function (3bdae810721b) fixed a leak in the
case of an unsuccessful call to brcmf_sdiod_buffrw(). However, the
glom_skb buffer, used for emulating a scattering read, is never used
or referenced after its contents are copied into the destination
buffers, and therefore always needs to be freed by the end of the
function.

Fixes: 3bdae810721b ("brcmfmac: Fix glob_skb leak in brcmf_sdiod_recv_chain")
Fixes: a413e39a38573 ("brcmfmac: fix brcmf_sdcard_recv_chain() for host without sg support")
Cc: stable@vger.kernel.org # 4.9.x-
Signed-off-by: Peter S. Housel <housel@acm.org>
Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/brcm80211/brcmfmac/bcmsdh.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/brcm80211/brcmfmac/bcmsdh.c b/drivers/net/wireless/brcm80211/brcmfmac/bcmsdh.c
index 91da67657f81..72e1796c8167 100644
--- a/drivers/net/wireless/brcm80211/brcmfmac/bcmsdh.c
+++ b/drivers/net/wireless/brcm80211/brcmfmac/bcmsdh.c
@@ -705,7 +705,7 @@ done:
 int brcmf_sdiod_recv_chain(struct brcmf_sdio_dev *sdiodev,
 			   struct sk_buff_head *pktq, uint totlen)
 {
-	struct sk_buff *glom_skb;
+	struct sk_buff *glom_skb = NULL;
 	struct sk_buff *skb;
 	u32 addr = sdiodev->sbwad;
 	int err = 0;
@@ -726,10 +726,8 @@ int brcmf_sdiod_recv_chain(struct brcmf_sdio_dev *sdiodev,
 			return -ENOMEM;
 		err = brcmf_sdiod_buffrw(sdiodev, SDIO_FUNC_2, false, addr,
 					 glom_skb);
-		if (err) {
-			brcmu_pkt_buf_free_skb(glom_skb);
+		if (err)
 			goto done;
-		}
 
 		skb_queue_walk(pktq, skb) {
 			memcpy(skb->data, glom_skb->data, skb->len);
@@ -740,6 +738,7 @@ int brcmf_sdiod_recv_chain(struct brcmf_sdio_dev *sdiodev,
 					    pktq);
 
 done:
+	brcmu_pkt_buf_free_skb(glom_skb);
 	return err;
 }
 
-- 
2.17.1



