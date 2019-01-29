Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 365DEC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:41:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 078152183F
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548762115;
	bh=STZDSb+WeZLkuDq+t5pa61YKNYpzqnUXERPzjJB900A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BK0zr/BuY9F+OKgpgOvOqTmui3PfVy7wXQBRBVTBSum4WUWh6faNh4NiCHxSRCdZU
	 xJIrtlxKHCeocmCIXXcDFj5asrhzynj8KMaahPNJBX1EjFq4Bd6uPaYRN8hkXc6a5M
	 2EF3cG20KfLT8Zh4Wpk+Toevkv0LAhp3ZYbZz5os=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727764AbfA2Llx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:41:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:59320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729348AbfA2Llv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:41:51 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3676820882;
        Tue, 29 Jan 2019 11:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548762110;
        bh=STZDSb+WeZLkuDq+t5pa61YKNYpzqnUXERPzjJB900A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Hk57Xh4QBEQE5AugWeQty+kRnf7QeXper5qBlCZgHoT/53CWtSaHr3/6mSKLc2ioB
         zyGFKGbAAiDNVUm/pnZgZpfrVHz6oUFP4W/KVFi9KvVWqDijVe3/xRrn0Dkjs96xX9
         k8vr5kvCrk8xdGtjD+ANYx0NEmRONbT3cCyNkAvM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felix Fietkau <nbd@nbd.name>,
        Stanislaw Gruszka <sgruszka@redhat.com>
Subject: [PATCH 4.20 113/117] mt76x02: assure we update gain after scan
Date:   Tue, 29 Jan 2019 12:36:04 +0100
Message-Id: <20190129113212.990470497@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129113207.477505932@linuxfoundation.org>
References: <20190129113207.477505932@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stanislaw Gruszka <sgruszka@redhat.com>

commit 4784a3cc3fffd0ba5ef6c7a23980ae0318fc1369 upstream.

Assure that after we initialize dev->cal.low_gain to -1 this
will cause update gain calibration. Otherwise this might or
might not happen depending on value of second bit of low_gain
and values read from registers in mt76x02_phy_adjust_vga_gain().

Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Stanislaw Gruszka <sgruszka@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/mediatek/mt76/mt76x0/main.c |    5 ++++-
 drivers/net/wireless/mediatek/mt76/mt76x0/phy.c  |    3 ++-
 2 files changed, 6 insertions(+), 2 deletions(-)

--- a/drivers/net/wireless/mediatek/mt76/mt76x0/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/main.c
@@ -139,8 +139,11 @@ void mt76x0_sw_scan_complete(struct ieee
 
 	clear_bit(MT76_SCANNING, &dev->mt76.state);
 
-	if (dev->cal.gain_init_done)
+	if (dev->cal.gain_init_done) {
+		/* Restore AGC gain and resume calibration after scanning. */
+		dev->cal.low_gain = -1;
 		ieee80211_queue_delayed_work(hw, &dev->cal_work, 0);
+	}
 }
 EXPORT_SYMBOL_GPL(mt76x0_sw_scan_complete);
 
--- a/drivers/net/wireless/mediatek/mt76/mt76x0/phy.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/phy.c
@@ -834,7 +834,8 @@ mt76x0_phy_update_channel_gain(struct mt
 	low_gain = (dev->cal.avg_rssi_all > mt76x02_get_rssi_gain_thresh(dev)) +
 		   (dev->cal.avg_rssi_all > mt76x02_get_low_rssi_gain_thresh(dev));
 
-	gain_change = (dev->cal.low_gain & 2) ^ (low_gain & 2);
+	gain_change = dev->cal.low_gain < 0 ||
+		      (dev->cal.low_gain & 2) ^ (low_gain & 2);
 	dev->cal.low_gain = low_gain;
 
 	if (!gain_change) {


