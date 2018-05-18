Return-Path: <SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZoQq1xUQpdRXy9NO4w2AwhZSlzXtUM1oRelHXpyGV/t8cYPvmHtC9de3OgXk+e7x7ZHmeP3
ARC-Seal: i=1; a=rsa-sha256; t=1526631644; cv=none;
        d=google.com; s=arc-20160816;
        b=SAJwBez9oQUJr6DK83ScJi3z5efK/d/xjuIypz+R/JILTy1+OgbmgryY2/+7I1dLZN
         cMxu4nfRSoMqpEbcRG68cYP4DAjmSJtm13y/q2xjB8x0aDUYbTsZKlorIyip+MRiZDnr
         2Q9N7izXn1DxYs43Cq9erUBBLYqD3kUpqO+TPJ0LE2nVcE9exSQ3o64aMHkBmzEy7IaU
         kLVWylD4/4cQsI4GSTUM4GoNPkyQkBI4ac0/d0S3mAvnZ0BkJ8Iaon2Nl6MjuI3+ApDM
         3f10KsTiYCr0+rS436LIQemLgP78B5pJxyOKdz7yheNiCn1ieEM872oKBEZXiq4y8lCx
         ZUug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=AE3b6Hj068yca8Eh8TAtHmZoMMGUNi33DWtDcFsM74c=;
        b=BG1UXhtxFw5+86aoJCrXmF4lwYt6edyleiabMtNtn4dwA5aUX8iEiqV/WTivRv8306
         Rt10eXOZzVYWjRztznXQpY1ZWsLXp9HJjMoQfEo04IK1GqrxOeliKYifWxr3R36pK5ID
         dbolMOuEX1x9j7QJled5v6hEORJbUgnTQJHkrrFTDsgBZI2JvRs67Ag3lyBZD+sM8lSJ
         Zvx9SuEFhFSpa4v2mE3vbj2K/FebUkZua/b1xJnHySS1HwPlnZqNQy4AP36EAH5VS/dl
         2rrHhQzU3odQKZsRxPYWVPOUqSUGa8z0UZi38dqYxOJPn/sOCvgOSH94kYz8cNz/JETI
         //gA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=mpcBNZt2;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=mpcBNZt2;
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
Subject: [PATCH 4.14 40/45] scsi: aacraid: Correct hba_send to include iu_type
Date: Fri, 18 May 2018 10:15:57 +0200
Message-Id: <20180518081532.408160633@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180518081530.331586165@linuxfoundation.org>
References: <20180518081530.331586165@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600789204656420532?=
X-GMAIL-MSGID: =?utf-8?q?1600789302514145458?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -752,6 +752,8 @@ int aac_hba_send(u8 command, struct fib
 	int wait;
 	unsigned long flags = 0;
 	unsigned long mflags = 0;
+	struct aac_hba_cmd_req *hbacmd = (struct aac_hba_cmd_req *)
+			fibptr->hw_fib_va;
 
 	fibptr->flags = (FIB_CONTEXT_FLAG | FIB_CONTEXT_FLAG_NATIVE_HBA);
 	if (callback) {
@@ -762,11 +764,9 @@ int aac_hba_send(u8 command, struct fib
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
