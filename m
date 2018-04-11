Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/wDavf9cpFDP2sb1Nz1NhOuDcdsptLs7rddVxKL/TV9NmJV/YvBdE9D9S+Xemev68/1n8L
ARC-Seal: i=1; a=rsa-sha256; t=1523472198; cv=none;
        d=google.com; s=arc-20160816;
        b=I7rj3RtxlbgpKhv7kH1CC550l/oXEGmq6Mltb18WV6CDESJzT8Rw8www/YiEhi0QSB
         1nZ+qEQIVKh6OYXMf5bfXRhp3sLOIrHl468naysLsyNtTYjVu+FPRdu/ZlatLld4gyDr
         398zooR2hQpxKjN2XeYNef8cCwj63iIAE/wIbE0gsPUwyYHZB+CFEW4rLbSGyS9DC7I+
         RnlXrMbuehK691WdLxoh1+oFyDiWDTKeNLBvP0C+b+F8TrBIO2wDcOSc516VEqTDYf5H
         xQA5ePKPna6sAZYUcG61A3oxnEWy7JfaNFoJbin3tHj/6C18IyYTgsCD9Hiplir8kOhV
         oBvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=KYlAfLLgT2o4gQkYt2QevtcH3uxdXVjohKxA/J6EYeA=;
        b=gKBlC/ywFkwYR/TgcOlQ0yQeZ/zMAW7MjwCyG2291NuO8Van7Xj0E7DrMfByavXhL0
         nWEADmQTwRqC/B5l2bz1UU3vThZvmuA2J0yW55nSW89ateb2HLvi+A8nUB90zQpFxFNd
         juTzClnQq/FiAAkVQqnCeqdujCB3MCKM/8WJ2A9KrhTLEB19K/4yAI/oCZsMtNHndo7X
         F9D1E76FMNAfgaQUnxw7+n8ULhj0iAJ55vUl/ZZt4eVEf0i+h4zAlMs+MUc3EzzYHRnv
         rhqcGXNBZdbBHwMPOgDsCUJXyXI4QGpAHkjvvAJtm2+GN6idUXeDWCtMnR+9GIPLTMAs
         CzUA==
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
Subject: [PATCH 3.18 088/121] ACPICA: Disassembler: Abort on an invalid/unknown AML opcode
Date: Wed, 11 Apr 2018 20:36:31 +0200
Message-Id: <20180411183501.827412320@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183456.195010921@linuxfoundation.org>
References: <20180411183456.195010921@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476383289984854?=
X-GMAIL-MSGID: =?utf-8?q?1597476383289984854?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -118,6 +118,9 @@ static acpi_status acpi_ps_get_aml_opcod
 			     (u32)(walk_state->aml_offset +
 				   sizeof(struct acpi_table_header)));
 
+			ACPI_ERROR((AE_INFO,
+				    "Aborting disassembly, AML byte code is corrupt"));
+
 			/* Dump the context surrounding the invalid opcode */
 
 			acpi_ut_dump_buffer(((u8 *)walk_state->parser_state.
@@ -126,6 +129,14 @@ static acpi_status acpi_ps_get_aml_opcod
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
 
@@ -290,6 +301,9 @@ acpi_ps_create_op(struct acpi_walk_state
 	if (status == AE_CTRL_PARSE_CONTINUE) {
 		return_ACPI_STATUS(AE_CTRL_PARSE_CONTINUE);
 	}
+	if (ACPI_FAILURE(status)) {
+		return_ACPI_STATUS(status);
+	}
 
 	/* Create Op structure and append to parent's argument list */
 
