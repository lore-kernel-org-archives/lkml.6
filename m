Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48slbfcyT7H9vKBK1tc/fvAAH0nXlNYvMZZAX2/5LyCCRfKEuTLBVWqezSeK5H1kkwa+2gB
ARC-Seal: i=1; a=rsa-sha256; t=1522168908; cv=none;
        d=google.com; s=arc-20160816;
        b=X97cHJFbCdKUhy4gS39etSvZjhrY/YvEi5IAhzmJD5O13Xj1aoK1dq4SWFyfqMyc6c
         NR6yvNZRE7r5galk5axJF8bKOxuLehOlTpzi5d67FcttaN3+xT8XWOB2zoenEnlYR/Lv
         OmrdEemkW4+UQfiml9Q+YelwLiijvngURoCk9X1jsDElWd86cFNclKRt7mtisvZfawWx
         uy3Xv4KDUkzKPR7q7wUiep2BnoTmV07W922BmReDlkdtxWtexK6b0Gfx0zFmVw6FvFUv
         vBGctnF183off7ce7QaGjCU5By8uVIXOLdLmRACEMhg6fXtl9kW38qaNmpf8u924p2me
         lb0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=8FpiwLXPvkxOH99/lnSscaWYIc3YVTwPxEQMWUPexGQ=;
        b=SUjqdXe42/oC0gNw8YLKYsxteQA/7SgCblAgLBDC8NzE6PwaJesgulhVcaW8lS+uSs
         HM2CL4Mr1gzOr/cM4SHRt4K+XlQ8h/EZFs9P3ziWlDL9XWvGYN21rE+/TBAEqbRlqP8o
         qAwuqjqhF7/8GKlWMuoZNNO7r746NO25f7CJVo0nd7L9P1LSe+Y7dlvDQpTGxM9IMkdi
         I9eJo3y3ey3JT7UyAaztv6xovR2Cz7uzLiW06Uvpk/JQovp6u0bh8djto+WQSAsu5Qj0
         Jtt/Nx/xV/W7doX1MB+tLffAH0Q81vhWMvs2gj83MPhElOZY+VF7+P+qv/mN33fGv555
         B9gw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Hans de Goede <hdegoede@redhat.com>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 4.15 040/105] libata: Apply NOLPM quirk to Crucial M500 480 and 960GB SSDs
Date: Tue, 27 Mar 2018 18:27:20 +0200
Message-Id: <20180327162759.731501169@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162757.813009222@linuxfoundation.org>
References: <20180327162757.813009222@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596108979990321198?=
X-GMAIL-MSGID: =?utf-8?q?1596109784676374063?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hdegoede@redhat.com>

commit 62ac3f7305470e3f52f159de448bc1a771717e88 upstream.

There have been reports of the Crucial M500 480GB model not working
with LPM set to min_power / med_power_with_dipm level.

It has not been tested with medium_power, but that typically has no
measurable power-savings.

Note the reporters Crucial_CT480M500SSD3 has a firmware version of MU03
and there is a MU05 update available, but that update does not mention any
LPM fixes in its changelog, so the quirk matches all firmware versions.

In my experience the LPM problems with (older) Crucial SSDs seem to be
limited to higher capacity versions of the SSDs (different firmware?),
so this commit adds a NOLPM quirk for the 480 and 960GB versions of the
M500, to avoid LPM causing issues with these SSDs.

Cc: stable@vger.kernel.org
Reported-and-tested-by: Martin Steigerwald <martin@lichtvoll.de>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/ata/libata-core.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4538,6 +4538,14 @@ static const struct ata_blacklist_entry
 						ATA_HORKAGE_ZERO_AFTER_TRIM |
 						ATA_HORKAGE_NOLPM, },
 
+	/* 480GB+ M500 SSDs have both queued TRIM and LPM issues */
+	{ "Crucial_CT480M500*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
+						ATA_HORKAGE_ZERO_AFTER_TRIM |
+						ATA_HORKAGE_NOLPM, },
+	{ "Crucial_CT960M500*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
+						ATA_HORKAGE_ZERO_AFTER_TRIM |
+						ATA_HORKAGE_NOLPM, },
+
 	/* devices that don't properly handle queued TRIM commands */
 	{ "Micron_M500_*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
 						ATA_HORKAGE_ZERO_AFTER_TRIM, },
