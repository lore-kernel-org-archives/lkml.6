Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsBGC4klfZDJkxZMU5AO8KLzg8nnDxBXgP955BWzoxZ52Q3XCUGO5ruDeieXrCp+971lPx6
ARC-Seal: i=1; a=rsa-sha256; t=1520955249; cv=none;
        d=google.com; s=arc-20160816;
        b=D3RE8YPAOwPMOr0R7tl5tRfepan+a76N4miMe5SKJLz+//RXxuAioJJtM8fAuoSiOY
         FagJDztsYmdP3D2ZdjwAto66rPPDreInjBL5zhgFAyz6xoLpkzt0l+JOXyEDKxlhB9OK
         o4eM/6HAwts5XOpv2j0ScI3icoUgWWfM6+uFqja2AicL4uSp9qtrsH4A5PvZGOj0TVp9
         iC8ERFWWDjiyrhy+9I+YAGsa/TLjGNJ1mvOAqPcHOy33oigRcpT20bpuHwdHJIVr/ih/
         +mBanC6ECoiHut42LgGdjqXRvcsWzFhHFcQ52chd78B0jsCXF9Qcmq2INliebU0Q9SWT
         1Pqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=E33erVtdJaa3VnUPFKU89eXM2BZiIYhg/5tYk+2sGfA=;
        b=ZOP6EtJMmn1Q+De0k7yFeDjDRKxzBBIS0mXT2QRzWU5W+XCUw8h5hT9F7Wy4qGtCpa
         zayPODH/2e7L8FOk575QMqU/KUf7gM0PmObRRtgEvMfEHCPzoc6w5SvM0U4+4YcKmWo1
         3kLhpMA0lq2kCGxB75y7tkExESmSTrMeO7yeZ7BbYCsiXT2Y4tJc44iAJubl4dfjxBQK
         QOYn2qg1WhBAQLrRvgep//6t5C1a5TCL4Z0rMpsayYZXDtWXIBmeUW5QOU0KiTdrwfDG
         RRb+9g46ZBPi7fe+8oGb/VqDiOGmk4wLFhBMqVeEJCo5m7Sdw+AaoWgcb6aMk5uMb921
         fkxA==
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
Subject: [PATCH 4.15 140/146] scsi: qla2xxx: Defer processing of GS IOCB calls
Date: Tue, 13 Mar 2018 16:25:07 +0100
Message-Id: <20180313152330.885836729@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152320.439085687@linuxfoundation.org>
References: <20180313152320.439085687@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594837171449342573?=
X-GMAIL-MSGID: =?utf-8?q?1594837171449342573?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Giridhar Malavali <giridhar.malavali@cavium.com>

commit 5d3300a9b8b122b4743aed5a178bf12c87e2b8c9 upstream.

This patch defers processing of GS IOCB calls from interrupt context to
avoid hardware spinlock recursion.

Following stack trace is seen

? mod_timer+0x193/0x330
? ql_dbg+0xa7/0xf0 [qla2xxx]
_raw_spin_lock_irqsave+0x31/0x40
qla2x00_start_sp+0x3b/0x250 [qla2xxx]
qla24xx_async_gnl+0x1d3/0x240 [qla2xxx]
qla24xx_fcport_handle_login+0x285/0x290 [qla2xxx]
? vprintk_func+0x20/0x50

Fixes: 726b85487067d ("qla2xxx: Add framework for async fabric discovery")
Cc: <stable@vger.kernel.org> # 4.10+
Signed-off-by: Giridhar Malavali <giridhar.malavali@cavium.com>
Signed-off-by: Himanshu Madhani <himanshu.madhani@cavium.com>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/qla2xxx/qla_init.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -975,7 +975,7 @@ int qla24xx_fcport_handle_login(struct s
 			ql_dbg(ql_dbg_disc, vha, 0x20bd,
 			    "%s %d %8phC post gnl\n",
 			    __func__, __LINE__, fcport->port_name);
-			qla24xx_async_gnl(vha, fcport);
+			qla24xx_post_gnl_work(vha, fcport);
 		} else {
 			ql_dbg(ql_dbg_disc, vha, 0x20bf,
 			    "%s %d %8phC post login\n",
@@ -1143,7 +1143,7 @@ void qla24xx_handle_relogin_event(scsi_q
 		ql_dbg(ql_dbg_disc, vha, 0x20e9, "%s %d %8phC post gidpn\n",
 		    __func__, __LINE__, fcport->port_name);
 
-		qla24xx_async_gidpn(vha, fcport);
+		qla24xx_post_gidpn_work(vha, fcport);
 		return;
 	}
 
