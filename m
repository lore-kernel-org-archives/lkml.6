Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZoWQCss4PA8Vsiw275amUjWtFUgj1M76MUKIkYAvByFpg2rRu9rL8QkMPL9meF7VujEb7Jd
ARC-Seal: i=1; a=rsa-sha256; t=1526281130; cv=none;
        d=google.com; s=arc-20160816;
        b=V8PPS7wR6LKHuMulJqGdRoe4w3vW75DevEtKXqryCDwuMuGtncLVlJaOZ0cHLezIs5
         fOmLpQpd39IM75nvxUCpWkjCr1SLJURQfOy6XJLnYDD6xTNuc03qKUq17FQKuA2fBwLN
         JIm1LPr2G9a3Ml2gk5dRdGOkxgyv3jSiK6w6g2JRMKfGFJ9AjUEU1DVuRTXzz22SOwBj
         SvAnuoYVR82Jfw8uGpy7V9AO2XgZ35jVBd+4M04dfjtwSG175FmWgY+6Z4/U0KjyEDAX
         jjh5zd4yMzX2I/DlYonGPlpxrNFYlrakNi/k9Wz+v4pbWHiEm7DZdKcY7kM2yMF+QO87
         7rYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=gt+uI2yTzW1OqzbmdHbQXsYsxnEaWWeem5jtx+IvpFc=;
        b=zFBxfPasKX8dABjs0SA/fGACpepqzhy2Ki3BZpCzHheupdjUsPdaqeFTZBmcN/bXEi
         VL6MfsvMaV2TKBkBoqWjw3May4nWBpK9bKpmePQUgNchGUH0C/tWw0yFaQ9c3kuElK1/
         /H5lUCdbreYp7ae6Ro4oz59ucY0AdYoglCg/VWTtqpwdCyKBB+T13t+oVCPydWHhCE7T
         E1ua/G0BZcM9v9Lnt9fFANINFPx4gGHqIN2DKw2ontHFymH/GJKRFG4npHwQqc3Qot3W
         jycqTJv3bi6bTySNu2iM7IeHK36Z/i3eo1mQ5C9pmzM0QIRQxgyAkFrF1cK1JUdVpdcY
         xOwA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=LVeWmUqq;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=LVeWmUqq;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	"Richard W.M. Jones" <rjones@redhat.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 4.16 28/72] libata: Apply NOLPM quirk for SanDisk SD7UB3Q*G1001 SSDs
Date: Mon, 14 May 2018 08:48:45 +0200
Message-Id: <20180514064824.248043941@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064823.033169170@linuxfoundation.org>
References: <20180514064823.033169170@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421262061858656?=
X-GMAIL-MSGID: =?utf-8?q?1600421763135003626?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
@@ -4549,6 +4549,9 @@ static const struct ata_blacklist_entry
 						ATA_HORKAGE_ZERO_AFTER_TRIM |
 						ATA_HORKAGE_NOLPM, },
 
+	/* Sandisk devices which are known to not handle LPM well */
+	{ "SanDisk SD7UB3Q*G1001",	NULL,	ATA_HORKAGE_NOLPM, },
+
 	/* devices that don't properly handle queued TRIM commands */
 	{ "Micron_M500_*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
 						ATA_HORKAGE_ZERO_AFTER_TRIM, },
