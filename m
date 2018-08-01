Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E48B0C46467
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:50:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA022208A5
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:50:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA022208A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390263AbeHATh1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:37:27 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50606 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406131AbeHATIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:08:43 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 003E5CC9;
        Wed,  1 Aug 2018 17:22:01 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 205/246] scsi: megaraid_sas: Increase timeout by 1 sec for non-RAID fastpath IOs
Date:   Wed,  1 Aug 2018 18:51:55 +0200
Message-Id: <20180801165021.532823078@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801165011.700991984@linuxfoundation.org>
References: <20180801165011.700991984@linuxfoundation.org>
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

From: Shivasharan S <shivasharan.srikanteshwara@broadcom.com>

[ Upstream commit 3239b8cd28fd849a2023483257d35d68c5876c74 ]

Hardware could time out Fastpath IOs one second earlier than the timeout
provided by the host.

For non-RAID devices, driver provides timeout value based on OS provided
timeout value. Under certain scenarios, if the OS provides a timeout
value of 1 second, due to above behavior hardware will timeout
immediately.

Increase timeout value for non-RAID fastpath IOs by 1 second.

Signed-off-by: Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/megaraid/megaraid_sas_fusion.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/scsi/megaraid/megaraid_sas_fusion.c
+++ b/drivers/scsi/megaraid/megaraid_sas_fusion.c
@@ -2677,6 +2677,9 @@ megasas_build_syspd_fusion(struct megasa
 		pRAID_Context->timeout_value = cpu_to_le16(os_timeout_value);
 		pRAID_Context->virtual_disk_tgt_id = cpu_to_le16(device_id);
 	} else {
+		if (os_timeout_value)
+			os_timeout_value++;
+
 		/* system pd Fast Path */
 		io_request->Function = MPI2_FUNCTION_SCSI_IO_REQUEST;
 		timeout_limit = (scmd->device->type == TYPE_DISK) ?


