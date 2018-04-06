Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/MJZ/ul4FYBMTLyERABIS1lO1aYSCj/8mv5JnqYEpfIzXkFfPgjUS4AQkhHoc73BEEwTVl
ARC-Seal: i=1; a=rsa-sha256; t=1523021132; cv=none;
        d=google.com; s=arc-20160816;
        b=SfDIFMx+2tId4yFY3eAWgaGV9iRBX3iHVrGqnsVegCAAanM7ZUkn3yI9lrJ1+POTNb
         UfhRWRGbkro9IwE9kH1RZ6DfH+ep7g+IlwjfzXgxcMqImUpR98xNhfyEZxdb7VaZHqPq
         EyL2ufoFD7LovYJlJmohg75NhuECUFRbIdDWkZ7BFm+RiP3GNStUbhY32d0JuqwRAOxy
         RXqqdVgF2pw3m/avv4wDkUCh4DYTeFsnNhnRH4JOIs1kIQ/3djgWT7VwSVSdgrG0of2H
         OIb7Ian9KQ9vF6pk6+75PsfNvK5gxoklL1/zmpci++o9DXJgaIa1Wn+H/QHgoPZfcU2O
         e4cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=5MMQlE7I51XP+8DF/2TvAx5VspOQ2Jr2uVtLXKhT08I=;
        b=S1kbjgpE7EGEwNUz+d+PYay73O2J9YVQP/KYSmxUYGP/2INNCyayJ31rLseo3FjTCl
         OXsdC2prSYoLl8o6PwWUvYqOb6yOEokXGH1GbhcPclCxEw/LRoKlPTze6LBV3us0yuay
         p31Q8CKuSeBC0uvwEo4ouW9fGvpab2pB3tOO/CmriwXbWoE5IbX12l0A3MaxegY8WYjB
         allof78p9wyY8OMf8oyU0EqOpVPEP8xeQGqKTbUOmhSuKT7hCkzk9kBkywEraezZEhlA
         HOa9qkJrqk6Enk1myPhgMqzBCiqgl5xk+uykF4DjVGEeu4cLMR4JrrS+lToSHU8wbjCF
         YDLg==
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
Subject: [PATCH 3.18 09/93] libata: Apply NOLPM quirk to Crucial M500 480 and 960GB SSDs
Date: Fri,  6 Apr 2018 15:22:38 +0200
Message-Id: <20180406084225.379874153@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084224.918716300@linuxfoundation.org>
References: <20180406084224.918716300@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003406747217001?=
X-GMAIL-MSGID: =?utf-8?q?1597003406747217001?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hdegoede@redhat.com>

commit 62ac3f7305470e3f52f159de448bc1a771717e88 upstream.

There have been reports of the Crucial M500 480GB model not working
with LPM set to min_power / med_power_with_dipm level.

It has not been tested with medium_power, but that typically has no
measurable power-savings.

Note the reporters Crucial_CT480M500SSD3 has a firmware version of MU03
and there is a MU05 update available, but that update does not mention any
LPM fixes in its changelog, so the quirk matches all firmware versions.

In my experience the LPM problems with (older) Crucial SSDs seem to be
limited to higher capacity versions of the SSDs (different firmware?),
so this commit adds a NOLPM quirk for the 480 and 960GB versions of the
M500, to avoid LPM causing issues with these SSDs.

Cc: stable@vger.kernel.org
Reported-and-tested-by: Martin Steigerwald <martin@lichtvoll.de>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/ata/libata-core.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4233,6 +4233,14 @@ static const struct ata_blacklist_entry
 						ATA_HORKAGE_ZERO_AFTER_TRIM |
 						ATA_HORKAGE_NOLPM, },
 
+	/* 480GB+ M500 SSDs have both queued TRIM and LPM issues */
+	{ "Crucial_CT480M500*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
+						ATA_HORKAGE_ZERO_AFTER_TRIM |
+						ATA_HORKAGE_NOLPM, },
+	{ "Crucial_CT960M500*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
+						ATA_HORKAGE_ZERO_AFTER_TRIM |
+						ATA_HORKAGE_NOLPM, },
+
 	/* devices that don't properly handle queued TRIM commands */
 	{ "Micron_M500_*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
 						ATA_HORKAGE_ZERO_AFTER_TRIM, },
