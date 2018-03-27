Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx493psfKuZ1LsURNZ70BRH1XcwugiJR0mZmcillBV69pNx/AA3XMG82zRn5tfxnegSRLE/yN
ARC-Seal: i=1; a=rsa-sha256; t=1522168208; cv=none;
        d=google.com; s=arc-20160816;
        b=TEYXKnLLZ0cdtcvgnz30swBydtf8qZTJdyCBPIu4l6zRhuYTBjg4oppdkbGzWKozxw
         IheWCo323BsHSbsVoTp5nV01hbPZ8YusPoGumqRd8Q9wLmQHhBg+oeZKPOddjd4yWh4/
         d1/jv1RpOCl+R5BDv88e+ZZg8TDtdkXTS/YEXobnqFzEIZjwGObU4PXDY0Bi1z7c0xXa
         zwuxb0T/rWGvrI2B7bx3XJt0qV3iL7QjtbCO+WBDJ/GDowJOvh2YRN27bY6QRScmdDeW
         isgQrqAOpL4nKRHYy09UU07sno5f8igiOIUM1vdisMugX0yZiMllrj9HyWA3VG6POoVd
         nclQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=DpqoWgXmjoiX9ReLr/6I8Wfec7rattGyiJGaqv/K/wQ=;
        b=oEbOR9baZzT9B2WkRV9/AN1HOglJvqPAqWuvO9U2vCXA2SoYNtX+E4qqxJxqvZDPNo
         L3iidaHI/gcWASdYe61DtNX4pqbC+tFaSVXQVWL9PYsqb82nyQwumDZ19mXaO0lRDRhD
         qBCwtCnSkwR+qqgwe3t8qZOWyn5Y5DnFTOjhH7LaGOORgnQZ4ga6dvEQA7Ll8ZDJJJ+c
         Ho2kZPixSZ8QOtcuZft8nLPvqPMqpXvuR286Mpg9Rv1rwdxdli4Ok8a7sfa1u/2H2C5G
         PH1MKBwshNHsA8h0C5gHBn3yXC6eaJMTM/yqc8boiq2ce2T0lv9Cis7VgduaQAjox10M
         k15w==
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
Subject: [PATCH 4.4 14/43] libata: Apply NOLPM quirk to Crucial MX100 512GB SSDs
Date: Tue, 27 Mar 2018 18:27:18 +0200
Message-Id: <20180327162717.251149251@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162716.407986916@linuxfoundation.org>
References: <20180327162716.407986916@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109050829353966?=
X-GMAIL-MSGID: =?utf-8?q?1596109050829353966?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hdegoede@redhat.com>

commit 9c7be59fc519af9081c46c48f06f2b8fadf55ad8 upstream.

Various people have reported the Crucial MX100 512GB model not working
with LPM set to min_power. I've now received a report that it also does
not work with the new med_power_with_dipm level.

It does work with medium_power, but that has no measurable power-savings
and given the amount of people being bitten by the other levels not
working, this commit just disables LPM altogether.

Note all reporters of this have either the 512GB model (max capacity), or
are not specifying their SSD's size. So for now this quirk assumes this is
a problem with the 512GB model only.

Buglink: https://bugzilla.kernel.org/show_bug.cgi?id=89261
Buglink: https://github.com/linrunner/TLP/issues/84
Cc: stable@vger.kernel.org
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/ata/libata-core.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4224,6 +4224,11 @@ static const struct ata_blacklist_entry
 	{ "PIONEER DVD-RW  DVR-212D",	NULL,	ATA_HORKAGE_NOSETXFER },
 	{ "PIONEER DVD-RW  DVR-216D",	NULL,	ATA_HORKAGE_NOSETXFER },
 
+	/* The 512GB version of the MX100 has both queued TRIM and LPM issues */
+	{ "Crucial_CT512MX100*",	NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
+						ATA_HORKAGE_ZERO_AFTER_TRIM |
+						ATA_HORKAGE_NOLPM, },
+
 	/* devices that don't properly handle queued TRIM commands */
 	{ "Micron_M500_*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
 						ATA_HORKAGE_ZERO_AFTER_TRIM, },
