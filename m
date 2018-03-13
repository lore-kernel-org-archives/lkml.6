Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELv96/kmM3eYWBYMI0UYg7KUMw964W59Dqt9sEpS/sBOiXGozN55PzlXf5MIccvwxpvTKFr9
ARC-Seal: i=1; a=rsa-sha256; t=1520955234; cv=none;
        d=google.com; s=arc-20160816;
        b=IwWNTN2zpRJbvoEgEqysohFGXsoTN77cJ7sg9r0V6bfp6hdPgSy1n5WDaUHBW/o8v/
         ycjIp6uCe4xxJt3QGigiKX+84fdctRBASjoCXNXDqSEo9kTqT3tHdPUn9cdx+72dOigJ
         V5qWnlD2RLjHuacBTmOCCBEN6KJ8vRoxTznm6+BplIBLkRe2l2AV10ByWsYG6qohTWn1
         +K0yXRgBJyeVv2wtZO6iAiJeYuw5HqquDq2SKpHhYont04+o0s9PXAaQ/mtZWQJa8r6C
         ZZNo/pqhftU184aZ9Jzpy8gnXWjXqUxk1Uo2sK2s/ApTDTv/mrbn0yu9QMt183LM4iFT
         HxPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=qA8+IyFxpjAch4a7LEMb2WmXbpCv3ZNBGYTdjB4j4b8=;
        b=N5W440wSo5ANLy2o0yEFtcZvK9Jq/ODkvX6ygyD43H+RV4+zRnzDXlvdh7xml0LLFb
         c4C6ed48H6FYdUyZhJg08RQ+sVHdYfJPt0an4RECCs53HwHvuVlUGdGgDYWBDbBvMwgi
         PR4vZymn14xN0LLRLg4qCJSenL+PTqwZSrgjukNL09ADL8zWTbgmxDSWcqAvCtWU/8XL
         YqJhxLCf3+Avg4rG6EP6Ioh4UDFDj6W/biCEyA4Q21UOV2Ofr/mzuBvB6sSfKwAcmyC7
         WkKjDo5rmQLm9mMXO2TcLHZlH/ViIb0qLMIrQ8hKMdeR8X/WEg9a9lXwDeVCi4qTks2p
         +KCg==
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
Subject: [PATCH 4.15 135/146] scsi: qla2xxx: Fix PRLI state check
Date: Tue, 13 Mar 2018 16:25:02 +0100
Message-Id: <20180313152330.543531830@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152320.439085687@linuxfoundation.org>
References: <20180313152320.439085687@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594837156721217729?=
X-GMAIL-MSGID: =?utf-8?q?1594837156721217729?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Quinn Tran <quinn.tran@cavium.com>

commit 23c645595dab7b414f23639d0a428a07515807df upstream.

Get Port Database MBX cmd is to validate current Login state upon PRLI
completion. Current code looks at the last login state for re-validation
which was incorrect. This patch removed incorrect state check.

Fixes: 15f30a5752287 ("qla2xxx: Use IOCB interface to submit non-critical MBX.")
Cc: <stable@vger.kernel.org> # 4.10+
Signed-off-by: Quinn Tran <quinn.tran@cavium.com>
Signed-off-by: Himanshu Madhani <himanshu.madhani@cavium.com>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/qla2xxx/qla_mbx.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/scsi/qla2xxx/qla_mbx.c
+++ b/drivers/scsi/qla2xxx/qla_mbx.c
@@ -6160,8 +6160,7 @@ int __qla24xx_parse_gpdb(struct scsi_qla
 	}
 
 	/* Check for logged in state. */
-	if (current_login_state != PDS_PRLI_COMPLETE &&
-	    last_login_state != PDS_PRLI_COMPLETE) {
+	if (current_login_state != PDS_PRLI_COMPLETE) {
 		ql_dbg(ql_dbg_mbx, vha, 0x119a,
 		    "Unable to verify login-state (%x/%x) for loop_id %x.\n",
 		    current_login_state, last_login_state, fcport->loop_id);
