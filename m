Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZoZ9OcA5Ph1wTjSgPffZtdSPruhB+kEJ6dRaHEeERd6SXvAZDFxdkWV5Y6MMHmUUalglvp+
ARC-Seal: i=1; a=rsa-sha256; t=1526280902; cv=none;
        d=google.com; s=arc-20160816;
        b=DonO2TvHAtskUi6tSHLKWJX6i62Tl10L8d0W1xVzBHaK6D6EJuwor7M2DT6MM41Ltf
         Ug7yrRtnhuIo8509EYhc3H5grMdZHI83ugPMCjG2OQnVo3CHj+kZJkWzyAUix0eOuNcU
         7rZ0D/6d9h8siKUzyv4HzwRk6ZvF5UXzWgFj7qNTZXPFMji7tbvXMvvlMCS4Oxhvr55C
         w7EnTtPdZTMwq1xlrnsWkwC5hSiCaO5SUIvquNKAtnBdnqSAUwHo475o3FbHeyU8LKeu
         APCnKrp/+lu3E2PuhY2fUxPtq9N8DwnfxA6HCmSZ9GdYww4jBCgjvuguKuU7ozQnrhG7
         mLUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=+rrBWuLA1DfvJkuMrKygUQbLRLXYy319ekb0t0xcpTc=;
        b=K+k1ZgC3f1IazbYKjk0KA8ox4TY9sAPrvkrC/M78oTuihRGxFl4FLe04jZlsgh6yua
         AECTEEphgDCppf+PTNugRJaXdcPu5P4shaGMJELGRQGreeNyikyqwxbD+ue6GHYLRo4o
         BC/zs8FXFmMe8fOoNogmYDLlrPbD9qwLNgErf894bntmjA4/k+hp4BvWSBHqQHPPlNGx
         l6DZDUPcSRlaaVjCKhqUvnt4cf4veIKGwEsrSfawdAc5Ru+721jKD7Q66fx5MbyrI8bv
         ae0cQY7B5Png1LYWVRAee6YZtjowtFHG4jruxjLdPeU3yl9olbnwny/YW5kD/P5DoNW2
         TR8Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=yL3b2/S9;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=yL3b2/S9;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	"Richard W.M. Jones" <rjones@redhat.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 4.9 21/36] libata: Apply NOLPM quirk for SanDisk SD7UB3Q*G1001 SSDs
Date: Mon, 14 May 2018 08:48:55 +0200
Message-Id: <20180514064805.921745797@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064804.252823817@linuxfoundation.org>
References: <20180514064804.252823817@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421262061858656?=
X-GMAIL-MSGID: =?utf-8?q?1600421523995257819?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hdegoede@redhat.com>

commit 184add2ca23ce5edcac0ab9c3b9be13f91e7b567 upstream.

Richard Jones has reported that using med_power_with_dipm on a T450s
with a Sandisk SD7UB3Q256G1001 SSD (firmware version X2180501) is
causing the machine to hang.

Switching the LPM to max_performance fixes this, so it seems that
this Sandisk SSD does not handle LPM well.

Note in the past there have been bug-reports about the following
Sandisk models not working with min_power, so we may need to extend
the quirk list in the future: name - firmware
Sandisk SD6SB2M512G1022I   - X210400
Sandisk SD6PP4M-256G-1006  - A200906

Cc: stable@vger.kernel.org
Cc: Richard W.M. Jones <rjones@redhat.com>
Reported-and-tested-by: Richard W.M. Jones <rjones@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/ata/libata-core.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4422,6 +4422,9 @@ static const struct ata_blacklist_entry
 						ATA_HORKAGE_ZERO_AFTER_TRIM |
 						ATA_HORKAGE_NOLPM, },
 
+	/* Sandisk devices which are known to not handle LPM well */
+	{ "SanDisk SD7UB3Q*G1001",	NULL,	ATA_HORKAGE_NOLPM, },
+
 	/* devices that don't properly handle queued TRIM commands */
 	{ "Micron_M500_*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
 						ATA_HORKAGE_ZERO_AFTER_TRIM, },
