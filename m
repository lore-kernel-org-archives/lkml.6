Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E05F2C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 10:56:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBD9E218A4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 10:56:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbfBFK4Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 05:56:16 -0500
Received: from terminus.zytor.com ([198.137.202.136]:33569 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726957AbfBFK4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 05:56:15 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x16AtZZI1258043
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 6 Feb 2019 02:55:36 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x16AtZet1258040;
        Wed, 6 Feb 2019 02:55:35 -0800
Date:   Wed, 6 Feb 2019 02:55:35 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Borislav Petkov <tipbot@zytor.com>
Message-ID: <tip-82f9ed3a93307089242ff8a5c694e82c8c93f522@git.kernel.org>
Cc:     hpa@zytor.com, tglx@linutronix.de, mingo@kernel.org, bp@suse.de,
        fanc.fnst@cn.fujitsu.com, linux-kernel@vger.kernel.org,
        lkp@intel.com
Reply-To: lkp@intel.com, hpa@zytor.com, tglx@linutronix.de,
          mingo@kernel.org, bp@suse.de, fanc.fnst@cn.fujitsu.com,
          linux-kernel@vger.kernel.org
In-Reply-To: <20190205131352.GA27396@zn.tnic>
References: <5c51daf0.83pQEkvDZILqoSYW%lkp@intel.com>
        <20190205131352.GA27396@zn.tnic>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/boot] x86/boot: Fix cmdline_find_option() prototype
 visibility
Git-Commit-ID: 82f9ed3a93307089242ff8a5c694e82c8c93f522
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  82f9ed3a93307089242ff8a5c694e82c8c93f522
Gitweb:     https://git.kernel.org/tip/82f9ed3a93307089242ff8a5c694e82c8c93f522
Author:     Borislav Petkov <bp@suse.de>
AuthorDate: Tue, 5 Feb 2019 12:05:45 +0100
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Wed, 6 Feb 2019 11:41:21 +0100

x86/boot: Fix cmdline_find_option() prototype visibility

  ac09c5f43cf6 ("x86/boot: Build the command line parsing code unconditionally")

enabled building the command line parsing code unconditionally but it
forgot to remove the respective ifdeffery around the prototypes in the
misc.h header, leading to

  arch/x86/boot/compressed/acpi.c: In function ‘get_acpi_rsdp’:
  arch/x86/boot/compressed/acpi.c:37:8: warning: implicit declaration of function \
	  ‘cmdline_find_option’ [-Wimplicit-function-declaration]
    ret = cmdline_find_option("acpi_rsdp", val, MAX_ADDR_LEN);
          ^~~~~~~~~~~~~~~~~~~

for configs where neither CONFIG_EARLY_PRINTK nor CONFIG_RANDOMIZE_BASE
was defined.

Drop the ifdeffery in the header too.

Fixes: ac09c5f43cf6 ("x86/boot: Build the command line parsing code unconditionally")
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc: x86@kernel.org
Link: https://lkml.kernel.org/r/5c51daf0.83pQEkvDZILqoSYW%lkp@intel.com
Link: https://lkml.kernel.org/r/20190205131352.GA27396@zn.tnic
---
 arch/x86/boot/compressed/misc.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index 19e8231a6fd6..5b8d51996cdd 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -66,11 +66,9 @@ static inline void debug_puthex(const char *s)
 
 #endif
 
-#if CONFIG_EARLY_PRINTK || CONFIG_RANDOMIZE_BASE
 /* cmdline.c */
 int cmdline_find_option(const char *option, char *buffer, int bufsize);
 int cmdline_find_option_bool(const char *option);
-#endif
 
 struct mem_vector {
 	unsigned long long start;
