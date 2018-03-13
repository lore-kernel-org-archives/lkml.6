Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELungRwjCPbyPgeP89MEoNtjjeQPtKoEh9pweR0kCdYJHJbIm5NbwL4GKXoUshXk+Yushh1m
ARC-Seal: i=1; a=rsa-sha256; t=1520955255; cv=none;
        d=google.com; s=arc-20160816;
        b=g1S8AUpa7elaZmRkyT6zhG1ripdWUmxTM1UAuCnY2rFex676PmriTgb9p55eDUuN58
         u5OUAPOcUKqOfXHWJY1Unb8Ry6idxvb4PyDpD9cHXvfXBZUU7OT/252pBpKHtbf929Q2
         94UGmLDLNuL4VMlFf/Rcdy+z807vjXnHV0ZBL5Ika3lCy7AvNYIRTmjUXglLRNnXQynM
         rcYlNGYZh39643zO3MwXPF3MaBY9fJnAinWXIfllF49CEDQ2TgDiCW3wSkzA6l00W3zh
         v0As21OPvy9tRowi+3M6tSzd7RxlO3ndLTYVRl9UaSKcSHJv8vD5rTbRinGDnBw+qhoS
         rNxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=jfh/qKyXGr74nSoJz3Plz6Eczw8NoQOh01XU10hKoF0=;
        b=ywIxjhH6snGS05eX9jFpdhysb1MbPoqI467vZADFNPn36eAw62JUOrUdaUMSFhTprN
         9Uvm7nFIR3YS3iAAQhQLQkYmWzzmq+cfER9ImrF/VkVxekIciupj24V6Qv/tDnnw93DK
         jREM6+FFWRjZihRFfpsSmXwdy8BJhxS6haCAvluxhf9mZF2/3nhKsC02VlaMsdDGw5HZ
         tWgrWEawmVr9EYVDC/K+Iw8L67GjLs+yv1+wVwrKKLMfQycWm7J3DW72+GbTXQMAAkqw
         eZokupda0ERT5lGn2srs5cHhLVWayQ0xeyQ4Zuf6VcpNYYRhN5zbajOSqhl6kOkJXC34
         D7Qw==
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
Subject: [PATCH 4.15 142/146] scsi: qla2xxx: Fix system crash in qlt_plogi_ack_unref
Date: Tue, 13 Mar 2018 16:25:09 +0100
Message-Id: <20180313152331.026527973@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152320.439085687@linuxfoundation.org>
References: <20180313152320.439085687@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594837177283038348?=
X-GMAIL-MSGID: =?utf-8?q?1594837177283038348?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -4750,11 +4750,11 @@ void qla24xx_create_new_sess(struct scsi
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
