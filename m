Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48rERGVvP0RhpIETkHuv2VQVadWbjswInbETUO7i15xYLOmnneYq0Bfh+qFYqOPOW9T992i
ARC-Seal: i=1; a=rsa-sha256; t=1522168341; cv=none;
        d=google.com; s=arc-20160816;
        b=gOgIsrDtq2IFAH+CgKHDfjZuPKrvtHAyvUC30E4/EKQFI4M4gzF3qQmdnZeZedZf0v
         pswmY9yLMC+ODxR+7pXAsiAVjsHLByzZKh5FqusUvc91P4pQcs0lAP227fO8PWwYPI2X
         P4odQyVA9f2iRaGBtArZ/8fYJ65uOQQvFl0HsLcA2p0bTiozOrfs2EOZxmqtj/hMXwFa
         +bqa4WvH0qgGobqymgOBBXEaLW+CW6VbiTrV7aaHNlXz0AYT+MXLl7tSgtYAfQzOchAl
         nLR+nERKfdugPNwoj4YPtXBUzFiOTbaPqF+Fbpz6M0eynwonqUVWCIg0RkUQ6Khq+OH2
         VbQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=pQuHdcWEABA1SJ0QvvAgXU687ZgGF28n5dRz7kd+Vxk=;
        b=lGFbZeHiP7G1U7TxVAkwNp0DgYGEOlbHIdTDZ//BzVuu4hadBpzQzoWpzDDor0FlkE
         vP28qBqIpFCg0xZAEay71ypRagDV4Z2E5pRbEEly3bXuR0vM/UsnSfO1U6BEjghul8xE
         gH2Sq0Aeoa9sFjCH40s5HbnZEI/QMgrlpGCtrwqM08HiBfHimCX/pwyNQUkU+fl7dWk0
         JFHCS0RBZTegSndrrwm5iaaCkwxpr3ZqM6MHb/FFcxLoLIRBlSdxxgn9Mauu+0OXR6GV
         obfzJZLxDEIDQGZQ+uQw70WtDJebAwl/2scnIP0BH8JGRLejr0phgTj5DSmUggLlB9Du
         55Ag==
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
Subject: [PATCH 4.9 20/67] libata: Apply NOLPM quirk to Crucial M500 480 and 960GB SSDs
Date: Tue, 27 Mar 2018 18:27:12 +0200
Message-Id: <20180327162727.966382921@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162726.702411083@linuxfoundation.org>
References: <20180327162726.702411083@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596108979990321198?=
X-GMAIL-MSGID: =?utf-8?q?1596109190359700574?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -4411,6 +4411,14 @@ static const struct ata_blacklist_entry
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
