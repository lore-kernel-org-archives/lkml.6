Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EF30C43612
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:46:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1138B2054F
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547570814;
	bh=0D/+igIbLV/eQ+QDuRMo75HYWMnPx0zNFoFm2mc5N/Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2rVosfB0VseuZuf7b1A84oJ/OWVU2BR+w3uWVmIwLTczm60KmZXtTwq4DPN8Ux7K5
	 oSeoJAWdDcxh8ltWZKQAg7mgMaxAAAupYZXOJ7hFespIFK3gaT+b1Vkjsg8Ln2pL+A
	 /6CixihEqCFCV5A2k7w0M/v4Q65cuoMoHk79CUCU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387653AbfAOQoy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:44:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:34384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728306AbfAOQov (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 11:44:51 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A7C5C20645;
        Tue, 15 Jan 2019 16:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547570690;
        bh=0D/+igIbLV/eQ+QDuRMo75HYWMnPx0zNFoFm2mc5N/Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fHZJHuZuBYM5bp8I4eEdgYErphvctGfkvAgUrssbgsVyYRP5s3kPur+WLz/V9u847
         QeG/WTTojEnR2bDuH7oAPU+m/8qu5XRIVFQjaP3uJ83uCUzE0i0kLKVHR2STwKPxp2
         a299LwdJc414JMVSvdYgODsPgTRN5E/UY4wD69+s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, WANG Chao <chao.wang@ucloud.cn>,
        Borislav Petkov <bp@suse.de>,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jessica Yu <jeyu@kernel.org>, Jiri Kosina <jkosina@suse.cz>,
        Kees Cook <keescook@chromium.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        linux-kbuild@vger.kernel.org, srinivas.eeda@oracle.com,
        x86-ml <x86@kernel.org>
Subject: [PATCH 4.20 08/57] x86, modpost: Replace last remnants of RETPOLINE with CONFIG_RETPOLINE
Date:   Tue, 15 Jan 2019 17:35:49 +0100
Message-Id: <20190115154911.193525782@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190115154910.734892368@linuxfoundation.org>
References: <20190115154910.734892368@linuxfoundation.org>
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

From: WANG Chao <chao.wang@ucloud.cn>

commit e4f358916d528d479c3c12bd2fd03f2d5a576380 upstream.

Commit

  4cd24de3a098 ("x86/retpoline: Make CONFIG_RETPOLINE depend on compiler support")

replaced the RETPOLINE define with CONFIG_RETPOLINE checks. Remove the
remaining pieces.

 [ bp: Massage commit message. ]

Fixes: 4cd24de3a098 ("x86/retpoline: Make CONFIG_RETPOLINE depend on compiler support")
Signed-off-by: WANG Chao <chao.wang@ucloud.cn>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
Reviewed-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jessica Yu <jeyu@kernel.org>
Cc: Jiri Kosina <jkosina@suse.cz>
Cc: Kees Cook <keescook@chromium.org>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Michal Marek <michal.lkml@markovi.net>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: linux-kbuild@vger.kernel.org
Cc: srinivas.eeda@oracle.com
Cc: stable <stable@vger.kernel.org>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20181210163725.95977-1-chao.wang@ucloud.cn
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/cpu/bugs.c   |    2 +-
 include/linux/compiler-gcc.h |    2 +-
 include/linux/module.h       |    2 +-
 scripts/mod/modpost.c        |    2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -213,7 +213,7 @@ static enum spectre_v2_mitigation spectr
 static enum spectre_v2_user_mitigation spectre_v2_user __ro_after_init =
 	SPECTRE_V2_USER_NONE;
 
-#ifdef RETPOLINE
+#ifdef CONFIG_RETPOLINE
 static bool spectre_v2_bad_module;
 
 bool retpoline_module_ok(bool has_retpoline)
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -68,7 +68,7 @@
  */
 #define uninitialized_var(x) x = x
 
-#ifdef RETPOLINE
+#ifdef CONFIG_RETPOLINE
 #define __noretpoline __attribute__((__indirect_branch__("keep")))
 #endif
 
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -817,7 +817,7 @@ static inline void module_bug_finalize(c
 static inline void module_bug_cleanup(struct module *mod) {}
 #endif	/* CONFIG_GENERIC_BUG */
 
-#ifdef RETPOLINE
+#ifdef CONFIG_RETPOLINE
 extern bool retpoline_module_ok(bool has_retpoline);
 #else
 static inline bool retpoline_module_ok(bool has_retpoline)
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -2157,7 +2157,7 @@ static void add_intree_flag(struct buffe
 /* Cannot check for assembler */
 static void add_retpoline(struct buffer *b)
 {
-	buf_printf(b, "\n#ifdef RETPOLINE\n");
+	buf_printf(b, "\n#ifdef CONFIG_RETPOLINE\n");
 	buf_printf(b, "MODULE_INFO(retpoline, \"Y\");\n");
 	buf_printf(b, "#endif\n");
 }


