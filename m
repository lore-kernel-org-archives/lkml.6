Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48NV9jr74D4G3RO9QPPKPOYAz+hkh7MKxxroAiPRnp7cb4n3Oma7dO2BJaUqhFKuQK8+ccR
ARC-Seal: i=1; a=rsa-sha256; t=1522168526; cv=none;
        d=google.com; s=arc-20160816;
        b=JyhhnEqI935E209ARNmZRStijabr00whCCIbYNQJGEupTO2gVLczmYmjzUK63VH1oN
         /5zq30VptTN7icOTH9HyDp5SzW5YWNNSUk8CDVeLioKV7J/TodY+Ev9IYyXlp2054CPw
         y6EB68Q4rwhSFdtiNUMphF2bT6dKoEF8+MFfT3Nml2n/K+R3UOFbeDauVmapBh3MFrqW
         B+xCL0KFE+hIvGNNZUdda2JpW3XvwDnhtzPr5uUBJ/jZFiZsvE7rxrKb5DcMlJNPh4zK
         Awi+bxiV5rrUY6T4Dzltnqzl9I2ntYqksGl4PxujVtLRsvoLmDZnk/kgB8q6voeyv8Ab
         A/Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=sU413HvwsPEVQFcw6qVmB8cJIsvDBKVAZN0fGOE54VI=;
        b=zQ0PsCtG/r/OlHhrKToRN1TgXsA+DgM9hpJ0xWpEyloPMLFs9Ev/STaijZC76QkFYP
         5knLHCi3I3hDhGVhTlnpvqi1yxm3FxsHXCEBwthJKWIKx48V2zZix14YgBXDx7u9aM/9
         51gsczWiN+QhYX689udhj7Ad5NUmlnpA4cBQ/8E6TAupyiSp4wyFOaHFTbUSeFRtxz2f
         ENCRSdqPFNaEai0Q3z/v9mL287LidW2iq98RIx3AqA0t5bsEMmmI93UPvKRl+CPBqF5Z
         vcaqONDOvttoVNpnyrd86tl3WQr2YkWTgW8a0rcu/THoIRCZF0yu8+Dxw8i4pFypuzlS
         JmGw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Kai-Heng Feng <kai.heng.feng@canonical.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 4.14 041/101] libata: Make Crucial BX100 500GB LPM quirk apply to all firmware versions
Date: Tue, 27 Mar 2018 18:27:13 +0200
Message-Id: <20180327162752.539674060@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162749.993880276@linuxfoundation.org>
References: <20180327162749.993880276@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596108983149684542?=
X-GMAIL-MSGID: =?utf-8?q?1596109384167347854?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hdegoede@redhat.com>

commit 3bf7b5d6d017c27e0d3b160aafb35a8e7cfeda1f upstream.

Commit b17e5729a630 ("libata: disable LPM for Crucial BX100 SSD 500GB
drive"), introduced a ATA_HORKAGE_NOLPM quirk for Crucial BX100 500GB SSDs
but limited this to the MU02 firmware version, according to:
http://www.crucial.com/usa/en/support-ssd-firmware

MU02 is the last version, so there are no newer possibly fixed versions
and if the MU02 version has broken LPM then the MU01 almost certainly
also has broken LPM, so this commit changes the quirk to apply to all
firmware versions.

Fixes: b17e5729a630 ("libata: disable LPM for Crucial BX100 SSD 500GB...")
Cc: stable@vger.kernel.org
Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/ata/libata-core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4521,7 +4521,7 @@ static const struct ata_blacklist_entry
 	{ "PIONEER DVD-RW  DVR-216D",	NULL,	ATA_HORKAGE_NOSETXFER },
 
 	/* Crucial BX100 SSD 500GB has broken LPM support */
-	{ "CT500BX100SSD1",		"MU02",	ATA_HORKAGE_NOLPM },
+	{ "CT500BX100SSD1",		NULL,	ATA_HORKAGE_NOLPM },
 
 	/* The 512GB version of the MX100 has both queued TRIM and LPM issues */
 	{ "Crucial_CT512MX100*",	NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
