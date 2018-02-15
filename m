Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2267HBcZtUITsKdVKtK553CpjMfu3jRKJd9MtJyqYjqbpsYFnXb9J+VHalLIXfF4lm2e1o0S
ARC-Seal: i=1; a=rsa-sha256; t=1518709107; cv=none;
        d=google.com; s=arc-20160816;
        b=OuPiwntWiBlQG/SF2J8D/dRZKVL53518tykW2GC5XrYIQcQgRW6HhglhANL6pZNW9D
         dQLP7Fo6ubOcbWOpZD+Whi2EQvD7ldCcnH3Hw7MOh69yzV58Px4kZE+VXZJuBYCRHMsy
         0B0wDIR+D9rE+n1GCZhuQ7OCBKepArArcL5UlbIb1rArc2EZeZq1VVAhkEmt8R01uQAJ
         Uq3UqjKWvwCtqfdQszjXM8oFxpl9vKsSOpTF0MwZOw6IPBBS+leiP1KqL1Dxr1r/WqJc
         ipQyXgcwBfOQnxhh8qhiDudXbWJjU509ThKhowF2IUMlVUAcLIGyge8e1qGyYYzEy5A9
         dZbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=FKlIut1hAYoA6i2d20MYIwjvCK6ry1QM8UR1OcUtODA=;
        b=fv2Oo86NiXDmoAZWHcO2Ri7NQRI2YEDpvlAcBGFiZAVaL0r7oqV/HfApEHmjyIllBj
         u99JBzDgsp+IoCwy+uGEcUpsQjXBrccNq4nIkYhjx/ss0qEw2cR4lIVHnb03A4shxltG
         +ceqvFSB4Uzu747+zdEFsr2C7FWFwaOCEgu+3XqSQp14bRMk+h4bb0Z3tQ8ZkALImCAt
         M3SpQ574hhl7PFKUMuHGxeuXzRBoa6RT+16JuOE5Ho5cVV1mGII7+ZAFirEzLbeZlxdl
         yfNjPuCyQuf1CP/kYKol9GngufQbVjsvUlkuPPjLUgFG6e/At2SxvNrOvFMtcQkWhZXt
         OPQg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Stuart Hayes <stuart.w.hayes@gmail.com>,
	Konstantin Khorenko <khorenko@virtuozzo.com>,
	Christoph Hellwig <hch@lst.de>,
	Hannes Reinecke <hare@suse.com>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.14 193/195] scsi: core: Ensure that the SCSI error handler gets woken up
Date: Thu, 15 Feb 2018 16:18:04 +0100
Message-Id: <20180215151715.998979032@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481921759159373?=
X-GMAIL-MSGID: =?utf-8?q?1592481921759159373?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bart Van Assche <bart.vanassche@wdc.com>

commit 3bd6f43f5cb3714f70c591514f344389df593501 upstream.

If scsi_eh_scmd_add() is called concurrently with
scsi_host_queue_ready() while shost->host_blocked > 0 then it can
happen that neither function wakes up the SCSI error handler. Fix
this by making every function that decreases the host_busy counter
wake up the error handler if necessary and by protecting the
host_failed checks with the SCSI host lock.

Reported-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
References: https://marc.info/?l=linux-kernel&m=150461610630736
Fixes: commit 746650160866 ("scsi: convert host_busy to atomic_t")
Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Reviewed-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Tested-by: Stuart Hayes <stuart.w.hayes@gmail.com>
Cc: Konstantin Khorenko <khorenko@virtuozzo.com>
Cc: Stuart Hayes <stuart.w.hayes@gmail.com>
Cc: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/hosts.c      |    6 ++++++
 drivers/scsi/scsi_error.c |   18 ++++++++++++++++--
 drivers/scsi/scsi_lib.c   |   39 ++++++++++++++++++++++++++++-----------
 include/scsi/scsi_host.h  |    2 ++
 4 files changed, 52 insertions(+), 13 deletions(-)

