Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id ED651C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:47:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3434208CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:47:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="k6AiNL0J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3434208CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755464AbeFNOr4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 10:47:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:48222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965068AbeFNOHs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 10:07:48 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B5D4208CB;
        Thu, 14 Jun 2018 14:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528985267;
        bh=qTmw6hbTbNCj0B9s+TAXDBfImAF+CbrpVso89iqQmwQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k6AiNL0JvexnGdjB3KhPTSSI7a5ToLwEckdALF2C2JJylgiGJEXc7rdPlXm93iAuQ
         YqhkpQcmqSRZa9a/emHum7fYLboQCYGMabL8VYYnTZiArkXiPVSPVqSGoBljHHhAVA
         az1HKJ1WzBl7rXKMXenPyIUv4vamBCOiWJ2cF/n8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alexander Kappner <agk@godking.net>,
        Alan Stern <stern@rowland.harvard.edu>,
        Oliver Neukum <oneukum@suse.com>
Subject: [PATCH 4.16 12/43] usb-storage: Add support for FL_ALWAYS_SYNC flag in the UAS driver
Date:   Thu, 14 Jun 2018 16:04:16 +0200
Message-Id: <20180614132135.627978491@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180614132135.111973468@linuxfoundation.org>
References: <20180614132135.111973468@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexander Kappner <agk@godking.net>

commit 8c4e97ddfe73a0958bb0abf7e6a3bc4cc3e04936 upstream.

The ALWAYS_SYNC flag is currently honored by the usb-storage driver but not UAS
and is required to work around devices that become unstable upon being
queried for cache. This code is taken straight from:
drivers/usb/storage/scsiglue.c:284

Signed-off-by: Alexander Kappner <agk@godking.net>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Cc: stable <stable@vger.kernel.org>
Acked-by: Oliver Neukum <oneukum@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/storage/uas.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/usb/storage/uas.c
+++ b/drivers/usb/storage/uas.c
@@ -836,6 +836,12 @@ static int uas_slave_configure(struct sc
 	if (devinfo->flags & US_FL_BROKEN_FUA)
 		sdev->broken_fua = 1;
 
+	/* UAS also needs to support FL_ALWAYS_SYNC */
+	if (devinfo->flags & US_FL_ALWAYS_SYNC) {
+		sdev->skip_ms_page_3f = 1;
+		sdev->skip_ms_page_8 = 1;
+		sdev->wce_default_on = 1;
+	}
 	scsi_change_queue_depth(sdev, devinfo->qdepth - 2);
 	return 0;
 }


