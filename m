Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtwyhA07U/3Oaw3g/bHHH9HthfStakExMKd7NsYKsftUOLbzNqpPSXfdPdj6kr0Z7q8wNgc
ARC-Seal: i=1; a=rsa-sha256; t=1520955382; cv=none;
        d=google.com; s=arc-20160816;
        b=SgEuYc6RnO4ml6fwjSGSt4gFQibKL9SuwgvrQtpCm4CK+nuF7OwWV3gzu8gOvh3A6n
         31sYye/p8jaaJ8Crkk0z3oB+6X8z4Nj/ena4x+FaNxCIJCzQJemHeOrMeieZBO+5N+e4
         z5OllE1WZR/M5VhE2+aa6neOpZoVTGGFik9k+R05gkcSSe+MS9w7feHB5AgudFzwxWyd
         JM0P6FpumUd2dKjGr/+31E7FQfpkRuB/AlKYTqEHSCJn1Zd/l8KST6EekhOtymdCHrap
         /nGzjvwnkpQ0HPZbz47KbCjHYwuUVIO41ARoWO7nuhWgyopsmRUonGUt+BYKvV+bnMM8
         uE/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=bej/QXWtf6/G+FYbOkf7YB0F77BpUjKTCqIJWTmk5O4=;
        b=IM/GE6XeTKrdQZ8SuycPEa4kUNY3SpiUHIaau434hakIOeKumPSHno+jxi2uRxw6gf
         odLAmYJ/uuiB61BRTWi9bU90VpjCweT3aA4nONza/3rRdS9lBaMVSMW50p0M0U7+9o6O
         ZmoboeLdnDD4DEtpg7RLg6P54W2uxQEme9v7kG06VlHY3VNdN+EAf7sri4Aga1wfeWDf
         br0BcWkVy1j+AZblR4VChwecS5gglo+b9QbVTlbsI6DranCK+Hk4ojJGaMBUUauS4PJs
         BmROUV3SmbgzZvoYs7Q3Jz1ptBuw8eGhSg8gpFoYycjrSHicsgVcoLpR3+2ZJ+XBPlIX
         wVBA==
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
Subject: [PATCH 4.14 031/140] scsi: qla2xxx: Fix login state machine stuck at GPDB
Date: Tue, 13 Mar 2018 16:23:54 +0100
Message-Id: <20180313152500.172736062@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152458.201155692@linuxfoundation.org>
References: <20180313152458.201155692@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594837204781255664?=
X-GMAIL-MSGID: =?utf-8?q?1594837310553562008?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -864,6 +864,7 @@ void qla24xx_handle_gpdb_event(scsi_qla_
 	int rval = ea->rc;
 	fc_port_t *fcport = ea->fcport;
 	unsigned long flags;
+	u16 opt = ea->sp->u.iocb_cmd.u.mbx.out_mb[10];
 
 	fcport->flags &= ~FCF_ASYNC_SENT;
 
@@ -894,7 +895,8 @@ void qla24xx_handle_gpdb_event(scsi_qla_
 	}
 
 	spin_lock_irqsave(&vha->hw->tgt.sess_lock, flags);
-	ea->fcport->login_gen++;
+	if (opt != PDO_FORCE_ADISC)
+		ea->fcport->login_gen++;
 	ea->fcport->deleted = 0;
 	ea->fcport->logout_on_delete = 1;
 
@@ -918,6 +920,13 @@ void qla24xx_handle_gpdb_event(scsi_qla_
 
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
