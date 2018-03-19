Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvHTYamn/c6zOYxaV8SCPPdLmbuCi/5Sieg8NeCs8cMSa6lQJaUk7r5up4sWyaUviozD+ft
ARC-Seal: i=1; a=rsa-sha256; t=1521483618; cv=none;
        d=google.com; s=arc-20160816;
        b=VuGJadTgqq27oqaWPymW6o7+cPhxiAsqBeJTm4824hFZ+vpsdKZ425i12XZxPBjUbB
         rTYjl3PCfgRDemfiXKk1Pwgdpzu9Qi7VJ9YXkXVK8twlgFW2x7BGdjAcjytKu6S/r4pA
         ojgEztqxWYGQ1no/Pg1KjrI2Mo2Dz+7EpNPVAYqIHErdhzvfynCnNXCmU2JnwKQAo8jP
         wtGiG66nRol1lKiyQ7fjCX1izP5/MW5ruy7D9m7kTnrDZu2CFkt0WFH3jwwCC3J6Bgmy
         ciEfrNYxd7mhzaMfglFfEpIQa7686JUF6cFJOPPaeI28bggrEiuqeQGlZIICYbI9+Gzg
         KQsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=EoB40qHLU/55MGSt36sKKG4rxn1HMnk2qoqj9k79EH4=;
        b=IH02W3C7t4BqA3Ox3qveCkeXKlFY/EBdVSnpDUtqRMzEJdmWfcK6wzXNtfdFYljNRG
         2i/SlofRGR2aoKz6VobJBsfUPLxJ/Pjh+O19s/T1pH8Gcb17KhOpvIduTVo/SdUFaeR0
         HOrJhFt6FjK2u0ZJ4LA9iCTQRyNpOvnpKKVI2FKt9HiU0r/rDR1fhNAhlsCFjhB9ylUQ
         Nw0iiQK5hG+5yj1roZ6VbmAIvVU4X0non+fIx/HpH8KnfSFGN5vcEt1ZpFypav1tpbVd
         BqdLNNUTuu75atgqgPv6wTpJ7VfNCdLGqAMW0a9wLROpaJkjNqmJ0fGLu4MQjnqo+Nru
         2SXA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Satish Kharat <satishkh@cisco.com>,
	Sesidhar Baddela <sebaddel@cisco.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 053/241] scsi: fnic: Fix for "Number of Active IOs" in fnicstats becoming negative
Date: Mon, 19 Mar 2018 19:05:18 +0100
Message-Id: <20180319180753.416154897@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595391206708329457?=
X-GMAIL-MSGID: =?utf-8?q?1595391206708329457?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Satish Kharat <satishkh@cisco.com>


[ Upstream commit 7ef539c88d7d394410d547c9f082d477093a2a22 ]

Fixing the IO stats update (Active IOs and IO completion) to prevent
"Number of Active IOs" from becoming negative in the fnistats output.

Signed-off-by: Satish Kharat <satishkh@cisco.com>
Signed-off-by: Sesidhar Baddela <sebaddel@cisco.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/fnic/fnic_scsi.c |   16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

--- a/drivers/scsi/fnic/fnic_scsi.c
+++ b/drivers/scsi/fnic/fnic_scsi.c
@@ -1127,12 +1127,6 @@ static void fnic_fcpio_itmf_cmpl_handler
 		else
 			CMD_ABTS_STATUS(sc) = hdr_status;
 
-		atomic64_dec(&fnic_stats->io_stats.active_ios);
-		if (atomic64_read(&fnic->io_cmpl_skip))
-			atomic64_dec(&fnic->io_cmpl_skip);
-		else
-			atomic64_inc(&fnic_stats->io_stats.io_completions);
-
 		if (!(CMD_FLAGS(sc) & (FNIC_IO_ABORTED | FNIC_IO_DONE)))
 			atomic64_inc(&misc_stats->no_icmnd_itmf_cmpls);
 
@@ -1173,6 +1167,11 @@ static void fnic_fcpio_itmf_cmpl_handler
 					(((u64)CMD_FLAGS(sc) << 32) |
 					CMD_STATE(sc)));
 				sc->scsi_done(sc);
+				atomic64_dec(&fnic_stats->io_stats.active_ios);
+				if (atomic64_read(&fnic->io_cmpl_skip))
+					atomic64_dec(&fnic->io_cmpl_skip);
+				else
+					atomic64_inc(&fnic_stats->io_stats.io_completions);
 			}
 		}
 
@@ -1962,6 +1961,11 @@ int fnic_abort_cmd(struct scsi_cmnd *sc)
 	/* Call SCSI completion function to complete the IO */
 		sc->result = (DID_ABORT << 16);
 		sc->scsi_done(sc);
+		atomic64_dec(&fnic_stats->io_stats.active_ios);
+		if (atomic64_read(&fnic->io_cmpl_skip))
+			atomic64_dec(&fnic->io_cmpl_skip);
+		else
+			atomic64_inc(&fnic_stats->io_stats.io_completions);
 	}
 
 fnic_abort_cmd_end:
