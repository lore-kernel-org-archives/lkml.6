Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA158C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:41:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71293214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548762117;
	bh=fw3W8bT2+faJ5nQ40Q2XhWgFtrsx2gUJGNsXvhBkVRM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=c7ZzCC4t3GB0KJdArLruDgAjvK98g+UlLcR/VTLwUjNzDhLMFhCvvt2qn0CMxacs/
	 1r1ryu4DLjTyAVLpc7N7Y4a0GeE3ba2oTBJ7eR1vfDVEAy10PGA3LlPUrhSdBSlpAT
	 XmDlD1zLNkICBlNu0qF9+FPEoiC2RSsrDtBQ7fOE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729932AbfA2Ll4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:41:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:59408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729348AbfA2Lly (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:41:54 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4545420882;
        Tue, 29 Jan 2019 11:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548762113;
        bh=fw3W8bT2+faJ5nQ40Q2XhWgFtrsx2gUJGNsXvhBkVRM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V+6IMM0c1oymp52zJ22uNWn0pLMEwBtxuVQPeTwBs8i+Aed2XdO6thq0dVu/pa6Lf
         ERymCeK5zsyCCa41/t38ruicJ2TeGvDZXH+0In4T0AvNF7VRUHekFsbC3TFftHYua0
         16sAbw/IXKwY682OPoq0zw2yGylZDcYoIA9eI90Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felix Fietkau <nbd@nbd.name>,
        Stanislaw Gruszka <sgruszka@redhat.com>
Subject: [PATCH 4.20 114/117] mt76x0: do not perform MCU calibration for MT7630
Date:   Tue, 29 Jan 2019 12:36:05 +0100
Message-Id: <20190129113213.036611619@linuxfoundation.org>
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

commit a83150eaad42769e4d08b6e07956a489e40214ae upstream.

Driver works better for MT7630 without MCU calibration, which
looks like it can hangs the firmware. Vendor driver do not
perform it for MT7630 as well.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Stanislaw Gruszka <sgruszka@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/mediatek/mt76/mt76x0/mt76x0.h |    5 +++++
 drivers/net/wireless/mediatek/mt76/mt76x0/phy.c    |    3 +++
 2 files changed, 8 insertions(+)

--- a/drivers/net/wireless/mediatek/mt76/mt76x0/mt76x0.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/mt76x0.h
@@ -41,6 +41,11 @@ static inline bool is_mt7610e(struct mt7
 
 void mt76x0_init_debugfs(struct mt76x02_dev *dev);
 
+static inline bool is_mt7630(struct mt76x02_dev *dev)
+{
+	return mt76_chip(&dev->mt76) == 0x7630;
+}
+
 /* Init */
 struct mt76x02_dev *
 mt76x0_alloc_device(struct device *pdev,
--- a/drivers/net/wireless/mediatek/mt76/mt76x0/phy.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/phy.c
@@ -588,6 +588,9 @@ void mt76x0_phy_calibrate(struct mt76x02
 	int is_5ghz = (chan->band == NL80211_BAND_5GHZ) ? 1 : 0;
 	u32 val, tx_alc, reg_val;
 
+	if (is_mt7630(dev))
+		return;
+
 	if (power_on) {
 		mt76x02_mcu_calibrate(dev, MCU_CAL_R, 0, false);
 		mt76x02_mcu_calibrate(dev, MCU_CAL_VCO, chan->hw_value,


