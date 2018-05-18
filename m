Return-Path: <SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqDFMfgtS/ClY3Lm8YurPP7j5F8VoL+iTfNjHQ9i7W05WvNYQ1neGpaLIrqaXjbHSk+2v8r
ARC-Seal: i=1; a=rsa-sha256; t=1526631550; cv=none;
        d=google.com; s=arc-20160816;
        b=xtFdbepS9A03FJ8n0q1Ko9Et9M/dsxIznZxT4b5im3bwea3A/BA6wLI6ohhICEvbum
         KdcLPQeIoj8vMZ1Vo0/qcVgik3BfsdBHYKaJelEz98L+7QiiNv3EUgtGHjUdFVr52nTA
         ZrTk1bY1XRz5MzB3c3uKP0ZQ9joHzeppFUB5TX+qMzX+oWaw3+9c2YMREAqb6D6C2T4X
         pIE/etaiRDGqGv4ZSEkk1vqBMThJW60anE+4A037cgudoM3jORpdYQRv4W2lJEhKS0Pt
         XX5plQPXJLLCyKZHP3Rh38yjPxZHSfBWNHGt25xzpNjpzcQ8+hvCqsFcZ0xdSztlJ2AV
         lK6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=ij2wEWtw0YjrCHDJF+bv5VT8BcRwY3lViyi896H/PG8=;
        b=BGiDsEXf6q/ho5K4IMLQuuYlZ/Pd6isIZB3pr6RCv+sJaDOajHmhTB5oqTDcU1DNSB
         AwdHhWyN0R7NRviW1b/vQQr5qCVMYZk35ID/BKdUl6hRnfuZpWVak4bDPOgH5FaZ2p/i
         atk+mhDHrihIWOvsTrpV5Gp9dBgScnsOoVqndnrtnnb/Boi62+VmMIYlrUlu+0X43M8J
         f2v0Te4hKzbb0DgLKap8HUrB1sdCnCnFzweJSa2AcFKJ7rvVSkGy+haG9UbEt5wAY235
         rWMcXvehNEMXj6mhW0meOLX5wMD15x/IDjlBRRFWoe+eEtVaOsxqvdXUxbQDTXJ06an9
         h0nA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=dV5qxybn;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=dV5qxybn;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Noah Misner <nmisner@us.ibm.com>,
	Dave Carroll <david.carroll@microsemi.com>,
	Raghava Aditya Renukunta <RaghavaAditya.Renukunta@microsemi.com>,
	Brian King <brking@linux.vnet.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.16 54/55] scsi: aacraid: Correct hba_send to include iu_type
Date: Fri, 18 May 2018 10:15:50 +0200
Message-Id: <20180518081459.900263413@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180518081457.428920292@linuxfoundation.org>
References: <20180518081457.428920292@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600789204656420532?=
X-GMAIL-MSGID: =?utf-8?q?1600789204656420532?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dave Carroll <david.carroll@microsemi.com>

commit 7d3af7d96af7b9f51e1ef67b6f4725f545737da2 upstream.

commit b60710ec7d7a ("scsi: aacraid: enable sending of TMFs from
aac_hba_send()") allows aac_hba_send() to send scsi commands, and TMF
requests, but the existing code only updates the iu_type for scsi
commands. For TMF requests we are sending an unknown iu_type to
firmware, which causes a fault.

Include iu_type prior to determining the validity of the command

Reported-by: Noah Misner <nmisner@us.ibm.com>
Fixes: b60710ec7d7ab ("aacraid: enable sending of TMFs from aac_hba_send()")
Fixes: 423400e64d377 ("aacraid: Include HBA direct interface")
Tested-by: Noah Misner <nmisner@us.ibm.com>
cc: stable@vger.kernel.org
Signed-off-by: Dave Carroll <david.carroll@microsemi.com>
Reviewed-by: Raghava Aditya Renukunta <RaghavaAditya.Renukunta@microsemi.com>
Reviewed-by: Brian King <brking@linux.vnet.ibm.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/aacraid/commsup.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/scsi/aacraid/commsup.c
+++ b/drivers/scsi/aacraid/commsup.c
@@ -724,6 +724,8 @@ int aac_hba_send(u8 command, struct fib
 	int wait;
 	unsigned long flags = 0;
 	unsigned long mflags = 0;
+	struct aac_hba_cmd_req *hbacmd = (struct aac_hba_cmd_req *)
+			fibptr->hw_fib_va;
 
 	fibptr->flags = (FIB_CONTEXT_FLAG | FIB_CONTEXT_FLAG_NATIVE_HBA);
 	if (callback) {
@@ -734,11 +736,9 @@ int aac_hba_send(u8 command, struct fib
 		wait = 1;
 
 
-	if (command == HBA_IU_TYPE_SCSI_CMD_REQ) {
-		struct aac_hba_cmd_req *hbacmd =
-			(struct aac_hba_cmd_req *)fibptr->hw_fib_va;
+	hbacmd->iu_type = command;
 
-		hbacmd->iu_type = command;
+	if (command == HBA_IU_TYPE_SCSI_CMD_REQ) {
 		/* bit1 of request_id must be 0 */
 		hbacmd->request_id =
 			cpu_to_le32((((u32)(fibptr - dev->fibs)) << 2) + 1);
