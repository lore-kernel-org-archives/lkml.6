Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvnnAa1uMkBdZAPaaTu6hBBnRzjihzdkczW5mEpRuVh7yNuWvnmITG6/R5PISwcoLWJynzF
ARC-Seal: i=1; a=rsa-sha256; t=1521800164; cv=none;
        d=google.com; s=arc-20160816;
        b=k+r0JzKbEkmHr4hfyoP/3qvkryED7tDgV9CBTT7/LpCjB/peY83oZjQ1lHMG9S7rjm
         2QlWSbqIV0QwP4Oz3RjMIzOmZPtZW9er6dNj13/4cjUyEP6GjomhDBjqptUWIR+ZFpoi
         NI8B/UcSnWoYtxJi5l//D3Y3TvCBvW52osClR1IWvjpVbevtqwZWzOmHcsxWJhcnN9Oz
         NALu3x+LyISUjdPlujJWFBAPP2wzkt2441IboyHD5FfrRijT2AX1z3b/2sKwHVlGd69Y
         8lWxhSdVh6DwRwp1BeXBxIimaOk9wQ113rVOA5qCKhYlGnP84o024WPaKBN/7KS2oYgp
         k3aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=M2LX1T6DhVmd0ULCsSAPDA6u93AT2f8i9XBJfNTa3vg=;
        b=CzcWvRbNY1ETt3yobPSjp9kcS9wR2CTd7uTg1M23yYkx+lc/gpAmOo26jabsOVJ1/q
         9JtK9OyvpEAnNgnQnB3FRBEm1XgcKNwv9U0uJDeRIzwtJT6cOT1CCixtNRabeDEyE7fl
         4bbvdK9AP3hUROzhZ1Qa/Rr/W/esmpXNcWiUSkrzuRKXSmUBLRYkDNPRCTDcfj8EKtIw
         iiwexh0HIjlSKhnmr9V/Bk8AS6XkY6bYPmHZHQjJVqeBablbnEP+Yow1AaNwTJcTxOyu
         hPpxH+pOcpQY3uS7B0BTImseEcuK/mFqSGgFLItAfi513N4B/BStA6m0NLpLJKzA4ZD3
         w8dQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Hans de Goede <hdegoede@redhat.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 58/97] ACPI / PMIC: xpower: Fix power_table addresses
Date: Fri, 23 Mar 2018 10:54:45 +0100
Message-Id: <20180323094200.892454673@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094157.535925724@linuxfoundation.org>
References: <20180323094157.535925724@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595722656164389359?=
X-GMAIL-MSGID: =?utf-8?q?1595723128948741935?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hdegoede@redhat.com>


[ Upstream commit 2bde7c32b1db162692f05c6be066b5bcd3d9fdbe ]

The power table addresses should be contiguous, but there was a hole
where 0x34 was missing. On most devices this is not a problem as
addresses above 0x34 are used for the BUC# convertors which are not
used in the DSDTs I've access to but after the BUC# convertors
there is a field named GPI1 in the DSTDs, which does get used in some
cases and ended up turning BUC6 on and off due to the wrong addresses,
resulting in turning the entire device off (or causing it to reboot).

Removing the hole in the addresses fixes this, fixing one of my
Bay Trail tablets turning off while booting the mainline kernel.

While at it add comments with the field names used in the DSDTs to
make it easier to compare the register and bits used at each address
with the datasheet.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/acpi/pmic/intel_pmic_xpower.c |   50 +++++++++++++++++-----------------
 1 file changed, 25 insertions(+), 25 deletions(-)

--- a/drivers/acpi/pmic/intel_pmic_xpower.c
+++ b/drivers/acpi/pmic/intel_pmic_xpower.c
@@ -28,97 +28,97 @@ static struct pmic_table power_table[] =
 		.address = 0x00,
 		.reg = 0x13,
 		.bit = 0x05,
-	},
+	}, /* ALD1 */
 	{
 		.address = 0x04,
 		.reg = 0x13,
 		.bit = 0x06,
-	},
+	}, /* ALD2 */
 	{
 		.address = 0x08,
 		.reg = 0x13,
 		.bit = 0x07,
-	},
+	}, /* ALD3 */
 	{
 		.address = 0x0c,
 		.reg = 0x12,
 		.bit = 0x03,
-	},
+	}, /* DLD1 */
 	{
 		.address = 0x10,
 		.reg = 0x12,
 		.bit = 0x04,
-	},
+	}, /* DLD2 */
 	{
 		.address = 0x14,
 		.reg = 0x12,
 		.bit = 0x05,
-	},
+	}, /* DLD3 */
 	{
 		.address = 0x18,
 		.reg = 0x12,
 		.bit = 0x06,
-	},
+	}, /* DLD4 */
 	{
 		.address = 0x1c,
 		.reg = 0x12,
 		.bit = 0x00,
-	},
+	}, /* ELD1 */
 	{
 		.address = 0x20,
 		.reg = 0x12,
 		.bit = 0x01,
-	},
+	}, /* ELD2 */
 	{
 		.address = 0x24,
 		.reg = 0x12,
 		.bit = 0x02,
-	},
+	}, /* ELD3 */
 	{
 		.address = 0x28,
 		.reg = 0x13,
 		.bit = 0x02,
-	},
+	}, /* FLD1 */
 	{
 		.address = 0x2c,
 		.reg = 0x13,
 		.bit = 0x03,
-	},
+	}, /* FLD2 */
 	{
 		.address = 0x30,
 		.reg = 0x13,
 		.bit = 0x04,
-	},
+	}, /* FLD3 */
 	{
-		.address = 0x38,
+		.address = 0x34,
 		.reg = 0x10,
 		.bit = 0x03,
-	},
+	}, /* BUC1 */
 	{
-		.address = 0x3c,
+		.address = 0x38,
 		.reg = 0x10,
 		.bit = 0x06,
-	},
+	}, /* BUC2 */
 	{
-		.address = 0x40,
+		.address = 0x3c,
 		.reg = 0x10,
 		.bit = 0x05,
-	},
+	}, /* BUC3 */
 	{
-		.address = 0x44,
+		.address = 0x40,
 		.reg = 0x10,
 		.bit = 0x04,
-	},
+	}, /* BUC4 */
 	{
-		.address = 0x48,
+		.address = 0x44,
 		.reg = 0x10,
 		.bit = 0x01,
-	},
+	}, /* BUC5 */
 	{
-		.address = 0x4c,
+		.address = 0x48,
 		.reg = 0x10,
 		.bit = 0x00
-	},
+	}, /* BUC6 */
 };
 
 /* TMP0 - TMP5 are the same, all from GPADC */
