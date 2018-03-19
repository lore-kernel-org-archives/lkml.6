Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELs9ModZy3xqWKKI5g+uXJ8BW9iw07dtPx/6WwVOyLmb6Mzbg0DqR+9Vzj9cNaJaGm0W6oRZ
ARC-Seal: i=1; a=rsa-sha256; t=1521483876; cv=none;
        d=google.com; s=arc-20160816;
        b=FvY4tY2x8bOaxlSqxKLua5aNdzHf1HWkjNcf284frwrNuf9mW3HDEUTmAJ9I9HTn+h
         27lAhiRMUs6DxHyzuybdaPgbviDbLenKg7QKI3j/wJaoALYBiVpqu1+Z4XHPDL//I3L9
         xw3+ZVIn9gokWH3lTweUyaGXST3COIGkJj43joOzAm/JsO5c+aVRX1PpLzcYEmwOHSWi
         UEILYljGjqGVeorh/rtyrTzXQVKg9iVCcywD2hA1RtB0LmIDUHgtwq7IifKNbPavWh+B
         zPD+Hh9ZVmI430Jod4rpO91w5JlpT38sf4/8yXgMbVdu/RbCuBCLggGbBI7EGEG9HXug
         AoLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=92UALv014qQnNjdqmR4he8Ddh2p3B+azxMiDH3KvDik=;
        b=xLGtZdCPtJd7ibcGJkLTQtRGxpVlj+5eh8BcKdVVnLcAMJyXdZfQyffHkWEQEYrdVo
         FrGmHYKvWDRFRq0bhbR2vmE4T07URIRJwkDHY8XMNP4Ve1lrHFKfJZprPagVkkYGWX6D
         C6NY4rF3aKBrRqU6rH9CuoSNUcnJE05MQQwLNlbOAC5RC8Mq8JjxtYMcaMEm99LaKlmX
         8NlooACuuew/ugTOROOntX1Jb1WYPGrenfsyEFjK8Vuc0exmo9jqpA6jxfLmLzcnsRCQ
         0cdXQL/DSvDqjo0J8rVFsMabDQOFBuT9PPmkOc7rRtMMc7cfBJ2zoqcNdhOuq1Daz12E
         AEFQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Hannes Reinecke <hare@suse.com>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 150/241] scsi: sg: close race condition in sg_remove_sfp_usercontext()
Date: Mon, 19 Mar 2018 19:06:55 +0100
Message-Id: <20180319180757.394220388@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390673021014173?=
X-GMAIL-MSGID: =?utf-8?q?1595391477032212002?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hannes Reinecke <hare@suse.de>


[ Upstream commit 97d27b0dd015e980ade63fda111fd1353276e28b ]

sg_remove_sfp_usercontext() is clearing any sg requests, but needs to
take 'rq_list_lock' when modifying the list.

Reported-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Hannes Reinecke <hare@suse.com>
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
Tested-by: Johannes Thumshirn <jthumshirn@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/sg.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -524,6 +524,7 @@ sg_read(struct file *filp, char __user *
 	} else
 		count = (old_hdr->result == 0) ? 0 : -EIO;
 	sg_finish_rem_req(srp);
+	sg_remove_request(sfp, srp);
 	retval = count;
 free_old_hdr:
 	kfree(old_hdr);
@@ -564,6 +565,7 @@ sg_new_read(Sg_fd * sfp, char __user *bu
 	}
 err_out:
 	err2 = sg_finish_rem_req(srp);
+	sg_remove_request(sfp, srp);
 	return err ? : err2 ? : count;
 }
 
@@ -800,6 +802,7 @@ sg_common_write(Sg_fd * sfp, Sg_request
 		SCSI_LOG_TIMEOUT(1, sg_printk(KERN_INFO, sfp->parentdp,
 			"sg_common_write: start_req err=%d\n", k));
 		sg_finish_rem_req(srp);
+		sg_remove_request(sfp, srp);
 		return k;	/* probably out of space --> ENOMEM */
 	}
 	if (atomic_read(&sdp->detaching)) {
@@ -812,6 +815,7 @@ sg_common_write(Sg_fd * sfp, Sg_request
 		}
 
 		sg_finish_rem_req(srp);
+		sg_remove_request(sfp, srp);
 		return -ENODEV;
 	}
 
@@ -1302,6 +1306,7 @@ sg_rq_end_io_usercontext(struct work_str
 	struct sg_fd *sfp = srp->parentfp;
 
 	sg_finish_rem_req(srp);
+	sg_remove_request(sfp, srp);
 	kref_put(&sfp->f_ref, sg_remove_sfp);
 }
 
@@ -1846,8 +1851,6 @@ sg_finish_rem_req(Sg_request *srp)
 	else
 		sg_remove_scat(sfp, req_schp);
 
-	sg_remove_request(sfp, srp);
-
 	return ret;
 }
 
@@ -2194,12 +2197,17 @@ sg_remove_sfp_usercontext(struct work_st
 	struct sg_fd *sfp = container_of(work, struct sg_fd, ew.work);
 	struct sg_device *sdp = sfp->parentdp;
 	Sg_request *srp;
+	unsigned long iflags;
 
 	/* Cleanup any responses which were never read(). */
+	write_lock_irqsave(&sfp->rq_list_lock, iflags);
 	while (!list_empty(&sfp->rq_list)) {
 		srp = list_first_entry(&sfp->rq_list, Sg_request, entry);
 		sg_finish_rem_req(srp);
+		list_del(&srp->entry);
+		srp->parentfp = NULL;
 	}
+	write_unlock_irqrestore(&sfp->rq_list_lock, iflags);
 
 	if (sfp->reserve.bufflen > 0) {
 		SCSI_LOG_TIMEOUT(6, sg_printk(KERN_INFO, sdp,
