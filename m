Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3070C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:30:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72E9320864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:30:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72E9320864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967028AbeFRIaz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:30:55 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33806 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967016AbeFRIav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:30:51 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 37814C75;
        Mon, 18 Jun 2018 08:30:51 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Long Li <longli@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 043/189] scsi: storvsc: Set up correct queue depth values for IDE devices
Date:   Mon, 18 Jun 2018 10:12:19 +0200
Message-Id: <20180618081211.074056077@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618081209.254234434@linuxfoundation.org>
References: <20180618081209.254234434@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Long Li <longli@microsoft.com>

[ Upstream commit f286299c1d0ba5e2ca0377610307b370fe178767 ]

Unlike SCSI and FC, we don't use multiple channels for IDE.  Also fix
the calculation for sub-channels.

Signed-off-by: Long Li <longli@microsoft.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/storvsc_drv.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -1725,11 +1725,14 @@ static int storvsc_probe(struct hv_devic
 		max_targets = STORVSC_MAX_TARGETS;
 		max_channels = STORVSC_MAX_CHANNELS;
 		/*
-		 * On Windows8 and above, we support sub-channels for storage.
+		 * On Windows8 and above, we support sub-channels for storage
+		 * on SCSI and FC controllers.
 		 * The number of sub-channels offerred is based on the number of
 		 * VCPUs in the guest.
 		 */
-		max_sub_channels = (num_cpus / storvsc_vcpus_per_sub_channel);
+		if (!dev_is_ide)
+			max_sub_channels =
+				(num_cpus - 1) / storvsc_vcpus_per_sub_channel;
 	}
 
 	scsi_driver.can_queue = (max_outstanding_req_per_channel *


