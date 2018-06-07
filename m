Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id m47vHHtIGVttSAAAmS7hNA
	; Thu, 07 Jun 2018 15:02:04 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 7B780608C8; Thu,  7 Jun 2018 15:02:04 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id E0694606DD;
	Thu,  7 Jun 2018 15:02:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E0694606DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935891AbeFGPCC (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 11:02:02 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41423 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935339AbeFGPB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 11:01:56 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbU-0005dI-8N; Thu, 07 Jun 2018 15:09:28 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbB-0003B8-8A; Thu, 07 Jun 2018 15:09:09 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Tejun Heo" <tj@kernel.org>,
        "Jason Yan" <yanaijie@huawei.com>,
        "Ding Xiang" <dingxiang@huawei.com>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.848561429@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 318/410] ata: do not schedule hot plug if it is a sas
 host
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Jason Yan <yanaijie@huawei.com>

commit 6f54120e17e311fd7ac42b9ec2a0611caa5b46ad upstream.

We've got a kernel panic when using sata disk with sas controller:

[115946.152283] Unable to handle kernel NULL pointer dereference at virtual address 000007d8
[115946.223963] CPU: 0 PID: 22175 Comm: kworker/0:1 Tainted: G   W OEL  4.14.0 #1
[115946.232925] Workqueue: events ata_scsi_hotplug
[115946.237938] task: ffff8021ee50b180 task.stack: ffff00000d5d0000
[115946.244717] PC is at sas_find_dev_by_rphy+0x44/0x114
[115946.250224] LR is at sas_find_dev_by_rphy+0x3c/0x114
......
[115946.355701] Process kworker/0:1 (pid: 22175, stack limit = 0xffff00000d5d0000)
[115946.363369] Call trace:
[115946.456356] [<ffff000008878a9c>] sas_find_dev_by_rphy+0x44/0x114
[115946.462908] [<ffff000008878b8c>] sas_target_alloc+0x20/0x5c
[115946.469408] [<ffff00000885a31c>] scsi_alloc_target+0x250/0x308
[115946.475781] [<ffff00000885ba30>] __scsi_add_device+0xb0/0x154
[115946.481991] [<ffff0000088b520c>] ata_scsi_scan_host+0x180/0x218
[115946.488367] [<ffff0000088b53d8>] ata_scsi_hotplug+0xb0/0xcc
[115946.494801] [<ffff0000080ebd70>] process_one_work+0x144/0x390
[115946.501115] [<ffff0000080ec100>] worker_thread+0x144/0x418
[115946.507093] [<ffff0000080f2c98>] kthread+0x10c/0x138
[115946.512792] [<ffff0000080855dc>] ret_from_fork+0x10/0x18

We found that Ding Xiang has reported a similar bug before:
https://patchwork.kernel.org/patch/9179817/

And this bug still exists in mainline. Since libsas handles hotplug and
device adding/removing itself, do not need to schedule ata hot plug task
here if it is a sas host.

Signed-off-by: Jason Yan <yanaijie@huawei.com>
Cc: Ding Xiang <dingxiang@huawei.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/ata/libata-eh.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -815,7 +815,8 @@ void ata_scsi_port_error_handler(struct
 
 	if (ap->pflags & ATA_PFLAG_LOADING)
 		ap->pflags &= ~ATA_PFLAG_LOADING;
-	else if (ap->pflags & ATA_PFLAG_SCSI_HOTPLUG)
+	else if ((ap->pflags & ATA_PFLAG_SCSI_HOTPLUG) &&
+		!(ap->flags & ATA_FLAG_SAS_HOST))
 		schedule_delayed_work(&ap->hotplug_task, 0);
 
 	if (ap->pflags & ATA_PFLAG_RECOVERED)
