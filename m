Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/8ndTqYj14jmro0eovXpMnI2WExnIRCZXoKv/kiNZDWW3pkJiLQ2dvFaFZ8bGOS5IZaszW
ARC-Seal: i=1; a=rsa-sha256; t=1522168877; cv=none;
        d=google.com; s=arc-20160816;
        b=snxleInRlCFnq2uWs/r+KrJaC6+LZmVccNEagJsI93YScb1te58oSN63OVS4d2ygdl
         XEyAJ3kfL6G4mQQZPdAQPZTAH/H7yk/w3/Xdp8892qd1a91rEzqBa8BJCbRduBdYj70H
         IkajKijws5iwmdY13y7tOsZrPU2cCFJC7xVU7w+giqxDXv8yoTpA7zTyJKp3Fcr8rYgT
         jrdOEGx7M6o6BK1hbA04ZKHZkqXZBrU0Cbg/zI9GV6j8shvmqy+hr9eWgY0HeHblkuVd
         VJnktY++XtR0q+eWgf0vcGVUDxqykVoEb138xjnlj1Ra87o4m845j/qOmopvBboPLyc+
         SmHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=KXtbgBoSQgogbGvDncABzTiRq9kD1LGMdKQmrTvKvSs=;
        b=r93IGnfYLHbCEw9Nh6P4F4qlBzfIsQ34JNyUb8kuDzgHLZQG/+FHvl4UO91P2cq4vL
         3VAVIGxctVpa15IZhvXkDY+KZhET64kzPzDed/JFM8/2MvUG/Ui3FfbGoPC+1DseytLn
         u+gz4MuFbhyw8qWtsWmAy2phZDyoX7ttx642dshmSBJBJOaahG/ySKez0XsZF/n76wOG
         HAJklzX1pahnxORso699rQIVpAEQCNGkO58qORvWFq9IK0/n+AdlRU1BZZsDRJO+0XVV
         8t9KCzyt6agdvRzObW08xLmkfzM7czDrVes/lXypfGKSw+rwVVJlfG7nZsi00diHei3s
         xv3g==
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
Subject: [PATCH 4.15 037/105] libata: Apply NOLPM quirk to Crucial MX100 512GB SSDs
Date: Tue, 27 Mar 2018 18:27:17 +0200
Message-Id: <20180327162759.595067510@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162757.813009222@linuxfoundation.org>
References: <20180327162757.813009222@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109050829353966?=
X-GMAIL-MSGID: =?utf-8?q?1596109753404642454?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -4530,6 +4530,11 @@ static const struct ata_blacklist_entry
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