--- a/drivers/scsi/hosts.c
+++ b/drivers/scsi/hosts.c
@@ -318,6 +318,9 @@ static void scsi_host_dev_release(struct
 
 	scsi_proc_hostdir_rm(shost->hostt);
 
+	/* Wait for functions invoked through call_rcu(&shost->rcu, ...) */
+	rcu_barrier();
+
 	if (shost->tmf_work_q)
 		destroy_workqueue(shost->tmf_work_q);
 	if (shost->ehandler)
@@ -325,6 +328,8 @@ static void scsi_host_dev_release(struct
 	if (shost->work_q)
 		destroy_workqueue(shost->work_q);
 
+	destroy_rcu_head(&shost->rcu);
+
 	if (shost->shost_state == SHOST_CREATED) {
 		/*
 		 * Free the shost_dev device name here if scsi_host_alloc()
@@ -399,6 +404,7 @@ struct Scsi_Host *scsi_host_alloc(struct
 	INIT_LIST_HEAD(&shost->starved_list);
 	init_waitqueue_head(&shost->host_wait);
 	mutex_init(&shost->scan_mutex);
+	init_rcu_head(&shost->rcu);
 
 	index = ida_simple_get(&host_index_ida, 0, 0, GFP_KERNEL);
 	if (index < 0)
--- a/drivers/scsi/scsi_error.c
+++ b/drivers/scsi/scsi_error.c
@@ -220,6 +220,17 @@ static void scsi_eh_reset(struct scsi_cm
 	}
 }
 
+static void scsi_eh_inc_host_failed(struct rcu_head *head)
+{
+	struct Scsi_Host *shost = container_of(head, typeof(*shost), rcu);
+	unsigned long flags;
+
+	spin_lock_irqsave(shost->host_lock, flags);
+	shost->host_failed++;
+	scsi_eh_wakeup(shost);
+	spin_unlock_irqrestore(shost->host_lock, flags);
+}
+
 /**
  * scsi_eh_scmd_add - add scsi cmd to error handling.
  * @scmd:	scmd to run eh on.
@@ -242,9 +253,12 @@ void scsi_eh_scmd_add(struct scsi_cmnd *
 
 	scsi_eh_reset(scmd);
 	list_add_tail(&scmd->eh_entry, &shost->eh_cmd_q);
-	shost->host_failed++;
-	scsi_eh_wakeup(shost);
 	spin_unlock_irqrestore(shost->host_lock, flags);
+	/*
+	 * Ensure that all tasks observe the host state change before the
+	 * host_failed change.
+	 */
+	call_rcu(&shost->rcu, scsi_eh_inc_host_failed);
 }
 
 /**
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -318,22 +318,39 @@ static void scsi_init_cmd_errh(struct sc
 		cmd->cmd_len = scsi_command_size(cmd->cmnd);
 }
 
-void scsi_device_unbusy(struct scsi_device *sdev)
+/*
+ * Decrement the host_busy counter and wake up the error handler if necessary.
+ * Avoid as follows that the error handler is not woken up if shost->host_busy
+ * == shost->host_failed: use call_rcu() in scsi_eh_scmd_add() in combination
+ * with an RCU read lock in this function to ensure that this function in its
+ * entirety either finishes before scsi_eh_scmd_add() increases the
+ * host_failed counter or that it notices the shost state change made by
+ * scsi_eh_scmd_add().
+ */
+static void scsi_dec_host_busy(struct Scsi_Host *shost)
 {
-	struct Scsi_Host *shost = sdev->host;
-	struct scsi_target *starget = scsi_target(sdev);
 	unsigned long flags;
 
+	rcu_read_lock();
 	atomic_dec(&shost->host_busy);
-	if (starget->can_queue > 0)
-		atomic_dec(&starget->target_busy);
-
-	if (unlikely(scsi_host_in_recovery(shost) &&
-		     (shost->host_failed || shost->host_eh_scheduled))) {
+	if (unlikely(scsi_host_in_recovery(shost))) {
 		spin_lock_irqsave(shost->host_lock, flags);
-		scsi_eh_wakeup(shost);
+		if (shost->host_failed || shost->host_eh_scheduled)
+			scsi_eh_wakeup(shost);
 		spin_unlock_irqrestore(shost->host_lock, flags);
 	}
+	rcu_read_unlock();
+}
+
+void scsi_device_unbusy(struct scsi_device *sdev)
+{
+	struct Scsi_Host *shost = sdev->host;
+	struct scsi_target *starget = scsi_target(sdev);
+
+	scsi_dec_host_busy(shost);
+
+	if (starget->can_queue > 0)
+		atomic_dec(&starget->target_busy);
 
 	atomic_dec(&sdev->device_busy);
 }
@@ -1532,7 +1549,7 @@ starved:
 		list_add_tail(&sdev->starved_entry, &shost->starved_list);
 	spin_unlock_irq(shost->host_lock);
 out_dec:
-	atomic_dec(&shost->host_busy);
+	scsi_dec_host_busy(shost);
 	return 0;
 }
 
@@ -1993,7 +2010,7 @@ static blk_status_t scsi_queue_rq(struct
 	return BLK_STS_OK;
 
 out_dec_host_busy:
-	atomic_dec(&shost->host_busy);
+	scsi_dec_host_busy(shost);
 out_dec_target_busy:
 	if (scsi_target(sdev)->can_queue > 0)
 		atomic_dec(&scsi_target(sdev)->target_busy);
--- a/include/scsi/scsi_host.h
+++ b/include/scsi/scsi_host.h
@@ -571,6 +571,8 @@ struct Scsi_Host {
 		struct blk_mq_tag_set	tag_set;
 	};
 
+	struct rcu_head rcu;
+
 	atomic_t host_busy;		   /* commands actually active on low-level */
 	atomic_t host_blocked;
 
