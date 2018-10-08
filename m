Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 385F1C677E4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E722F214FA
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:26:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="h4F9xc0l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E722F214FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727863AbeJHWiY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 18:38:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:56852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726451AbeJHWiX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 18:38:23 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 34C24214FF;
        Mon,  8 Oct 2018 15:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539012368;
        bh=Kxdz2FMheazQ7bfbYa+j9PFYOkN37ZvsaLMSwIvU5FE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h4F9xc0lao5QWh6v+JlJWn870xIYzoEiU0u0hfEp34jkZxJfJ9M80K0fdTMc2E4/s
         oqWv2XdZ+DO2Y/ZV8Ugruszzx1elVuXBEwFby1MxR49R0DOR2X325svLoe0lK/IJMt
         RALYB0sODGh2W+NQwetquS6rHomTQnfDp4FpLxFs=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 43/58] scsi: sd: don't crash the host on invalid commands
Date:   Mon,  8 Oct 2018 11:25:08 -0400
Message-Id: <20181008152523.70705-43-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181008152523.70705-1-sashal@kernel.org>
References: <20181008152523.70705-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johannes Thumshirn <jthumshirn@suse.de>

[ Upstream commit f1f1fadacaf08b7cf11714c0c29f8fa4d4ef68a9 ]

When sd_init_command() get's a command with a unknown req_op() it crashes the
system via BUG().

This makes debugging the actual reason for the broken request cmd_flags pretty
hard as the system is down before it's able to write out debugging data on the
serial console or the trace buffer.

Change the BUG() to a WARN_ON() and return BLKPREP_KILL to fail gracefully and
return an I/O error to the producer of the request.

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Christoph Hellwig <hch@lst.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/scsi/sd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 9421d9877730..0949d3db56e7 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -1277,7 +1277,8 @@ static int sd_init_command(struct scsi_cmnd *cmd)
 	case REQ_OP_ZONE_RESET:
 		return sd_zbc_setup_reset_cmnd(cmd);
 	default:
-		BUG();
+		WARN_ON_ONCE(1);
+		return BLKPREP_KILL;
 	}
 }
 
-- 
2.17.1

