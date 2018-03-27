Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx497luS6dR+CBvY4Mz67UxyD86Tn8ZglRWpDLGmxchdZo/L3/l0xxssVD0d430E39lq16c8U
ARC-Seal: i=1; a=rsa-sha256; t=1522168332; cv=none;
        d=google.com; s=arc-20160816;
        b=cHZ0ilHtsRwIuTpnd+dKh051jToXE9crsh7usgnGPqqRfeW1Pklr9KfcWdjDZ3xZDf
         lAl8e3HB6i5YBusVvid6w12gHLqAB5NrVbxWtuB60iXwShlJAp4qNpmUPIJJ10SnrZg0
         AqCV7YSWAbdWgx45PDlANn7uaUH7SDuoxk1qrK1Y/VLPKbj4lGCMHLIzLX53/CGkW8ok
         e8tJNwzpJ1sjqU2SGjt3VDmeQivdvokzRPmnByHphuoJ6NEScdmw07zsHJhtKlZUdEip
         5X57GIK43O21d6T0aCyUp1mHHL/SqgaW2/WxbBn71+W1eHxCUnBATKS8fVsfbFcRIf/q
         tqtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=vhO0pCKJDn+GPy8XDXIlFz+R26Mqq8mU3CV7kbvaSik=;
        b=bMX2G/AFZJq0OFjkK8C3ieFkVSFvwLPv6u/G1wJmwMMauTtZVtaFFX1zEej4+4O+m/
         870+NPyQeKhDj8cR8aW5I+mraJ4Oype+685D7sI9zFci3+lC8VzDmdQZshLW3DxRF6Tt
         NxTuEgFCXuLIbWI4UPaDIB6u8s1hMpju1u6KFCii1PiQCCy76UX6+C6IOFLQdy5Mlpiz
         gzFXirCb4EDeLoMSh8SsDg6y0tW0/Zy8vVLNIDpkFTuvbb0qKXQcNa1nniU1nUF3Tko5
         bN/eIDjrRXbBZag4Z1XJ5OARucn3xMKr/ldUB8s/6OgXSCMIigtgTxlyy6QUFe+xFZZl
         jX9g==
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
Subject: [PATCH 4.9 17/67] libata: Apply NOLPM quirk to Crucial MX100 512GB SSDs
Date: Tue, 27 Mar 2018 18:27:09 +0200
Message-Id: <20180327162727.656651511@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162726.702411083@linuxfoundation.org>
References: <20180327162726.702411083@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109050829353966?=
X-GMAIL-MSGID: =?utf-8?q?1596109182227207196?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -4403,6 +4403,11 @@ static const struct ata_blacklist_entry
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
