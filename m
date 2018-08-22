Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95D01C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 12:20:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5099420C0D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 12:20:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="VGFgrsyR";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="HJWzGe+u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5099420C0D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728588AbeHVPpO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 11:45:14 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:37694 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727835AbeHVPpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 11:45:13 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 641BD601B4; Wed, 22 Aug 2018 12:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534940431;
        bh=Wjjpf9MvYmG1l8q2opKkAB1Wbgo0XApLrox1BwH/HTo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VGFgrsyRM1NV2gAz8fLIbwRyOvdqn3yUFeR1TTmKoQWJcTKi0hFsiYy+bMsqnyCaR
         FcUQh9Chayl4fG5rd58ScApLpMlLOK0FvNg9balGdzhTBXUTcAauf3NE5LO95PUjw8
         CgVZnTavuS3FSA/LMO3i7vJqyLufNQZCvhLnkJrY=
Received: from bgodavar-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: bgodavar@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3375E60159;
        Wed, 22 Aug 2018 12:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534940430;
        bh=Wjjpf9MvYmG1l8q2opKkAB1Wbgo0XApLrox1BwH/HTo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HJWzGe+uOCUB9ELgE188IhbmPraFdC3Y4IICPV+DGq9MCEFeZEWBGl7uXqhnLX5pl
         PyNSosO82MYy59TvvzRGYzDqfdPQ4m8zQQMEgImbhGfN6/sdUZoEohwmADfL/yxwOk
         CgOC20VVDmHE+KZRFgNvsKnf2HYDGebQJJtRso0w=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3375E60159
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=bgodavar@codeaurora.org
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     mka@chromium.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>
Subject: [PATCH v1 1/2] Bluetooth: hci_qca: Remove serdev_device_open/close function calls
Date:   Wed, 22 Aug 2018 17:50:04 +0530
Message-Id: <20180822122005.11218-2-bgodavar@codeaurora.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180822122005.11218-1-bgodavar@codeaurora.org>
References: <20180822122005.11218-1-bgodavar@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removed serdev_device_open/close functions from qca_open/close as
they are called in hci_uart_register_device() and
hci_uart_unregister_device() functions.

Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
---
 drivers/bluetooth/hci_qca.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index e182f6019f68..a740d5703914 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -499,7 +499,6 @@ static int qca_open(struct hci_uart *hu)
 	hu->priv = qca;
 
 	if (hu->serdev) {
-		serdev_device_open(hu->serdev);
 
 		qcadev = serdev_device_get_drvdata(hu->serdev);
 		if (qcadev->btsoc_type != QCA_WCN3990) {
@@ -613,7 +612,6 @@ static int qca_close(struct hci_uart *hu)
 		else
 			gpiod_set_value_cansleep(qcadev->bt_en, 0);
 
-		serdev_device_close(hu->serdev);
 	}
 
 	kfree_skb(qca->rx_skb);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

