Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1429103AbeCBPJI (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 10:09:08 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:5733 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1429022AbeCBPIC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 10:08:02 -0500
From: John Garry <john.garry@huawei.com>
To: <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC: <linux-scsi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        Xiaofei Tan <tanxiaofei@huawei.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH v2 5/8] scsi: hisi_sas: increase timer expire of internal abort task
Date: Fri, 2 Mar 2018 23:06:19 +0800
Message-ID: <1520003182-26277-6-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1520003182-26277-1-git-send-email-john.garry@huawei.com>
References: <1520003182-26277-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiaofei Tan <tanxiaofei@huawei.com>

The current 110ms expiry time is not long enough for the internal
abort task.

The reason is that the internal abort task could be blocked in HW
if the HW is retrying to set up link. The internal abort task will
be executed only when the retry process finished.

The maximum time is 5s for the retry of setting up link. So, the timer
expire should be more than 5s. This patch increases it from 110ms to 6s.

Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/hisi_sas/hisi_sas_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
index 9d16372..9ff8790 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -871,6 +871,7 @@ static void hisi_sas_tmf_timedout(struct timer_list *t)
 
 #define TASK_TIMEOUT 20
 #define TASK_RETRY 3
+#define INTERNAL_ABORT_TIMEOUT 6
 static int hisi_sas_exec_internal_tmf_task(struct domain_device *device,
 					   void *parameter, u32 para_len,
 					   struct hisi_sas_tmf_task *tmf)
@@ -1574,7 +1575,7 @@ static int hisi_sas_query_task(struct sas_task *task)
 	task->task_proto = device->tproto;
 	task->task_done = hisi_sas_task_done;
 	task->slow_task->timer.function = hisi_sas_tmf_timedout;
-	task->slow_task->timer.expires = jiffies + msecs_to_jiffies(110);
+	task->slow_task->timer.expires = jiffies + INTERNAL_ABORT_TIMEOUT*HZ;
 	add_timer(&task->slow_task->timer);
 
 	res = hisi_sas_internal_abort_task_exec(hisi_hba, sas_dev->device_id,
-- 
1.9.1
