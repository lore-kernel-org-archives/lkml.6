Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx495xDHNqw4icfAoDYA2wx3FL4HYRaKMaOMgKWPQ3sINpRJ1NB/VQbA+Vf57x1jZTqssEwOw
ARC-Seal: i=1; a=rsa-sha256; t=1522168343; cv=none;
        d=google.com; s=arc-20160816;
        b=yOQ7tWLuJDpIfwwFZLVacudzih9A3IZLeK6Zc/fn5RhQdSuO2n7hMOmeZJkEEF8HIG
         +E3XqTU20k4+nrI0z9fZULpuVOClEJx/5WhnucndiFrfjAaFigXOqg1biibWblVX/Y8B
         c8VAj9tkXnoderCjeAMXfG5SUxE91erfAFRqBnYo8/xlw/GbsEU5bm8GpifqiuRC1qEM
         1yOLp+F4kC4+3Gd4VS37OrLaZodLIvaBxQJAHTmfgVJkQkBpYTUkHKt1bieQRH4qeIgl
         KJNwjdI51KU62dFAmxS/e/9SHWvU7PEA821KTTmqkKfMsa3P5j3Aofc8RKm//DsTp8ng
         33GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=CvNfIiGkF3I4wkbiMNJaK1YEKKidTw5SCMN/GKbilX0=;
        b=vSrZUZrcP6SNczBKlSIcuG8b6NshO6Xg+IOk0cFbauhu1BdQEsj+5/xaaJp1VILMl2
         mWNLyAG4VZEnv1dxyrWhxW/ginULKVUHFC9aDJNZt31bPcaPjhXc0lbp04Os6bOv5bLN
         OnAdLzieHuSypcZm8RqtDwLNqGYPPLk8gXLOMYq8GTf8xOWThqiJAwcMeAp0U9n2L+v8
         4eJhBG5FKzRBTI7h9yOK2eD8XKlOyvM2vIbel8ixTHmIwhwjr2JllTQWLvbE/wyk/2Aj
         uZiV2CQgpr9Teirs76HGQ5E8eq6AC9IqPRkKb2misKCpvX8jQ+O2VrMTrwjbf1dFaHch
         cU+g==
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
Subject: [PATCH 4.9 21/67] libata: Make Crucial BX100 500GB LPM quirk apply to all firmware versions
Date: Tue, 27 Mar 2018 18:27:13 +0200
Message-Id: <20180327162728.067105133@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162726.702411083@linuxfoundation.org>
References: <20180327162726.702411083@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596108983149684542?=
X-GMAIL-MSGID: =?utf-8?q?1596109193326936727?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -4404,7 +4404,7 @@ static const struct ata_blacklist_entry
 	{ "PIONEER DVD-RW  DVR-216D",	NULL,	ATA_HORKAGE_NOSETXFER },
 
 	/* Crucial BX100 SSD 500GB has broken LPM support */
-	{ "CT500BX100SSD1",		"MU02",	ATA_HORKAGE_NOLPM },
+	{ "CT500BX100SSD1",		NULL,	ATA_HORKAGE_NOLPM },
 
 	/* The 512GB version of the MX100 has both queued TRIM and LPM issues */
 	{ "Crucial_CT512MX100*",	NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
