Return-Path: <prvs=615d01a9e=ohad.sharabi@sandisk.com>
X-Google-Smtp-Source: AG47ELsOpZ9mZ1Op+cWCuze8aXgL0CUHSXm3fzN4rSA+QU3OABeIc9P+6vSm5A6Mlgwess/JPM8o
ARC-Seal: i=1; a=rsa-sha256; t=1521961702; cv=none;
        d=google.com; s=arc-20160816;
        b=BDhhjEaRb7eoaUSG36MREFEF87ayS6ILhadnYFMjWXmVQQI8gnEhOq7aM/Z6ISne42
         8MTpKdgoCiuFeWGeKMl6ciRpJ+aAqvKpwK/StFcpxQNhoA6aAwbPuoAZH03XVKukNIi+
         htq+RIMVvpmkVp0YAjV/2iY8onuwhouXi2qc4xMBH1Z+iSWIbBhSl8KdJYcqXYT8llB+
         BW5JQ1tBYkj2joe/jDZveUMY96GKhnkBmEo7e1+xzwO7ygKm33AbSzbaqVchJsV1ncyG
         LJ4tQqRAhwxkgOIRpN5AJv5eWdaD3z5kF8UPVQnoCXIcAzykoFhM6gTRI4+TgV07UXOC
         ST2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=VEtXK7I1BF4FXjKec65Tv85HDXynugSzUMK9RwAA+54=;
        b=mcSyfTZR+hoOwX1rAGTkslnekGbKnku9F66ibUH7JpaMQ+3rQcxHufx7pDT4gPyLAH
         NKVT6msk0edFHLbmJxRacyqV3RcWB9w7FIH1A8TI73Vj7wstyVKv2J3rMMaDb8Jbzwa/
         KbLSr2DHSq/LnoukXxUNyT9BDZr/Z/x+sAXlBkCuTQl0au594Yx++8Lz4yjWSDHJmYQR
         09jO4eC0jf26cjxy5fjZEYocK/bmJ9s3oapO9QkoAO28zv5kpvjjXgsmXLWAIsuJ+mNV
         S0HVVlAFpT+f8/ycDWFoo06seeov/z335qFkCcEP4+nm0oeZlNhzfvqT+4V1wcsrAArH
         ZRxg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@sandisk.com header.s=dkim.sandisk.com header.b=evlCxlo1;
       spf=pass (google.com: domain of prvs=615d01a9e=ohad.sharabi@sandisk.com designates 216.71.154.45 as permitted sender) smtp.mailfrom=prvs=615d01a9e=ohad.sharabi@sandisk.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@sandisk.com header.s=dkim.sandisk.com header.b=evlCxlo1;
       spf=pass (google.com: domain of prvs=615d01a9e=ohad.sharabi@sandisk.com designates 216.71.154.45 as permitted sender) smtp.mailfrom=prvs=615d01a9e=ohad.sharabi@sandisk.com
X-IronPort-AV: E=Sophos;i="5.48,358,1517846400";
   d="scan'208";a="75019972"
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
Date: Sun, 25 Mar 2018 10:08:04 +0300
Message-Id: <1521961684-13588-1-git-send-email-ohad.sharabi@sandisk.com>
X-Mailer: git-send-email 1.9.1
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595892513876179134?=
X-GMAIL-MSGID: =?utf-8?q?1595892513876179134?=
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

v2->v3:
    - modify args 3,4 of trace_ufshcd_upiu to be void *

v1->v2:
    - split to transaction specific functions (fix warnings and simplifies
      code)
    - adding traces when sending query command

Signed-off-by: Ohad Sharabi <ohad.sharabi@sandisk.com>
---
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
