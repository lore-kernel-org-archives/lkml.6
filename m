Return-Path: <SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqNSoMDM8dPlihk7iqNeNvfTuFSk7ky5x9WdPSJuLMxi/EOT50JLSYIt3KwU/hNiz4h0rWN
ARC-Seal: i=1; a=rsa-sha256; t=1527156245; cv=none;
        d=google.com; s=arc-20160816;
        b=QYZhjNAecTL4BombbcpCiKvpPZc2SdrTyvz2OL/23cLR5ilqSIBz9NhPcZ2tepwbmR
         m5iUlSBYXAGjm4qJiBFr5fLzmvHnKZxq530AAhgy53NshfldpTUCPR3ulMQ4/OMwRZEB
         kMv0NEyNp/bzmnwtS3kRzX0ttfkgxxFKotFxguXvPa63PzUK33iqc9Vy6MU0imp/5I6s
         OIqIe2UVqJGtaSvWgx2vR7LskaLX0tE0PHe8J4LdRbsqlcDxM6umlxV1JWP3uDM3Feqj
         vquwcFo/0rObdnZ2UVrFV+/jMehFdNgWCTCIf8xTnj01/bqejffmgRqAqFIVDdHPRz5H
         DIcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=TskIUPYwtRdriD8ODD4LNzq0VdRDeXxMS7hcvWBxkDo=;
        b=nYxe1LTbjdCIzwne3Hh6+YukhQhl2kmt6KGEqCuVEeskS5QStyvF+QY9IEGRdJHVDj
         hkExangs2laASqEpRL7Po2SGuAOwKoRXNe681+enIb8qnxUzEfhPhWO3CdL4MRCxvhS/
         vttNbwkiyapSSSg5Rkw7UlsYe5V7D0pOnrzCMZSvzJK3PHVdLALeahjwaBLTFUhs46RB
         1ZPeWdiWAR39qNpuduBK8+8MAjP6Sal9EpaWIfnJw5WPt2bJru5LR74j/q7PeCFUmpIl
         r2OqdbWs5JAQJK9iw3kOkncFvyDXrucL8EFSDf8P5uQlKqutP0A2uzzHzhCGQKZ4HoOm
         3CEQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=D6hgJNIG;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=D6hgJNIG;
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
Subject: [PATCH 4.16 116/161] scsi: lpfc: Fix frequency of Release WQE CQEs
Date: Thu, 24 May 2018 11:39:01 +0200
Message-Id: <20180524093032.229085394@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093018.331893860@linuxfoundation.org>
References: <20180524093018.331893860@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601338586393623526?=
X-GMAIL-MSGID: =?utf-8?q?1601339387061419487?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: James Smart <jsmart2021@gmail.com>

[ Upstream commit 04673e38f56b30cd39b1fa0f386137d818b17781 ]

The driver controls when the hardware sends completions that communicate
consumption of elements from the WQ. This is done by setting a WQEC bit
on a WQE.

The current driver sets it on every Nth WQE posting. However, the driver
isn't clearing the bit if the WQE is reused. Thus, if the queue depth
isn't evenly divisible by N, with enough time, it can be set on every
element, creating a lot of overhead and risking CQ full conditions.

Correct by clearing the bit when not setting it on an Nth element.

Signed-off-by: Dick Kennedy <dick.kennedy@broadcom.com>
Signed-off-by: James Smart <james.smart@broadcom.com>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/lpfc/lpfc_sli.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/scsi/lpfc/lpfc_sli.c
+++ b/drivers/scsi/lpfc/lpfc_sli.c
@@ -129,6 +129,8 @@ lpfc_sli4_wq_put(struct lpfc_queue *q, u
 	/* set consumption flag every once in a while */
 	if (!((q->host_index + 1) % q->entry_repost))
 		bf_set(wqe_wqec, &wqe->generic.wqe_com, 1);
+	else
+		bf_set(wqe_wqec, &wqe->generic.wqe_com, 0);
 	if (q->phba->sli3_options & LPFC_SLI4_PHWQ_ENABLED)
 		bf_set(wqe_wqid, &wqe->generic.wqe_com, q->queue_id);
 	lpfc_sli_pcimem_bcopy(wqe, temp_wqe, q->entry_size);
