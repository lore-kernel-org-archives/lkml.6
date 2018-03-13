Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuT/obwZa+2MmqarW7RtuZNN++XkWWTkk7zagXQhBc/y9McvXr/GXS4PDF/n5ZWdHzoGNyM
ARC-Seal: i=1; a=rsa-sha256; t=1520955390; cv=none;
        d=google.com; s=arc-20160816;
        b=bigw5XOh32vKvSipsANAaUyy91NNrQXP0PU1HG45owTPmpdfyGnxaATRNMCbU4LVZz
         20eScVsiuZ+pAPtdKLTguOgDJgDwcEAWzWlFy00zwvoiIUtUNPY5mRNnOYCr1pBcfyan
         hhD3xcvia09tRENEqsuZDMRdURLx9/ta2BYOXl4snfd+c/7996l5CkN86OpvZtPFqUYh
         OUhszVippG40vuI8B8cheGieibxxAghFixIJUDtfBGKTDILoRG5XFY6yc5bxiWcnS1/j
         TiV1P4bKOh+/2yySaNDilIEtAppr6XsYL3HTsceIen6yN/78xEkWsWzCfhDoGF+5qGmW
         zmMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=+J2r3llMWQJKm9c6vyjKBAsYDDxtFKVG7Kjn5jJkGcA=;
        b=jQNGpE7no+5bgqHUcQGW+Rpwk14+zYhuN/E6LnrwK8FUVmdpHuAbcATqtRoPnhr47R
         P6hsCDPE3EdJyl9mpRxV7iPwOGkJSKDWuds0na+pGia5UBI2m0Zst4N67Yk0w3FAhzmE
         A/tHPh4CjITv/jAv2Ew0QfJNYDmOoc9qh+M0rDvISsQVtnK4WcerIXOkgC0A0i1vLhOB
         KFiuLrIiY6Kcqbt7G2VtTLIA+t5tkm4ey1BppDXaB1NMbXd5Thlf/w1Td75cP4CNcaEj
         ojhf+kpvg5vDbzAGRjPYSX0Vv9+ElDBxPp/WgC+EFoZgJVfRbvL9ozVBwEBAMwYb229i
         Om6g==
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
Subject: [PATCH 4.14 034/140] scsi: qla2xxx: Fix PRLI state check
Date: Tue, 13 Mar 2018 16:23:57 +0100
Message-Id: <20180313152500.418550144@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152458.201155692@linuxfoundation.org>
References: <20180313152458.201155692@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594837156721217729?=
X-GMAIL-MSGID: =?utf-8?q?1594837319688748557?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -6078,8 +6078,7 @@ int __qla24xx_parse_gpdb(struct scsi_qla
 	}
 
 	/* Check for logged in state. */
-	if (current_login_state != PDS_PRLI_COMPLETE &&
-	    last_login_state != PDS_PRLI_COMPLETE) {
+	if (current_login_state != PDS_PRLI_COMPLETE) {
 		ql_dbg(ql_dbg_mbx, vha, 0x119a,
 		    "Unable to verify login-state (%x/%x) for loop_id %x.\n",
 		    current_login_state, last_login_state, fcport->loop_id);
