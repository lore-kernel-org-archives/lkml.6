Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77405ECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:55:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3388220892
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:55:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="llCdUuUh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3388220892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728808AbeKIHdV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:33:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:48960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727311AbeKIHdV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:33:21 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B27C120892;
        Thu,  8 Nov 2018 21:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714153;
        bh=V5JYs4r3GVVYOyf3Hw89w8pn8yPcayr99sZWk/HvALQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=llCdUuUhSwJPXU486GZKEUbQzhMTBOlwKOyYaz97e4Vi5JwMhFxK442JFds+YLmhz
         oXwJuLHj3ZNPp0fftpzvnAP+tuvJeHzK3dsWGv0Hmf5serR9IeDpaXx0ltv5G+eQXe
         pcKT+6oCaSOYqcSEgJ4d4SIxbOqcCM1jl+/icpwo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 061/144] uas: disable UAS on Apricorn SATA dongles
Date:   Thu,  8 Nov 2018 13:50:32 -0800
Message-Id: <20181108215059.302025538@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215054.826084593@linuxfoundation.org>
References: <20181108215054.826084593@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

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



