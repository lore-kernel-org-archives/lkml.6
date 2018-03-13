Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELt7lP5B63p6LC8fRAeVpMd9ukSgiBm34D/lo3R4NDjk3UCj2+AnTe3VNDWywp1PJgj2jftA
ARC-Seal: i=1; a=rsa-sha256; t=1520955419; cv=none;
        d=google.com; s=arc-20160816;
        b=p8nR6VVNhiOucpwXU7IIqDlYr8dX+jjsH4tofFBSsDE5cMPfJ8/UUGw/A0XP6ZRjED
         tINbfV4h836EVhaLLu9HIdt8tMpWhSjc/fGO17iGaRbMiIfHMP4fupJGbXcUJ+NtOmTO
         7EKKUPqKJq2Lr8ieJpdX1wDnZ93sTjqNdYTKEAbNHfxUStQzxfPqxQYDdbyx2yVs1BR2
         8tjQe1TxBWTm0aPtYw/QranoxPbeTtOwFgrl5/3FvzjBgOlD6Ah8ln6ug90JeQwwr77U
         4oz624IDa3faehF09QzPBStqIIEr+EBTPfU5G0chgrbY+aMPkDuV9YYhxOn6VgkYNeWP
         BPTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=nbbnrAkztFgkL/9CLPgR/jPytJqydQNXJzhq+XCjj5A=;
        b=jqabp8Cac9Vm3KS/4lkxiMWm6w0aS/Do/dAzwxPeNFQiN0rRtC77kgtmrrKSucbn9T
         /xtMorFOpcpV4hdN8aNFzULb7yWQd6ds7FZ7ogmu/xy097u1dsnK5dGpzeXbpw8iGJqO
         YktOBaui8mQmJh7yYYrKKshw0bWB32frN9Uz9smunCQYqXk9Yzl16Ht2XPEXswav/BLR
         eBo5ufELWJp498uA4zoh+aV2x74aPJHo1nWHEXPJKVFljMCL1AX3rL/IU0AGdXWib+XG
         Cq4B0MU+/jPhb+0c2wQulFxogWIIcwioivZsc4bTde0T3k1zlHgQoJ2FTQ+1j3WFVmS2
         M/7g==
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
Subject: [PATCH 4.14 039/140] scsi: qla2xxx: Defer processing of GS IOCB calls
Date: Tue, 13 Mar 2018 16:24:02 +0100
Message-Id: <20180313152500.757095021@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152458.201155692@linuxfoundation.org>
References: <20180313152458.201155692@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594837171449342573?=
X-GMAIL-MSGID: =?utf-8?q?1594837349897984022?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -973,7 +973,7 @@ int qla24xx_fcport_handle_login(struct s
 			ql_dbg(ql_dbg_disc, vha, 0x20bd,
 			    "%s %d %8phC post gnl\n",
 			    __func__, __LINE__, fcport->port_name);
-			qla24xx_async_gnl(vha, fcport);
+			qla24xx_post_gnl_work(vha, fcport);
 		} else {
 			ql_dbg(ql_dbg_disc, vha, 0x20bf,
 			    "%s %d %8phC post login\n",
@@ -1142,7 +1142,7 @@ void qla24xx_handle_relogin_event(scsi_q
 		ql_dbg(ql_dbg_disc, vha, 0x20e9, "%s %d %8phC post gidpn\n",
 		    __func__, __LINE__, fcport->port_name);
 
-		qla24xx_async_gidpn(vha, fcport);
+		qla24xx_post_gidpn_work(vha, fcport);
 		return;
 	}
 
