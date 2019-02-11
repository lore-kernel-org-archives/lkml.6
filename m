Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE4CC282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CFCE21B18
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549895831;
	bh=mjAm/QKxfyT1jRVyldkpIRz0R5NSQs79h6mRIfQS5YQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xqxLe1ZoQIefphSFZFG7iBs41+AR8h2AmK7ZaIHLsyhyhS3OwqJ9AFHVkVWKmahmC
	 lQAkIkGTxYNxONe9WvtUA9+S9dnX0YWK4Y/zhEZyevovwHdLNVU8FlTIvcjVbgqJ3j
	 IDJ6yE/PyGD0jgt0o+f0o4K6PIjM1h5JJGT4kSTo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729961AbfBKOhJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:37:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:46376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730726AbfBKOhG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:37:06 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4103420844;
        Mon, 11 Feb 2019 14:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895825;
        bh=mjAm/QKxfyT1jRVyldkpIRz0R5NSQs79h6mRIfQS5YQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S3jBE0NXsYtezWjW6yxfVhEzaWK7SfcyM6BNb5jYEsTwVj5wQ+LY1YM7Camu0W6sH
         7E+LbjYPv5M1xcP0fqrJRFi2cUThJ7SknNC/8yGuC5crGh8yf43sAPKHPBKoV4GSor
         I9CjOHRPNuQfbOEUuyn2KHsc20XcnmhnuYpv4mmI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Chan <michael.chan@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.20 308/352] bnxt_en: Disable interrupts when allocating CP rings or NQs.
Date:   Mon, 11 Feb 2019 15:18:55 +0100
Message-Id: <20190211141906.448359989@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141846.543045703@linuxfoundation.org>
References: <20190211141846.543045703@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Chan <michael.chan@broadcom.com>

[ Upstream commit 5e66e35aab335b83d9ffb220d8a3a13986a7a60e ]

When calling firmware to allocate a CP ring or NQ, an interrupt associated
with that ring may be generated immediately before the doorbell is even
setup after the firmware call returns.  When servicing the interrupt, the
driver may crash when trying to access the doorbell.

Fix it by disabling interrupt on that vector until the doorbell is
set up.

Fixes: 697197e5a173 ("bnxt_en: Re-structure doorbells.")
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -4903,12 +4903,18 @@ static int bnxt_hwrm_ring_alloc(struct b
 		struct bnxt_cp_ring_info *cpr = &bnapi->cp_ring;
 		struct bnxt_ring_struct *ring = &cpr->cp_ring_struct;
 		u32 map_idx = ring->map_idx;
+		unsigned int vector;
 
+		vector = bp->irq_tbl[map_idx].vector;
+		disable_irq_nosync(vector);
 		rc = hwrm_ring_alloc_send_msg(bp, ring, type, map_idx);
-		if (rc)
+		if (rc) {
+			enable_irq(vector);
 			goto err_out;
+		}
 		bnxt_set_db(bp, &cpr->cp_db, type, map_idx, ring->fw_ring_id);
 		bnxt_db_nq(bp, &cpr->cp_db, cpr->cp_raw_cons);
+		enable_irq(vector);
 		bp->grp_info[i].cp_fw_ring_id = ring->fw_ring_id;
 
 		if (!i) {


