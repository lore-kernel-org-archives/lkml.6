Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751649AbeBAXNb (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 18:13:31 -0500
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:11523 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751508AbeBAXNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 18:13:25 -0500
X-IronPort-AV: E=Sophos;i="5.46,444,1511827200";
   d="scan'208";a="706380342"
From: =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>
To: Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
        x86@kernel.org
Cc: =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] x86: e820: Implement a range manipulation operator
Date: Fri,  2 Feb 2018 00:13:13 +0100
Message-Id: <20180201231313.28458-1-jschoenh@amazon.de>
X-Mailer: git-send-email 2.9.3.1.gcba166c.dirty
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a more versatile memmap= operator, which -- in addition to all the
things that were possible before -- allows you to:
- redeclare existing ranges -- before, you were limited to adding ranges;
- drop any range -- like a mem= for any location;
- use any e820 memory type -- not just some predefined ones.

The syntax is:

  memmap=<size>%<offset>-<oldtype>+<newtype>

Size and offset work as usual. The "-<oldtype>" and "+<newtype>" are
optional and their existence determine the behavior: The command
works on the specified range of memory limited to type <oldtype>
(if specified). This memory is then configured to show up as <newtype>.
If <newtype> is not specified, the memory is removed from the e820 map.

Signed-off-by: Jan H. Schönherr <jschoenh@amazon.de>
---
 Documentation/admin-guide/kernel-parameters.txt |  9 +++++++++
 arch/x86/kernel/e820.c                          | 18 ++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 46b26bfee27b..94609eaff2a9 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2221,6 +2221,15 @@
 			The memory region may be marked as e820 type 12 (0xc)
 			and is NVDIMM or ADR memory.
 
+	memmap=<size>%<offset>-<oldtype>+<newtype>
+			[KNL,ACPI] Convert memory within the specified region
+			from <oldtype> to <newtype>. If "-<oldtype>" is left
+			out, the whole region will be marked as <newtype>,
+			even if previously unavailable. If "+<newtype>" is left
+			out, matching memory will be removed. Types are
+			specified as e820 types, eg, 1==RAM, 2==reserved,
+			3==ACPI, 12==PRAM.
+
 	memory_corruption_check=0/1 [X86]
 			Some BIOSes seem to corrupt the first 64k of
 			memory when doing things like suspend/resume.
diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index 71c11ad5643e..cd22c6a07632 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -924,6 +924,24 @@ static int __init parse_memmap_one(char *p)
 	} else if (*p == '!') {
 		start_at = memparse(p+1, &p);
 		e820__range_add(start_at, mem_size, E820_TYPE_PRAM);
+	} else if (*p == '%') {
+		enum e820_type from = 0, to = 0;
+
+		start_at = memparse(p + 1, &p);
+		if (*p == '-')
+			from = simple_strtoull(p + 1, &p, 0);
+		if (*p == '+')
+			to = simple_strtoull(p + 1, &p, 0);
+		if (*p != 0)
+			return -EINVAL;
+		if (from && to)
+			e820__range_update(start_at, mem_size, from, to);
+		else if (to)
+			e820__range_add(start_at, mem_size, to);
+		else if (from)
+			e820__range_remove(start_at, mem_size, from, 1);
+		else
+			e820__range_remove(start_at, mem_size, 0, 0);
 	} else {
 		e820__range_remove(mem_size, ULLONG_MAX - mem_size, E820_TYPE_RAM, 1);
 	}
-- 
2.9.3.1.gcba166c.dirty
