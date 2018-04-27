Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZojl6xnIZED6mvV8Sy0LeDcXZ2chs43G737Jfysh4oJ1PP1YDd6khLfNFQC0Zob9yyM9OaU
ARC-Seal: i=1; a=rsa-sha256; t=1524838114; cv=none;
        d=google.com; s=arc-20160816;
        b=NTcrqVsB/rfdGekkXSrK1vWyahprWfmHMDkwmSXSrQ66K0tp06TTa0xn5BWOS/LtOu
         lyOPRk8mknc81uuqq2AJjZLi9NwsQv6DkC4oSHtui3MS3RqlfeNDCFWelZ/K7EFMdeYb
         WbePJ/DxZ8IkI4mmCcSHMZb2E0+8+eYQ9eRdK1DQyus76xBvdiSbFOsoFppSbnAK0G7n
         oAVwYAPHhlrwh0s1Mmm6S7AXo5Qxh5ck4c4PX58OD/Ycj8o+Zy/guMJsFi3EBB+axtpG
         LqjA3HrCj45S2rWiyVc8Hml3IPAkY/ES98E7kxSYG1qOJIuSqqLYhJxY6X6TilRLiZXY
         CewA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=/L24NZm9YjJJkqLn9Uo6XvPtm8Rov1Qv9AXFEco39AQ=;
        b=VWZLhNVj11C7uTqjLopnSVqk1krKRj+pU/p44U5PFjmTSSxKHhoLyd6s1XYbTLZUtU
         PR3Tb0Oe+JMh49RG03UWPFxCnNjXp+Y3BlOTjfjT0IdefzHDIUEDubjznMBeiw4hCxSJ
         k/NWimaSpdPLwACE6VpcVL3AI5BYt2isD73LmTrTkdgsWCu4seXonr+YK75BX5Cc9NWu
         UD2ZLk+Jl71n/qcv0cidmdNDgJ01WVLWEBuo7lRcIxoENim6mHgl2TLs+OWkz8LkrOt7
         4ubdCR9toEpIQlTlHQu41Dkqp4No1nLUFEwOKeO/B8zCL8g3FzFLXK5+HQJd4PzPrvhm
         q3vA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDBF021892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Nikola Ciprich <nikola.ciprich@linuxbox.cz>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.14 65/80] scsi: mptsas: Disable WRITE SAME
Date: Fri, 27 Apr 2018 15:58:58 +0200
Message-Id: <20180427135736.257821684@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135732.928644313@linuxfoundation.org>
References: <20180427135732.928644313@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908124902978465?=
X-GMAIL-MSGID: =?utf-8?q?1598908650720070594?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1995,6 +1995,7 @@ static struct scsi_host_template mptsas_
 	.cmd_per_lun			= 7,
 	.use_clustering			= ENABLE_CLUSTERING,
 	.shost_attrs			= mptscsih_host_attrs,
+	.no_write_same			= 1,
 };
 
 static int mptsas_get_linkerrors(struct sas_phy *phy)
