Return-Path: <prvs=61814189d=ohad.sharabi@sandisk.com>
X-Google-Smtp-Source: AIpwx48KMcY/2v+3LTJLv8Vplv4C/6K2VoQu0InliNdtqz6tuIDymmo/01hNM5n6rHaqiHjNThlp
ARC-Seal: i=1; a=rsa-sha256; t=1522230151; cv=none;
        d=google.com; s=arc-20160816;
        b=l9tRClwsCFiF63BYRitzesZZ8C9KMZQjKOmFleWAg216MLTCSIg7cr3veRhK+2L6Xh
         squFd3wTedQAhhS7hp19Pby1j8tMJnBMc2MtYAMgQlto78gTxpId3tJ+XYnFIprksJdu
         BoLB44aAM/8TQDCwGXNZKnrOhDDypq8XZSqoXZh1RPtFqV0sPhOzchNqzZh1YU02MMNx
         UyIkKLdR5Ohyxx2sgCibp+0Skk0+ut5cqjHrbLKgHPp8ZI3DGm+eebKtYifcn6Sz30fU
         JG7mY2fd7uP+Dxu7WpoTxOp4uTdwCLxYq8PUQNiYMfFAaV3CUU8XjHm6Zza6wXzcjq3z
         AWxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=kkc6S80IQgKjv+VOT32QXVCcJXoPxpogLjwmuCjCK3Q=;
        b=FFYEAw8Cd6EnbGIWLfKU1PrROmFPvgzof/VDi9enpCmxb9xb7/lJ9XRy7FCdt8gy7u
         6gOlDXDuR4DarNsonANFyZX6NIxExyiFJCww2M1atsBlPGVbL2HW54sfaQYmlOl0MrNS
         53wPXqaLLnlWVSuNB9BzDoVpl4lIU4mYLmLf856gsfqppdjj9wyqQp5yVo7BVdgfB+XU
         mCaXOry5yo8RnFajoQ8WKz2mqwTuehgLYa6aSGll7UhUon+nuq+ESIdNfLtWt+h0EERL
         5SyIbFvL5k/i9LpZWXzgxK9KsgItg59utFiJfwatYn3IP98MUnNorys3mOTWGbhbdS4e
         RIqQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@sandisk.com header.s=dkim.sandisk.com header.b=p/u/FjE5;
       spf=pass (google.com: domain of prvs=61814189d=ohad.sharabi@sandisk.com designates 68.232.141.245 as permitted sender) smtp.mailfrom=prvs=61814189d=ohad.sharabi@sandisk.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@sandisk.com header.s=dkim.sandisk.com header.b=p/u/FjE5;
       spf=pass (google.com: domain of prvs=61814189d=ohad.sharabi@sandisk.com designates 68.232.141.245 as permitted sender) smtp.mailfrom=prvs=61814189d=ohad.sharabi@sandisk.com
X-IronPort-AV: E=Sophos;i="5.48,370,1517846400";
   d="scan'208";a="177741648"
From: Ohad Sharabi <ohad.sharabi@sandisk.com>
To: stanislav.nijnikov@wdc.com,
	jejb@linux.vnet.ibm.com,
	martin.petersen@oracle.com,
	gregkh@linuxfoundation.org
Cc: linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	alex.lemberg@wdc.com,
	Ohad Sharabi <ohad.sharabi@sandisk.com>
Subject: [PATCH v3] scsi: ufs: add trace event for ufs upiu
Date: Wed, 28 Mar 2018 12:42:18 +0300
Message-Id: <1522230138-27674-1-git-send-email-ohad.sharabi@sandisk.com>
X-Mailer: git-send-email 1.9.1
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596174003792567298?=
X-GMAIL-MSGID: =?utf-8?q?1596174003792567298?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add UFS Protocol Information Units(upiu) trace events for ufs driver,
used to trace various ufs transaction types- command, task-management
and device management.
The trace-point format is generic and can be easily adapted to trace
other upius if needed.
Currently tracing ufs transaction of type 'device management', which
this patch introduce, cannot be obtained from any other trace.
Device management transactions are used for communication with the
device such as reading and writing descriptor or attributes etc.

Signed-off-by: Ohad Sharabi <ohad.sharabi@sandisk.com>
Reviewed-by: Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
Reviewed-by: Bart Van Assche <bart.vanassche@wdc.com>
---
v2->v3:
    - modify args 3,4 of trace_ufshcd_upiu to be void *

v1->v2:
    - split to transaction specific functions (fix warnings and simplifies
      code)
    - adding traces when sending query command

 drivers/scsi/ufs/ufshcd.c  | 40 ++++++++++++++++++++++++++++++++++++++++
 include/trace/events/ufs.h | 27 +++++++++++++++++++++++++++
 2 files changed, 67 insertions(+)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index c7da2c1..23ffaed 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -274,6 +274,35 @@ static inline void ufshcd_remove_non_printable(char *val)
 		*val = ' ';
 }
 
