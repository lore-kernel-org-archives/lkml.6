Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F43EC0044C
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:31:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFDD2208A3
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:31:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="bYYKc/9U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFDD2208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389276AbeKLIU7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:20:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:46824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389217AbeKLIU6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:20:58 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E774C21508;
        Sun, 11 Nov 2018 22:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975462;
        bh=2NwwM2hDUnmEssft1xcrkxoS8rixXNwVFz6g5/DBxM0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bYYKc/9UKrT1mM4qjeg02P/V3AsbuSLoSD5uY+1ekDYaDDk3YdIhPh9g/oGdqFlYY
         6kxpWGFksFBxx34dcQqJSpj/ljuiboCykUpF3cS5/NjGlb8J4AZtfnUVPr0CYXClkB
         MTjNBdXjFLtam3Q23xS4jv+DcoXeptiJxJvQXeRc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Felix Fietkau <nbd@nbd.name>
Subject: [PATCH 4.18 207/350] mt76: mt76x2: fix multi-interface beacon configuration
Date:   Sun, 11 Nov 2018 14:21:11 -0800
Message-Id: <20181111221716.688485761@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221707.043394111@linuxfoundation.org>
References: <20181111221707.043394111@linuxfoundation.org>
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

From: Felix Fietkau <nbd@nbd.name>

commit 5289976ad887deb07c76df7eecf553c264aeebed upstream.

If the first virtual interface is a station (or an AP with beacons
temporarily disabled), the beacon of the second interface needs to
occupy hardware beacon slot 0.
For some reason the beacon index was incorrectly masked with the
virtual interface beacon mask, which prevents the secondary
interface from sending beacons unless the first one also does.

Cc: stable@vger.kernel.org
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/wireless/mediatek/mt76/mt76x2_mac.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/net/wireless/mediatek/mt76/mt76x2_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2_mac.c
@@ -725,8 +725,7 @@ __mt76x2_mac_set_beacon(struct mt76x2_de
 	if (skb) {
 		ret = mt76_write_beacon(dev, beacon_addr, skb);
 		if (!ret)
-			dev->beacon_data_mask |= BIT(bcn_idx) &
-						 dev->beacon_mask;
+			dev->beacon_data_mask |= BIT(bcn_idx);
 	} else {
 		dev->beacon_data_mask &= ~BIT(bcn_idx);
 		for (i = 0; i < beacon_len; i += 4)


