Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48cR8wrrkyFzVp1r6F6bqwBwx4LVmsbkVzF2Y8GVxEzNoV90MhBBRAP45lrpZ3NQZKzYOlE
ARC-Seal: i=1; a=rsa-sha256; t=1523021129; cv=none;
        d=google.com; s=arc-20160816;
        b=bunjyESYJ8m+hV34M2Q3dwJxmaTPPZzky03J0zFeSBT90x/Y+jFj5ab3Yat6yJ1iA4
         NmGiadukaPrA8wwyn8TrJUzXF0AQws4WvcBIYngrT/9AanigcPg9XFcb4tBHMlsf60WD
         WAcAdy0vmXHGGkzOtWhlXkveb6vbQgO4xXm0+eF8X43vxjba7HNnLJcpDdFq1Xfikpo8
         wvP0LU0Xu+r7Y2e6U4hV6i+y8gJyQZSa7/RDX2dS1ToK7Z7TFX/MQVVQfCtQR83PIwEn
         WypcNfA1DmBetnyG7Z0qCnoZLsraNNtD53P+MCCkT6IhzafjegryhSIDEtmQqeuiPJ4O
         ycrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=hDImhPfLl+pwwN4XsJcZLIhT/H15QS01tTKRDf8dLe4=;
        b=zwcHd9PTJxuRB05lbUsxg8OfaY3Hu3NTmzJu/FErc3AQ2jhlreJ2rxy2dN/oGsOjTe
         nPG3YETHZCusGHBaFdkvEOnBFUdwva7Edu3zPqjhByzV18SAEvigZSgs3yr3tVxtcu36
         zyhgWX/c96GwK/WcvXXT15NzYbUSA+cYZWXu8mUiUn8dv9qEv15ZGwxzXZWC/CJ0HQvU
         c++yHuohRw19kyT3ujiO9ijYB2u9FTgy4xpSZ2haxn54hM6z1LzANuIGYpDZ8sGUJMQq
         V1QpQ60qtRjRFMq14jtMsjJYDonX4S+6vLTf5cZIw16btzHyxs2DL7H024NTp7KD7xXy
         0rPw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Park Ju Hyung <qkrwngud825@gmail.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 3.18 08/93] libata: Enable queued TRIM for Samsung SSD 860
Date: Fri,  6 Apr 2018 15:22:37 +0200
Message-Id: <20180406084225.338254186@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084224.918716300@linuxfoundation.org>
References: <20180406084224.918716300@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003403143044560?=
X-GMAIL-MSGID: =?utf-8?q?1597003403143044560?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ju Hyung Park <qkrwngud825@gmail.com>

commit ca6bfcb2f6d9deab3924bf901e73622a94900473 upstream.

Samsung explicitly states that queued TRIM is supported for Linux with
860 PRO and 860 EVO.

Make the previous blacklist to cover only 840 and 850 series.

Signed-off-by: Park Ju Hyung <qkrwngud825@gmail.com>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/ata/libata-core.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4244,7 +4244,9 @@ static const struct ata_blacklist_entry
 						ATA_HORKAGE_ZERO_AFTER_TRIM, },
 	{ "Crucial_CT*MX100*",		"MU01",	ATA_HORKAGE_NO_NCQ_TRIM |
 						ATA_HORKAGE_ZERO_AFTER_TRIM, },
-	{ "Samsung SSD 8*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
+	{ "Samsung SSD 840*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
+						ATA_HORKAGE_ZERO_AFTER_TRIM, },
+	{ "Samsung SSD 850*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
 						ATA_HORKAGE_ZERO_AFTER_TRIM, },
 	{ "FCCT*M500*",			NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
 						ATA_HORKAGE_ZERO_AFTER_TRIM, },
