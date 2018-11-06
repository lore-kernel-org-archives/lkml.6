Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCAC5C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 12:05:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3DC020869
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 12:05:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="LI3Ry9Xg";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="j76rsqNg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3DC020869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730820AbeKFVao (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 16:30:44 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:52074 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726976AbeKFVam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 16:30:42 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 190CF60B7A; Tue,  6 Nov 2018 12:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1541505949;
        bh=f2vsGCrqV2dWHoMY3RT2mpv+RFW38Gde5kOkwGwavd4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LI3Ry9XgzS9ZC+P5xacSCMEmIULNpV+yE+EOvjB+S8NRzYjK38Hc/f6WppgC8lRU/
         xE5kAYOM6WQTH2tkZido06uonLJkAhuuiKkdr5zZoe97kwz9rJYYN1SnMp9yNQlytm
         bqfuwjcxqh4uZVNi+FYxHlFgdJzB1nDLOyt7K6Jg=
Received: from bgodavar-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: bgodavar@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B72BF60B62;
        Tue,  6 Nov 2018 12:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1541505948;
        bh=f2vsGCrqV2dWHoMY3RT2mpv+RFW38Gde5kOkwGwavd4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j76rsqNgzdzSfsY8kqD0XBbIylLXNhoNgvIRE1wVV0JC3yrIXevafBQzzYQt7SSxF
         AidM/jQZqQxVmNNViZ+LAGZF8PtuPzyLZbwxPvdrZG4YkTh1RwisrmjNHFNoAw4XJy
         PQ7tAFi5CDc1lggFRvBB6RHzCqFFTqgeRnea3snE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B72BF60B62
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=bgodavar@codeaurora.org
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     mka@chromium.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>
Subject: [PATCH v1 3/4] Bluetooth: hci_qca: clear HCI_QUIRK_RESET_ON_CLOSE flag
Date:   Tue,  6 Nov 2018 17:35:27 +0530
Message-Id: <20181106120528.30342-4-bgodavar@codeaurora.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181106120528.30342-1-bgodavar@codeaurora.org>
References: <20181106120528.30342-1-bgodavar@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During hci down we are sending reset command to chip, which
is not required for wcn3990, as hdev->shutdown() will turn off the
regulators.

Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
---
 drivers/bluetooth/hci_qca.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 8301663f0004..97b57e0f4725 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1190,6 +1190,7 @@ static int qca_setup(struct hci_uart *hu)
 		 */
 		set_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks);
 		set_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks);
+		clear_bit(HCI_QUIRK_RESET_ON_CLOSE, &hdev->quirks);
 		hu->hdev->shutdown = qca_power_off;
 		ret = qca_wcn3990_init(hu);
 		if (ret)
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

