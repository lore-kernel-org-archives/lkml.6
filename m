Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuTT2f6s49f1q25REqYyinH1MGk0wp6GJPQP5zVS9/DwSQlNvEfHmkWjxeNEGrFdeq0SOMA
ARC-Seal: i=1; a=rsa-sha256; t=1520955402; cv=none;
        d=google.com; s=arc-20160816;
        b=rRGtwNXMzWM4w/ToEv8i9PwKan3jeTJkBNbLQvjxv9ozcOY05e9QqBDeYePbKoDEdy
         +/1gx9LEzEXd2rJKuTWipMURJ9RS1yxvlEqj6AlpEyJhWCPPwEEZ5QjtZr48sAz7G/Bm
         Az3DSM5bY26DpcXauQP0dpLpceXhc7AGToeZ7HAwcvdBK1X2wthd1UYBiWuYoVO0W6u/
         rxR7lKRF8kHYalyKhulUN0EM6+bVRiZ9GE1NAhVYn3ARsYst4EPJyu9rfAdX73HYY6x6
         zz7XNKvMxIObVf1nx2c1iO2iRmbPKP7YIiyvwXtz9NTnoi9y5V5xKtpP8qU7dMFx6fA+
         FmrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=EXFhv/75ALu9z0jSdXWSbVCcT1fLUEUN2w7W7f5Sn20=;
        b=ppnDBHbyzs+/DnhgWOb6xy+7Obcv/rxz5mWSAhSmqQfjh+yq1NrlWyyqlgQ6ieUw1G
         AIQ5RCcSjDgrcYhrC67vwBP2AMmPnHzyrWMGn3hO5/hQZanRexG7XlzN4gcr/OgbMGdc
         VNS9fJvHN0jEuF5YhB1nHBrLCQMnnsNEtlCxJcWe7HlbNes4p8tyJrmpJQLeb4T8HCYp
         nWHF8z+rWFniWh8c4UiyuFwGxZbxlgxLeLt4aN4HCtAZqJjZRp82HCM5x0a/JdW97awV
         jWvtvkCP8SvJwXFQunAvA6NpzYXStlOQ7EAoRy96vrJnkvygugb9y4z1fm3CyMGBZb35
         Nk9w==
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
Subject: [PATCH 4.14 038/140] scsi: qla2xxx: Clear loop id after delete
Date: Tue, 13 Mar 2018 16:24:01 +0100
Message-Id: <20180313152500.698718331@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152458.201155692@linuxfoundation.org>
References: <20180313152458.201155692@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594837168245563924?=
X-GMAIL-MSGID: =?utf-8?q?1594837332196353801?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Quinn Tran <quinn.tran@cavium.com>

commit ba743f9148e951abe1c94f89c174ec8e44fb145b upstream.

Clear loop id after delete to prevent session invalidation of stale
session.

Fixes: 726b85487067d ("qla2xxx: Add framework for async fabric discovery")
Cc: <stable@vger.kernel.org> # 4.10+
Signed-off-by: Quinn Tran <quinn.tran@cavium.com>
Signed-off-by: Himanshu Madhani <himanshu.madhani@cavium.com>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/qla2xxx/qla_target.c |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

--- a/drivers/scsi/qla2xxx/qla_target.c
+++ b/drivers/scsi/qla2xxx/qla_target.c
@@ -974,7 +974,7 @@ static void qlt_free_session_done(struct
 			qlt_send_first_logo(vha, &logo);
 		}
 
-		if (sess->logout_on_delete) {
+		if (sess->logout_on_delete && sess->loop_id != FC_NO_LOOP_ID) {
 			int rc;
 
 			rc = qla2x00_post_async_logout_work(vha, sess, NULL);
@@ -1033,8 +1033,7 @@ static void qlt_free_session_done(struct
 		sess->login_succ = 0;
 	}
 
-	if (sess->chip_reset != ha->base_qpair->chip_reset)
-		qla2x00_clear_loop_id(sess);
+	qla2x00_clear_loop_id(sess);
 
 	if (sess->conflict) {
 		sess->conflict->login_pause = 0;
@@ -4588,9 +4587,9 @@ qlt_find_sess_invalidate_other(scsi_qla_
 				    "Invalidating sess %p loop_id %d wwn %llx.\n",
 				    other_sess, other_sess->loop_id, other_wwn);
 
-
 				other_sess->keep_nport_handle = 1;
-				*conflict_sess = other_sess;
+				if (other_sess->disc_state != DSC_DELETED)
+					*conflict_sess = other_sess;
 				qlt_schedule_sess_for_deletion(other_sess,
 				    true);
 			}
