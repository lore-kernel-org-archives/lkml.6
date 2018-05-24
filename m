Return-Path: <SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZr44/FFV0IGC1MKKnmPkhtjhhZPjoELRGtER16+2zlj2ZKbhSrCKmsFaMMPYiqQuuhL/NT6
ARC-Seal: i=1; a=rsa-sha256; t=1527156231; cv=none;
        d=google.com; s=arc-20160816;
        b=TEcGg3o7FnyMY24tBWARFc+FeMWtwuQ0Kv+xf8vZbFMpE6g++9DiwkRyheV/Y81t49
         uFauhwNJl0y7sXk+RLlOoIl7TBOHRr4r7GFbj1sz1HiJqnFWZTAzFfP5SCNjtaLHJQZs
         q0LXC7BuCPVYxji210ytFfsk0gnhPNJ+2bmioWh8iq0BiSaVasIkmsXh5m/nn89fOS6j
         2OVzDwrJUhYvN0vGfREo03rLWsVQXtM8zK7Wv32VBQ1rBYMsV7puf7iEMjN5UTfXLHOZ
         fysq2nJAZWIMo0SgGBKXr1NsD1Q0jWCqnIMXPW1BEP/yfZ8cnnoSXp9uUhYytbDThWtZ
         618g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=IJrPS/Vjf5XsiUiYBUFluq+SNoZlrwe7MnJTH2ZYobM=;
        b=jN7PTBTUc4qa2jb5Phe4ZnLA17pZfYI4J/ms0bShzERZEzhl6KipV+ud8Bvn1pcgV4
         cvKVvtO4WNbjOWhCIEblh/dD6kX+uTjYr3gxiqf33WW6hm6gUkaIbF4f9JOXm+ZKuMnv
         qOpHRXxDDr6ECois3E43TW0wcDX88USmFkbVUEB5qG1T+gv+b1YJsYwBuJXDYxTZbY0B
         drTaafBxhdtLsTQF13dRmIXZPFyNSNIvTQn0tlqhrzAOnGPBHtszeMOpcYIwvFT6R2xJ
         Lzqz48GmpvJpozHORTwLyvsY23QwjNyfwFOGKmJ6eX/mNFHarqVH37I/h1K0XFcfgSEQ
         C4jA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=GlKQRh7F;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=GlKQRh7F;
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
Subject: [PATCH 4.16 112/161] scsi: lpfc: Fix issue_lip if link is disabled
Date: Thu, 24 May 2018 11:38:57 +0200
Message-Id: <20180524093031.762194177@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093018.331893860@linuxfoundation.org>
References: <20180524093018.331893860@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601338580945268847?=
X-GMAIL-MSGID: =?utf-8?q?1601339372356405259?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: James Smart <jsmart2021@gmail.com>

[ Upstream commit 2289e9598dde9705400559ca2606fb8c145c34f0 ]

The driver ignored checks on whether the link should be kept
administratively down after a link bounce. Correct the checks.

Signed-off-by: Dick Kennedy <dick.kennedy@broadcom.com>
Signed-off-by: James Smart <james.smart@broadcom.com>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/lpfc/lpfc_attr.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/scsi/lpfc/lpfc_attr.c
+++ b/drivers/scsi/lpfc/lpfc_attr.c
@@ -905,7 +905,12 @@ lpfc_issue_lip(struct Scsi_Host *shost)
 	LPFC_MBOXQ_t *pmboxq;
 	int mbxstatus = MBXERR_ERROR;
 
+	/*
+	 * If the link is offline, disabled or BLOCK_MGMT_IO
+	 * it doesn't make any sense to allow issue_lip
+	 */
 	if ((vport->fc_flag & FC_OFFLINE_MODE) ||
+	    (phba->hba_flag & LINK_DISABLED) ||
 	    (phba->sli.sli_flag & LPFC_BLOCK_MGMT_IO))
 		return -EPERM;
 
