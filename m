Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/g/upc65gXTSLuqhLtnYTddPNg6dDwuxIg7q0aQk+7W++xku6oityBmBaUAsa1Rb5n/PLN
ARC-Seal: i=1; a=rsa-sha256; t=1524652698; cv=none;
        d=google.com; s=arc-20160816;
        b=mWys7wm3bgeAs5jCCwkeDHiCFkkC8c5F6y1zGwGNu+ggkjyQfs6AqB9xPTEIHZPDSj
         H+YJo9uSjXBt5n5i9mw/SICOCIRUUtF3bYWa3jru2/K1Ub9sqFKvoiDtIDXJemjhtnKd
         80YWyDfArepPMt1qsoIUuwdgsZti7V7HaPZFfl27QfFY62VD0H7R4+DsTsDMM8M5VCqP
         WS/H2SSXDdKbuN2dCApQi71c/slvzugkaOBr2Zxyp3INDrfp319oTOO8DvgaQk2BVcnj
         mNCcMxLYouKFre1nQ6fVzZK1WM/y/zC+KPaEwnQT3G0w3w186zWn8V0mpFLFUjhvnBBk
         8VGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=yZbsrM3F9eU7vjfuAXMc67buNWLMnFihRvyQD8xOuZY=;
        b=GT4qn+TUa1vk4IAhIBm13a4vMo5NAiC3jTRIx4rDg3uuC2xmPzPlXJzEs864flW7W6
         V2o9JKiOfD4ZPbybBvOomsB6ERiWdjSkBUiwcZWHS/7k2ikhZuIi1zCE3cCKOpZtbdhR
         Nc6zUAD07yjRAW0cJE0XAEManzgbbCQjTRtJtWzmzpPiEthIHBPGP8iqMVZjQx8PpUpw
         DSHEjWHGeYpack24VXp7ZORvcmcD42aXq9acFbaXRDIR0nFvRwTi2nrSApti+b1SvBiJ
         9r0z745xdPliG54T6JjjprwPEHr3CsaeLhpM3E+tvywIMl7Yiks8POKgC2hhTscQjSXe
         uaNg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Quinn Tran <quinn.tran@cavium.com>,
	Himanshu Madhani <himanshu.madhani@cavium.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 037/183] scsi: qla2xxx: Fix warning in qla2x00_async_iocb_timeout()
Date: Wed, 25 Apr 2018 12:34:17 +0200
Message-Id: <20180425103244.069187056@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598714227740513877?=
X-GMAIL-MSGID: =?utf-8?q?1598714227740513877?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "himanshu.madhani@cavium.com" <himanshu.madhani@cavium.com>


[ Upstream commit 7ac0c332f96bb9688560726f5e80c097ed8de59a ]

This patch fixes following Smatch warning:

drivers/scsi/qla2xxx/qla_init.c:130 qla2x00_async_iocb_timeout() error: we previously assumed 'fcport' could be null (see line 107)

Fixes: 5c25d451163c ("scsi: qla2xxx: Fix NULL pointer access for fcport structure")
Reported by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Quinn Tran <quinn.tran@cavium.com>
Signed-off-by: Himanshu Madhani <himanshu.madhani@cavium.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/qla2xxx/qla_init.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -115,6 +115,8 @@ qla2x00_async_iocb_timeout(void *data)
 
 	switch (sp->type) {
 	case SRB_LOGIN_CMD:
+		if (!fcport)
+			break;
 		/* Retry as needed. */
 		lio->u.logio.data[0] = MBS_COMMAND_ERROR;
 		lio->u.logio.data[1] = lio->u.logio.flags & SRB_LOGIN_RETRIED ?
@@ -128,6 +130,8 @@ qla2x00_async_iocb_timeout(void *data)
 		qla24xx_handle_plogi_done_event(fcport->vha, &ea);
 		break;
 	case SRB_LOGOUT_CMD:
+		if (!fcport)
+			break;
 		qlt_logo_completion_handler(fcport, QLA_FUNCTION_TIMEOUT);
 		break;
 	case SRB_CT_PTHRU_CMD:
