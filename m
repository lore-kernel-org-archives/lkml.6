Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE268C4646D
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 09:11:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81CCF2177A
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 09:11:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81CCF2177A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389238AbeHDLLj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 07:11:39 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50274 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733176AbeHDLLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 07:11:38 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 257FDBC6;
        Sat,  4 Aug 2018 09:11:37 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Damien Le Moal <damien.lemoal@wdc.com>,
        Hannes Reinecke <hare@suse.com>, Tejun Heo <tj@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 067/124] libata: Fix command retry decision
Date:   Sat,  4 Aug 2018 11:00:56 +0200
Message-Id: <20180804082705.032583095@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180804082702.434482435@linuxfoundation.org>
References: <20180804082702.434482435@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Damien Le Moal <damien.lemoal@wdc.com>

[ Upstream commit 804689ad2d9b66d0d3920b48cf05881049d44589 ]

For failed commands with valid sense data (e.g. NCQ commands),
scsi_check_sense() is used in ata_analyze_tf() to determine if the
command can be retried. In such case, rely on this decision and ignore
the command error mask based decision done in ata_worth_retry().

This fixes useless retries of commands such as unaligned writes on zoned
disks (TYPE_ZAC).

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/ata/libata-eh.c |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -2198,12 +2198,16 @@ static void ata_eh_link_autopsy(struct a
 		if (qc->err_mask & ~AC_ERR_OTHER)
 			qc->err_mask &= ~AC_ERR_OTHER;
 
-		/* SENSE_VALID trumps dev/unknown error and revalidation */
+		/*
+		 * SENSE_VALID trumps dev/unknown error and revalidation. Upper
+		 * layers will determine whether the command is worth retrying
+		 * based on the sense data and device class/type. Otherwise,
+		 * determine directly if the command is worth retrying using its
+		 * error mask and flags.
+		 */
 		if (qc->flags & ATA_QCFLAG_SENSE_VALID)
 			qc->err_mask &= ~(AC_ERR_DEV | AC_ERR_OTHER);
-
-		/* determine whether the command is worth retrying */
-		if (ata_eh_worth_retry(qc))
+		else if (ata_eh_worth_retry(qc))
 			qc->flags |= ATA_QCFLAG_RETRY;
 
 		/* accumulate error info */


