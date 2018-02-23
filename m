Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226tbQjtTP8UPr3t3TX2hJgBfzzIMG/PKYAWhHXH9IP1FwJ6hxQVb9DmDGQvEy7QkIALWgiH
ARC-Seal: i=1; a=rsa-sha256; t=1519412106; cv=none;
        d=google.com; s=arc-20160816;
        b=A5F1O1uy9Ko8G7BORvwNzn2HQHOZB4AnXIul/vHWBv0q+rMc2lIJCB3HN62+wBqIIl
         nRDpxMlDfu873BgXDmnM6ZvASntMf8qFrcfh/LuYlH5jCU0IS1fvIUoZU8yipzE2+gJs
         CvP0Bx6ZXPYg/BadLUMFPyK2ex6b4lDOJLMnTehtj3un0yeof6+qZdap+AMCf7c9hoTx
         NFvCj+ydlk8TDXDB3veXX1ao8oyjD51yB90CtCZN17xLXYuX+bWbuzrgAx2Ev23LvSTQ
         koYIA5sRXLk0ayq/Qp6XFJBw/esG+1ORK7i5ueiLN/xb/E/znsBs7b5tQIQ6sQWuz0nk
         nPNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=PQVqScq2UkopbTcSFz/gRAqyjXsY046703oGofLGU+4=;
        b=xmyrzPBiexpS08Zt+oi0+nhzkWhrT6BxsKtW0oF7ryyMFlIC2oU0Gy0YA+/BIPLTyI
         2ygccrCtrc7RmlNI8DbOeVPL5+KkkU8dVjs2BCwKjt48oWAnZGtE/V2XhGHE4sH84Wyq
         zQE3KAac50A1fJBaY11SCk2sSGPnMUvmTREAvqYnnpGd8ucXsHbTVQS94y9AKhPSrqPp
         OutZ9FLp3vZpHOB3zmZUZMCgGinQfPFYwDmrs6lCP0bTF6TnAutBUcOUikLF9JqCCI3r
         sr+VKsw+B7oYm0ELhFplcuRU7vX+zeApkBLVCm6Wp8ooRodn4713J5sYvy5og1rM6HEB
         +1+A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Dick Kennedy <dick.kennedy@broadcom.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 128/159] scsi: lpfc: Use after free in lpfc_rq_buf_free()
Date: Fri, 23 Feb 2018 19:27:16 +0100
Message-Id: <20180223170758.626342040@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170743.086611315@linuxfoundation.org>
References: <20180223170743.086611315@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593219068955390403?=
X-GMAIL-MSGID: =?utf-8?q?1593219068955390403?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <dan.carpenter@oracle.com>


[ Upstream commit 9816ef6ecbc102b9bcbb1d83e12c7fb19924f38c ]

The error message dereferences "rqb_entry" so we need to print it first
and then free the buffer.

Fixes: 6c621a2229b0 ("scsi: lpfc: Separate NVMET RQ buffer posting from IO resources SGL/iocbq/context")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Acked-by: Dick Kennedy <dick.kennedy@broadcom.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/lpfc/lpfc_mem.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/scsi/lpfc/lpfc_mem.c
+++ b/drivers/scsi/lpfc/lpfc_mem.c
@@ -753,12 +753,12 @@ lpfc_rq_buf_free(struct lpfc_hba *phba,
 	drqe.address_hi = putPaddrHigh(rqb_entry->dbuf.phys);
 	rc = lpfc_sli4_rq_put(rqb_entry->hrq, rqb_entry->drq, &hrqe, &drqe);
 	if (rc < 0) {
-		(rqbp->rqb_free_buffer)(phba, rqb_entry);
 		lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
 				"6409 Cannot post to RQ %d: %x %x\n",
 				rqb_entry->hrq->queue_id,
 				rqb_entry->hrq->host_index,
 				rqb_entry->hrq->hba_index);
+		(rqbp->rqb_free_buffer)(phba, rqb_entry);
 	} else {
 		list_add_tail(&rqb_entry->hbuf.list, &rqbp->rqb_buffer_list);
 		rqbp->buffer_count++;
