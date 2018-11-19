Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 796FEC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:47:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FE5820823
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:47:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="e9o/TJW/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FE5820823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389232AbeKTDMF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:12:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:48182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388196AbeKTDME (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:12:04 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 00C4D20823;
        Mon, 19 Nov 2018 16:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542646072;
        bh=1quj5pOrLScvHGVSWUEUXh2y1f1hNmspDIOCqWP2hrY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e9o/TJW/1/CcL3fLz7Aw30OrTK+n6OX4gM4A6IrD5/J1DQOuzbzUxea+6mneSK6H/
         SeVbxuHlLESgTdu0V57eJ925XEGW5bgR8X+gd7BQ2pQIbEWWZMErPJlPbQBMnPmkGe
         dC/x/A5/dWb8xUgTlLaJ6k+wIjx4AwLBn+I1kwM0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Himanshu Madhani <himanshu.madhani@cavium.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.14 025/124] scsi: qla2xxx: Fix incorrect port speed being set for FC adapters
Date:   Mon, 19 Nov 2018 17:27:59 +0100
Message-Id: <20181119162618.458307377@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162612.951907286@linuxfoundation.org>
References: <20181119162612.951907286@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Himanshu Madhani <himanshu.madhani@cavium.com>

commit 4c1458df9635c7e3ced155f594d2e7dfd7254e21 upstream.

Fixes: 6246b8a1d26c7c ("[SCSI] qla2xxx: Enhancements to support ISP83xx.")
Fixes: 1bb395485160d2 ("qla2xxx: Correct iiDMA-update calling conventions.")
Cc: <stable@vger.kernel.org>
Signed-off-by: Himanshu Madhani <himanshu.madhani@cavium.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/qla2xxx/qla_mbx.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

--- a/drivers/scsi/qla2xxx/qla_mbx.c
+++ b/drivers/scsi/qla2xxx/qla_mbx.c
@@ -3682,10 +3682,7 @@ qla2x00_set_idma_speed(scsi_qla_host_t *
 	mcp->mb[0] = MBC_PORT_PARAMS;
 	mcp->mb[1] = loop_id;
 	mcp->mb[2] = BIT_0;
-	if (IS_CNA_CAPABLE(vha->hw))
-		mcp->mb[3] = port_speed & (BIT_5|BIT_4|BIT_3|BIT_2|BIT_1|BIT_0);
-	else
-		mcp->mb[3] = port_speed & (BIT_2|BIT_1|BIT_0);
+	mcp->mb[3] = port_speed & (BIT_5|BIT_4|BIT_3|BIT_2|BIT_1|BIT_0);
 	mcp->mb[9] = vha->vp_idx;
 	mcp->out_mb = MBX_9|MBX_3|MBX_2|MBX_1|MBX_0;
 	mcp->in_mb = MBX_3|MBX_1|MBX_0;


