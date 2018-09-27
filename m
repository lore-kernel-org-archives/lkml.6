Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F3E0C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C01FE20836
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:12:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C01FE20836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728579AbeI0P3S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 11:29:18 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55316 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727691AbeI0P3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 11:29:18 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B725610A4;
        Thu, 27 Sep 2018 09:12:01 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Sbarra <sbarra.paul@gmail.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.18 59/88] libata: mask swap internal and hardware tag
Date:   Thu, 27 Sep 2018 11:03:40 +0200
Message-Id: <20180927090307.961382188@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180927090300.631426620@linuxfoundation.org>
References: <20180927090300.631426620@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jens Axboe <axboe@kernel.dk>

commit 7ce5c8cd753f9afa8e79e9ec40351998e354f239 upstream.

hen we're comparing the hardware completion mask passed in from the
driver with the internal tag pending mask, we need to account for the
fact that the internal tag is different from the hardware tag. If not,
then we can end up either prematurely completing the internal tag (since
it's not set in the hw mask), or simply flag an error:

ata2: illegal qc_active transition (100000000->00000001)

If the internal tag is set, then swap that with the hardware tag in this
case before comparing with what the hardware reports.

Fixes: 28361c403683 ("libata: add extra internal command")
Buglink: https://bugzilla.kernel.org/show_bug.cgi?id=201151
Cc: stable@vger.kernel.org
Reported-by: Paul Sbarra <sbarra.paul@gmail.com>
Tested-by: Paul Sbarra <sbarra.paul@gmail.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/ata/libata-core.c |   14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -5358,10 +5358,20 @@ void ata_qc_complete(struct ata_queued_c
  */
 int ata_qc_complete_multiple(struct ata_port *ap, u64 qc_active)
 {
+	u64 done_mask, ap_qc_active = ap->qc_active;
 	int nr_done = 0;
-	u64 done_mask;
 
-	done_mask = ap->qc_active ^ qc_active;
+	/*
+	 * If the internal tag is set on ap->qc_active, then we care about
+	 * bit0 on the passed in qc_active mask. Move that bit up to match
+	 * the internal tag.
+	 */
+	if (ap_qc_active & (1ULL << ATA_TAG_INTERNAL)) {
+		qc_active |= (qc_active & 0x01) << ATA_TAG_INTERNAL;
+		qc_active ^= qc_active & 0x01;
+	}
+
+	done_mask = ap_qc_active ^ qc_active;
 
 	if (unlikely(done_mask & qc_active)) {
 		ata_port_err(ap, "illegal qc_active transition (%08llx->%08llx)\n",


