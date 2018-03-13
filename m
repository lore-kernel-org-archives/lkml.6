Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvVTBaQsK2IwnGOAVkALqPEl8tKtrIJNgfvhk0yGvBYSh3Lktb8+zvblhqRmOyWy2975rw/
ARC-Seal: i=1; a=rsa-sha256; t=1520955246; cv=none;
        d=google.com; s=arc-20160816;
        b=cJ3bTK6mkoskb6vJ0Ht9PuMIx7/Aj4GKu6GRwAmfT0MAIIcMXx5I5peh48bkitA1HV
         PeP0P7oe2jEQGLcEzDHyZSoCZ5ScfqDOXuyl9123sZAZcn2D3nGMIORfUE0xdUSNe+xg
         pgIdAXJ45RoxjTHC+WVv3yrZ7jEJ+KOG9mBE0bRrnbpxQ1YPoFLu6PItjDTi5Q3YABPs
         CamA2WKiMyqXLsJvsTGh/WHUk/60QLHG2w0bv81C+HWk/jQudEtrUAfwW6+anACaaxvz
         RHQSt1RoirQbavweT5zJFy1xGf+x+AS4jF0UFBcYHKSxgqDf4ZrgsWrpImNpHpTDKgkK
         A7gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=vGNvtNDgeZifWbcY3Cwn1/IcbkyjPdzppZfbfZhS4Wc=;
        b=xp9r+N3Vmsj6PEOQ+mp8IxBGrQd4z9V8qpC1/67gYp9FLbR7VyC7Hs5Wt6eK4Q6ngx
         HCJHs8r7dp19ddIUMb1oguMEclfMeDyp6ujI4v9a7Zb2m1mVoBKv1f8Apf9k9m2yMFPf
         gPWwnv/mfW20qZLdJvPvXk2PLYJtFlEDk8owjRIVDORAE7Erik5EAKINRMpcgYksneVa
         LRj+yV9ujyjPnpV6Vuo7NccqQmCJ3BqSCr2c938oZj0XoKhkFuPYjFxnkVbxjLSVstKy
         KVxh1CO6a7LFXx8cPxoWEmxHQoiorSgkXeA6AxELyim1mMIanb7vCq7xBx0LQwZkm/0o
         wKmw==
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
Subject: [PATCH 4.15 139/146] scsi: qla2xxx: Clear loop id after delete
Date: Tue, 13 Mar 2018 16:25:06 +0100
Message-Id: <20180313152330.794011766@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152320.439085687@linuxfoundation.org>
References: <20180313152320.439085687@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594837168245563924?=
X-GMAIL-MSGID: =?utf-8?q?1594837168245563924?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -985,7 +985,7 @@ static void qlt_free_session_done(struct
 			qlt_send_first_logo(vha, &logo);
 		}
 
-		if (sess->logout_on_delete) {
+		if (sess->logout_on_delete && sess->loop_id != FC_NO_LOOP_ID) {
 			int rc;
 
 			rc = qla2x00_post_async_logout_work(vha, sess, NULL);
@@ -1044,8 +1044,7 @@ static void qlt_free_session_done(struct
 		sess->login_succ = 0;
 	}
 
-	if (sess->chip_reset != ha->base_qpair->chip_reset)
-		qla2x00_clear_loop_id(sess);
+	qla2x00_clear_loop_id(sess);
 
 	if (sess->conflict) {
 		sess->conflict->login_pause = 0;
@@ -4599,9 +4598,9 @@ qlt_find_sess_invalidate_other(scsi_qla_
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
