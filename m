Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuZj02+Ro03ad1bQzULFmrXfOT6kKfcn+2ANsfXSsZBSbMNEdgLdYxi/mqBa37qhkj9uGtF
ARC-Seal: i=1; a=rsa-sha256; t=1520954970; cv=none;
        d=google.com; s=arc-20160816;
        b=gdGRbZe+eOSc9+PNrKHMRDj3nbBppnv5pO6CqTUSeI2jHjfEjklUkGTtkA6zpevTGU
         owStXMPkg/3NQcdKzsvQPUbcDBHrTYbPkVz7b3ZFoGWMwfs6aGBg2sWBi0N2rQKwSXoR
         KeIl/hbAboDxSR7qXk6Puf9XasgG+7WYY/PVzKLUZao7u0mTgknpFn/mWj5VnjOz6dc2
         F9rMAgCEPfyVhBgyAUVkr8HGp4/uPXCd5b0WbXk9mMRBgdwQKnEUX704HZnGCXRCH+Eb
         HGLQZdmPb4lekVa428y9VPmB1XIs0MtH7Ui+Qs+rBBlfz3iw2rCdHdcZWuqDuysQdbEO
         gCoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=9WxqrN3uqxfaSl6bdEUWPkaJqaZf1mPFMucLrYroSwk=;
        b=rlr1ZAAVTM3t4dVDm0oQV2UlipTGofIAJGR/W1tgcp2F25WnHhbUZG9ANDXy3fiUnn
         kuDMFsOO4AGrMos6JxBNoUUxyLqL4K/gBDEf5hpAzosLgOWrperArqPDOs9rP/Vy0ve9
         4Im2vyjVS0S1Wp2H5Jo5wZDpUQa8Y7x7/yoNe8QVofZzO9UgjCxv99cDvp5fxVv0fERu
         ZBtGKWbiNchuO2Dl65SMdmju6eAfBxBuerZ5ybbMiHec3TjFRE/5jQ11+bmPoLTDBsun
         RRWhTo3W/1JGmqemSH3NvBLsjUe020tBqmTHZJaurUeiky+D5PTutnKn+TXZpk0f+S/I
         VB1w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Natanael Copa <ncopa@alpinelinux.org>,
	Damien Le Moal <damien.lemoal@wdc.com>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Alexandre Oliva <oliva@gnu.org>,
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
	Hannes Reinecke <hare@suse.com>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.15 017/146] scsi: core: Avoid that ATA error handling can trigger a kernel hang or oops
Date: Tue, 13 Mar 2018 16:23:04 +0100
Message-Id: <20180313152321.845919842@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152320.439085687@linuxfoundation.org>
References: <20180313152320.439085687@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594836878897044643?=
X-GMAIL-MSGID: =?utf-8?q?1594836878897044643?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bart Van Assche <bart.vanassche@wdc.com>

commit 3be8828fc507cdafe7040a3dcf361a2bcd8e305b upstream.

Avoid that the recently introduced call_rcu() call in the SCSI core
triggers a double call_rcu() call.

Reported-by: Natanael Copa <ncopa@alpinelinux.org>
Reported-by: Damien Le Moal <damien.lemoal@wdc.com>
References: https://bugzilla.kernel.org/show_bug.cgi?id=198861
Fixes: 3bd6f43f5cb3 ("scsi: core: Ensure that the SCSI error handler gets woken up")
Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>
Tested-by: Damien Le Moal <damien.lemoal@wdc.com>
Cc: Natanael Copa <ncopa@alpinelinux.org>
Cc: Damien Le Moal <damien.lemoal@wdc.com>
Cc: Alexandre Oliva <oliva@gnu.org>
Cc: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
Cc: <stable@vger.kernel.org>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/hosts.c      |    3 ---
 drivers/scsi/scsi_error.c |    5 +++--
 drivers/scsi/scsi_lib.c   |    2 ++
 include/scsi/scsi_cmnd.h  |    3 +++
 include/scsi/scsi_host.h  |    2 --
 5 files changed, 8 insertions(+), 7 deletions(-)

--- a/drivers/scsi/hosts.c
+++ b/drivers/scsi/hosts.c
@@ -328,8 +328,6 @@ static void scsi_host_dev_release(struct
 	if (shost->work_q)
 		destroy_workqueue(shost->work_q);
 
-	destroy_rcu_head(&shost->rcu);
-
 	if (shost->shost_state == SHOST_CREATED) {
 		/*
 		 * Free the shost_dev device name here if scsi_host_alloc()
@@ -404,7 +402,6 @@ struct Scsi_Host *scsi_host_alloc(struct
 	INIT_LIST_HEAD(&shost->starved_list);
 	init_waitqueue_head(&shost->host_wait);
 	mutex_init(&shost->scan_mutex);
-	init_rcu_head(&shost->rcu);
 
 	index = ida_simple_get(&host_index_ida, 0, 0, GFP_KERNEL);
 	if (index < 0)
--- a/drivers/scsi/scsi_error.c
+++ b/drivers/scsi/scsi_error.c
@@ -222,7 +222,8 @@ static void scsi_eh_reset(struct scsi_cm
 
 static void scsi_eh_inc_host_failed(struct rcu_head *head)
 {
-	struct Scsi_Host *shost = container_of(head, typeof(*shost), rcu);
+	struct scsi_cmnd *scmd = container_of(head, typeof(*scmd), rcu);
+	struct Scsi_Host *shost = scmd->device->host;
 	unsigned long flags;
 
 	spin_lock_irqsave(shost->host_lock, flags);
@@ -258,7 +259,7 @@ void scsi_eh_scmd_add(struct scsi_cmnd *
 	 * Ensure that all tasks observe the host state change before the
 	 * host_failed change.
 	 */
-	call_rcu(&shost->rcu, scsi_eh_inc_host_failed);
+	call_rcu(&scmd->rcu, scsi_eh_inc_host_failed);
 }
 
 /**
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -670,6 +670,7 @@ static bool scsi_end_request(struct requ
 	if (!blk_rq_is_scsi(req)) {
 		WARN_ON_ONCE(!(cmd->flags & SCMD_INITIALIZED));
 		cmd->flags &= ~SCMD_INITIALIZED;
+		destroy_rcu_head(&cmd->rcu);
 	}
 
 	if (req->mq_ctx) {
@@ -1150,6 +1151,7 @@ void scsi_initialize_rq(struct request *
 	struct scsi_cmnd *cmd = blk_mq_rq_to_pdu(rq);
 
 	scsi_req_init(&cmd->req);
+	init_rcu_head(&cmd->rcu);
 	cmd->jiffies_at_alloc = jiffies;
 	cmd->retries = 0;
 }
--- a/include/scsi/scsi_cmnd.h
+++ b/include/scsi/scsi_cmnd.h
@@ -69,6 +69,9 @@ struct scsi_cmnd {
 	struct list_head list;  /* scsi_cmnd participates in queue lists */
 	struct list_head eh_entry; /* entry for the host eh_cmd_q */
 	struct delayed_work abort_work;
+
+	struct rcu_head rcu;
+
 	int eh_eflags;		/* Used by error handlr */
 
 	/*
--- a/include/scsi/scsi_host.h
+++ b/include/scsi/scsi_host.h
@@ -571,8 +571,6 @@ struct Scsi_Host {
 		struct blk_mq_tag_set	tag_set;
 	};
 
-	struct rcu_head rcu;
-
 	atomic_t host_busy;		   /* commands actually active on low-level */
 	atomic_t host_blocked;
 
