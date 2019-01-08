Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A35A9C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:29:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 730F42183F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546975766;
	bh=u/ssqokTEAvKBlVtv7/5497/fLar44ZWUb1ObTNHpEg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FHUuDG6hbc6w8vWjVgPknJr5WlrnF4O6FkGSQBaXuiZuO1A8+ogdSZLS0+pBWl55J
	 HSdXRm6xUavxiHfgM1BiKnR0d0q33CtK+7YDXyFMwoJ8b97nxE0vSFGsPbljUDWiVj
	 Tl8jwNvYAiBBlQ5q7NhBLE1l+Nnkc4mkEnntKXrs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730385AbfAHT3Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 14:29:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:36764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730367AbfAHT3X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 14:29:23 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 63FA8217D9;
        Tue,  8 Jan 2019 19:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546975762;
        bh=u/ssqokTEAvKBlVtv7/5497/fLar44ZWUb1ObTNHpEg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dF4RqVf7v+5jXzJ91A/5mAifxQztfK9swhkNC/IE3riBlIgpB27esATH3hwUpeooD
         08w1OpLZoGOk6SdZb9uzdlcRxXk/s6I/FTHPAyDqFSGzSmb3i/CgLEO7uV87WeAxNY
         RbOJhEubIQga2FOZuJTXNIilglzwiASF6tpHmUnM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kevin Barnett <kevin.barnett@microsemi.com>,
        Don Brace <don.brace@microsemi.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, esc.storagedev@microsemi.com,
        linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 104/117] scsi: smartpqi: correct lun reset issues
Date:   Tue,  8 Jan 2019 14:26:12 -0500
Message-Id: <20190108192628.121270-104-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190108192628.121270-1-sashal@kernel.org>
References: <20190108192628.121270-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kevin Barnett <kevin.barnett@microsemi.com>

[ Upstream commit 2ba55c9851d74eb015a554ef69ddf2ef061d5780 ]

Problem:
The Linux kernel takes a logical volume offline after a LUN reset.  This is
generally accompanied by this message in the dmesg output:

Device offlined - not ready after error recovery

Root Cause:
The root cause is a "quirk" in the timeout handling in the Linux SCSI
layer. The Linux kernel places a 30-second timeout on most media access
commands (reads and writes) that it send to device drivers.  When a media
access command times out, the Linux kernel goes into error recovery mode
for the LUN that was the target of the command that timed out. Every
command that timed out is kept on a list inside of the Linux kernel to be
retried later. The kernel attempts to recover the command(s) that timed out
by issuing a LUN reset followed by a TEST UNIT READY. If the LUN reset and
TEST UNIT READY commands are successful, the kernel retries the command(s)
that timed out.

Each SCSI command issued by the kernel has a result field associated with
it. This field indicates the final result of the command (success or
error). When a command times out, the kernel places a value in this result
field indicating that the command timed out.

The "quirk" is that after the LUN reset and TEST UNIT READY commands are
completed, the kernel checks each command on the timed-out command list
before retrying it. If the result field is still "timed out", the kernel
treats that command as not having been successfully recovered for a
retry. If the number of commands that are in this state are greater than
two, the kernel takes the LUN offline.

Fix:
When our RAIDStack receives a LUN reset, it simply waits until all
outstanding commands complete. Generally, all of these outstanding commands
complete successfully. Therefore, the fix in the smartpqi driver is to
always set the command result field to indicate success when a request
completes successfully. This normally isn’t necessary because the result
field is always initialized to success when the command is submitted to the
driver. So when the command completes successfully, the result field is
left untouched. But in this case, the kernel changes the result field
behind the driver’s back and then expects the field to be changed by the
driver as the commands that timed-out complete.

Reviewed-by: Dave Carroll <david.carroll@microsemi.com>
Reviewed-by: Scott Teel <scott.teel@microsemi.com>
Signed-off-by: Kevin Barnett <kevin.barnett@microsemi.com>
Signed-off-by: Don Brace <don.brace@microsemi.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/smartpqi/smartpqi_init.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/scsi/smartpqi/smartpqi_init.c b/drivers/scsi/smartpqi/smartpqi_init.c
index a25a07a0b7f0..c1efc182f5ea 100644
--- a/drivers/scsi/smartpqi/smartpqi_init.c
+++ b/drivers/scsi/smartpqi/smartpqi_init.c
@@ -2704,6 +2704,9 @@ static unsigned int pqi_process_io_intr(struct pqi_ctrl_info *ctrl_info,
 		switch (response->header.iu_type) {
 		case PQI_RESPONSE_IU_RAID_PATH_IO_SUCCESS:
 		case PQI_RESPONSE_IU_AIO_PATH_IO_SUCCESS:
+			if (io_request->scmd)
+				io_request->scmd->result = 0;
+			/* fall through */
 		case PQI_RESPONSE_IU_GENERAL_MANAGEMENT:
 			break;
 		case PQI_RESPONSE_IU_TASK_MANAGEMENT:
-- 
2.19.1

