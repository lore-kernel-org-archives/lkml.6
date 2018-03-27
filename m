Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/MF/S7nXuv0nCFzb3Eh6bcC9xXm4TnQLQXLD6EEzBqsVHEuMGRI1hCcDCabPgphCX2AFEP
ARC-Seal: i=1; a=rsa-sha256; t=1522168276; cv=none;
        d=google.com; s=arc-20160816;
        b=HZDqB+C6Aj9MMsKk1LO1CRWQznCwfB+JSuQDhhEk5pKcYh110nofzodumQDH3yXJhs
         TqyjhORTyHdGY3ShCPjfqj4K9jdr4oxOb1ZG9dXeogpkoNTyAbZppx+a3YynXklrVqSe
         GxaLjguScYryxEAa5JwkAprWbFHomXUrytMqubouzKVGCridoRHh5kDw4q+bfUeWLffh
         wV22m6l1WQQsHKObfo0Z+UPuYM5UklukGu5fo1nczSeetcrh6IxDT9lnOJ89ubLlYKtv
         +9OkaREjwONaIdQaL3PsvGqmz05iiexfgWr5+79PXg4h7zJOjq8AQ8r+3/r48p4lTRJ7
         s94A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=gw8DymwRcI1UmapoRUXaMZ7LL/thYSrrbanhhgQaxw0=;
        b=s1z1F+Kp76pMtFArfhFxfiQWoV9g2sjpUOhbrqdWEoCbCFPMF/d47+BE+3sH8/CqmI
         Nn0aCfGTfSguTCqBT4jTzDjbPfZIpgR92/729eAvA5VMic1nxJCqC1X/m0brjgvCgvSG
         o6Fq2uAjRKtz27b8ruEwrfdjQ+3XGvkSp3BW70ck7enDoXEmxfCdruU61neqf7ZdJxr4
         5QdSOpSCg6KqWSR3J26hlFA7c2emhBReYC0jHGSnv0NiU8BhJcLzVNq2asapAvA5fIXL
         rFxnT5JVpPyWisMEg98nviZnruwFGb9OiqOnIhdtSHUnoSoLDCC10nLWTYalJS48G1V7
         Oyzg==
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
Subject: [PATCH 4.9 22/67] libata: Modify quirks for MX100 to limit NCQ_TRIM quirk to MU01 version
Date: Tue, 27 Mar 2018 18:27:14 +0200
Message-Id: <20180327162728.110013990@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162726.702411083@linuxfoundation.org>
References: <20180327162726.702411083@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596108985800843811?=
X-GMAIL-MSGID: =?utf-8?q?1596109122887035691?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hdegoede@redhat.com>

commit d418ff56b8f2d2b296daafa8da151fe27689b757 upstream.

When commit 9c7be59fc519af ("libata: Apply NOLPM quirk to Crucial MX100
512GB SSDs") was added it inherited the ATA_HORKAGE_NO_NCQ_TRIM quirk
from the existing "Crucial_CT*MX100*" entry, but that entry sets model_rev
to "MU01", where as the entry adding the NOLPM quirk sets it to NULL.

This means that after this commit we no apply the NO_NCQ_TRIM quirk to
all "Crucial_CT512MX100*" SSDs even if they have the fixed "MU02"
firmware. This commit splits the "Crucial_CT512MX100*" quirk into 2
quirks, one for the "MU01" firmware and one for all other firmware
versions, so that we once again only apply the NO_NCQ_TRIM quirk to the
"MU01" firmware version.

Fixes: 9c7be59fc519af ("libata: Apply NOLPM quirk to ... MX100 512GB SSDs")
Cc: stable@vger.kernel.org
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/ata/libata-core.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4406,10 +4406,13 @@ static const struct ata_blacklist_entry
 	/* Crucial BX100 SSD 500GB has broken LPM support */
 	{ "CT500BX100SSD1",		NULL,	ATA_HORKAGE_NOLPM },
 
-	/* The 512GB version of the MX100 has both queued TRIM and LPM issues */
-	{ "Crucial_CT512MX100*",	NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
+	/* 512GB MX100 with MU01 firmware has both queued TRIM and LPM issues */
+	{ "Crucial_CT512MX100*",	"MU01",	ATA_HORKAGE_NO_NCQ_TRIM |
 						ATA_HORKAGE_ZERO_AFTER_TRIM |
 						ATA_HORKAGE_NOLPM, },
+	/* 512GB MX100 with newer firmware has only LPM issues */
+	{ "Crucial_CT512MX100*",	NULL,	ATA_HORKAGE_ZERO_AFTER_TRIM |
+						ATA_HORKAGE_NOLPM, },
 
 	/* 480GB+ M500 SSDs have both queued TRIM and LPM issues */
 	{ "Crucial_CT480M500*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
