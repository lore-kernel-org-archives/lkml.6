Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79007C64EB1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C62420700
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544108261;
	bh=Xaq9pidXNdFKHcniGWARDEt8ODw+YKhvIgN52w3IYOI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=G2ymlvk/nvXohJ4TAjhuNrSs4v5x2Vk8puriGNmTjY6jphDefSKNhgmEQsGOx8fdy
	 w5XtqjAkL5SVgGlydvjXS4VGml5I7jn6mnjVqg/e3YBs6JlpmgGBD0ruBDNcV9KvPi
	 KVPy9yDQxfZIwo/fR2ASIUySkKsyyx4EztL9k0a4=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C62420700
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726125AbeLFO5k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 09:57:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:46882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730490AbeLFOmd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 09:42:33 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE84F2082B;
        Thu,  6 Dec 2018 14:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544107353;
        bh=Xaq9pidXNdFKHcniGWARDEt8ODw+YKhvIgN52w3IYOI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LWQNckjR4IciqDUxNVO2OjOyps1MEH/HCIpdIrukAwoPxBXHFiPKqxM/xWz/JxkSI
         Yyz4GZMHJUNUrQ0fLzCAub0XL5RjLceEdYbHXl7XsGgsjUd/b9pim28f+n1Ndc5eZd
         6ByUWxNkgzC43QIQJh3d6FzbagsPE2rSYwc7yuBU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>,
        Laura Abbott <labbott@redhat.com>
Subject: [PATCH 4.14 30/55] kgdboc: Fix warning with module build
Date:   Thu,  6 Dec 2018 15:39:04 +0100
Message-Id: <20181206143003.352409362@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206143001.749982936@linuxfoundation.org>
References: <20181206143001.749982936@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Laura Abbott <labbott@redhat.com>

commit 1cd25cbb2fedbc777f3a8c3cb1ba69b645aeaa64 upstream.

After 2dd453168643 ("kgdboc: Fix restrict error"), kgdboc_option_setup is
now only used when built in, resulting in a warning when compiled as a
module:

drivers/tty/serial/kgdboc.c:134:12: warning: 'kgdboc_option_setup' defined but not used [-Wunused-function]
 static int kgdboc_option_setup(char *opt)
            ^~~~~~~~~~~~~~~~~~~

Move the function under the appropriate ifdef for builtin only.

Fixes: 2dd453168643 ("kgdboc: Fix restrict error")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Laura Abbott <labbott@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/serial/kgdboc.c |   37 +++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 18 deletions(-)

--- a/drivers/tty/serial/kgdboc.c
+++ b/drivers/tty/serial/kgdboc.c
@@ -131,24 +131,6 @@ static void kgdboc_unregister_kbd(void)
 #define kgdboc_restore_input()
 #endif /* ! CONFIG_KDB_KEYBOARD */
 
-static int kgdboc_option_setup(char *opt)
-{
-	if (!opt) {
-		pr_err("kgdboc: config string not provided\n");
-		return -EINVAL;
-	}
-
-	if (strlen(opt) >= MAX_CONFIG_LEN) {
-		printk(KERN_ERR "kgdboc: config string too long\n");
-		return -ENOSPC;
-	}
-	strcpy(config, opt);
-
-	return 0;
-}
-
-__setup("kgdboc=", kgdboc_option_setup);
-
 static void cleanup_kgdboc(void)
 {
 	if (kgdb_unregister_nmi_console())
@@ -316,6 +298,25 @@ static struct kgdb_io kgdboc_io_ops = {
 };
 
 #ifdef CONFIG_KGDB_SERIAL_CONSOLE
+static int kgdboc_option_setup(char *opt)
+{
+	if (!opt) {
+		pr_err("config string not provided\n");
+		return -EINVAL;
+	}
+
+	if (strlen(opt) >= MAX_CONFIG_LEN) {
+		pr_err("config string too long\n");
+		return -ENOSPC;
+	}
+	strcpy(config, opt);
+
+	return 0;
+}
+
+__setup("kgdboc=", kgdboc_option_setup);
+
+
 /* This is only available if kgdboc is a built in for early debugging */
 static int __init kgdboc_early_init(char *opt)
 {


