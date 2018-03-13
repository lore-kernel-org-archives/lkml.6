Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELurHlK1DKpSvJI3xAsfg2WQenMvI64VJ5GnLUhgmTnIExbDa3f1C2eaEQHE0Yt+vMFTVzzj
ARC-Seal: i=1; a=rsa-sha256; t=1520955410; cv=none;
        d=google.com; s=arc-20160816;
        b=G3zrhGQuNNffSP9rqoFS+2+0qsrIoYCBIZeahEjejZ6/nJBmGHXboBdot++kuBG9Av
         wE0KKyomlHcxgU1Ok9x76/N9PwlNdS1wwFue1e5suLBJJJeB6EJQSsMvNs29kL+XMdoL
         zDKPbbe6VOrj1l/xGXLSl8bG6/48SQ3MpmWNEzFj2zzGNwV4/Shx8xbcpof7CjZDLP7l
         ywmJBn5v4jf8WVJLcbYnGAuniuE+zZLhlr30Bv7lX9sMWaoM38uDJlsrk23HfdhNBCXk
         eP4gVQkWWz73GU5CoFdXlrGMIPGOq1g+l4dlD35rGLJOEE+mC7hvouuEI4gbMbC2xoR0
         b7vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=D3z9iGZlAaCm3RoPMo9KFZ8e4MWHGZ49BgeGpCA7udA=;
        b=G5kTbw6F++55QCXZr/440zsvOP4rmmk1iFNsNp/DI69j67zL8xvvFF/B7gYqrl6ds7
         UOtE9ZC978ETPSIhtiJPiLr8w3HxK/58Av2Icx2fpXqmYJtyaKMjLp/Vju5i+F1g8Z2A
         Jl6L24GL9AyJ39Z91OGdgy16gWkHdpbAJrkzu57uxJNOQi+FEGkHuGIJyjVs4PwXuFA6
         Cw6zlNKKoMUyFWY1Gh+IvRueRiSwOB006FqL8VxftiQO1YP55tA9KRJecuTbAuuvLA9v
         bcviMasMRB5LEvckzNKkcUn6CM+UfzcJQz6SJuwyf0DRnqmBr+sdel/96d45FJ7JYfLR
         Z7Hw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Quinn Tran <quinn.tran@cavium.com>,
	Giridhar Malavali <giridhar.malavali@cavium.com>,
	Himanshu Madhani <himanshu.madhani@cavium.com>,
	Hannes Reinecke <hare@suse.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.14 041/140] scsi: qla2xxx: Fix system crash in qlt_plogi_ack_unref
Date: Tue, 13 Mar 2018 16:24:04 +0100
Message-Id: <20180313152500.890784748@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152458.201155692@linuxfoundation.org>
References: <20180313152458.201155692@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594837177283038348?=
X-GMAIL-MSGID: =?utf-8?q?1594837340968932382?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Quinn Tran <quinn.tran@cavium.com>

commit 19759033e0d0beed70421ab9258f5ede79e070ae upstream.

Fix system crash due to NULL pointer access.

qlt_plogi_ack_t and fc_port structures were not properly bound before
calling qlt_plogi_ack_unref().

RIP: 0010:qlt_plogi_ack_unref+0xa1/0x150 [qla2xxx]
Call Trace:
qla24xx_create_new_sess+0xb1/0x320 [qla2xxx]
qla2x00_do_work+0x123/0x260 [qla2xxx]
qla2x00_iocb_work_fn+0x30/0x40 [qla2xxx]
process_one_work+0x1f3/0x530
worker_thread+0x4e/0x480
kthread+0x10c/0x140

Fixes: 726b85487067d ("qla2xxx: Add framework for async fabric discovery")
Cc: <stable@vger.kernel.org> # 4.10+
Signed-off-by: Quinn Tran <quinn.tran@cavium.com>
Signed-off-by: Giridhar Malavali <giridhar.malavali@cavium.com>
Signed-off-by: Himanshu Madhani <himanshu.madhani@cavium.com>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/qla2xxx/qla_os.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -4734,11 +4734,11 @@ void qla24xx_create_new_sess(struct scsi
 		} else {
 			list_add_tail(&fcport->list, &vha->vp_fcports);
 
-			if (pla) {
-				qlt_plogi_ack_link(vha, pla, fcport,
-				    QLT_PLOGI_LINK_SAME_WWN);
-				pla->ref_count--;
-			}
+		}
+		if (pla) {
+			qlt_plogi_ack_link(vha, pla, fcport,
+			    QLT_PLOGI_LINK_SAME_WWN);
+			pla->ref_count--;
 		}
 	}
 	spin_unlock_irqrestore(&vha->hw->tgt.sess_lock, flags);
