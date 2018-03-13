Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELu2GFVIIghhuPYAcvI2yyQR4pbaox7l3L9VaBi5PWu/0Xk0/RDc82QbnWc2/LwfiLOdcmFR
ARC-Seal: i=1; a=rsa-sha256; t=1520955252; cv=none;
        d=google.com; s=arc-20160816;
        b=IRAq4VMhH54mDmnkioA2k61se48g6V6PloXOhK+A6hJ5wrdDuogmAXK2iL1oKvoSu8
         nSJvdkE84siht/gtXsFIAQ6mIrKqrQZYWf4AKQLKxziJsuu1pfjEbSCD6Y7Vbk+j3J77
         pGBxCabZef7TGrByYjumfXRl1/2RWwAPhFGshVfne8U7e+/7ojG71mg0Cz6WTz60Ld4n
         XsAEscpHc8t2qqKqIFkky7OB7vQkI+mvVAcL/Xm2fuVCrsnSgMabTrT/g/MFa8XtcRMz
         Bzb1TF+6F9UqACVBrvH/gHq3OUZKDxsKziSxCbtrXbetEv6dTZ5N3Dj3TbQ7t7qBgtKB
         zglA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=SwRxACBLBgBCMAyYIDt3gAn+SeS/VDt+XQ50YnttU68=;
        b=RySFIhRHpOxwrJyv1VWfRwSR8nkua8UmP6HkrvNsCZK4Gpl1KfFrOZJwBBC1B3TnYm
         FwDlRxKyDMQpoAPjOevXiKs66qqvUj5dWrCiKuwkUBvS4BhrGhHFpJAdNMit73GGK+dk
         2up6q5qom59afJYhuXRfieY835DDxoDLrdiEhcQpDldV2J+yTkct4k9EJ3yKuJqdem1w
         XBQalpGMIkOG7M9HfXQ87yagFngE3c2SCzscLcJQYVIgJxQMS/45cG2tXi1l9wnWktiT
         mC5x6dTb9iR2/g4Bc0w694rXa+lAbPWVx7j1MxjJ7XbZMY4mvwP+qWBH42EWOadCWqtZ
         gtaQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Giridhar Malavali <giridhar.malavali@cavium.com>,
	Himanshu Madhani <himanshu.madhani@cavium.com>,
	Hannes Reinecke <hare@suse.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.15 141/146] scsi: qla2xxx: Remove aborting ELS IOCB call issued as part of timeout.
Date: Tue, 13 Mar 2018 16:25:08 +0100
Message-Id: <20180313152330.960707756@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152320.439085687@linuxfoundation.org>
References: <20180313152320.439085687@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594837174318558817?=
X-GMAIL-MSGID: =?utf-8?q?1594837174318558817?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Giridhar Malavali <giridhar.malavali@cavium.com>

commit bf07ef86e882013522876f7c834c8eea085f35b4 upstream.

This fix the spinlock recursion issue seen while unloading the driver.

14 [ffff9f2e21e03db8] native_queued_spin_lock_slowpath at ffffffffad0d8802
15 [ffff9f2e21e03dc0] do_raw_spin_lock at ffffffffad0d99e4
16 [ffff9f2e21e03dd8] _raw_spin_lock_irqsave at ffffffffad652471
17 [ffff9f2e21e03e00] qla2x00_els_dcmd_iocb_timeout at ffffffffc070cd63
18 [ffff9f2e21e03e40] qla2x00_sp_timeout at ffffffffc06f06d3 [qla2xxx]
19 [ffff9f2e21e03e68] call_timer_fn at ffffffffad0f97d8
20 [ffff9f2e21e03ed8] run_timer_softirq at ffffffffad0faf47
21 [ffff9f2e21e03f68] __softirqentry_text_start at ffffffffad655f32

Fixes: 6eb54715b54bb ("qla2xxx: Added interface to send explicit LOGO.")
Cc: <stable@vger.kernel.org> # 4.10+
Signed-off-by: Giridhar Malavali <giridhar.malavali@cavium.com>
Signed-off-by: Himanshu Madhani <himanshu.madhani@cavium.com>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/qla2xxx/qla_iocb.c |   10 ----------
 1 file changed, 10 deletions(-)

--- a/drivers/scsi/qla2xxx/qla_iocb.c
+++ b/drivers/scsi/qla2xxx/qla_iocb.c
@@ -2392,7 +2392,6 @@ qla2x00_els_dcmd_iocb_timeout(void *data
 	srb_t *sp = data;
 	fc_port_t *fcport = sp->fcport;
 	struct scsi_qla_host *vha = sp->vha;
-	struct qla_hw_data *ha = vha->hw;
 	struct srb_iocb *lio = &sp->u.iocb_cmd;
 
 	ql_dbg(ql_dbg_io, vha, 0x3069,
@@ -2400,15 +2399,6 @@ qla2x00_els_dcmd_iocb_timeout(void *data
 	    sp->name, sp->handle, fcport->d_id.b.domain, fcport->d_id.b.area,
 	    fcport->d_id.b.al_pa);
 
-	/* Abort the exchange */
-	if (ha->isp_ops->abort_command(sp)) {
-		ql_dbg(ql_dbg_io, vha, 0x3070,
-		    "mbx abort_command failed.\n");
-	} else {
-		ql_dbg(ql_dbg_io, vha, 0x3071,
-		    "mbx abort_command success.\n");
-	}
-
 	complete(&lio->u.els_logo.comp);
 }
 
