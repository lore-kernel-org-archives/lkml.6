Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751370AbeELO7w (ORCPT <rfc822;w@1wt.eu>);
        Sat, 12 May 2018 10:59:52 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:36375 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750756AbeELO7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 May 2018 10:59:50 -0400
X-Google-Smtp-Source: AB8JxZpx8Vb25GFuxZQ7qHUAwWa/CRFfm0Ho5+a8BEEg56jw6/7uyIAkwSM7erpwxR/DMaAt1ulw/w==
From: Larry Finger <Larry.Finger@lwfinger.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Larry Finger <Larry.Finger@lwfinger.net>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org
Subject: [RFC] acpi: Declare memory allocations in acpi_ut_create_internal_object_dbg as non-leaks
Date: Sat, 12 May 2018 09:59:38 -0500
Message-Id: <20180512145938.7936-1-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.16.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In kernel 4.17.0-rcX, kmemleak reports 9 leaks with tracebacks similat to
the following:

unreferenced object 0xffff880224a077e0 (size 72):
  comm "swapper/0", pid 1, jiffies 4294892358 (age 1022.636s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 0e 01 01 00 00 00 00 01  ................
    00 00 00 80 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<000000004f506615>] acpi_ut_create_internal_object_dbg+0x4d/0x10e
    [<000000006e7730e3>] acpi_ds_build_internal_object+0xed/0x1cd
    [<00000000272b7c73>] acpi_ds_build_internal_package_obj+0x245/0x3a2
    [<000000000b64c50e>] acpi_ds_eval_data_object_operands+0x17b/0x21b
    [<00000000589647ac>] acpi_ds_exec_end_op+0x433/0x6c1
    [<000000001d69bcbf>] acpi_ps_parse_loop+0x926/0x9be
    [<000000005d6fa97d>] acpi_ps_parse_aml+0x1a2/0x4af
    [<00000000c4bef823>] acpi_ps_execute_table+0xbb/0x119
    [<00000000fd9632e4>] acpi_ns_execute_table+0x20c/0x260
    [<00000000e6ae17ac>] acpi_ns_parse_table+0x7d/0x1b3
    [<0000000008e1e148>] acpi_ns_load_table+0x8d/0x1c0
    [<000000009fc8346f>] acpi_tb_load_namespace+0x176/0x278
    [<0000000073f98b3b>] acpi_load_tables+0x6e/0xfd
    [<00000000d2ef13d2>] acpi_init+0x8c/0x340
    [<000000007da19d8d>] do_one_initcall+0x46/0x1fa
    [<0000000024681a1d>] kernel_init_freeable+0x1a2/0x237

According to gdb, the offending code is
              object =
                  acpi_ut_allocate_object_desc_dbg(module_name, line_number,
                                                   component_id);

As it is not possible to unload the acpi code to test that this is a real
leak and not a false positive, and that only these 9 appear no matter how
long the system is up, a kmemleak_not_leak(object) call is inserted.

Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org
Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
---
 drivers/acpi/acpica/utobject.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/acpi/acpica/utobject.c b/drivers/acpi/acpica/utobject.c
index 5b78fe08d7d7..ae6d8cc18cec 100644
--- a/drivers/acpi/acpica/utobject.c
+++ b/drivers/acpi/acpica/utobject.c
@@ -8,6 +8,7 @@
  *****************************************************************************/
 
 #include <acpi/acpi.h>
+#include <linux/kmemleak.h>
 #include "accommon.h"
 #include "acnamesp.h"
 
@@ -70,6 +71,7 @@ union acpi_operand_object *acpi_ut_create_internal_object_dbg(const char
 	if (!object) {
 		return_PTR(NULL);
 	}
+	kmemleak_not_leak(object);
 
 	switch (type) {
 	case ACPI_TYPE_REGION:
-- 
2.16.3
