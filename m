Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49g29cHUGFw7+GU4YEIfqAlUtmITZMbGyE3Ny2/fw5b2gwfLfND0Q05cmdG8R0tZ455C8j+
ARC-Seal: i=1; a=rsa-sha256; t=1523021107; cv=none;
        d=google.com; s=arc-20160816;
        b=jEj6sUehnUC6W5GvSZ3p34hBKF2zUnU30VwzNJv+BAOdjGDBylY4iSYwh9Gn1EVSLX
         jJw5hjDai5rcFW1438tNLSenmjx3+XI38QjzHMO5irXjjVZhtRLYb3ET3AgOtxpgA+oL
         hgj1WFVFd9llNQ8jSYAkA46NagyUwjLIKd3JiMBYLzCP1byo9lTzHXvGU098GXiANqcf
         b/2CbzTuJo/4XxSMOUCgkpa5NFOPW/WMCflmdImCRSu+DZHAozep/04/FyZqSxJCIjx6
         cVfaNBjHzao1JkStSifYxDJyYgFCyoIrNcVcCdQrDm9I/s9PV+sieDXIRaxh3sTAEInc
         cJwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=aABffA5D/OhxyzH1DewifJUpJZEIN0Cyc1lLHbB2MpM=;
        b=PQo7+jKSR4dghtnGW5zIeOSttLOyV2m2xwSr/OhlXoMIKiaaxfrn9wUyHD+QJzEt93
         zszR7GbeTlY4JjlxtEv/lzqj/t6Y8NJ85eJLIiTCbyypB+/2ePYKW6geDCp2TRIM8MvC
         2jRGcHpZt0TZuu/Ot2Gjp0D8I60u9cv4f45RNlPjMiS7+drbOnrSM2ZphbQzd6VPTCFX
         cIPu3xu2SO41qyxMJWihowfM56rIeMN51AaHw7yBFqNyZ2lL94ScwGVCgvTojWU9YaIh
         Qk2lQ2HYHAhlPcz65vEuSIV4sVVLCYztFbIE5rhdVRGkKsJt922/g0a3H9JUBlkk/Skj
         Rayw==
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
Subject: [PATCH 3.18 10/93] libata: Make Crucial BX100 500GB LPM quirk apply to all firmware versions
Date: Fri,  6 Apr 2018 15:22:39 +0200
Message-Id: <20180406084225.417170305@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084224.918716300@linuxfoundation.org>
References: <20180406084224.918716300@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003380261822311?=
X-GMAIL-MSGID: =?utf-8?q?1597003380261822311?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -4226,7 +4226,7 @@ static const struct ata_blacklist_entry
 	{ "PIONEER DVD-RW  DVR-216D",	NULL,	ATA_HORKAGE_NOSETXFER },
 
 	/* Crucial BX100 SSD 500GB has broken LPM support */
-	{ "CT500BX100SSD1",		"MU02",	ATA_HORKAGE_NOLPM },
+	{ "CT500BX100SSD1",		NULL,	ATA_HORKAGE_NOLPM },
 
 	/* The 512GB version of the MX100 has both queued TRIM and LPM issues */
 	{ "Crucial_CT512MX100*",	NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
