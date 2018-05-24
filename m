Return-Path: <SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpM+h7xCIWasmnlGA8h4yOnwsZHMtToeevTBKvtHPxvxBWcsYOg0/bP2U2ThPHj2lSGjWuT
ARC-Seal: i=1; a=rsa-sha256; t=1527156223; cv=none;
        d=google.com; s=arc-20160816;
        b=AcDWpcTzRgCJx9TxKevsis0B9bgzOEFsPs+7q/N6Jpe5e8X7Beq2Tyf8sNuiaGG+3F
         9WM/+0NVLyC2/mroBs29DRzTaaqynC/fXyDS7yH7O+EwtjXF1A0RAhMWkduv4PYUtFBl
         C7VNXBlGf4OtqNQRE+s7IgUc/cRMmX1mRkIvZ9Nr4IJx//AW/hr+EZnNTWXBdGFci8qs
         eIx5mo8ZEftNsqpDhbsv+gUiNDsUnQh0wQfpOFxDt46SZLiN/iG/VWVIzZCMPqAhlHgG
         QDzJPRCCQMoN7LbFixUHmcM7KDRlDxRffsc1wl9xllibourMEP/F/Hyq+bEQEgN3xK//
         vE9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=h12Y9VF6C5XY37Pu9pqpgEF3NiqQug/EB5Wf+MeRu4U=;
        b=od1/MSjJ64C6GoBsN2toiKUjpf8QKNmxzq2vk9eYVmV0FCLRrOK/58+9xD3iXkHdyt
         i6vgxTFFxqR9cWHlbUtsArVYrD4vFZ+BVpcm3clEyk14T0iowgLg5OAj9wKhXoMK7Ceo
         lOYM6sTQ+hY9sQW43tbLVEIwYeSiVIraierUaQUYMgSKejL0ARZfPD+MdozMQ8PG39TG
         x7d29l6hV/9SCGf9Xmi4DQ2gPZfQgJ6r3qYJnx1To1d6/CgjEQRuKf+hnQhKmw9qwNMi
         /dew7zdbV0SnuZrA9u0FuAcETCpcjYABwFaOOz8rU1TLkzZDFCb/R6duDE7iBbXHTXdu
         zopA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=GDiBRtst;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=GDiBRtst;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dick Kennedy <dick.kennedy@broadcom.com>,
	James Smart <james.smart@broadcom.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 109/161] scsi: lpfc: Fix NVME Initiator FirstBurst
Date: Thu, 24 May 2018 11:38:54 +0200
Message-Id: <20180524093031.445200161@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093018.331893860@linuxfoundation.org>
References: <20180524093018.331893860@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601339363920053969?=
X-GMAIL-MSGID: =?utf-8?q?1601339363920053969?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: James Smart <jsmart2021@gmail.com>

[ Upstream commit 0709263abe0de70a798dcdf481d5dd489ca4752e ]

First Burst support was not properly indicated in NVMe PRLI.

Correct the bit position and the logic to check and set first burst support.

Signed-off-by: Dick Kennedy <dick.kennedy@broadcom.com>
Signed-off-by: James Smart <james.smart@broadcom.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/lpfc/lpfc_nportdisc.c |   15 ++++++++++++++-
 drivers/scsi/lpfc/lpfc_nvme.h      |    2 ++
 2 files changed, 16 insertions(+), 1 deletion(-)

--- a/drivers/scsi/lpfc/lpfc_nportdisc.c
+++ b/drivers/scsi/lpfc/lpfc_nportdisc.c
@@ -1998,8 +1998,14 @@ lpfc_cmpl_prli_prli_issue(struct lpfc_vp
 			ndlp->nlp_type |= NLP_NVME_TARGET;
 			if (bf_get_be32(prli_disc, nvpr))
 				ndlp->nlp_type |= NLP_NVME_DISCOVERY;
+
+			/*
+			 * If prli_fba is set, the Target supports FirstBurst.
+			 * If prli_fb_sz is 0, the FirstBurst size is unlimited,
+			 * otherwise it defines the actual size supported by
+			 * the NVME Target.
+			 */
 			if ((bf_get_be32(prli_fba, nvpr) == 1) &&
-			    (bf_get_be32(prli_fb_sz, nvpr) > 0) &&
 			    (phba->cfg_nvme_enable_fb) &&
 			    (!phba->nvmet_support)) {
 				/* Both sides support FB. The target's first
@@ -2008,6 +2014,13 @@ lpfc_cmpl_prli_prli_issue(struct lpfc_vp
 				ndlp->nlp_flag |= NLP_FIRSTBURST;
 				ndlp->nvme_fb_size = bf_get_be32(prli_fb_sz,
 								 nvpr);
+
+				/* Expressed in units of 512 bytes */
+				if (ndlp->nvme_fb_size)
+					ndlp->nvme_fb_size <<=
+						LPFC_NVME_FB_SHIFT;
+				else
+					ndlp->nvme_fb_size = LPFC_NVME_MAX_FB;
 			}
 		}
 
--- a/drivers/scsi/lpfc/lpfc_nvme.h
+++ b/drivers/scsi/lpfc/lpfc_nvme.h
@@ -27,6 +27,8 @@
 
 #define LPFC_NVME_WAIT_TMO              10
 #define LPFC_NVME_EXPEDITE_XRICNT	8
+#define LPFC_NVME_FB_SHIFT		9
+#define LPFC_NVME_MAX_FB		(1 << 20)	/* 1M */
 
 struct lpfc_nvme_qhandle {
 	uint32_t index;		/* WQ index to use */
