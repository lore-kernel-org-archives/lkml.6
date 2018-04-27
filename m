Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpu9ADwuTxNCakt01g2xVIMvpmZo/a5q8114kz0YoaTStpfH6/qQiIrfUCwhTuMGfkPs62M
ARC-Seal: i=1; a=rsa-sha256; t=1524837925; cv=none;
        d=google.com; s=arc-20160816;
        b=VoeCpuEItom7LixYGAR2CqJKHmWXOOXNCSbLBZIBpvsXA3FnFMgL+pWwgRZY2FnYDj
         mrLbD6q77FaA2V+kudOQ8vOX1L/rt4xUXT2lm3jh3y0b9ZilZJJToRKAo/QdOiC3oXPG
         Ckby1RrX62hl/95FR/5cyeKIb4AsFeoEuONS4peGaLq+EsdYtdnOJrSGhMeU0K5zdg1Z
         v2Efgx13kT0nfxbgjBXuIYdQs+oiV/xieS8ExySUQeNGUF17W1zNEguD7WbwyXYVCGsL
         S0kqL5RGKEuqbyo7SZvHzGGIRnR2hm8mcM0q5ImBKvIuXO9pzsXFoFK6DHrRpHxUUrGU
         WF7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=p9JPHIvKKjOoagMA97FhwPcSRko42ohfns/u0zZFYi0=;
        b=AoSSMqzWPtWd+fldpyBln2dX+9gvlTWLKIzg7mCbOCP2XkqsW5ATcFmD5v/ZdYl/uj
         QUt/k6a/QnC/CXD3y+q0vhvEXhofd2QKfuhfM0AGX7Bur2bFGt6jl6EBeLmapbQt+4Rz
         YRfYh9+y80CTH87s+F+Ywpzuh6vCSqjIIdBl+m0k9ja6mRu+FW5VlPktAkNUBsv3N1Ou
         ZzMSfhRmw0ga7rh+yXaClFahxLZ+JaZXFvtoOl1PGqVg/+EOYSganfVtD41KRtkiQhuH
         kF0RyEPVOu0s23+BNi+uFadq7KpOqwPuBKwR4iHMQa4XqWWdrwbbICI+7TooiQTQffPU
         6NhQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0E1C21890
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Nikola Ciprich <nikola.ciprich@linuxbox.cz>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.9 69/74] scsi: mptsas: Disable WRITE SAME
Date: Fri, 27 Apr 2018 15:58:59 +0200
Message-Id: <20180427135712.807955900@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135709.899303463@linuxfoundation.org>
References: <20180427135709.899303463@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908124902978465?=
X-GMAIL-MSGID: =?utf-8?q?1598908453327222432?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
