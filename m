Return-Path: <SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrfvC406y+rZ99rtY/5pybT1NQT6c3LF2kTJ4Zgnp5Swi7/aTRiaJkA+11mKQjzj6JaXk0H
ARC-Seal: i=1; a=rsa-sha256; t=1527156239; cv=none;
        d=google.com; s=arc-20160816;
        b=yPjeHeOeIbmtJOXMgKNqnZJi3FMpXEOu3a6WTUpYw2SG3M7b7l8U/iAMkQ1gr6Qm0v
         WX8VXgZlpEhbtpVOqerPFcVAhXC0jvSa1JjLdzcmCNLHgR3kpFpboap6speQIQomGEd3
         uyxgaPc9G0IKX3i3Z3runNRh6HA/ABYYl3FLZ0vC+p+zJhoMD6fPmW0cbA3LcXDzFdPO
         uyjkJZgsYiLq/1xrX/AzI6wHa9chm/ZHBHG7a1UpiwkyfQmxtkIMWg5Gpu1BSAyoy/NI
         UMhGEzy4MkIvM4iEosUKjfMNIyQfp2m0pckwm5kt3inJAjbhqYdmRgpEDH2/aT+bG1Tp
         65Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=0TDW4W4BRkLohQw+RlNdjdgpj5ZbBjcj5jRg1M+uXOE=;
        b=mh+3iKbZQW1VvYfAvlAHCuXRW7vEpaxOdBqyTEZljQFLDTdrS+WGyJHeaYB2GUTu25
         lc4cIjjI0ktOJbbJxCHOOCY28Oq1xQ4TSLP6+50IOB+4n8RwLNC/eAw8MIUz2oS12zKe
         doI0JMl0jbXVOv4++hAJk9GJSjyFZXhXGN5IPVJwSnP7uX/hoHVm+D1VamNsT4bnLp4c
         jVIsvJXRAPM8sjYi8KSkUZMZIRoArom7R4CT6qr6csviCT/mu4lolQ9Lebx07QiEuZ3u
         DYaqqfgpZMS8SBeZQo6QIuU1lAV+nIab7QBtmePi4BUHKumIgWcKNxzOj6Ixj0itFWbz
         ap8w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=jFEIFeKM;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=jFEIFeKM;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dick Kennedy <dick.kennedy@broadcom.com>,
	James Smart <james.smart@broadcom.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 115/161] scsi: lpfc: Fix IO failure during hba reset testing with nvme io.
Date: Thu, 24 May 2018 11:39:00 +0200
Message-Id: <20180524093032.113712063@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093018.331893860@linuxfoundation.org>
References: <20180524093018.331893860@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601339381319531726?=
X-GMAIL-MSGID: =?utf-8?q?1601339381319531726?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: James Smart <jsmart2021@gmail.com>

[ Upstream commit 91455b850956bc13708a074bd1400f54aae74890 ]

A stress test repeatedly resetting the adapter while performing io would
eventually report I/O failures and missing nvme namespaces.

The driver was setting the nvmefc_fcp_req->private pointer to NULL
during the IO completion routine before upcalling done().  If the
transport was also running an abort for that IO, the driver would fail
the abort with message 6140. Failing the abort is not allowed by the
nvme-fc transport, as it mandates that the io must be returned back to
the transport. As that does not happen, the transport controller delete
has an outstanding reference and can't complete teardown.

The NULL-ing of the private pointer should be done only when the io is
considered complete. It's complete when the adapter returns the exchange
with the "exchange busy" flag clear.

Move the NULL'ing of the structure to the done case. This leaves the io
contexts set while it is busy and until the subsequent XRI_ABORTED
completion which returns the exchange is received.

Signed-off-by: Dick Kennedy <dick.kennedy@broadcom.com>
Signed-off-by: James Smart <james.smart@broadcom.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/lpfc/lpfc_nvme.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/scsi/lpfc/lpfc_nvme.c
+++ b/drivers/scsi/lpfc/lpfc_nvme.c
@@ -982,14 +982,14 @@ out_err:
 			phba->cpucheck_cmpl_io[lpfc_ncmd->cpu]++;
 	}
 #endif
-	freqpriv = nCmd->private;
-	freqpriv->nvme_buf = NULL;
 
 	/* NVME targets need completion held off until the abort exchange
 	 * completes unless the NVME Rport is getting unregistered.
 	 */
 
 	if (!(lpfc_ncmd->flags & LPFC_SBUF_XBUSY)) {
+		freqpriv = nCmd->private;
+		freqpriv->nvme_buf = NULL;
 		nCmd->done(nCmd);
 		lpfc_ncmd->nvmeCmd = NULL;
 	}