+static void ufshcd_add_cmd_upiu_trace(struct ufs_hba *hba, unsigned int tag,
+		const char *str)
+{
+	struct utp_upiu_req *rq = hba->lrb[tag].ucd_req_ptr;
+
+	trace_ufshcd_upiu(dev_name(hba->dev), str, &rq->header, &rq->sc.cdb);
+}
+
+static void ufshcd_add_query_upiu_trace(struct ufs_hba *hba, unsigned int tag,
+		const char *str)
+{
+	struct utp_upiu_req *rq = hba->lrb[tag].ucd_req_ptr;
+
+	trace_ufshcd_upiu(dev_name(hba->dev), str, &rq->header, &rq->qr);
+}
+
+static void ufshcd_add_tm_upiu_trace(struct ufs_hba *hba, unsigned int tag,
+		const char *str)
+{
+	struct utp_task_req_desc *descp;
+	struct utp_upiu_task_req *task_req;
+	int off = (int)tag - hba->nutrs;
+
+	descp = &hba->utmrdl_base_addr[off];
+	task_req = (struct utp_upiu_task_req *)descp->task_req_upiu;
+	trace_ufshcd_upiu(dev_name(hba->dev), str, &task_req->header,
+			&task_req->input_param1);
+}
+
 static void ufshcd_add_command_trace(struct ufs_hba *hba,
 		unsigned int tag, const char *str)
 {
@@ -283,6 +312,9 @@ static void ufshcd_add_command_trace(struct ufs_hba *hba,
 	struct ufshcd_lrb *lrbp;
 	int transfer_len = -1;
 
+	/* trace UPIU also */
+	ufshcd_add_cmd_upiu_trace(hba, tag, str);
+
 	if (!trace_ufshcd_command_enabled())
 		return;
 
@@ -2584,6 +2616,7 @@ static int ufshcd_exec_dev_cmd(struct ufs_hba *hba,
 
 	hba->dev_cmd.complete = &wait;
 
+	ufshcd_add_query_upiu_trace(hba, tag, "query_send");
 	/* Make sure descriptors are ready before ringing the doorbell */
 	wmb();
 	spin_lock_irqsave(hba->host->host_lock, flags);
@@ -2593,6 +2626,9 @@ static int ufshcd_exec_dev_cmd(struct ufs_hba *hba,
 
 	err = ufshcd_wait_for_dev_cmd(hba, lrbp, timeout);
 
+	ufshcd_add_query_upiu_trace(hba, tag,
+			err ? "query_complete_err" : "query_complete");
+
 out_put_tag:
 	ufshcd_put_dev_cmd_tag(hba, tag);
 	wake_up(&hba->dev_cmd.tag_wq);
@@ -5464,11 +5500,14 @@ static int ufshcd_issue_tm_cmd(struct ufs_hba *hba, int lun_id, int task_id,
 
 	spin_unlock_irqrestore(host->host_lock, flags);
 
+	ufshcd_add_tm_upiu_trace(hba, task_tag, "tm_send");
+
 	/* wait until the task management command is completed */
 	err = wait_event_timeout(hba->tm_wq,
 			test_bit(free_slot, &hba->tm_condition),
 			msecs_to_jiffies(TM_CMD_TIMEOUT));
 	if (!err) {
+		ufshcd_add_tm_upiu_trace(hba, task_tag, "tm_complete_err");
 		dev_err(hba->dev, "%s: task management cmd 0x%.2x timed-out\n",
 				__func__, tm_function);
 		if (ufshcd_clear_tm_cmd(hba, free_slot))
@@ -5477,6 +5516,7 @@ static int ufshcd_issue_tm_cmd(struct ufs_hba *hba, int lun_id, int task_id,
 		err = -ETIMEDOUT;
 	} else {
 		err = ufshcd_task_req_compl(hba, free_slot, tm_response);
+		ufshcd_add_tm_upiu_trace(hba, task_tag, "tm_complete");
 	}
 
 	clear_bit(free_slot, &hba->tm_condition);
diff --git a/include/trace/events/ufs.h b/include/trace/events/ufs.h
index bf6f826..f8260e5 100644
--- a/include/trace/events/ufs.h
+++ b/include/trace/events/ufs.h
@@ -257,6 +257,33 @@
 	)
 );
 
+TRACE_EVENT(ufshcd_upiu,
+	TP_PROTO(const char *dev_name, const char *str, void *hdr, void *tsf),
+
+	TP_ARGS(dev_name, str, hdr, tsf),
+
+	TP_STRUCT__entry(
+		__string(dev_name, dev_name)
+		__string(str, str)
+		__array(unsigned char, hdr, 12)
+		__array(unsigned char, tsf, 16)
+	),
+
+	TP_fast_assign(
+		__assign_str(dev_name, dev_name);
+		__assign_str(str, str);
+		memcpy(__entry->hdr, hdr, sizeof(__entry->hdr));
+		memcpy(__entry->tsf, tsf, sizeof(__entry->tsf));
+	),
+
+	TP_printk(
+		"%s: %s: HDR:%s, CDB:%s",
+		__get_str(str), __get_str(dev_name),
+		__print_hex(__entry->hdr, sizeof(__entry->hdr)),
+		__print_hex(__entry->tsf, sizeof(__entry->tsf))
+	)
+);
+
 #endif /* if !defined(_TRACE_UFS_H) || defined(TRACE_HEADER_MULTI_READ) */
 
 /* This part must be outside protection */
-- 
1.9.1
