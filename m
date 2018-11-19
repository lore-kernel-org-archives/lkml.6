Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53C50C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:43:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C4262086A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:43:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ATA/Qgmt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C4262086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388091AbeKTDID (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:08:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:42380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731911AbeKTDIC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:08:02 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D72EB2086A;
        Mon, 19 Nov 2018 16:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542645831;
        bh=IHgHSsEbRwnMtzr9JDx6HgV44AXUaDqCRf8ORoU5nuw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ATA/QgmtHsb0UoERmRTRSY8XOqt69GMqe2Hx3Z6hm14q+wfkGaHU1HQwqTBTKZaAo
         IB5khm7z5A4zhJ7tOGyJPJcCyughRj883KtBxTpUS8CPlic7EPQbETFBQwdcVlFbhZ
         KEclauEnfZSKA7KEA39Yuez1uMl12ZjrXGAvdFw8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Quinn Tran <quinn.tran@cavium.com>,
        Himanshu Madhani <himanshu.madhani@cavium.com>,
        Laurence Oberman <loberman@redhat.com>,
        "Ewan D. Milne" <emilne@redhat.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.18 078/171] scsi: qla2xxx: Initialize port speed to avoid setting lower speed
Date:   Mon, 19 Nov 2018 17:27:54 +0100
Message-Id: <20181119162632.112139842@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162618.909354448@linuxfoundation.org>
References: <20181119162618.909354448@linuxfoundation.org>
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

From: Quinn Tran <quinn.tran@cavium.com>

commit f635e48e866ee1a47d2d42ce012fdcc07bf55853 upstream.

This patch initializes port speed so that firmware does not set lower
operating speed. Setting lower speed in firmware impacts WRITE perfomance.

Fixes: 726b85487067 ("qla2xxx: Add framework for async fabric discovery")
Cc: <stable@vger.kernel.org>
Signed-off-by: Quinn Tran <quinn.tran@cavium.com>
Signed-off-by: Himanshu Madhani <himanshu.madhani@cavium.com>
Tested-by: Laurence Oberman <loberman@redhat.com>
Reviewed-by: Ewan D. Milne <emilne@redhat.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/qla2xxx/qla_init.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -4491,6 +4491,7 @@ qla2x00_alloc_fcport(scsi_qla_host_t *vh
 	fcport->loop_id = FC_NO_LOOP_ID;
 	qla2x00_set_fcport_state(fcport, FCS_UNCONFIGURED);
 	fcport->supported_classes = FC_COS_UNSPECIFIED;
+	fcport->fp_speed = PORT_SPEED_UNKNOWN;
 
 	fcport->ct_desc.ct_sns = dma_alloc_coherent(&vha->hw->pdev->dev,
 		sizeof(struct ct_sns_pkt), &fcport->ct_desc.ct_sns_dma,


