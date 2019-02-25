Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C180CC10F00
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:42:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9228F20842
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551130925;
	bh=ZMBQxEgAyus4Sy/A7Rw2fGDfG+a+5wmJZia15ptR5xA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kqgfP6YfnZpJeaemaLondW224tYgASOhw4X1WoaiwJ+YQWqdCmXGsKDIXhctKHjgJ
	 U7ozQ47tsO2bBfjcaaMBNBcurgostk+aqP1UdtbVbmLIXC3OBXFMz9Z5zfJRy8wDfR
	 zD3qzv4GcynvH44KgN8/pZFDv/R6Hf75O3PrAXO4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732567AbfBYVcy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:32:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:38584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731756AbfBYVcr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:32:47 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F77921841;
        Mon, 25 Feb 2019 21:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551130365;
        bh=ZMBQxEgAyus4Sy/A7Rw2fGDfG+a+5wmJZia15ptR5xA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bj0pR1pMEwJuHYGFaWdGiWUQoITTzE9f/qluf2hqb1ImmfDYpI3z232ER8rEnPqD6
         j8RWk6G1vPDAqF9OkHJXoJ/7zoWyHRlCbfioecs+wmwvSfe5L2cjC4Zv1AJJo7TWEa
         3m9LqtwGAsLIssirJQ1NQf4scMGkdrsbLBKyQCQk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, step-ali <sunmooon15@gmail.com>,
        Charles Stanhope <charles.stanhope@gmail.com>,
        Paulo Nascimento <paulo.ulusu@googlemail.com>,
        David Purton <dcpurton@marshwiggle.net>,
        Adam Harvey <adam@adamharvey.name>,
        Zhang Rui <rui.zhang@intel.com>,
        Jean-Marc Lenoir <archlinux@jihemel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 097/183] ACPI: EC: Look for ECDT EC after calling acpi_load_tables()
Date:   Mon, 25 Feb 2019 22:11:10 +0100
Message-Id: <20190225195111.035072053@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195054.748060397@linuxfoundation.org>
References: <20190225195054.748060397@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit b1c0330823fe842dbb34641f1410f0afa51c29d3 ]

Some systems have had functional issues since commit 5a8361f7ecce
(ACPICA: Integrate package handling with module-level code) that,
among other things, changed the initial values of the
acpi_gbl_group_module_level_code and acpi_gbl_parse_table_as_term_list
global flags in ACPICA which implicitly caused acpi_ec_ecdt_probe() to
be called before acpi_load_tables() on the vast majority of platforms.

Namely, before commit 5a8361f7ecce, acpi_load_tables() was called from
acpi_early_init() if acpi_gbl_parse_table_as_term_list was FALSE and
acpi_gbl_group_module_level_code was TRUE, which almost always was
the case as FALSE and TRUE were their initial values, respectively.
The acpi_gbl_parse_table_as_term_list value would be changed to TRUE
for a couple of platforms in acpi_quirks_dmi_table[], but it remained
FALSE in the vast majority of cases.

After commit 5a8361f7ecce, the initial values of the two flags have
been reversed, so in effect acpi_load_tables() has not been called
from acpi_early_init() any more.  That, in turn, affects
acpi_ec_ecdt_probe() which is invoked before acpi_load_tables() now
and it is not possible to evaluate the _REG method for the EC address
space handler installed by it.  That effectively causes the EC address
space to be inaccessible to AML on platforms with an ECDT matching the
EC device definition in the DSDT and functional problems ensue in
there.

Because the default behavior before commit 5a8361f7ecce was to call
acpi_ec_ecdt_probe() after acpi_load_tables(), it should be safe to
do that again.  Moreover, the EC address space handler installed by
acpi_ec_ecdt_probe() is only needed for AML to be able to access the
EC address space and the only AML that can run during acpi_load_tables()
is module-level code which only is allowed to access address spaces
with default handlers (memory, I/O and PCI config space).

For this reason, move the acpi_ec_ecdt_probe() invocation back to
acpi_bus_init(), from where it was taken away by commit d737f333b211
(ACPI: probe ECDT before loading AML tables regardless of module-level
code flag), and put it after the invocation of acpi_load_tables() to
restore the original code ordering from before commit 5a8361f7ecce.

Fixes: 5a8361f7ecce ("ACPICA: Integrate package handling with module-level code")
Link: https://bugzilla.kernel.org/show_bug.cgi?id=199981
Reported-by: step-ali <sunmooon15@gmail.com>
Reported-by: Charles Stanhope <charles.stanhope@gmail.com>
Tested-by: Charles Stanhope <charles.stanhope@gmail.com>
Reported-by: Paulo Nascimento <paulo.ulusu@googlemail.com>
Reported-by: David Purton <dcpurton@marshwiggle.net>
Reported-by: Adam Harvey <adam@adamharvey.name>
Reported-by: Zhang Rui <rui.zhang@intel.com>
Tested-by: Zhang Rui <rui.zhang@intel.com>
Tested-by: Jean-Marc Lenoir <archlinux@jihemel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/bus.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index bb3d96dea6dba..26d4164d394fb 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -1054,18 +1054,6 @@ void __init acpi_early_init(void)
 		goto error0;
 	}
 
-	/*
-	 * ACPI 2.0 requires the EC driver to be loaded and work before
-	 * the EC device is found in the namespace (i.e. before
-	 * acpi_load_tables() is called).
-	 *
-	 * This is accomplished by looking for the ECDT table, and getting
-	 * the EC parameters out of that.
-	 *
-	 * Ignore the result. Not having an ECDT is not fatal.
-	 */
-	status = acpi_ec_ecdt_probe();
-
 #ifdef CONFIG_X86
 	if (!acpi_ioapic) {
 		/* compatible (0) means level (3) */
@@ -1142,6 +1130,18 @@ static int __init acpi_bus_init(void)
 		goto error1;
 	}
 
+	/*
+	 * ACPI 2.0 requires the EC driver to be loaded and work before the EC
+	 * device is found in the namespace.
+	 *
+	 * This is accomplished by looking for the ECDT table and getting the EC
+	 * parameters out of that.
+	 *
+	 * Do that before calling acpi_initialize_objects() which may trigger EC
+	 * address space accesses.
+	 */
+	acpi_ec_ecdt_probe();
+
 	status = acpi_enable_subsystem(ACPI_NO_ACPI_ENABLE);
 	if (ACPI_FAILURE(status)) {
 		printk(KERN_ERR PREFIX
-- 
2.19.1



