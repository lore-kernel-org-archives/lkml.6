Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71CC5C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 16:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8EC32070B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 16:06:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729881AbeLNQGB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 11:06:01 -0500
Received: from bastet.se.axis.com ([195.60.68.11]:49690 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728829AbeLNQGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 11:06:00 -0500
Received: from localhost (localhost [127.0.0.1])
        by bastet.se.axis.com (Postfix) with ESMTP id 32A441860D;
        Fri, 14 Dec 2018 17:05:58 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
        by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id XmZBrH9sGzNg; Fri, 14 Dec 2018 17:05:57 +0100 (CET)
Received: from boulder02.se.axis.com (boulder02.se.axis.com [10.0.8.16])
        by bastet.se.axis.com (Postfix) with ESMTPS id 0CECC1860E;
        Fri, 14 Dec 2018 17:05:57 +0100 (CET)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ECEA91A063;
        Fri, 14 Dec 2018 17:05:56 +0100 (CET)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E0E3F1A062;
        Fri, 14 Dec 2018 17:05:56 +0100 (CET)
Received: from seth.se.axis.com (unknown [10.0.2.172])
        by boulder02.se.axis.com (Postfix) with ESMTP;
        Fri, 14 Dec 2018 17:05:56 +0100 (CET)
Received: from lnxartpec.se.axis.com (lnxartpec.se.axis.com [10.88.4.9])
        by seth.se.axis.com (Postfix) with ESMTP id D3F9D144;
        Fri, 14 Dec 2018 17:05:56 +0100 (CET)
Received: by lnxartpec.se.axis.com (Postfix, from userid 10564)
        id CE91E80D7B; Fri, 14 Dec 2018 17:05:56 +0100 (CET)
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     linux@armlinux.org.uk, jeyu@kernel.org
Cc:     dave.martin@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Vincent Whitchurch <rabinv@axis.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Dave Martin <Dave.Martin@arm.com>
Subject: [PATCH v6 modules-next 1/2] module: Overwrite st_size instead of st_info
Date:   Fri, 14 Dec 2018 17:05:54 +0100
Message-Id: <20181214160555.9980-1-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

st_info is currently overwritten after relocation and used to store the
elf_type().  However, we're going to need it fix kallsyms on ARM's
Thumb-2 kernels, so preserve st_info and overwrite the st_size field
instead.  st_size is neither used by the module core nor by any
architecture.

Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Reviewed-by: Dave Martin <Dave.Martin@arm.com>
Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
v6: Add Miroslav Benes' Reviewed-by
v5: Add Dave Martin's Reviewed-by
v4: Split out to separate patch.  Use st_size instead of st_other.
v1-v3: See PATCH 2/2

 kernel/module.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/module.c b/kernel/module.c
index 1b5edf78694c..b36ff8a3d562 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -2684,7 +2684,7 @@ static void add_kallsyms(struct module *mod, const struct load_info *info)
 
 	/* Set types up while we still have access to sections. */
 	for (i = 0; i < mod->kallsyms->num_symtab; i++)
-		mod->kallsyms->symtab[i].st_info
+		mod->kallsyms->symtab[i].st_size
 			= elf_type(&mod->kallsyms->symtab[i], info);
 
 	/* Now populate the cut down core kallsyms for after init. */
@@ -4070,7 +4070,7 @@ int module_get_kallsym(unsigned int symnum, unsigned long *value, char *type,
 		kallsyms = rcu_dereference_sched(mod->kallsyms);
 		if (symnum < kallsyms->num_symtab) {
 			*value = kallsyms->symtab[symnum].st_value;
-			*type = kallsyms->symtab[symnum].st_info;
+			*type = kallsyms->symtab[symnum].st_size;
 			strlcpy(name, kallsyms_symbol_name(kallsyms, symnum), KSYM_NAME_LEN);
 			strlcpy(module_name, mod->name, MODULE_NAME_LEN);
 			*exported = is_exported(name, *value, mod);
-- 
2.11.0

