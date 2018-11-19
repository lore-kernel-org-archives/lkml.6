Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06ECDC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:32:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3E2820870
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:32:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="pY1Bb7FZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3E2820870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730935AbeKTC47 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 21:56:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:55416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730221AbeKTC47 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 21:56:59 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D3892086A;
        Mon, 19 Nov 2018 16:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542645171;
        bh=r7nwC5Uj7Vcg3i5o7qN8r/s6w1/PLTkS/iuE9gakvYY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pY1Bb7FZDiR6atfdvtkKLQk7lJEwq03saKHpXdUQQ0veYiDWA7Ci96T+8wpVRJY0L
         wqEQme7UTu37u6gH/OTl2lOPzQDA3//afJ+xtjDhvIvXIjSVJA8Mmza64tLVtwWcm/
         +nqfw0yO5akKhPhHOYtPmjdZkwzYY4/5lqecTOv4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Quinn Tran <quinn.tran@cavium.com>,
        "Ewan D. Milne" <emilne@redhat.com>,
        Himanshu Madhani <himanshu.madhani@cavium.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.19 061/205] scsi: qla2xxx: Fix duplicate switch database entries
Date:   Mon, 19 Nov 2018 17:26:08 +0100
Message-Id: <20181119162628.074549631@linuxfoundation.org>
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

commit 732ee9a912cf2d9a50c5f9c4213cdc2f885d6aa6 upstream.

The response data buffer used in switch scan is reused 4 times.  (For example,
for commands GPN_FT, GNN_FT for FCP and FC-NVME) Before driver reuses this
buffer, clear it to prevent duplicate entries in our database.

Fixes: a4239945b8ad1 ("scsi: qla2xxx: Add switch command to simplify fabric discovery"
Cc: <stable@vger.kernel.org>
Signed-off-by: Quinn Tran <quinn.tran@cavium.com>
Reviewed-by: Ewan D. Milne <emilne@redhat.com>
Signed-off-by: Himanshu Madhani <himanshu.madhani@cavium.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/qla2xxx/qla_gs.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/scsi/qla2xxx/qla_gs.c
+++ b/drivers/scsi/qla2xxx/qla_gs.c
@@ -4447,9 +4447,9 @@ int qla24xx_async_gpnft(scsi_qla_host_t
 	sp->u.iocb_cmd.timeout = qla2x00_async_iocb_timeout;
 	qla2x00_init_timer(sp, qla2x00_get_async_timeout(vha) + 2);
 
-	rspsz = sizeof(struct ct_sns_gpnft_rsp) +
-		((vha->hw->max_fibre_devices - 1) *
-		    sizeof(struct ct_sns_gpn_ft_data));
+	rspsz = sp->u.iocb_cmd.u.ctarg.rsp_size;
+	memset(sp->u.iocb_cmd.u.ctarg.rsp, 0, sp->u.iocb_cmd.u.ctarg.rsp_size);
+	memset(sp->u.iocb_cmd.u.ctarg.req, 0, sp->u.iocb_cmd.u.ctarg.req_size);
 
 	ct_sns = (struct ct_sns_pkt *)sp->u.iocb_cmd.u.ctarg.req;
 	/* CT_IU preamble  */


