Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 102DAC67839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 16:59:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D30332080F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 16:59:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D30332080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbeLLQ7J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 11:59:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47360 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727845AbeLLQ7J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 11:59:09 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 331CE89AD3;
        Wed, 12 Dec 2018 16:59:09 +0000 (UTC)
Received: from jtoppins.rdu.csb (ovpn-122-101.rdu2.redhat.com [10.10.122.101])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9C61160C44;
        Wed, 12 Dec 2018 16:59:08 +0000 (UTC)
From:   Jonathan Toppins <jtoppins@redhat.com>
To:     netdev@vger.kernel.org
Cc:     michael.chan@broadcom.com, "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next] bnxt: remove printing of hwrm message
Date:   Wed, 12 Dec 2018 11:58:51 -0500
Message-Id: <a183bfa67a3c3ca6c62676f01434eb921c9dc008.1544633931.git.jtoppins@redhat.com>
In-Reply-To: <CACKFLi=bOMKnmucRTNUyG=xWYWADJ61COFy2U-7rph0WRWR4Yg@mail.gmail.com>
References: <CACKFLi=bOMKnmucRTNUyG=xWYWADJ61COFy2U-7rph0WRWR4Yg@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Wed, 12 Dec 2018 16:59:09 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  bnxt_en 0000:19:00.0 (unregistered net_device) (uninitialized): hwrm
req_type 0x190 seq id 0x6 error 0xffff

The message above is commonly seen when a newer driver is used on
hardware with older firmware. The issue is this message means nothing to
anyone except Broadcom. Remove the message to not confuse users as this
message is really not very informative.

Signed-off-by: Jonathan Toppins <jtoppins@redhat.com>
---

Notes:
    v2:
      include changes recommended by Michael Chan

 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 5d21c14853ac..f4f29939ba72 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -6190,7 +6190,8 @@ int bnxt_hwrm_func_resc_qcaps(struct bnxt *bp, bool all)
 	req.fid = cpu_to_le16(0xffff);
 
 	mutex_lock(&bp->hwrm_cmd_lock);
-	rc = _hwrm_send_message(bp, &req, sizeof(req), HWRM_CMD_TIMEOUT);
+	rc = _hwrm_send_message_silent(bp, &req, sizeof(req),
+				       HWRM_CMD_TIMEOUT);
 	if (rc) {
 		rc = -EIO;
 		goto hwrm_func_resc_qcaps_exit;
-- 
2.16.4

