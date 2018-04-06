Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx486RCgDimiYl/M7M1CiUXF5PbtcuZiwnoid0AfIonrdnnAkfWOi4DWCPvzBoRkPAUeA95oe
ARC-Seal: i=1; a=rsa-sha256; t=1523021123; cv=none;
        d=google.com; s=arc-20160816;
        b=YPK90yleEhfnpesW+yar/NEMyPBeXNKBt8vh6ktJQWtjvo82OamOBSHOan7lLExZcH
         bBuoPZ36fYpzOt9TMEUrNa/5L226c+DVSZ3VivHssQgfBS6Q3u3vk04NagAT68Z5UG8m
         Y5doHT/hep8n8W7Mc7nVKLQo+iE+7iMtgvUPGbmnLJzdMTN+n0wN1ovsxXZ3tZBM2+ah
         9j1CLx5a2LG4Bh3APcb9Rq+mNwd+BMplT18rYYWmbjHPFc1x2ryx6cHiFRvGWmQzVD2H
         Ka21bOC6AY2lHcNj+zljCBuT7f3gRNRGzSMMqTonuH59ozM2rUuDjt6ETVasyaMibzfV
         RveQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=yhG3aj1vD/d4sSB2G4Cm8d6xedtaxuWDkRpWjazTJNw=;
        b=z2v3HL7gGfD2cYHuL/jzCcRnADCZMcGUErEU89taHH9ZDBnRLjBkCBbtsuK+zS8Eie
         iooHNS9pYv9RgI345dvwPBbIjl6iziRuhJ6C5NPurTrehvrSmfZlJRCnXqT318R2T3+j
         UTE36lcdF8+exjjO3jcqxQaUB8KqyDbnNwJA6wmXF1kLpRvrFo+ZmiBNSfwc0zeS/Q3h
         6yXQDjO4wAa/QsKlMUPPy/99dNrphFmMz1H1GvWR/wDgQoeu5d/SzicVxBajYq5byIdX
         Otdu0Ij3lKycGn2QZ4z5DM1D1kcoUKtzmmpOtBCPB8jKbAVnW4C67OEBHNaAA+QGu52m
         lO2A==
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
Subject: [PATCH 3.18 06/93] libata: Apply NOLPM quirk to Crucial MX100 512GB SSDs
Date: Fri,  6 Apr 2018 15:22:35 +0200
Message-Id: <20180406084225.252330211@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084224.918716300@linuxfoundation.org>
References: <20180406084224.918716300@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003397859826048?=
X-GMAIL-MSGID: =?utf-8?q?1597003397859826048?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -4225,6 +4225,11 @@ static const struct ata_blacklist_entry
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
