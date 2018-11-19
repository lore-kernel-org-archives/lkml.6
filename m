Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74DEEC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:32:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DD7E20831
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:32:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="krTm6nvD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DD7E20831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730830AbeKTC4n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 21:56:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:55012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730015AbeKTC4m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 21:56:42 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D45420831;
        Mon, 19 Nov 2018 16:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542645155;
        bh=kABwgflrxr/oieKF3C7Ih5zGAo7zuCFYvjP6KrKd0mk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=krTm6nvDqgKo+byNfzUrqrGcSWqZabcFFxqb7zYGq2BKcEAkbXReEKJCBPCyks9Rn
         PVgPjF1a5+oV2fYjzlqE/fPwS6VlX6GvyR2Yl8NP+OWD1ogPu2/KzkHyCI28H+PCEg
         6mMjKYNodOUVHt0YLlR2clzWH4cCQtBXjusEr7Zs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Quinn Tran <quinn.tran@cavium.com>,
        Himanshu Madhani <himanshu.madhani@cavium.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.19 056/205] scsi: qla2xxx: Reject bsg request if chip is down.
Date:   Mon, 19 Nov 2018 17:26:03 +0100
Message-Id: <20181119162627.174244299@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162616.586062722@linuxfoundation.org>
References: <20181119162616.586062722@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Quinn Tran <quinn.tran@cavium.com>

commit 56d942de59ebfa2e970a6cd33299d1984710b6c0 upstream.

Reject bsg request if chip is down.  This prevent erroneous timeout.

Fixes: d051a5aa1c23 ("[SCSI] qla2xxx: Add an "is reset active" helper.")
Cc: stable@vger.kernel.org # 4.10
Signed-off-by: Quinn Tran <quinn.tran@cavium.com>
Signed-off-by: Himanshu Madhani <himanshu.madhani@cavium.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/qla2xxx/qla_bsg.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/scsi/qla2xxx/qla_bsg.c
+++ b/drivers/scsi/qla2xxx/qla_bsg.c
@@ -2487,7 +2487,7 @@ qla24xx_bsg_request(struct bsg_job *bsg_
 		vha = shost_priv(host);
 	}
 
-	if (qla2x00_reset_active(vha)) {
+	if (qla2x00_chip_is_down(vha)) {
 		ql_dbg(ql_dbg_user, vha, 0x709f,
 		    "BSG: ISP abort active/needed -- cmd=%d.\n",
 		    bsg_request->msgcode);


