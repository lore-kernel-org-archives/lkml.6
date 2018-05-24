Return-Path: <SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqiHPAJdByCjYKq/IQQ15qYCxTHhc8fhqkPhXaX7oDgNyI07/A/thsjlrzcUD6+XG/CaZRj
ARC-Seal: i=1; a=rsa-sha256; t=1527156237; cv=none;
        d=google.com; s=arc-20160816;
        b=RcXyP6VQS4mkGuLH2phuvse9Bwa0tbYCwbV+axZ9OkkBY+z/ujKx3egTi7IkX+3Aug
         NTOTapBhLM1tkdQqOVnHAf04csoO7+7r4b0+Kj7yx2uciL/7WbngYygSXmzwgjCTC5XA
         QSahjQ0h7tODPqPWZYKVZEe3fUjfr0xPWj7pLMYP18zBGHCl/i27qTZTWtBhcbn30IRk
         IPPndcpKWsd5Da/EIFmf5DwBO7KZJZannmF8m0hFx0VlChRmM1BwmyT3MtA3WJTJmGER
         F3zeO2M8GIEt/Ig7ztUD4smanWr5YqF6MxBocUfqm5ULh/OcVkLE3LwhbQdzc7c22rXh
         k8/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=4hfdmhTzl9gBQsj7AucV4n3y9N/FqRdYmZZRnejaoMg=;
        b=fp3cuCzVkJFm/o2CqeWIDgOmtydt/B66db9ydNYgAqiS4Sa3Zik2CDwzMEvd9IA3BI
         4iq0Jrsnbp1FpNIdvXVnCZtszzKsjuk4/pWVKp9+A/j76toZnxTXGZ3q50kTU5jVxbq2
         htraVKWdK1xxzPRE2xkm4CAyVKlqx8WRfcJsAOS75zpbVIZ5Ua2XWLrgz6Sn6UTXRRih
         FDN1AFA7fzJSZEWsvqXeaQYRiuEQT1cgAq+5rTMANUp9yWmqL57kkldAeYnULn0Malt1
         4OaUQAXDjYY4yWpRNNxifH+OfTMUi7f4gSZ8HRUNw2b6hWt2wwMHLlwSScKj6aHz/nQG
         748A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=TIwAYQmo;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=TIwAYQmo;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dick Kennedy <dick.kennedy@broadcom.com>,
	James Smart <james.smart@broadcom.com>,
	Hannes Reinecke <hare@suse.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 114/161] scsi: lpfc: Fix soft lockup in lpfc worker thread during LIP testing
Date: Thu, 24 May 2018 11:38:59 +0200
Message-Id: <20180524093031.975849318@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093018.331893860@linuxfoundation.org>
References: <20180524093018.331893860@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601338583856953859?=
X-GMAIL-MSGID: =?utf-8?q?1601339378440620629?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: James Smart <jsmart2021@gmail.com>

[ Upstream commit 161df4f09987ae2e9f0f97f0b38eee298b4a39ff ]

During link bounce testing in a point-to-point topology, the host may
enter a soft lockup on the lpfc_worker thread:

    Call Trace:
     lpfc_work_done+0x1f3/0x1390 [lpfc]
     lpfc_do_work+0x16f/0x180 [lpfc]
     kthread+0xc7/0xe0
     ret_from_fork+0x3f/0x70

The driver was simultaneously setting a combination of flags that caused
lpfc_do_work()to effectively spin between slow path work and new event
data, causing the lockup.

Ensure in the typical wq completions, that new event data flags are set
if the slow path flag is running. The slow path will eventually
reschedule the wq handling.

Signed-off-by: Dick Kennedy <dick.kennedy@broadcom.com>
Signed-off-by: James Smart <james.smart@broadcom.com>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/lpfc/lpfc_hbadisc.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/scsi/lpfc/lpfc_hbadisc.c
+++ b/drivers/scsi/lpfc/lpfc_hbadisc.c
@@ -696,8 +696,9 @@ lpfc_work_done(struct lpfc_hba *phba)
 		      phba->hba_flag & HBA_SP_QUEUE_EVT)) {
 		if (pring->flag & LPFC_STOP_IOCB_EVENT) {
 			pring->flag |= LPFC_DEFERRED_RING_EVENT;
-			/* Set the lpfc data pending flag */
-			set_bit(LPFC_DATA_READY, &phba->data_flags);
+			/* Preserve legacy behavior. */
+			if (!(phba->hba_flag & HBA_SP_QUEUE_EVT))
+				set_bit(LPFC_DATA_READY, &phba->data_flags);
 		} else {
 			if (phba->link_state >= LPFC_LINK_UP ||
 			    phba->link_flag & LS_MDS_LOOPBACK) {
