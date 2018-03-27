Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48/BMSeEyZAKuFsCGs9twoMfdqMZFOdcsNyQnu6t0z7I2WtAAHF3eCpWbdsKvAOn5ICY7Dl
ARC-Seal: i=1; a=rsa-sha256; t=1522168913; cv=none;
        d=google.com; s=arc-20160816;
        b=N+8nvXkkX7VUkgpwuqTfx/ezSA4u3jUGatqBKmXcIJ17D1mbIjgxvE5tGn/Th69KOG
         GP5gQZ3Pv0A6Ws7yikV+50By8N7Qbz6FKa1B3HX+QrHjggBbYkqWzRS7UhZBpWMHgpgR
         yAbOwG7H5FE4rLeaz6nRl3Rx0oY9egihp+MiAil8GZIlqoGCdE2swOK94+vO8msvT822
         F/t3/Oows2UDSY7dbqvIuk+0ZFUdRsk1KKzzYxGzslH8UXvITXTHcOpKsm5e/iQ99PV7
         MZcfiEtfqsJV1Lj2yvnBDUzuYJq31wdRerwQsByUbpnRxo763MOu9gIbpbsxb11K9hoy
         ophA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Ff5ANg5JaiiCSeOhBm9s1jCGKMXDO21AGj0T714a7j0=;
        b=KUEgaf1CcCG+jqlDASwW8EYl4siPJkbTu1ygKpXa8KrXPD8PTTCy5P8y2fhMWRQFkN
         VM2jhZjpvkQifhagydfNPBrWHWuvKJ5HQeDHwUqSWapYfa0fP+J3zTFG201RYSVbw+xn
         hxd+0KMXxlah5Sxf64Odyrxbd1IU44QJM0Wk0fQak8YNhQgNBA0uLVfLSuoffOxH6hIG
         4j1BQObY2IJkqHYLJbfm35h5hv11TiUhAeI6Cr9E00Hhu9tdKDFWIa3VTBLkcpoQBs8t
         DxO2uT7fR9uVaMWqauVk9HT2hV8ZeOtLsew2Fp++GIyVAVCe6Hv2TQuRXgYRrlfct8Io
         2MRQ==
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
Subject: [PATCH 4.15 042/105] libata: Modify quirks for MX100 to limit NCQ_TRIM quirk to MU01 version
Date: Tue, 27 Mar 2018 18:27:22 +0200
Message-Id: <20180327162759.840931842@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162757.813009222@linuxfoundation.org>
References: <20180327162757.813009222@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596108985800843811?=
X-GMAIL-MSGID: =?utf-8?q?1596109791578792441?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hdegoede@redhat.com>

commit d418ff56b8f2d2b296daafa8da151fe27689b757 upstream.

When commit 9c7be59fc519af ("libata: Apply NOLPM quirk to Crucial MX100
512GB SSDs") was added it inherited the ATA_HORKAGE_NO_NCQ_TRIM quirk
from the existing "Crucial_CT*MX100*" entry, but that entry sets model_rev
to "MU01", where as the entry adding the NOLPM quirk sets it to NULL.

This means that after this commit we no apply the NO_NCQ_TRIM quirk to
all "Crucial_CT512MX100*" SSDs even if they have the fixed "MU02"
firmware. This commit splits the "Crucial_CT512MX100*" quirk into 2
quirks, one for the "MU01" firmware and one for all other firmware
versions, so that we once again only apply the NO_NCQ_TRIM quirk to the
"MU01" firmware version.

Fixes: 9c7be59fc519af ("libata: Apply NOLPM quirk to ... MX100 512GB SSDs")
Cc: stable@vger.kernel.org
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/ata/libata-core.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4533,10 +4533,13 @@ static const struct ata_blacklist_entry
 	/* Crucial BX100 SSD 500GB has broken LPM support */
 	{ "CT500BX100SSD1",		NULL,	ATA_HORKAGE_NOLPM },
 
-	/* The 512GB version of the MX100 has both queued TRIM and LPM issues */
-	{ "Crucial_CT512MX100*",	NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
+	/* 512GB MX100 with MU01 firmware has both queued TRIM and LPM issues */
+	{ "Crucial_CT512MX100*",	"MU01",	ATA_HORKAGE_NO_NCQ_TRIM |
 						ATA_HORKAGE_ZERO_AFTER_TRIM |
 						ATA_HORKAGE_NOLPM, },
+	/* 512GB MX100 with newer firmware has only LPM issues */
+	{ "Crucial_CT512MX100*",	NULL,	ATA_HORKAGE_ZERO_AFTER_TRIM |
+						ATA_HORKAGE_NOLPM, },
 
 	/* 480GB+ M500 SSDs have both queued TRIM and LPM issues */
 	{ "Crucial_CT480M500*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
