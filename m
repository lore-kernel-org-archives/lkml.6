Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 984A3C46463
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:30:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4074E20841
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:30:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4074E20841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387729AbeHAURB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 16:17:01 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46070 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404224AbeHATDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:03:36 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 170DF11F3;
        Wed,  1 Aug 2018 17:08:31 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
        Uma Krishnan <ukrishn@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 283/336] scsi: cxlflash: Avoid clobbering context control register value
Date:   Wed,  1 Aug 2018 18:50:18 +0200
Message-Id: <20180801165039.853744981@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801165028.930831994@linuxfoundation.org>
References: <20180801165028.930831994@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>

[ Upstream commit 465891fe9237b02f8d0fd26448f733fae7236f4a ]

The SISLite specification originally defined the context control register with
a single field of bits to represent the LISN and also stipulated that the
register reset value be 0. The cxlflash driver took advantage of this when
programming the LISN for the master contexts via an unconditional write - no
other bits were preserved.

When unmap support was added, SISLite was updated to define bit 0 of the
context control register as a way for the AFU to notify the context owner that
unmap operations were supported. Thus the assumptions under which the register
is setup changed and the existing unconditional write is clobbering the unmap
state for master contexts. This is presently not an issue due to the order in
which the context control register is programmed in relation to the unmap bit
being queried but should be addressed to avoid a future regression in the
event this code is moved elsewhere.

To remedy this issue, preserve the bits when programming the LISN field in the
context control register. Since the LISN will now be programmed using a read
value, assert that the initial state of the LISN field is as described in
SISLite (0).

Signed-off-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
Signed-off-by: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/cxlflash/main.c    |    5 ++++-
 drivers/scsi/cxlflash/sislite.h |    1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

--- a/drivers/scsi/cxlflash/main.c
+++ b/drivers/scsi/cxlflash/main.c
@@ -1303,7 +1303,10 @@ static void afu_err_intr_init(struct afu
 	for (i = 0; i < afu->num_hwqs; i++) {
 		hwq = get_hwq(afu, i);
 
-		writeq_be(SISL_MSI_SYNC_ERROR, &hwq->host_map->ctx_ctrl);
+		reg = readq_be(&hwq->host_map->ctx_ctrl);
+		WARN_ON((reg & SISL_CTX_CTRL_LISN_MASK) != 0);
+		reg |= SISL_MSI_SYNC_ERROR;
+		writeq_be(reg, &hwq->host_map->ctx_ctrl);
 		writeq_be(SISL_ISTATUS_MASK, &hwq->host_map->intr_mask);
 	}
 }
--- a/drivers/scsi/cxlflash/sislite.h
+++ b/drivers/scsi/cxlflash/sislite.h
@@ -284,6 +284,7 @@ struct sisl_host_map {
 	__be64 cmd_room;
 	__be64 ctx_ctrl;	/* least significant byte or b56:63 is LISN# */
 #define SISL_CTX_CTRL_UNMAP_SECTOR	0x8000000000000000ULL /* b0 */
+#define SISL_CTX_CTRL_LISN_MASK		(0xFFULL)
 	__be64 mbox_w;		/* restricted use */
 	__be64 sq_start;	/* Submission Queue (R/W): write sequence and */
 	__be64 sq_end;		/* inclusion semantics are the same as RRQ    */


