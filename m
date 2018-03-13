Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELt4yMERNc6RUQDr+8lgJXCTMzQqtPqe9CvfU3yIq4fd9VZlWGolapdsEStdSeqdDRL3Dqqu
ARC-Seal: i=1; a=rsa-sha256; t=1520955396; cv=none;
        d=google.com; s=arc-20160816;
        b=xKx4PRZLjUYrsfl4MgGyaiphWEjrfHovtUwxBiHl7lqbTB5Dxml0TQffG5FxVdCMXi
         cpn751p8chK++d9KT5LSWkq6EeR7V5VtpVvMtD6ZroGaMupafK0cl1i7g5VJhXQhvKj4
         3p8lx2gmQHeVTc5GHjDe1k+oI7iu/4HB358I2nBUUGAi85YW8F679orw4aWGZThTEfqh
         UTzx+TlHGc/McHeBRBYbBRBO4hHFDH0+wytFGFceak2U2ZuwsVLVC1cawTkPH/30PR/R
         rtx+soXON0a7L+A63DxpPoiEQVSOZuUjOwNDEgKhPt7jwWrzeubC4miH9PiGoz6vDXs4
         dFlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=xuNjnC1m5k1zinVdMmClZTRJ/mnqtYM7Q7a8ru4sFhA=;
        b=rNzgf1nh7JqI5oIDNHzILU2APQqRXAbNPDC23XX+9oBOM/NQSVwHifkjFoRT2KjyUW
         zwiZzsX50lbLbnVnpU8NGI+nMNsUyp4ilvA2hbOx5367KursHPTA8WwnjhEouWDsRZhA
         nFWCM6HD5dZB1fC6Y7zRfGIdcqvl9xqPR1CYLCEDcl+gX8aWyInmqJOHQHT9BcY4NbBm
         DhzfA8o6gRnyjg1MmkhERe3per2QVdvkRVE07TBr66S+jz0uRh4BKeR+w+/BccB/ntjH
         /xwmuviUVOs9R9+XbNdhGrFsw+Zm6KFGFZ4UujJR8YPq8Ggjsldu3yfLZ3wPqm6bLX4J
         UpTQ==
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
Subject: [PATCH 4.14 036/140] scsi: qla2xxx: Replace fcport alloc with qla2x00_alloc_fcport
Date: Tue, 13 Mar 2018 16:23:59 +0100
Message-Id: <20180313152500.547323028@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152458.201155692@linuxfoundation.org>
References: <20180313152458.201155692@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594837162674464832?=
X-GMAIL-MSGID: =?utf-8?q?1594837325936376902?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Quinn Tran <quinn.tran@cavium.com>

commit 063b36d6b0ad74c748d536f5cb47bac2f850a0fa upstream.

Current code manually allocate an fcport structure that is not properly
initialize. Replace kzalloc with qla2x00_alloc_fcport, so that all
fields are initialized.  Also set set scan flag to port found

Cc: <stable@vger.kernel.org>
Signed-off-by: Quinn Tran <quinn.tran@cavium.com>
Signed-off-by: Himanshu Madhani <himanshu.madhani@cavium.com>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/qla2xxx/qla_target.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/scsi/qla2xxx/qla_target.c
+++ b/drivers/scsi/qla2xxx/qla_target.c
@@ -5759,7 +5759,7 @@ static fc_port_t *qlt_get_port_database(
 	unsigned long flags;
 	u8 newfcport = 0;
 
-	fcport = kzalloc(sizeof(*fcport), GFP_KERNEL);
+	fcport = qla2x00_alloc_fcport(vha, GFP_KERNEL);
 	if (!fcport) {
 		ql_dbg(ql_dbg_tgt_mgt, vha, 0xf06f,
 		    "qla_target(%d): Allocation of tmp FC port failed",
