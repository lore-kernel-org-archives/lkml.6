Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELu71TUF1wChBsWw/8sRYQ8eVAn5AulWntVjuU6Azq+rNQVb9Mx/pEY6UMRVNGHrEH/mJc9F
ARC-Seal: i=1; a=rsa-sha256; t=1520955361; cv=none;
        d=google.com; s=arc-20160816;
        b=zbXs/MGgtYmzWatVeQ9knglF8R4xN9mpRA9kJZSWtAbJAIVJcpjgcUZS4u51mEEymR
         4O51OmZ0Fgpu65EQ75+Y0WO1KVyJL8Nrp+cd7au5/Fb+vv+MS6axXikA1Q3nBS4BM1dU
         Wv7ztkor9cJiYRC2tmu9sliBOIbeX34nOEVFwHchiV9TOIB4iV1OtoimKGy5JCKteFZf
         a5qgJARM911ay54MI8J8DnbH0uQCyAgq2nnpEzhDjYBJAUr7YoebbjXKoXWo8KLlqllw
         PJvHz8eZGDCp3580wa7xw0WocyRbAzUdI+5p2AnDBm6DQo/TaAKf1HGNbxU4bs2WpTAe
         WGKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=FBnpQGYtsqitQieVpi9Qovb5nNiG/ZxKYzfwH+jwTjA=;
        b=pB1ToaPqZIwToCOr97hx2WPFKEKmmoTYQUHVQ1Y7VkLOhFQEtY0WWUnOb2o73LH3IH
         bwdLgxXMGs3ZabisCfLHIpPh7L0b0vVG8lisUotwHVQzu0ggMTFKszXKi+250WfcvjYO
         1zxzU7d1Mmh6lrRFadZL5Z7XVKQqKFaSqrXzFQo4x+5QsGrn5zZ6FUXBHzcRkLHnRe+1
         oYMRQd2KtERd1q/+xWojOvD3wgZQqsoIqeAyU+qwbrGdxGLOzuBa8ds5AOmWzDhBVIzt
         kzCU+OneocqHe//axlVECnjxtNUOJNpozygiDc/JpiJx3p9JFFcJR7u/HtqAwRd97COZ
         t7tQ==
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
Subject: [PATCH 4.14 024/140] scsi: qla2xxx: Fix system crash for Notify ack timeout handling
Date: Tue, 13 Mar 2018 16:23:47 +0100
Message-Id: <20180313152459.636616080@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152458.201155692@linuxfoundation.org>
References: <20180313152458.201155692@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594837125962234805?=
X-GMAIL-MSGID: =?utf-8?q?1594837289947362220?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Quinn Tran <quinn.tran@cavium.com>

commit 2e01d0ba868ec1d4d55ddcba519339e072b0bf4d upstream.

Fix NULL pointer crash due to missing timeout handling callback for
Notify Ack IOCB.

Fixes: 726b85487067d ("qla2xxx: Add framework for async fabric discovery")
Cc: <stable@vger.kernel.org> # 4.10+
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
@@ -665,7 +665,7 @@ int qla24xx_async_notify_ack(scsi_qla_ho
 	qla2x00_init_timer(sp, qla2x00_get_async_timeout(vha)+2);
 
 	sp->u.iocb_cmd.u.nack.ntfy = ntfy;
-
+	sp->u.iocb_cmd.timeout = qla2x00_async_iocb_timeout;
 	sp->done = qla2x00_async_nack_sp_done;
 
 	rval = qla2x00_start_sp(sp);
