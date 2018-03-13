Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvPQNzGKCLi346nyjCkO9mTIcbUorsNG61NPY9EoRFJO1MLDkhUSkJOgkV4L4ORtcyPE2V5
ARC-Seal: i=1; a=rsa-sha256; t=1520955619; cv=none;
        d=google.com; s=arc-20160816;
        b=GxEQ/QVwPshWcC8h4eRFWBqAxSQVsVP8YfwY9EUioZIAXKBSH+d6g0A1pb7s8Q9IfI
         sNQTvz5+dbihrLE4Qpk9oy6S5UxJvYRdlV6FOEj2/3C/It8rfq/EbbVv8Njy6+TEBm5R
         xFMCLGAgCrMAAJNAIKz0r6uqcbwIFXhrIbF3dno08wSEJeckB1RdHW3zcgQOD82jCOvH
         5Wz9pyDcDZvDEjX6drMYwAEJ5gTb+Uaw9EP2KbkwRLYQyPbm1XYbENohEQvYpaJ0kPAW
         31SZICsB0osdKQz47zpk6Con4wNG9GcEOl2gh0zsJ9j8Z1XlDUi4LDqVhexCCFo3XeEo
         cNiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=0e2mg5ePaesEnsJwfZIavHuI1CLt0BJCZWj1h/NuGrg=;
        b=C3AfjaAu2lzkOZTOljEGqAi7nyvNLM6gfDALtD0mWzN8ipjIInjed4kYb1Bj8Hy4+w
         XHTwsb0OdYhNV1XndZUbZlwKjQ3o8m+wugoTE2f9U609UoTrxkvj2ASgRVxnNrwtXsQP
         ivmBAtyCj+MhlwHhpFAkAABgOICuuT1Fctf1Bho3aOxWTRny6m+oYEq7s2eYJB1c/P36
         rv1q5LeQea+t+YoaFBTXPZHDyRAvVCeUcWjW1Rqx+zUA47QEICGmWVA1OaRxDFoWtnHH
         V7yEkpwOvCM5A91g4usXNl3CiFVW6qY2q4l5pcF2k7Kzrj57khTeO0sRFUHZob6YCIzC
         YEKw==
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
Subject: [PATCH 4.14 112/140] scsi: qla2xxx: Fix recursion while sending terminate exchange
Date: Tue, 13 Mar 2018 16:25:15 +0100
Message-Id: <20180313152505.721980371@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152458.201155692@linuxfoundation.org>
References: <20180313152458.201155692@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594837061465280113?=
X-GMAIL-MSGID: =?utf-8?q?1594837559985370505?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -3711,7 +3711,7 @@ static int qlt_term_ctio_exchange(struct
 		term = 1;
 
 	if (term)
-		qlt_term_ctio_exchange(qpair, ctio, cmd, status);
+		qlt_send_term_exchange(qpair, cmd, &cmd->atio, 1, 0);
 
 	return term;
 }
