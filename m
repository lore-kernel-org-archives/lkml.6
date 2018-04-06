Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48YZsdpijkAx2oPhXVjHrHW6IMhDkDiC6CNKbE4PizKS1ZzT19KDUWWzIzbinL9fCyTorWG
ARC-Seal: i=1; a=rsa-sha256; t=1523021126; cv=none;
        d=google.com; s=arc-20160816;
        b=GOEwRP+g6S1k6Q/1yCOCR4QY3fJ/J4D4uaIWZ2KCPP/e11Cy046A2FQI7nElk76CET
         /u1AdsFXCTakk5UH02ANiaxOdRZQ27Do//5Sksu4jK6pfbTypw52quyYJ0oPqmgCHKVw
         GRWyHprtXAlLTZfPmMm0xPurW17OsLuLs27BwtEjc53cegYxcC6bdKwPgOU3VZ+TvPkR
         f5BQp6t3uz1tfvWJK6Kz0aWYFSxeTfqolpym/F/XvBaa6w2So91kYs7wx9DeCUjirYD+
         Rrm0x8HBWpYjhLcvUyya8qLTwWaSWrGoW6GJQEBSLMtS+KVg2Fcpoo0qKZgiVUo6SOIX
         fBxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=0tlfDAuZwec4KyzPBbkX70m/ebe1Zyp89k/HJl1IFeU=;
        b=Cob3baEdG5IkCvYFitmhf4IOCsNOMH08Wa1ROGA2qXJsffml/h4a95vUml/PGsSoXm
         AHXuk+dnHmxW+LFyibKKBvIrNLsP3y0dIWkX7wUbuQ8x6T5WhBelX0hAKhM/9FBgLOfC
         7ruSIIYGBUijzvxI/0FI0hgZSWaYEGGqED4EBZfxq9Ccx7HJpJrExGQUHmXqsl7fsw5X
         PrMaP0hUNJ42iVTSgE6ze8/Tuz83tV0kZ/O9zuUcayBeAGkzoTp+UG+ykUY8lqIHKsxg
         qxHRFc0y/JnRidQfNru5LYSqQ89DRAoV4YF55mrHYFPmgDhb7OUcwiBRYhhjGGN6qezC
         ensA==
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
Subject: [PATCH 3.18 07/93] libata: disable LPM for Crucial BX100 SSD 500GB drive
Date: Fri,  6 Apr 2018 15:22:36 +0200
Message-Id: <20180406084225.300910940@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084224.918716300@linuxfoundation.org>
References: <20180406084224.918716300@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003400405899639?=
X-GMAIL-MSGID: =?utf-8?q?1597003400405899639?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -4225,6 +4225,9 @@ static const struct ata_blacklist_entry
 	{ "PIONEER DVD-RW  DVR-212D",	NULL,	ATA_HORKAGE_NOSETXFER },
 	{ "PIONEER DVD-RW  DVR-216D",	NULL,	ATA_HORKAGE_NOSETXFER },
 
+	/* Crucial BX100 SSD 500GB has broken LPM support */
+	{ "CT500BX100SSD1",		"MU02",	ATA_HORKAGE_NOLPM },
+
 	/* The 512GB version of the MX100 has both queued TRIM and LPM issues */
 	{ "Crucial_CT512MX100*",	NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
 						ATA_HORKAGE_ZERO_AFTER_TRIM |
