Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsMk+T5Ewljh4wOPYUdKsaluWI9aG3AZrHJDC4yGYldtL4F0l9Je5M+ZkTeFxGtrvDZ7wJn
ARC-Seal: i=1; a=rsa-sha256; t=1521484101; cv=none;
        d=google.com; s=arc-20160816;
        b=pbT+rYGECoQt4a4GIpYbwsdt7uWL1EO5NK/DJ+OnBttDiVPLAj7dpT4gG2WiZ14nfl
         DsOP2OVPyTOmB9vE07xBUeAENYGY8/x4WKLdx+/VKJK9YyjKaidJloypC1LPKnQ1XONx
         iMrPA5lYY0SVTg0LzUkvUqjpHpO2+qDgxBAy4V8x+CG/DEM8NTwG7H9t6mZivo1ExV0i
         /d/EwDTFHGjqJNxlZXTEODh7PSgMVxm4+3Crc+Kl9x5gh6/09EMJecyp7ZXuewEYF/E6
         0pQ132nPBczoI6Gt7n+kTMzz2Cdmnofvdv2pFVdpzkstGj+GTMGZ1U80BRGFWoHnsow7
         kfDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=QrzEXNaQtossO61sGsX94C5kRi1LUR8iq4zbynGCKXg=;
        b=zQAjMQShd7PUUZzlvtKlQWbvzKasJxjF+D2H/IEDC32rKPx/uE9MQVHedLXlIVdozK
         hMxYoZJpg7dy4jm9SPw7YydQn1pM7M0ln5qZA9VvtpvxXUu+55Zt3W4xoVjKGKmDbxRu
         8YmJBZCsRy5ehvwo/njozy794kThYZHjEA643r4zAC9DYVxFcta8U5jw4RExSfKsNV3N
         amAYjtRc1oPEqkvGs6w/0KN2aCiPOshX7mpEqiTfiaVxzvfdycNY/rK92i/wxYP+6Vhp
         GCOBRDkWMPcWshCxDinIf3EyVIGrq449IyrEucsC5JS4TaefWsykG8t/6IBNE/PW5z76
         /8iQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Johannes Thumshirn <jthumshirn@suse.de>,
	Chris Clayton <chris2553@googlemail.com>,
	Douglas Gilbert <dgilbert@interlog.com>,
	Hannes Reinecke <hare@suse.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Cristian Crinteanu <crinteanu.cristian@gmail.com>
Subject: [PATCH 4.9 233/241] scsi: sg: fix SG_DXFER_FROM_DEV transfers
Date: Mon, 19 Mar 2018 19:08:18 +0100
Message-Id: <20180319180800.827102310@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390662644513499?=
X-GMAIL-MSGID: =?utf-8?q?1595391713863060368?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johannes Thumshirn <jthumshirn@suse.de>

commit 68c59fcea1f2c6a54c62aa896cc623c1b5bc9b47 upstream.

SG_DXFER_FROM_DEV transfers do not necessarily have a dxferp as we set
it to NULL for the old sg_io read/write interface, but must have a
length bigger than 0. This fixes a regression introduced by commit
28676d869bbb ("scsi: sg: check for valid direction before starting the
request")

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
Fixes: 28676d869bbb ("scsi: sg: check for valid direction before starting the request")
Reported-by: Chris Clayton <chris2553@googlemail.com>
Tested-by: Chris Clayton <chris2553@googlemail.com>
Cc: Douglas Gilbert <dgilbert@interlog.com>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Tested-by: Chris Clayton <chris2553@googlemail.com>
Acked-by: Douglas Gilbert <dgilbert@interlog.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Cc: Cristian Crinteanu <crinteanu.cristian@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/sg.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -758,8 +758,11 @@ static bool sg_is_valid_dxfer(sg_io_hdr_
 		if (hp->dxferp || hp->dxfer_len > 0)
 			return false;
 		return true;
-	case SG_DXFER_TO_DEV:
 	case SG_DXFER_FROM_DEV:
+		if (hp->dxfer_len < 0)
+			return false;
+		return true;
+	case SG_DXFER_TO_DEV:
 	case SG_DXFER_TO_FROM_DEV:
 		if (!hp->dxferp || hp->dxfer_len == 0)
 			return false;
