Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48CXHPRm0jmqyLvkWHNl8do2gISRYGQTSdu6MYnDoCcqtDL3kFiXyrqgSHzKsNMfbttZ9mS
ARC-Seal: i=1; a=rsa-sha256; t=1522168910; cv=none;
        d=google.com; s=arc-20160816;
        b=NtNk1X66yljXRKN7GvlQYLBc+RzfSP6D17xqXyL+oTdwyQM+p9bQbovue1XNkYuI5c
         Oz7YXHyGhaVHoy7UZyRxbk5aWZHju08TlCjHZHsZY+aI3WQpv2TVRs2cHXPB5/Gz2g4J
         nlIvZyye/seA7nltCkSjWYGJRk91YLGNXCmVoWB3769idVXps75QB2XOD2AqF6EnoENe
         3hTwsRIpK7WF8drwrv+TTzPfEBN2q0NngRuGoRBUBrmMkxW1u05pR2ropwG1AKq74Eb9
         jwTxzGXpMQ5xHtuATZaxeXkiGk4NTjCqC+OUCZ5SPSBbLV9kSopKfsTiFlnQ6kxnW1tq
         OEMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=QnvwEf6vZtbdLCZskPQ7XwNcV2K+8N7Gazxg/mh6cjM=;
        b=f+YJn6f2nLXTxFoHeFPxitmwfZd4mBB7ZgUYF1i/amgNWlpVaUD1WLjMwrkVu/kCob
         oE1fYf1IMSI4fRymYog01o/XpY6DdmKxCLKDaePey545Cq6qb/L9cBB0JDKhmLEsyN0m
         GsLJ0OshgVSaWkTpJAkWdcIQUODChX6YMAPET78hNL/BZeHFi0r3Qbcc5J/9+850y4hl
         Olw4ucLW8P5Lo7bUJAoURzn6Vz6ydnAs1k8aDHsLOTFEAGEpGHqCQ5lyTnan92M2CjZz
         1dWHyKMUd0t3vxgjr011CjEXZE18IAG2Rb3wGPIOSoOZJHjmgecigiwf2/lL3ROX0t7X
         5YAw==
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
Subject: [PATCH 4.15 041/105] libata: Make Crucial BX100 500GB LPM quirk apply to all firmware versions
Date: Tue, 27 Mar 2018 18:27:21 +0200
Message-Id: <20180327162759.788597655@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162757.813009222@linuxfoundation.org>
References: <20180327162757.813009222@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596108983149684542?=
X-GMAIL-MSGID: =?utf-8?q?1596109787740248771?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -4531,7 +4531,7 @@ static const struct ata_blacklist_entry
 	{ "PIONEER DVD-RW  DVR-216D",	NULL,	ATA_HORKAGE_NOSETXFER },
 
 	/* Crucial BX100 SSD 500GB has broken LPM support */
-	{ "CT500BX100SSD1",		"MU02",	ATA_HORKAGE_NOLPM },
+	{ "CT500BX100SSD1",		NULL,	ATA_HORKAGE_NOLPM },
 
 	/* The 512GB version of the MX100 has both queued TRIM and LPM issues */
 	{ "Crucial_CT512MX100*",	NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
