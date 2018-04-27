Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpSOnitbn13KKx+/4M/dLkLGD5f+stt+SGvheOVIRP6ahUkToW6sQrWyiMz0er5Fof6tIrl
ARC-Seal: i=1; a=rsa-sha256; t=1524837754; cv=none;
        d=google.com; s=arc-20160816;
        b=mcmcSijuvl1uIrKurIDpDPvUHQY+0OSr2eOcEMSOQ8gcWSOvq9DLU7oJYHjnkfplEp
         ediXzidBU5HpsHlvep8HHn9s+1HyI5VDhI9mX9rX1ZT0ucaMy806qnWxbbRVyK+45TFs
         jxZM8YMnKuGWnuOw8W5d2z/KEv5klaOWCKB2IXdlpjoD28M05JKkGUdjGZelHY3trUIU
         avzxOZezJs6mVCGHzInQG+vxWEffrfCiLlCK0a3x+PgfadnazAlU+xR5PArTjUfwJD0S
         WYTuuTSe7+9J5NLsz0HRsmW6f64x75o6hHAoTorqLSt6BV6aSKkSdu+UlmZbTMAe+R49
         y9MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=llSRD3aC+RuBYEv6CAl+dHIN5jF4cXumFoIxNN8gNLA=;
        b=FYH3fzCJC5A2SaCFz84fK97hlt7tKzLB/lNv65VGQIGeoLNlWuiY/Jigh/zebOZgSl
         jSab1UYkoTyVP+j5GF5PCSDiizjp/bdhdt5a7DnWrx/fvRf4FdC/C4xIMg/shthZ8/Zp
         x9BLn+DyBx26tp1L/O8U/GnrOs6cm5CtDKSnoyO4mxXtftxiFLU+WFprZb5tzag1iJ3y
         vc5H/oO36ImqyVWOVF8ofipMGN+ZxBf4LmQC1NjOCxXTbCGTR3FM6Cvr5bBU3xUVB5Lu
         D6lAJ8h/GmhF9iYiXmpK08JZI4z9OCvmxL1WS12UqVYIxFeOqpyZHIlXGF7tJCYamoXR
         q8xA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5B0821897
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Nikola Ciprich <nikola.ciprich@linuxbox.cz>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.4 47/50] scsi: mptsas: Disable WRITE SAME
Date: Fri, 27 Apr 2018 15:58:49 +0200
Message-Id: <20180427135658.447309211@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135655.623669681@linuxfoundation.org>
References: <20180427135655.623669681@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908124902978465?=
X-GMAIL-MSGID: =?utf-8?q?1598908273325337986?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Martin K. Petersen <martin.petersen@oracle.com>

commit 94e5395d2403c8bc2504a7cbe4c4caaacb7b8b84 upstream.

First generation MPT Fusion controllers can not translate WRITE SAME
when the attached device is a SATA drive. Disable WRITE SAME support.

Reported-by: Nikola Ciprich <nikola.ciprich@linuxbox.cz>
Cc: <stable@vger.kernel.org>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/message/fusion/mptsas.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/message/fusion/mptsas.c
+++ b/drivers/message/fusion/mptsas.c
@@ -1994,6 +1994,7 @@ static struct scsi_host_template mptsas_
 	.cmd_per_lun			= 7,
 	.use_clustering			= ENABLE_CLUSTERING,
 	.shost_attrs			= mptscsih_host_attrs,
+	.no_write_same			= 1,
 };
 
 static int mptsas_get_linkerrors(struct sas_phy *phy)
