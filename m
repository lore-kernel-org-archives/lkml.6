Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E60D2C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:32:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFE2E2086A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:32:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZdZpxj+i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFE2E2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730884AbeKTC4w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 21:56:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:55222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730869AbeKTC4v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 21:56:51 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C137920870;
        Mon, 19 Nov 2018 16:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542645164;
        bh=SbfbzIa8VSzBnUVxQZ7MwAUtSc9OkHs3VicVPNtpCuI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZdZpxj+iJ4RCef6pNWxMVcJHwhnAZQLquBpTu4QsiDjgGUKZZQogudPijV/jeScMK
         vBtjDsqT35+nusloLWMPztGNP52SMc2l5sDwfSWc0YmG4SKLwTH2Q7V83ChMTW8/QX
         J6fv1jECftFI01VuGPAPiBQAttcZkHl0pALp5RUs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Quinn Tran <quinn.tran@cavium.com>,
        "Ewan D. Milne" <emilne@redhat.com>,
        Himanshu Madhani <himanshu.madhani@cavium.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.19 059/205] scsi: qla2xxx: Fix NVMe session hang on unload
Date:   Mon, 19 Nov 2018 17:26:06 +0100
Message-Id: <20181119162627.644268201@linuxfoundation.org>
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

commit f7d61c995df74d6bb57bbff6a2b7b1874c4a2baa upstream.

Send aborts only when chip is active.

Fixes: 623ee824e579 ("scsi: qla2xxx: Fix FC-NVMe IO abort during driver reset")
Cc: <stable@vger.kernel.org> # 4.14
Signed-off-by: Quinn Tran <quinn.tran@cavium.com>
Reviewed-by: Ewan D. Milne <emilne@redhat.com>
Signed-off-by: Himanshu Madhani <himanshu.madhani@cavium.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/qla2xxx/qla_nvme.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/scsi/qla2xxx/qla_nvme.c
+++ b/drivers/scsi/qla2xxx/qla_nvme.c
@@ -607,7 +607,7 @@ void qla_nvme_abort(struct qla_hw_data *
 {
 	int rval;
 
-	if (!test_bit(ABORT_ISP_ACTIVE, &sp->vha->dpc_flags)) {
+	if (ha->flags.fw_started) {
 		rval = ha->isp_ops->abort_command(sp);
 		if (!rval && !qla_nvme_wait_on_command(sp))
 			ql_log(ql_log_warn, NULL, 0x2112,


