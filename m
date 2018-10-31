Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FA6BC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:07:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1F2A20664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:07:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="DuJpgQy1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1F2A20664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729134AbeKAIHo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:07:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:55740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729065AbeKAIHn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:07:43 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E81420821;
        Wed, 31 Oct 2018 23:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541027252;
        bh=8eYbxooVdlF5ub09TAzOYwFF5oATdhJMgQR2WoZfpWM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DuJpgQy1llAE7A41ycOsMrF+9U884Mc8CaYqC/DYDKUcqvvJRQJZ9jnfKTlVujfWg
         WfZpuUglQ5ebMYq3GHaxr7W+8Yfw5ueV8iwhyWLkQceTV+yDOT7zjEhVWP2m3Wwo/e
         GoUPD1TAW4cxdHYjSRlvyNcDVd+BINJhWBomMWvE=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Quinn Tran <quinn.tran@cavium.com>, stable@ger.kernel.org,
        Himanshu Madhani <himanshu.madhani@cavium.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 122/146] scsi: qla2xxx: Fix recursive mailbox timeout
Date:   Wed, 31 Oct 2018 19:05:17 -0400
Message-Id: <20181031230541.28822-122-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031230541.28822-1-sashal@kernel.org>
References: <20181031230541.28822-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 drivers/scsi/qla2xxx/qla_mbx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/qla2xxx/qla_mbx.c b/drivers/scsi/qla2xxx/qla_mbx.c
index 2c6c2cd5a0d0..596a9b214df1 100644
--- a/drivers/scsi/qla2xxx/qla_mbx.c
+++ b/drivers/scsi/qla2xxx/qla_mbx.c
@@ -493,7 +493,7 @@ qla2x00_mailbox_command(scsi_qla_host_t *vha, mbx_cmd_t *mcp)
 				set_bit(ISP_ABORT_NEEDED, &vha->dpc_flags);
 				qla2xxx_wake_dpc(vha);
 			}
-		} else if (!abort_active) {
+		} else if (current == ha->dpc_thread) {
 			/* call abort directly since we are in the DPC thread */
 			ql_dbg(ql_dbg_mbx, vha, 0x101d,
 			    "Timeout, calling abort_isp.\n");
-- 
2.17.1

