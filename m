Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2914C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 23:35:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E2FB208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 23:35:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="U8nMJ3bk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E2FB208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727839AbeK0Kbj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 05:31:39 -0500
Received: from sonic309-48.consmr.mail.ne1.yahoo.com ([66.163.184.174]:42552
        "EHLO sonic309-48.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727456AbeK0Kbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 05:31:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1543275349; bh=HQoavzPoUgtaN9gOCWKpLaU9vTUnkapJ2x/zqvAbtZs=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=U8nMJ3bkt4M2GxgbIS4IJT1IOq/V9xh2RpEyQ9xpCJz9MhAgOFNVTku8/nzza2n+J2GU9EZe+DXNhPECZz4slfugYt9F4RU3wWjpT+XcycFNFNSX170Z5o1wd4PvJ7BBdkQkQyePL8TO3ctj1KwvLRXeOKw4/30t/ijKHxh7QXRlDGwLsEcXS2EHiwtYuxQvp3a56Uwsb/g1DQ7IMDAoZn5UedOsPSw7R26kV0Up2+/DbXQEbn1Brs+ckkBTFwGR6bv/Dk9nNO7RH4sLPHFibwn3WHYBsLlBvC7YZv4W+JOSKA77vnRJoBX0rDBTblvZHYhTi8IMSWkcPfZJDQ+Khg==
X-YMail-OSG: UKSUkGAVM1l9sRpN7q3tqu_Y4K48kAK8mvREIdnDAoQqTDQwAAbkGtOsjTuM_3_
 krv8x0a9OKg--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Mon, 26 Nov 2018 23:35:49 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.105]) ([67.169.65.224])
          by smtp420.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 3f9402b8f658487cba525e8eec926514;
          Mon, 26 Nov 2018 23:31:47 +0000 (UTC)
Subject: [PATCH v5 07/38] LSM: Introduce "lsm=" for boottime LSM selection
To:     James Morris <jmorris@namei.org>,
        LSM <linux-security-module@vger.kernel.org>,
        LKLM <linux-kernel@vger.kernel.org>,
        SE Linux <selinux@tycho.nsa.gov>
Cc:     John Johansen <john.johansen@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Paul Moore <paul@paul-moore.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>,
        Salvatore Mesoraca <s.mesoraca16@gmail.com>
References: <50db058a-7dde-441b-a7f9-f6837fe8b69f@schaufler-ca.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <3003d07a-61dc-e997-2814-50ad27930b9d@schaufler-ca.com>
Date:   Mon, 26 Nov 2018 15:31:44 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <50db058a-7dde-441b-a7f9-f6837fe8b69f@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide a way to explicitly choose LSM initialization order via the new
"lsm=" comma-separated list of LSMs.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 Documentation/admin-guide/kernel-parameters.txt |  4 ++++
 security/Kconfig                                |  3 ++-
 security/security.c                             | 14 +++++++++++++-
 3 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 81d1d5a74728..ea33bcbaecb2 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2302,6 +2302,10 @@
 
 	lsm.debug	[SECURITY] Enable LSM initialization debugging output.
 
+	lsm=lsm1,...,lsmN
+			[SECURITY] Choose order of LSM initialization. This
+			overrides CONFIG_LSM.
+
 	machvec=	[IA-64] Force the use of a particular machine-vector
 			(machvec) in a generic kernel.
 			Example: machvec=hpzx1_swiotlb
diff --git a/security/Kconfig b/security/Kconfig
index 7de42bbacc28..41aa0be6142f 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -281,7 +281,8 @@ config LSM
 	default "integrity"
 	help
 	  A comma-separated list of LSMs, in initialization order.
-	  Any LSMs left off this list will be ignored.
+	  Any LSMs left off this list will be ignored. This can be
+	  controlled at boot with the "lsm=" parameter.
 
 	  If unsure, leave this as the default.
 
diff --git a/security/security.c b/security/security.c
index 96e0b7d057b0..38fc436e8b4b 100644
--- a/security/security.c
+++ b/security/security.c
@@ -47,6 +47,7 @@ char *lsm_names;
 /* Boot-time LSM user choice */
 static __initdata char chosen_lsm[SECURITY_NAME_MAX + 1] =
 	CONFIG_DEFAULT_SECURITY;
+static __initdata const char *chosen_lsm_order;
 
 static __initconst const char * const builtin_lsm_order = CONFIG_LSM;
 
@@ -190,7 +191,10 @@ static void __init ordered_lsm_init(void)
 	ordered_lsms = kcalloc(LSM_COUNT + 1, sizeof(*ordered_lsms),
 				GFP_KERNEL);
 
-	ordered_lsm_parse(builtin_lsm_order, "builtin");
+	if (chosen_lsm_order)
+		ordered_lsm_parse(chosen_lsm_order, "cmdline");
+	else
+		ordered_lsm_parse(builtin_lsm_order, "builtin");
 
 	for (lsm = ordered_lsms; *lsm; lsm++)
 		maybe_initialize_lsm(*lsm);
@@ -252,6 +256,14 @@ static int __init choose_lsm(char *str)
 }
 __setup("security=", choose_lsm);
 
+/* Explicitly choose LSM initialization order. */
+static int __init choose_lsm_order(char *str)
+{
+	chosen_lsm_order = str;
+	return 1;
+}
+__setup("lsm=", choose_lsm_order);
+
 /* Enable LSM order debugging. */
 static int __init enable_debug(char *str)
 {
-- 
2.14.5


