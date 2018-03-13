Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvoFCvIQfo011fuPB4rcmXTIj2x4zsbW9WXTlFgbgIK19CDeaQ+Ywq5cOJPADVCanXfccCJ
ARC-Seal: i=1; a=rsa-sha256; t=1520955408; cv=none;
        d=google.com; s=arc-20160816;
        b=FbDFQcUOoSj/t02c8kMsYrVrnZV/Gut6Tas7PUxu1vmb57xc8yu92dmMB1db67zVz6
         /aonEwT2AIpf8sCGLfVvi1WAPgULieh/sbUUhYQFcxTVoMZJOjboWykT6MxgtkLTJSbn
         ZvwduruSh3IcHj04jm9gEP09tRkMGOD/N/9dDeJ/6G1TvkFyXO8qi+60Nz3lyjfgLHYQ
         ajcjyvoTmTw4JL6eAMDPO/uuka2Li7S6NKeizCuuK7vJRq02BcDkB36QFFZm0WJrjWQn
         +majSflF/OKCak60noa2Likjxhw5MPSOGbdsNAukfSHbXA1wmkx4HK89FPSnxgo42Spx
         hkmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=KZCOAJSH9GJ6XvhuuRLmaoGXpoFLkdMpB/b1M2vHc6Y=;
        b=hc0a7yrCpKCtS7nUxaz+Q86y9QptKBuOJhlekIwF3FerXOZd/rz1yNsouHh0pa592y
         e+R5pzMzGAkC+kVbMlM99zGEMPOq73C/kXQKJUVKkfVqdlgjR6kSBSaIpzRiMLYEyMzu
         kSVCKajvfH1zOmheLceO1k5sFo9UUphjKccJlJ7AvCikrfShEyl8MFYhf4YG53rNs67B
         J1gEcoHjlP5g8SzM7vJLxcffTQ4KZ1gbecrQnzhSECId8xGNKxFVbcB+CILRhrDk8Ggw
         X82meIZ+/M25nhgdsi6SNHJn+ge+khGkqUToVMMK8t6anqUhANiZtmm4yV/7GsMJ7sew
         fgqw==
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
Subject: [PATCH 4.14 040/140] scsi: qla2xxx: Remove aborting ELS IOCB call issued as part of timeout.
Date: Tue, 13 Mar 2018 16:24:03 +0100
Message-Id: <20180313152500.814611494@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152458.201155692@linuxfoundation.org>
References: <20180313152458.201155692@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594837174318558817?=
X-GMAIL-MSGID: =?utf-8?q?1594837338023329408?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
 
