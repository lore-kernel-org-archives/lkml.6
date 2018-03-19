Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsofxZ0ve+Atxv00bTdixe6Eclz9/VSGar6tI8mdOTKQGgzdzAM5yUSjwSsl+C5y2pqPXXx
ARC-Seal: i=1; a=rsa-sha256; t=1521484233; cv=none;
        d=google.com; s=arc-20160816;
        b=nsmZcYhyeDMcE+L6ec5fSmJ8pHk2i5xu7XN86j2wnUAnHTnu3VAo4S1R3aRN473jnq
         AMnQwf/4BIwT8RU3OaDD1/F2VwoUST0n1zuE+8MJd7R9WRoyilc15imPjqwUxhDaOU0N
         8LrNp8vNEkdF0ZcEB2TDHoCHEdkP2bgNZnyvToQk0dI2AydWN1iBWyJAMvvYPB9hGI/i
         kaZTXFkz2BbxFivmSgAPhpDKBvNAgMPT1lZLK4HFd7vl8U48ccMM6XtqeR9klvliNfv9
         25hdhykMt1DavsRS/5Teu4mXG/ozrhEZYnlq2c5Q1ZCe/ol5Fy7YeFVEdCh+oXHyBPj+
         KeGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=uZEQNBwvwUkLVygFMYCURDa/fYd2UBZFZtENCTrPXA0=;
        b=DILFbo5TszfgOy40fSYQq20soyeIK8p+rH9YPH0UrlZQpc75FfNVsrUCdnSod3YVsN
         oOlpRiirTaio7DEGgt2qgLCtKt3ClCuDH1LPVQw/j2UHg6FEV7e5IGctHwA6cSFxAHkQ
         GdYM2ttBs2ogZ0j7GB55fH5Hi6+TWAMNwu59+G8N/nYjiSutruscJb/UaiRAEsXHeDKu
         XqnwsFm9XP6hnIDxEjcMka5SZH5YBDZUX9GECIzbEy75DGr7ZO1Jq3ozgO6iUdC9KzDA
         bPuKezrhB/sc/9H/THRBUYgs+IXU/ASAs0Xk9UY9UosSplqPHTORdNsK0uCNYAWRbX1E
         1MAA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Himanshu Madhani <hmadhani@redhat.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.14 38/41] scsi: qla2xxx: Fix logo flag for qlt_free_session_done()
Date: Mon, 19 Mar 2018 19:08:38 +0100
Message-Id: <20180319180734.672861445@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180732.195217948@linuxfoundation.org>
References: <20180319180732.195217948@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595391851319784932?=
X-GMAIL-MSGID: =?utf-8?q?1595391851319784932?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Himanshu Madhani <hmadhani@redhat.com>

commit a2390348c19d0819d525d375414a7cfdacb51a68 upstream.

Commit 3515832cc614 ("scsi: qla2xxx: Reset the logo flag, after target
re-login.")fixed the target re-login after session relogin is complete,
but missed out the qlt_free_session_done() path.

This patch clears send_els_logo flag in qlt_free_session_done()
callback.

[mkp: checkpatch]

Fixes: 3515832cc614 ("scsi: qla2xxx: Reset the logo flag, after target re-login.")
Signed-off-by: Himanshu Madhani <hmadhani@redhat.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/qla2xxx/qla_target.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/scsi/qla2xxx/qla_target.c
+++ b/drivers/scsi/qla2xxx/qla_target.c
@@ -971,6 +971,7 @@ static void qlt_free_session_done(struct
 
 			logo.id = sess->d_id;
 			logo.cmd_count = 0;
+			sess->send_els_logo = 0;
 			qlt_send_first_logo(vha, &logo);
 		}
 
