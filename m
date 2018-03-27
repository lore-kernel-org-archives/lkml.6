Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/w6iIXGopNSZBqpMYv7Cx3MgDnHUrfx4wlyi0iTyJvVKWhfncF2R20gtegY/hGU34uRDtH
ARC-Seal: i=1; a=rsa-sha256; t=1522168903; cv=none;
        d=google.com; s=arc-20160816;
        b=Ke/VPeYFlDVcb7g2gFeRsu3F1gEsJbJGz1+PQUm6Mpk/Jz/W3iHuGG7pneGXU8TbtW
         3qfuVxqligFzUr+lfoX8ygThYAwSRrOkAlxqK6wXpYnQdoemi0jJBRVutT1xRYlqZHzJ
         ZCtneo/REkBXBpJml4VmIhrml/XAIBdbMdrl1afPAfwCgLJp9YdyMCXgiNYoXRk0ep/s
         HD24zdJsKMxyQshPE9bHYlSq/ovmtoDEkBlF1JU8JV4gR+qsOM4A8472owHAyI2JrCU8
         1yJet6YtnSc5hWQjvBhZBQ8jQPlObhZa1YUn4zDzWKHtLc6ESK8cAHRTsqx8UAH1AIdL
         0Pow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=IyOKGwAS4wFFb2ZwD4OB6rcluinxqzlDhKnszMdb+dI=;
        b=APET3op4YfSKBhXLE0eT/o88SVTS0Eg7FveW9if4o+J+0o/+K/7Ddes75wkR5JgIXP
         sf+XnAOhhNVTLjFu2pOx8S/TnAvVl7zjjiNGCHNcMJpcB9hWIvQD7jxl3MeYd00953e2
         YJ6N6gMQOFQ2NjN0m0C26f5fRDkOh820d+9fqwdDEo5INo4/8O9Cjomv2pSigHnvroiF
         m7J2hwE/tJwCsgI1HubHmEkkYmRsMRp8xKs1ynm8A/Os1Qh7iN6gCTtCOoeE9suGGz15
         H6e3zzKROx8iGJ2T9pvOjPhCl+2guso1c8Lvurl+vKAd6jdF5C06U8i5NEHim1xu8Wjy
         z5Zg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Kai-Heng Feng <kai.heng.feng@canonical.com>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 4.15 038/105] libata: disable LPM for Crucial BX100 SSD 500GB drive
Date: Tue, 27 Mar 2018 18:27:18 +0200
Message-Id: <20180327162759.643400334@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162757.813009222@linuxfoundation.org>
References: <20180327162757.813009222@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109053741544875?=
X-GMAIL-MSGID: =?utf-8?q?1596109779194034641?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kai-Heng Feng <kai.heng.feng@canonical.com>

commit b17e5729a630d8326a48ec34ef02e6b4464a6aef upstream.

After Laptop Mode Tools starts to use min_power for LPM, a user found
out Crucial BX100 SSD can't get mounted.

Crucial BX100 SSD 500GB drive don't work well with min_power. This also
happens to med_power_with_dipm.

So let's disable LPM for Crucial BX100 SSD 500GB drive.

BugLink: https://bugs.launchpad.net/bugs/1726930
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/ata/libata-core.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4530,6 +4530,9 @@ static const struct ata_blacklist_entry
 	{ "PIONEER DVD-RW  DVR-212D",	NULL,	ATA_HORKAGE_NOSETXFER },
 	{ "PIONEER DVD-RW  DVR-216D",	NULL,	ATA_HORKAGE_NOSETXFER },
 
+	/* Crucial BX100 SSD 500GB has broken LPM support */
+	{ "CT500BX100SSD1",		"MU02",	ATA_HORKAGE_NOLPM },
+
 	/* The 512GB version of the MX100 has both queued TRIM and LPM issues */
 	{ "Crucial_CT512MX100*",	NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
 						ATA_HORKAGE_ZERO_AFTER_TRIM |
