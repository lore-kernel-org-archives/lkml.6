Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 009B4C6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 17:48:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1A052575E
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 17:48:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1A052575E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030689AbeGARr7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 13:47:59 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35414 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030771AbeGAQdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:33:32 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 93F5D49B;
        Sun,  1 Jul 2018 16:33:31 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Anil Gurumurthy <anil.gurumurthy@cavium.com>,
        Giridhar Malavali <giridhar.malavali@cavium.com>,
        Himanshu Madhani <himanshu.madhani@cavium.com>,
        "Ewan D. Milne" <emilne@redhat.com>,
        Martin Wilck <mwilck@suse.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.14 096/157] scsi: qla2xxx: Mask off Scope bits in retry delay
Date:   Sun,  1 Jul 2018 18:22:48 +0200
Message-Id: <20180701160857.348757650@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701160852.287307684@linuxfoundation.org>
References: <20180701160852.287307684@linuxfoundation.org>
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

From: Anil Gurumurthy <anil.gurumurthy@cavium.com>

commit 3cedc8797b9c0f2222fd45a01f849c57c088828b upstream.

Some newer target uses "Status Qualifier" response in a returned "Busy
Status". This new response code of 0x4001, which is "Scope" bits,
translates to "Affects all units accessible by target".  Due to this new
value returned in the Scope bits, driver was using that value as timeout
value which resulted into driver waiting for 27min timeout.

This patch masks off this Scope bits so that driver does not use this
value as retry delay time.

Cc: <stable@vger.kernel.org>
Signed-off-by: Anil Gurumurthy <anil.gurumurthy@cavium.com>
Signed-off-by: Giridhar Malavali <giridhar.malavali@cavium.com>
Signed-off-by: Himanshu Madhani <himanshu.madhani@cavium.com>
Reviewed-by: Ewan D. Milne <emilne@redhat.com>
Reviewed-by: Martin Wilck <mwilck@suse.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/qla2xxx/qla_isr.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/drivers/scsi/qla2xxx/qla_isr.c
+++ b/drivers/scsi/qla2xxx/qla_isr.c
@@ -2454,8 +2454,12 @@ qla2x00_status_entry(scsi_qla_host_t *vh
 		ox_id = le16_to_cpu(sts24->ox_id);
 		par_sense_len = sizeof(sts24->data);
 		/* Valid values of the retry delay timer are 0x1-0xffef */
-		if (sts24->retry_delay > 0 && sts24->retry_delay < 0xfff1)
-			retry_delay = sts24->retry_delay;
+		if (sts24->retry_delay > 0 && sts24->retry_delay < 0xfff1) {
+			retry_delay = sts24->retry_delay & 0x3fff;
+			ql_dbg(ql_dbg_io, sp->vha, 0x3033,
+			    "%s: scope=%#x retry_delay=%#x\n", __func__,
+			    sts24->retry_delay >> 14, retry_delay);
+		}
 	} else {
 		if (scsi_status & SS_SENSE_LEN_VALID)
 			sense_len = le16_to_cpu(sts->req_sense_length);


