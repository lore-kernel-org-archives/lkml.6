Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/HGORLdza7FHFAwTZVpukcYqPK7OBFWxkezoEJ0TCG3XmPWhoF2c82uN8AVdM/iOsi3hSX
ARC-Seal: i=1; a=rsa-sha256; t=1522168523; cv=none;
        d=google.com; s=arc-20160816;
        b=VVxAyh/fm3Rk+2VsLFm3WL0PP+arHfZ1Eh7LYTQy0bNug85Y99IPIoZ8/jng2ybLN6
         PPHDcdF4hzOcqLgv1lDH+7NJwCnEbedh8ZzBJSkQurof0tMeLOsDbAXAChDoJ8h09ACV
         78k8RxtAU3uwlLKOOgxIBCdfQFO27vyZm07vqu7nnlnzbh58rnkQOZfbZqZ4AEfeP+2D
         ulAs73SP8+Jg9rv7N+MmyCUyNigGGbUPhrw5qwMs6f7UNlckp1J4VRgw8SnQYa/idI0t
         r86tIWW1ZmiG/IQ0413nTQs8Njty4jPiiJigrQhknrZQNy2FLA2hYnQc5BLzOVEwmvY+
         aP8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=JNBFyufYydAx5v4Gk/hx/gzVqkZ9w8rAIC5rAI0e9y0=;
        b=JbFz7epWzG7DL1lkt04SJ9Ys2HxDn0tngpAc1EmBotlVfk4qFBsThaaHHb52nRMum3
         ZkN2yA0PFeARB3X1JKuDxXxaRtWvjB2YRgP/NdKlPFjoyWFP6cjzsgsP+RX/lT1+I2xY
         yCyxg2KYfSXy7wo79GtE9cMV5YEr4JpqM3GfZidXouSAlfn9tiu5wQcc6cfoiL6878Nz
         nSnMRA4kmRznmmyE6+wLeOGuq7wwMsqofvd+p4t7ov2pcQhNrQ2VL95LtIpbjnftmnuf
         P2AHj0CUNW3or5V1yIDF6EelmQC+xWxjHDdcZI5ZgQsDudI5EllVUGwUX3gjZZjLCIOv
         6iCw==
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
Subject: [PATCH 4.14 040/101] libata: Apply NOLPM quirk to Crucial M500 480 and 960GB SSDs
Date: Tue, 27 Mar 2018 18:27:12 +0200
Message-Id: <20180327162752.483842274@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162749.993880276@linuxfoundation.org>
References: <20180327162749.993880276@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596108979990321198?=
X-GMAIL-MSGID: =?utf-8?q?1596109381707463059?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -4528,6 +4528,14 @@ static const struct ata_blacklist_entry
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
