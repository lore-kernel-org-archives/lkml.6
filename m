Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvF5rmgnaTjIXd8FdSu9i2cEai0AocoueGZEwfcIgLYtIdIocYmU8oIWQvLLuB5FZWKODIR
ARC-Seal: i=1; a=rsa-sha256; t=1520955144; cv=none;
        d=google.com; s=arc-20160816;
        b=oth+rUxxvvgt+JCyVPsP2BB63YGVjvn11KBUllbagZsjSV+OcSmyAc562SGDAJ66Jn
         KI0oEBqW6A+uhRjXgCCL9T4LIhS3a6agqbbeXBBciRJHrII3Kfl7QG7B3ZiVfgK6JBuf
         HKqWIpu3qvlCgSPAOS+AVKtlOFptr/h9WZhAg6agukf60TkygugMrCQ3l5wkY0SF/fc0
         3yRbBooM2hQ7HPKj6tNCE9G//Hq8040AFLke2iTmJa9u0OeQcGTVRJHpBEFmCht1JlAj
         8kbqAe73ncj2nU/pLwHaXASaodHRi//LtPehDq6kLRc8yOLROvvUooMQf4rC26aiEluE
         PNlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=+YRqUcJNkw+723YDgXPuoQUDQnVys+cYC+JRiIlD8JA=;
        b=kxlHpl0vgIDNfWCb0A479+Q/qdywj2rOqS0uMFgjiT6znKvsX2pWK6mLnuD8urYfL9
         CoZiHqDjs44/PFeJXNiJN1X0Ss3wk4E52DhvkCYyQw9SerKe3rgL5WUb8kVR3rEUPsFr
         HCTcVcWKOo3/e5Ac+H7bkQ9m5YgOX80h4f3jBItghBqKdrPttmtHBOAtdw+gBcpPcWaO
         VzYmROVkPTxgOXHSsmT5jrDW1rExbCxqkrFppPmrPVcRL3RR3QBsK4XnJ7qCtBvyiPUC
         oiGHmlqTAaoZx+eEvKOyUBGamRC880+k6trpyJ2rTmYD7By9df+Rbq96kEh4V7WNmbP7
         08rg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Himanshu Madhani <himanshu.madhani@cavium.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.15 077/146] scsi: qla2xxx: Fix recursion while sending terminate exchange
Date: Tue, 13 Mar 2018 16:24:04 +0100
Message-Id: <20180313152326.691593049@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152320.439085687@linuxfoundation.org>
References: <20180313152320.439085687@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594837061465280113?=
X-GMAIL-MSGID: =?utf-8?q?1594837061465280113?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: himanshu.madhani@cavium.com <himanshu.madhani@cavium.com>

commit 3efc31f76dd7fc8a71cd86683909f637e9b7cadb upstream.

During error test case where switch port status is toggled from enable to
disable, following stack trace is seen which indicates recursion trying to
send terminate exchange.  This regression was introduced by commit
82de802ad46e ("scsi: qla2xxx: Preparation for Target MQ.")

BUG: stack guard page was hit at ffffb96488383ff8 (stack is ffffb96488384000..ffffb96488387fff)
BUG: stack guard page was hit at ffffb964886c3ff8 (stack is ffffb964886c4000..ffffb964886c7fff)
kernel stack overflow (double-fault): 0000 [#1] SMP
qlt_term_ctio_exchange+0x9c/0xb0 [qla2xxx]
qlt_term_ctio_exchange+0x9c/0xb0 [qla2xxx]
qlt_term_ctio_exchange+0x9c/0xb0 [qla2xxx]
qlt_term_ctio_exchange+0x9c/0xb0 [qla2xxx]
qlt_term_ctio_exchange+0x9c/0xb0 [qla2xxx]

Fixes: 82de802ad46e ("scsi: qla2xxx: Preparation for Target MQ.")
Cc: <stable@vger.kernel.org> #4.10
Signed-off-by: Himanshu Madhani <himanshu.madhani@cavium.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/qla2xxx/qla_target.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/scsi/qla2xxx/qla_target.c
+++ b/drivers/scsi/qla2xxx/qla_target.c
@@ -3708,7 +3708,7 @@ static int qlt_term_ctio_exchange(struct
 		term = 1;
 
 	if (term)
-		qlt_term_ctio_exchange(qpair, ctio, cmd, status);
+		qlt_send_term_exchange(qpair, cmd, &cmd->atio, 1, 0);
 
 	return term;
 }
