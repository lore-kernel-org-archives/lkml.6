Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx482sWbX8mwQjieFpzH0pwLti18fmEQvTmBI+UYQHa68TKeAOLht7yzkCJPxX2zgpZKIIiBL
ARC-Seal: i=1; a=rsa-sha256; t=1522168210; cv=none;
        d=google.com; s=arc-20160816;
        b=Zobp1rWTE+T0ROKv8FMPjU95Illx5YUvhtJRX6mINzDCr3FMau357rcvp4J/lPq++b
         WwVPHiz06iuCA2LUX9dZ3z7oUPc3wgsnVyLFDpx6bPrQ/vkygOT89ZBZQHpcSQ82Mp7Q
         VdJ6J78bhZN5OGvS+fWJbB/uf/I7hiIWDU4mAxblXDL/2xjw1TWa6uFqeZORqqc/yA8G
         yEvb5P4dI0zUp93XNTfL07fKneRxHVuj5VCjOeXcBSF9huu2vfKNsO6e27rwSFeRWhdC
         yCVpt+G55v5BrFluBP/eJqsTmM1Mo5IeSMxoAAE/YukO55fY15/GgIgXIh0RhUfzfwtm
         tdgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=yo0SEJspl2lq77m0OoM73MRgZpJBZ/l/Zj6mvCEYR24=;
        b=pKGccQGI/PeVax6aTngiD+4ozm2KUb7tmT3F0J4+w68W0OewMXlQiVXhwYqv12bsAZ
         9gkLPrS3FGRpE4vHjpm5GudH38O78etowZcHu7Wl3Boj7ofE8101jIlABWz7sM+lXUNS
         cH8e1+mcuaZgOI6IGd3TmMpEC+RD8P04EBkoOsQ0AQ4to8qNFfnG3rQLdUeUtlVENhBN
         8Pq6JkwhaJmuYCG/gRsQS/wszgmM+6kV6zYStARVfsptAgt5O2W/9mqx6max17YhkRil
         bOv453hZG0JDUaR//BfpJOvNsyktLaZW26z4aExaJZYHFrabxZR0qBptMatejTMU5VjI
         c1Tw==
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
Subject: [PATCH 4.4 15/43] libata: disable LPM for Crucial BX100 SSD 500GB drive
Date: Tue, 27 Mar 2018 18:27:19 +0200
Message-Id: <20180327162717.308286731@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162716.407986916@linuxfoundation.org>
References: <20180327162716.407986916@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109053741544875?=
X-GMAIL-MSGID: =?utf-8?q?1596109053741544875?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -4224,6 +4224,9 @@ static const struct ata_blacklist_entry
 	{ "PIONEER DVD-RW  DVR-212D",	NULL,	ATA_HORKAGE_NOSETXFER },
 	{ "PIONEER DVD-RW  DVR-216D",	NULL,	ATA_HORKAGE_NOSETXFER },
 
+	/* Crucial BX100 SSD 500GB has broken LPM support */
+	{ "CT500BX100SSD1",		"MU02",	ATA_HORKAGE_NOLPM },
+
 	/* The 512GB version of the MX100 has both queued TRIM and LPM issues */
 	{ "Crucial_CT512MX100*",	NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
 						ATA_HORKAGE_ZERO_AFTER_TRIM |
