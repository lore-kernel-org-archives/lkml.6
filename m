Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3CF0C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:05:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B34720866
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:05:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="mtyU0mEN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B34720866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732285AbeKLJz1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 04:55:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:34412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731884AbeKLIRp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:17:45 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1D522175B;
        Sun, 11 Nov 2018 22:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975270;
        bh=l7LeWHwSHtuK6+gaMjrgewWjeWqjfyTMB+p6n7g5ifc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mtyU0mENEcXivGczra8FDzZZFXwCAdjiq1It6nAemiQS/7pxps+W39mLO1lBf6hum
         ZprIKTnH0nKMBpdI+pjbFm1XZ0sqZiog2p0RRfSjYaIKyhsSskM5B+Nu7Sk8wUVPwu
         tHFPvHR5kaA1mwKZqoU1Erm9S82bu7Iu6tKdL63Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, stable@ger.kernel.org,
        Quinn Tran <quinn.tran@cavium.com>,
        "Ewan D. Milne" <emilne@redhat.com>,
        Himanshu Madhani <himanshu.madhani@cavium.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 166/361] scsi: qla2xxx: Fix recursive mailbox timeout
Date:   Sun, 11 Nov 2018 14:18:33 -0800
Message-Id: <20181111221643.682095382@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221619.915519183@linuxfoundation.org>
References: <20181111221619.915519183@linuxfoundation.org>
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

[ Upstream commit 710bc78f829d014eca95ed7ccc4052bc064b1320 ]

This patch prevents user space mailbox request from doing chip reset if the
mailbox timed out. The chip reset is only reserved for the DPC thread to
ensure all mailbox requests are flushed properly. The DPC thread is
responsible for the flushing all MBs and chip reset.

Fixes: b2000805a975 ("scsi: qla2xxx: Flush mailbox commands on chip reset")
Cc: <stable@ger.kernel.org>
Signed-off-by: Quinn Tran <quinn.tran@cavium.com>
Reviewed-by: Ewan D. Milne <emilne@redhat.com>
Signed-off-by: Himanshu Madhani <himanshu.madhani@cavium.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/qla2xxx/qla_mbx.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/scsi/qla2xxx/qla_mbx.c
+++ b/drivers/scsi/qla2xxx/qla_mbx.c
@@ -493,7 +493,7 @@ qla2x00_mailbox_command(scsi_qla_host_t
 				set_bit(ISP_ABORT_NEEDED, &vha->dpc_flags);
 				qla2xxx_wake_dpc(vha);
 			}
-		} else if (!abort_active) {
+		} else if (current == ha->dpc_thread) {
 			/* call abort directly since we are in the DPC thread */
 			ql_dbg(ql_dbg_mbx, vha, 0x101d,
 			    "Timeout, calling abort_isp.\n");


