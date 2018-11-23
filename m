Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40477C43610
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 07:57:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0828020820
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 07:57:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="EZAV4q3k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0828020820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408322AbeKWSlA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 13:41:00 -0500
Received: from conuserg-08.nifty.com ([210.131.2.75]:55963 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729827AbeKWSk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 13:40:58 -0500
Received: from grover.tkatk1.zaq.ne.jp (zaqdadce369.zaq.ne.jp [218.220.227.105]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id wAN7vWj2021058;
        Fri, 23 Nov 2018 16:57:32 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com wAN7vWj2021058
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1542959853;
        bh=Yqsi8EZdGJBsAxM6FldKbnl+rKoATI9SGx36ZNkWo0I=;
        h=From:To:Cc:Subject:Date:From;
        b=EZAV4q3kvX6yt4jMhdJkdkg9skzM/pxbCmde4J0CR1m5o7ScQoLTLihbIYSexMNXb
         tv8x552dge70Jc1KeLZI/+118oZAGE3uvud2q0Qam9a9UtI9CRRe33w8IAfPmvgyRc
         Py3ZRpsFZscD1/zexeWJ7ED78diijkwsfMsDnVuJLI8XqbJR8MLim5YvCNgaMper3E
         UC4VRZRW42U/FVBfZvlUN6zCmf5KR7HwRRTrwPztfUQCRs31mz4GHvxcUlDpWnx6EM
         tiGfei6Zcq1zor3XGMgRL+IQ1gUIHguIHweSH/Eo77svVLmIyhDZDcWBP+/kn5BUxW
         RcX7oni/JSkQQ==
X-Nifty-SrcIP: [218.220.227.105]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Leonardo Bras <leobras.c@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] modpost: refactor seen flag clearing in add_depends()
Date:   Fri, 23 Nov 2018 16:57:21 +0900
Message-Id: <1542959843-16145-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

You do not need to iterate over all modules for resetting ->seen flag
because add_depends() is only interested in modules that export symbols
referenced from the given 'mod'.

This also avoids shadowing the 'modules' parameter of add_depends().

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/mod/modpost.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index c64066d..39432c2 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -2229,15 +2229,15 @@ static int add_versions(struct buffer *b, struct module *mod)
 	return err;
 }
 
-static void add_depends(struct buffer *b, struct module *mod,
-			struct module *modules)
+static void add_depends(struct buffer *b, struct module *mod)
 {
 	struct symbol *s;
-	struct module *m;
 	int first = 1;
 
-	for (m = modules; m; m = m->next)
-		m->seen = is_vmlinux(m->name);
+	/* Clear ->seen flag of modules that own symbols needed by this. */
+	for (s = mod->unres; s; s = s->next)
+		if (s->module)
+			s->module->seen = is_vmlinux(s->module->name);
 
 	buf_printf(b, "\n");
 	buf_printf(b, "static const char __module_depends[]\n");
@@ -2506,7 +2506,7 @@ int main(int argc, char **argv)
 		add_retpoline(&buf);
 		add_staging_flag(&buf, mod->name);
 		err |= add_versions(&buf, mod);
-		add_depends(&buf, mod, modules);
+		add_depends(&buf, mod);
 		add_moddevtable(&buf, mod);
 		add_srcversion(&buf, mod);
 
-- 
2.7.4

