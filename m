Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49ZBHz8lKnUKr7QQ4GPbAfai0Bwwds3Yid/zmhl02q9tLe4YuhnB4inb3x7aDyofR9u0ivz
ARC-Seal: i=1; a=rsa-sha256; t=1523472605; cv=none;
        d=google.com; s=arc-20160816;
        b=mF2x8eEdYL4TlZ5czUEmTGYaTHJ89s6HsyzanskCFQgmVq+/XUjtZQB1KWzFZITLiN
         fcMz/SSmGbSXbOig4xRjjmT1cObe8nnu2P3MkoHWomxOBbXGRbQTSZ+4Z+n93H6zJrDK
         OOcmz1b9AIPOFZvxFaxHf1/plS4h+98uqibPRKB2a3t+qCafcYS1HbXUpy2N+/3u9kT9
         uTCPpc+oPrtogRbs5w0521FyZvHhDKv56Nv10rqIp5LhUnWiRo5OxMOFqWXDiw4d4RPJ
         dpR6E5q8bakDfyAryiIjIZIPtVYEfsHKx5LIz1aK+EY6h6jzV1wMSybM5tWpLs2RaUMU
         v4VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=93yG43xxwDSunxo0ZskO3jlNu7tuM49QssyIl1RhViQ=;
        b=0xtiq+JFp6H0E/EYxIe8pzXxMISB3o1KkAPWX/1blaAQKHAXvQ1AbRip+3AAXkUfd6
         0FsE5F19ctq/90Ek3djzhoA3KjGxH6KXtfOXmdr4JlY1an2w+07GmEDRkdLadQEyuqJ1
         EH7yME+ier0FEXHbbMDlggcGmnAxLq8vw+T5eRjOPGPgbZCdv/UoP248yymuXihi0DZv
         Yp3TqZf700Yrm8qOciszHautZ0c0o0z8/GVzPxeEaIqrEOtBUjIX8v6NRucrVap+hhgX
         KKo9TijIgiI6oAeMaqvq2/eGEZRMAkHOGqfQY+4RNesQ99/ci7SBigiWPOb8jVgMVe8k
         wZQA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Bob Moore <robert.moore@intel.com>,
	Lv Zheng <lv.zheng@intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 146/190] ACPICA: Disassembler: Abort on an invalid/unknown AML opcode
Date: Wed, 11 Apr 2018 20:36:32 +0200
Message-Id: <20180411183601.165911895@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183550.114495991@linuxfoundation.org>
References: <20180411183550.114495991@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476383289984854?=
X-GMAIL-MSGID: =?utf-8?q?1597476810443902856?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bob Moore <robert.moore@intel.com>


[ Upstream commit 6f0527b77d9e0129dd8e50945b0d610ed943d6b2 ]

ACPICA commit ed0389cb11a61e63c568ac1f67948fc6a7bd1aeb

An invalid opcode indicates something seriously wrong with the
input AML file. The AML parser is immediately confused and lost,
causing the resulting parse tree to be ill-formed. The actual
disassembly can then cause numerous unrelated errors and faults.

This change aborts the disassembly upon discovery of such an
opcode during the AML parse phase.

Link: https://github.com/acpica/acpica/commit/ed0389cb
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/acpi/acpica/psobject.c |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

--- a/drivers/acpi/acpica/psobject.c
+++ b/drivers/acpi/acpica/psobject.c
@@ -121,6 +121,9 @@ static acpi_status acpi_ps_get_aml_opcod
 			     (u32)(aml_offset +
 				   sizeof(struct acpi_table_header)));
 
+			ACPI_ERROR((AE_INFO,
+				    "Aborting disassembly, AML byte code is corrupt"));
+
 			/* Dump the context surrounding the invalid opcode */
 
 			acpi_ut_dump_buffer(((u8 *)walk_state->parser_state.
@@ -129,6 +132,14 @@ static acpi_status acpi_ps_get_aml_opcod
 					     sizeof(struct acpi_table_header) -
 					     16));
 			acpi_os_printf(" */\n");
+
+			/*
+			 * Just abort the disassembly, cannot continue because the
+			 * parser is essentially lost. The disassembler can then
+			 * randomly fail because an ill-constructed parse tree
+			 * can result.
+			 */
+			return_ACPI_STATUS(AE_AML_BAD_OPCODE);
 #endif
 		}
 
@@ -293,6 +304,9 @@ acpi_ps_create_op(struct acpi_walk_state
 	if (status == AE_CTRL_PARSE_CONTINUE) {
 		return_ACPI_STATUS(AE_CTRL_PARSE_CONTINUE);
 	}
+	if (ACPI_FAILURE(status)) {
+		return_ACPI_STATUS(status);
+	}
 
 	/* Create Op structure and append to parent's argument list */
 
