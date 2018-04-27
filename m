Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZprGK2ggsxJv+EiTuDq8dIc7S1r0Xp2/JuXYWPD350aKfw6kbMYw6HqXBo8JbCDbiFELLH2
ARC-Seal: i=1; a=rsa-sha256; t=1524837798; cv=none;
        d=google.com; s=arc-20160816;
        b=FOi0v8oRDv9iLPVcRwLyS2Q+kEDVy27UVKq/XclGWkmAb499t3FwV8Gvh7EuXXDhj0
         LPZUKrHmOZ7Dm+SqA/9+tY6sUcKZGrOs7E3tQy/dh4rW0WqVJ86cZqh18jlOCj0zi4IB
         anivjBvRZBNjbWOWg8TQbfYZPPC6iJF/ByWUrSNdKXhpVpAerHK7V6J7Kwz/HeMhcqR2
         qd8fGJK3obYYvVv7XhjI7F7BukfptOcFSumVE2LoH3FMglWNRzutafWINLsAAWS0TztK
         5J19eSXAXOQ4CDrlOY56lFSu9tN+2XTv16wwENvgyoOkSi9VwkmVIq2SdDcdYNwgaHm4
         b/Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=XNrt0cgQ56ZMZ6C6CjGZpMcfonGH+ynh1UxL4rrXxgs=;
        b=ihrtIc0y6JUBOx06vxFai0iaEO9Jr1rDOowh37NptznXoF76zC8QIFD0/SwEJBP+2v
         KpHvC7e3FEJfPr0bEv6/wh06zDLHLDiDqOmrcYJ8Fq4Dl3TaDwYfI0FQtQyJYJUJVg+Q
         BaFWNA2ktMPMo8+lmaUn1gT5bJONSAFrbTChNac6iybBHPxQyvTcU8K0xtAM5DlVJ+ZM
         kvhvaoAGsshLoyYTxC9qJJNwuaReFchYVswpS6kfstX0aF70r5YylJ71VbpW2Bpahe9z
         hPgDR5CA7VHNdZmbvZwxOnubCVA5s8WFvFOMJ9CTBhZ+skV+ZBjHrRzzawbPdbufCPg4
         7I5w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA5AE218A0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Colin Ian King <colin.king@canonical.com>,
	=?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>,
	Sebastian Reichel <sre@kernel.org>,
	Amit Pundir <amit.pundir@linaro.org>
Subject: [PATCH 4.9 13/74] power: supply: bq2415x: check for NULL acpi_id to avoid null pointer dereference
Date: Fri, 27 Apr 2018 15:58:03 +0200
Message-Id: <20180427135710.445685323@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135709.899303463@linuxfoundation.org>
References: <20180427135709.899303463@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908319639239239?=
X-GMAIL-MSGID: =?utf-8?q?1598908319639239239?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Colin Ian King <colin.king@canonical.com>

commit a1b94355ea3fde5e13db7ff37c0272fcde4e29b2 upstream.

acpi_match_device can potentially return NULL, so it is prudent to
check if acpi_id is null before it is dereferenced.  Add a check
and an error message to indicate the failure.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Reviewed-by: Pali Rohár <pali.rohar@gmail.com>
Signed-off-by: Sebastian Reichel <sre@kernel.org>
Cc: Amit Pundir <amit.pundir@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/power/supply/bq2415x_charger.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/power/supply/bq2415x_charger.c
+++ b/drivers/power/supply/bq2415x_charger.c
@@ -1569,6 +1569,11 @@ static int bq2415x_probe(struct i2c_clie
 		acpi_id =
 			acpi_match_device(client->dev.driver->acpi_match_table,
 					  &client->dev);
+		if (!acpi_id) {
+			dev_err(&client->dev, "failed to match device name\n");
+			ret = -ENODEV;
+			goto error_1;
+		}
 		name = kasprintf(GFP_KERNEL, "%s-%d", acpi_id->id, num);
 	}
 	if (!name) {
