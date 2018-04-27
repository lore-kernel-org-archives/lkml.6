Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZo09xwkm7O7oSplhcLbFapi7waJ2+AXIVQrlXTdDYzkgRx5XiMLLuPB+NYTjfKq1IHQ9t1m
ARC-Seal: i=1; a=rsa-sha256; t=1524837612; cv=none;
        d=google.com; s=arc-20160816;
        b=je/UsYLICH453MWmt+pcRaqg94AG7K0Q6N1rJ5FKf7b1p/4LDpQT0Qdd4cKW5OreHj
         qIAPpbFsFE/8L2i6aVr86W/9DzyxBhw9FKYGcB8qCkn6Is+FuxpOjr61ucKeh5qVOxhM
         n73TxXR31IfIq7tAG+QdWRYgPmmTO5uzkpnws5twFWpJnEhpMBagABHTcB37iryx+V2Z
         LZtcgoMEEtEAj32sWYo4jUuuXqzFcTX8C9RThdTSrHzAappOFuiJRjvuAudWZMVt+xOW
         4PzHQkSMqKAeFoo+Fdw9eHUlQ0m5Qlh2vMWG9T8jDWvtsIei5u5pIWCMfWp+XDDCcxTH
         WzuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=f/54kxQl44vESK6NzK0QBnNok5RoIruR9aYcCh0BTvQ=;
        b=VQaqE10yVGILKLuqO+dNSlHcX8lpwBajx21BrcOJkkvfECNXX1s7yQiCdsopGR3XM9
         m0Krdm6i6gJIFdBok8Aco/OqEwiIIu7zGBQFBxfKUVfrhDIKv2m+qFSnlF7qqsopH/fX
         EMGiauw61RAbNFNJ27F3z/3V8kfBG9IT2qGY4FEEGxGUN70I3PyK8iMPOAEr9TeZvA7w
         GWKQl5llyCL4mZBcvtMBNSYpBGKDAQZApzFcIH+sWkDD3arwNC3TJWCeBO21ruQ+Ds5+
         r5q+G7tVN1TGcb5ZWIwBH4+W6TIP08YR4V5WfYDX3Y3KsL0+ZqxFA2fbSS/uR71vj58t
         Khow==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D55AD2185A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Nikola Ciprich <nikola.ciprich@linuxbox.cz>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 3.18 23/24] scsi: mptsas: Disable WRITE SAME
Date: Fri, 27 Apr 2018 15:57:58 +0200
Message-Id: <20180427135632.533620740@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135631.584839868@linuxfoundation.org>
References: <20180427135631.584839868@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908124902978465?=
X-GMAIL-MSGID: =?utf-8?q?1598908124902978465?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
