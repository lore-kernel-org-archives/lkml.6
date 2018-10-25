Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEE1AC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:19:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C9BF208A3
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:19:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0D5gG5gI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C9BF208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730665AbeJYWwj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:52:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:34792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730638AbeJYWwi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:52:38 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 05CD020870;
        Thu, 25 Oct 2018 14:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540477181;
        bh=Zh5XP7fZDy70AjHwJvv52HWRKsELeHegtaYDQ+XCZ2A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0D5gG5gI6yCkyd98DZgJzt1j2TvtnWCi+14pd7YJ1/6RPljOMFScnCetxEBpsdXn2
         YmPfWNP+ZuC5o7kQ+dLvklq5NmJAQiWmlcpFpwdioyeaxtXc2ARlBkX+ZCgL5f9nHa
         m/2tn4n3Y/lkaak+lXabgUzmRcvyISQxEQzwKwOc=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 3.18 31/98] uas: disable UAS on Apricorn SATA dongles
Date:   Thu, 25 Oct 2018 10:17:46 -0400
Message-Id: <20181025141853.214051-31-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141853.214051-1-sashal@kernel.org>
References: <20181025141853.214051-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Darrick J. Wong" <darrick.wong@oracle.com>

[ Upstream commit 36d1ffdb210ec2d0d6a69e9f6466ae8727d34119 ]

The Apricorn SATA dongle will occasionally return "USBSUSBSUSB" in
response to SCSI commands when running in UAS mode.  Therefore,
disable UAS mode on this dongle.

Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
Acked-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/storage/unusual_uas.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/usb/storage/unusual_uas.h b/drivers/usb/storage/unusual_uas.h
index baf671aef9d0..31c79b1f970e 100644
--- a/drivers/usb/storage/unusual_uas.h
+++ b/drivers/usb/storage/unusual_uas.h
@@ -40,6 +40,16 @@
  * and don't forget to CC: the USB development list <linux-usb@vger.kernel.org>
  */
 
+/*
+ * Apricorn USB3 dongle sometimes returns "USBSUSBSUSBS" in response to SCSI
+ * commands in UAS mode.  Observed with the 1.28 firmware; are there others?
+ */
+UNUSUAL_DEV(0x0984, 0x0301, 0x0128, 0x0128,
+		"Apricorn",
+		"",
+		USB_SC_DEVICE, USB_PR_DEVICE, NULL,
+		US_FL_IGNORE_UAS),
+
 /* https://bugzilla.kernel.org/show_bug.cgi?id=79511 */
 UNUSUAL_DEV(0x0bc2, 0x2312, 0x0000, 0x9999,
 		"Seagate",
-- 
2.17.1

