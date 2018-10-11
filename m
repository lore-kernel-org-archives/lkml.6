Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F5DBC677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:43:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 146C521470
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:43:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wAKy8okf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 146C521470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730976AbeJKXLN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:11:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:42992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726700AbeJKXLM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:11:12 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2BF332098A;
        Thu, 11 Oct 2018 15:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539272607;
        bh=3tiStKFnUvqabf75f0uzaXhYy55ux5VoDkeH9RVVQnw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wAKy8okfNquyUH0zlkpo1WJm6VLzO4UZXjuvVVnk+Y27vUskVtRWtJpgn8+CskgvM
         Jk+S70ffqGmiwe6wVtrg4BuQPvjJd9LrcKQERjiPv3kz03JHQPcUN8tGyZGowyR5U4
         Tms/zNmI0mtYg3k0iAsXdr/LsNo9ByLsZYhTl1nM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michal Suchanek <msuchanek@suse.de>,
        Hari Bathini <hbathini@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Kleber Sacilotto de Souza <kleber.souza@canonical.com>
Subject: [PATCH 4.9 21/35] powerpc/fadump: Return error when fadump registration fails
Date:   Thu, 11 Oct 2018 17:35:23 +0200
Message-Id: <20181011152521.019372729@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181011152520.174949126@linuxfoundation.org>
References: <20181011152520.174949126@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michal Suchanek <msuchanek@suse.de>

commit 98b8cd7f75643e0a442d7a4c1cef2c9d53b7e92b upstream.

 - log an error message when registration fails and no error code listed
   in the switch is returned
 - translate the hv error code to posix error code and return it from
   fw_register
 - return the posix error code from fw_register to the process writing
   to sysfs
 - return EEXIST on re-registration
 - return success on deregistration when fadump is not registered
 - return ENODEV when no memory is reserved for fadump

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
Tested-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
[mpe: Use pr_err() to shrink the error print]
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Cc: Kleber Sacilotto de Souza <kleber.souza@canonical.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/kernel/fadump.c |   23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -365,9 +365,9 @@ static int __init early_fadump_reserve_m
 }
 early_param("fadump_reserve_mem", early_fadump_reserve_mem);
 
-static void register_fw_dump(struct fadump_mem_struct *fdm)
+static int register_fw_dump(struct fadump_mem_struct *fdm)
 {
-	int rc;
+	int rc, err;
 	unsigned int wait_time;
 
 	pr_debug("Registering for firmware-assisted kernel dump...\n");
@@ -384,7 +384,11 @@ static void register_fw_dump(struct fadu
 
 	} while (wait_time);
 
+	err = -EIO;
 	switch (rc) {
+	default:
+		pr_err("Failed to register. Unknown Error(%d).\n", rc);
+		break;
 	case -1:
 		printk(KERN_ERR "Failed to register firmware-assisted kernel"
 			" dump. Hardware Error(%d).\n", rc);
@@ -392,18 +396,22 @@ static void register_fw_dump(struct fadu
 	case -3:
 		printk(KERN_ERR "Failed to register firmware-assisted kernel"
 			" dump. Parameter Error(%d).\n", rc);
+		err = -EINVAL;
 		break;
 	case -9:
 		printk(KERN_ERR "firmware-assisted kernel dump is already "
 			" registered.");
 		fw_dump.dump_registered = 1;
+		err = -EEXIST;
 		break;
 	case 0:
 		printk(KERN_INFO "firmware-assisted kernel dump registration"
 			" is successful\n");
 		fw_dump.dump_registered = 1;
+		err = 0;
 		break;
 	}
+	return err;
 }
 
 void crash_fadump(struct pt_regs *regs, const char *str)
@@ -1006,7 +1014,7 @@ static unsigned long init_fadump_header(
 	return addr;
 }
 
-static void register_fadump(void)
+static int register_fadump(void)
 {
 	unsigned long addr;
 	void *vaddr;
@@ -1017,7 +1025,7 @@ static void register_fadump(void)
 	 * assisted dump.
 	 */
 	if (!fw_dump.reserve_dump_area_size)
-		return;
+		return -ENODEV;
 
 	ret = fadump_setup_crash_memory_ranges();
 	if (ret)
@@ -1032,7 +1040,7 @@ static void register_fadump(void)
 	fadump_create_elfcore_headers(vaddr);
 
 	/* register the future kernel dump with firmware. */
-	register_fw_dump(&fdm);
+	return register_fw_dump(&fdm);
 }
 
 static int fadump_unregister_dump(struct fadump_mem_struct *fdm)
@@ -1218,7 +1226,6 @@ static ssize_t fadump_register_store(str
 	switch (buf[0]) {
 	case '0':
 		if (fw_dump.dump_registered == 0) {
-			ret = -EINVAL;
 			goto unlock_out;
 		}
 		/* Un-register Firmware-assisted dump */
@@ -1226,11 +1233,11 @@ static ssize_t fadump_register_store(str
 		break;
 	case '1':
 		if (fw_dump.dump_registered == 1) {
-			ret = -EINVAL;
+			ret = -EEXIST;
 			goto unlock_out;
 		}
 		/* Register Firmware-assisted dump */
-		register_fadump();
+		ret = register_fadump();
 		break;
 	default:
 		ret = -EINVAL;


