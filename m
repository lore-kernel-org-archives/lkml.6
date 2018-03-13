Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuAWFqhnz0Zb+7s7SAmDEOrCQW/0YsTsg8Zof/z/JeQETFVO0gFJnLn0TnBuMd+C06x1Pdb
ARC-Seal: i=1; a=rsa-sha256; t=1520955205; cv=none;
        d=google.com; s=arc-20160816;
        b=iQIqFyOlp0ApASYgu5vc5WAlkkoSOnAAjg0gINsF3WGc29Qk6BtjctiH+V8qOywIAF
         Jn/a8RcMTEU+TGmvH7XC+0WpONZc99jjmwSK5S7ip1yQ+dZPdPWtwnMy+KQU/YRTSSZ6
         eD46MbokUAjeoif5/5goaXTPlpsNjRbsypmp6xgCgJVGUspQ2Sw9uqP478wTrfBeCSPc
         PoMQEZsiaP/bhg0Xdza+fCApvrPi4TmYlRYY+p5RWplkMtmyAHnZOqyzE+GDeo/RUN45
         IaMsSDK1V2pB/4P4f+2QQv8lY2UGp68BEcc6Uh3jdK3Squ80NXk2wb+SwaD2DVYJWAS3
         ehcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=BZPK9RX98N76URfxjzYPPdfjXRiK7gCgtaYGy97aqt4=;
        b=TD3opuNUZcMOnCgK9/KjlTFMNtaPdbcr1sK03Ez/N1732aLNhTR7KbZIx7a744ChDp
         Tv7lxj07elQvilYKQ8h4Rb2m3O6ZHDbdSwIpLhXYiMNQ/IAUt4Xuzjcmf7uaIfJ6l6Yl
         gBdcMhT6YD+P9lPktFbr3dBXPum5u7kzxpb8bLTZyGBd4J0JI/VbqzSkdFH7qD11WN1A
         tX7rwTxEBYiVuhbdWeRFh929/NZAr0IeEMgjuKKG2XEXAj1d43mqoMNZXgYwh842V17V
         4wXCYNYNuugoC8PsGT5rfFW98k1t9JvDKqcSnF2sBjZjL8DJknb2UffqkxsQy1g+rOS8
         qqjQ==
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
Subject: [PATCH 4.15 124/146] scsi: qla2xxx: Fix system crash for Notify ack timeout handling
Date: Tue, 13 Mar 2018 16:24:51 +0100
Message-Id: <20180313152329.799578143@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152320.439085687@linuxfoundation.org>
References: <20180313152320.439085687@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594837125962234805?=
X-GMAIL-MSGID: =?utf-8?q?1594837125962234805?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
