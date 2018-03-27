Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+5oywCy1IsD9HXbfMReLdxCNV1pNiGXnz/lS/rges8b6t/+fONN9MX5Yujbvto4MBoBj/a
ARC-Seal: i=1; a=rsa-sha256; t=1522168514; cv=none;
        d=google.com; s=arc-20160816;
        b=Hkw2oBkPFeCoU5/USQRtMUIdbxoLJ46OoC90TRndJvqzPYpLo+W2I9lEPOOO4LhSl8
         pFWA84b2TLxxFRPi9TtrDhCO9skq07PbOnXIpfCximXzAt2271Y369JggqFSdG1sfclz
         /fK+sw7YHFGb8VfMd0kCTmRVMZQ+HxtR4NsDfrt66hy1R4HVvnNjOFwOmTegnIVRcUkx
         sMzyuy/UDxHJ5cSKjv3bzAbFiotnCiAsioeCDDUyf/ALKqPpcK8tL8IIN/vg22ewqmH1
         W+e7yCY512KvmdhVsgsSFbOdhU29StP6Xv5RuodIu3tQOwaG2H8/vb8ryDM9sHx2Jm2M
         foow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=oDHuCQa6m/qH8DxZoSwaWonoHfnN2/EAHarKF3tsrik=;
        b=1KmJqIG4/DP3qlWBCRTbwnAjSkzzEaAGcPr4fecVWIcFTW/GiXUhQ5+BDUB9cdrTW1
         SAPwuYD1IVz3UAvFaAcEYDM/+Qheo82UBpWgBuEZohKWj6HJdDgLMY7Q/X97DrJwIA7H
         E/HsF5PNH3K7nsxU9x+rLsfTbz5B5LsPRYZ1bjsEY5AU6SE3S48Ww/TFm3OTTS0Bcm6M
         niQti8xnaqB0cwtHickeTgBb6WWpV8fH0pvgkK2ZB+cajBFb9rQTdkIqFkvCX5KShex5
         HGJ/Nkfbl9ezwN1kRRnHjkEPDraFHbgOUDcXfmUaShwkg19zJ7jXl6zGbH9/TJPMNUjU
         srpA==
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
Subject: [PATCH 4.14 038/101] libata: disable LPM for Crucial BX100 SSD 500GB drive
Date: Tue, 27 Mar 2018 18:27:10 +0200
Message-Id: <20180327162752.354614698@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162749.993880276@linuxfoundation.org>
References: <20180327162749.993880276@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109053741544875?=
X-GMAIL-MSGID: =?utf-8?q?1596109372678131501?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -4520,6 +4520,9 @@ static const struct ata_blacklist_entry
 	{ "PIONEER DVD-RW  DVR-212D",	NULL,	ATA_HORKAGE_NOSETXFER },
 	{ "PIONEER DVD-RW  DVR-216D",	NULL,	ATA_HORKAGE_NOSETXFER },
 
+	/* Crucial BX100 SSD 500GB has broken LPM support */
+	{ "CT500BX100SSD1",		"MU02",	ATA_HORKAGE_NOLPM },
+
 	/* The 512GB version of the MX100 has both queued TRIM and LPM issues */
 	{ "Crucial_CT512MX100*",	NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
 						ATA_HORKAGE_ZERO_AFTER_TRIM |
