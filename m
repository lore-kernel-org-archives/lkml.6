Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELs0EK6rjzUjC45lGGCphPF3n6mXCdxe0vLT4o0wl4R6sHIyoGLQ7/003WW6XoH8yhyaYo5Y
ARC-Seal: i=1; a=rsa-sha256; t=1520955280; cv=none;
        d=google.com; s=arc-20160816;
        b=V1yBFlqHtSXaLLJjN8ZS6EQrlzhMblB/HJDctjzBUKZoG7LHP9VxjjAcWnNsJRZjY+
         PcoGVtbIehilQu59zniM00qifRyUvj7NR2CW+TaJW16vVUvkcMK6Y/YT4ablZqmghPd0
         KyAZw9SohQxdatF2JLuk+wclxo6XsRFhwSGRLElEJmOy4WMEO7sOepplYrPz0MpisBAs
         I8ZWvwacXL4kPfHybZM9gmLdO0ZCfTOikUS8EAFgnjHVlFcMMEoZAC5//QlVjB/ztLzk
         ZTIZrcVuO66ls76aSWSL0rWTRszEmLjkMn/3YvrWAiSTw//ooYmyP7GFaqruMRgIvcu9
         xkUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=EhvJ5ljlER/7WKvTQRo8Oc0EN84SObeZDaJfoZXDpCs=;
        b=Lk+H4V/ha1EdhIDO8b4eiLcIoPdKkYjxYVcEvy/TdWZuZO2sViNBi0li21uwh1Nk+P
         bcpUqxb2rMqD3MfW+xTEnD0It1Hl10uUPta0qM4g+F67zbQv3ETwftDW3KEkVSix6I41
         ZlOkTlOvAclEC6uoQuPbh8xwWLFn1wQbFxJR11fGRQWCyAADloBz1tUffuqrwMp/9rhg
         P4uT2hZIQWj8rXF9L+Q0McZEfJRh6cLRnuIl27KziRFpkpNkD0f3fekqXFnKOD7v/8w2
         ga9wFFMaPlXBkB2uToPNRicJzKBFKYiRXT/CVdSR4RzLbvek0PgtBfash4VA4Khl77BV
         mC+Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Quinn Tran <quinn.tran@cavium.com>,
	Himanshu Madhani <himanshu.madhani@cavium.com>,
	Hannes Reinecke <hare@suse.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.15 131/146] scsi: qla2xxx: Fix login state machine stuck at GPDB
Date: Tue, 13 Mar 2018 16:24:58 +0100
Message-Id: <20180313152330.273657910@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152320.439085687@linuxfoundation.org>
References: <20180313152320.439085687@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594837204781255664?=
X-GMAIL-MSGID: =?utf-8?q?1594837204781255664?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Quinn Tran <quinn.tran@cavium.com>

commit 414d9ff3f8039f85d23f619dcbbd1ba2628a1a67 upstream.

This patch returns discovery state machine back to Login Complete.

Fixes: 726b85487067d ("qla2xxx: Add framework for async fabric discovery")
Cc: <stable@vger.kernel.org> # 4.10+
Signed-off-by: Quinn Tran <quinn.tran@cavium.com>
Signed-off-by: Himanshu Madhani <himanshu.madhani@cavium.com>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/qla2xxx/qla_init.c |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -863,6 +863,7 @@ void qla24xx_handle_gpdb_event(scsi_qla_
 	int rval = ea->rc;
 	fc_port_t *fcport = ea->fcport;
 	unsigned long flags;
+	u16 opt = ea->sp->u.iocb_cmd.u.mbx.out_mb[10];
 
 	fcport->flags &= ~FCF_ASYNC_SENT;
 
@@ -893,7 +894,8 @@ void qla24xx_handle_gpdb_event(scsi_qla_
 	}
 
 	spin_lock_irqsave(&vha->hw->tgt.sess_lock, flags);
-	ea->fcport->login_gen++;
+	if (opt != PDO_FORCE_ADISC)
+		ea->fcport->login_gen++;
 	ea->fcport->deleted = 0;
 	ea->fcport->logout_on_delete = 1;
 
@@ -917,6 +919,13 @@ void qla24xx_handle_gpdb_event(scsi_qla_
 
 			qla24xx_post_gpsc_work(vha, fcport);
 		}
+	} else if (ea->fcport->login_succ) {
+		/*
+		 * We have an existing session. A late RSCN delivery
+		 * must have triggered the session to be re-validate.
+		 * session is still valid.
+		 */
+		fcport->disc_state = DSC_LOGIN_COMPLETE;
 	}
 	spin_unlock_irqrestore(&vha->hw->tgt.sess_lock, flags);
 } /* gpdb event */
