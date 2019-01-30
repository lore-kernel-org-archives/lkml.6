Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F1A1C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 11:22:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4E9F20869
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 11:22:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="Ye3LF6A4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730572AbfA3LWn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 06:22:43 -0500
Received: from mail.skyhub.de ([5.9.137.197]:56632 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726548AbfA3LWn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 06:22:43 -0500
Received: from zn.tnic (p200300EC2BCAED00302FA729E39312A6.dip0.t-ipconnect.de [IPv6:2003:ec:2bca:ed00:302f:a729:e393:12a6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 68B351EC0338;
        Wed, 30 Jan 2019 12:22:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1548847361;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=9lKmqgAGQmoy3eXozKvt/n4KgNEfC4DagqCeBEoaWDI=;
        b=Ye3LF6A4mn64bU3Hf0Yyq5CGs9bC/J8MIxlGpFcvciB1BJlFVM9iNRlsg/zebdFw7JEM+D
        NOapPHmsqgwHuQvW8XjafTupogvDUPhVzclPav+zfGP+sa5zWtjSMdToBC2VdtPJM0Yh8z
        AcDvNVTGC7qVaCfCLg6nl1YhtO2sOTA=
Date:   Wed, 30 Jan 2019 12:22:38 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, keescook@chromium.org,
        bhe@redhat.com, msys.mizuma@gmail.com, indou.takao@jp.fujitsu.com,
        caoj.fnst@cn.fujitsu.com, kasong@redhat.com
Subject: [PATCH] x86/boot: Build the command line parsing code
 unconditionally (was: Re: [PATCH v16 0/7] Parse ACPI table and limit KASLR
 to choosing immovable memory)
Message-ID: <20190130112238.GB18383@zn.tnic>
References: <20190123110850.12433-1-fanc.fnst@cn.fujitsu.com>
 <20190128175132.GE20487@zn.tnic>
 <20190130055847.GA17551@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190130055847.GA17551@localhost.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 01:58:47PM +0800, Chao Fan wrote:
> I clone your branch and test some cases. Except the build issue of
> cmdline_find_option(), PATCHSET works well.
> Build in x86_64 and i386.
> Tested EFI/BIOS environment in x86_64 and BIOS environment in i386.
> Tested the 'acpi_rsdp=' and 'boot_params->acpi_rsdp_addr' issue, all
> work well.

Thanks.

Here's a fix for the build issue below, pushing a new branch.

---
From: Borislav Petkov <bp@suse.de>
Subject: [PATCH] x86/boot: Build the command line parsing code unconditionally

Just drop the three-item ifdeffery and build it in unconditionally.
Early cmdline parsing is needed more often than not.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: x86@kernel.org
---
 arch/x86/boot/compressed/cmdline.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/x86/boot/compressed/cmdline.c b/arch/x86/boot/compressed/cmdline.c
index af6cda0b7900..f1add5d85da9 100644
--- a/arch/x86/boot/compressed/cmdline.c
+++ b/arch/x86/boot/compressed/cmdline.c
@@ -1,8 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "misc.h"
 
-#if CONFIG_EARLY_PRINTK || CONFIG_RANDOMIZE_BASE || CONFIG_X86_5LEVEL
-
 static unsigned long fs;
 static inline void set_fs(unsigned long seg)
 {
@@ -30,5 +28,3 @@ int cmdline_find_option_bool(const char *option)
 {
 	return __cmdline_find_option_bool(get_cmd_line_ptr(), option);
 }
-
-#endif
-- 
2.19.1

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
