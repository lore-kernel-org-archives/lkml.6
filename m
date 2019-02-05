Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97334C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 13:14:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EF01206DD
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 13:14:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="LNICGdh+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729323AbfBENOA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 08:14:00 -0500
Received: from mail.skyhub.de ([5.9.137.197]:56708 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726098AbfBENOA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 08:14:00 -0500
Received: from zn.tnic (p200300EC2BCB6B00213B35D40B3412ED.dip0.t-ipconnect.de [IPv6:2003:ec:2bcb:6b00:213b:35d4:b34:12ed])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6FA8D1EC0A8F;
        Tue,  5 Feb 2019 14:13:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1549372438;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fMxkUDkPKCiEHHBpknBTTTbFtqDhskKmJ6Kbp/u4RrQ=;
        b=LNICGdh+RMVBOalG7aj3z1o5tKVEou3YHQCQgjQ8Y80rcGUzXcCX/cHJ9LfxkyFhLYucJF
        5+cH1p8kgxzsAOlE2s0cfg++iSCu+UdPbc33XizOV0kpMuO9d8WGZfTm8HwUWxEFKzqr5t
        h8rCWsRAMgmwxsCG05gWDC1kYOPjDAc=
Date:   Tue, 5 Feb 2019 14:13:53 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     kbuild test robot <lkp@intel.com>
Cc:     Chao Fan <fanc.fnst@cn.fujitsu.com>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86/boot: Fix cmdline_find_option() prototype visibility
Message-ID: <20190205131352.GA27396@zn.tnic>
References: <5c51daf0.83pQEkvDZILqoSYW%lkp@intel.com>
 <20190130172019.GD21221@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190130172019.GD21221@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 06:20:19PM +0100, Borislav Petkov wrote:
> On Thu, Jan 31, 2019 at 01:12:16AM +0800, kbuild test robot wrote:
> > tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bp/bp.git  tip-x86-boot
> > branch HEAD: 593ab2163e72a9697814dbca7247928a2bbb8b49  x86/boot/KASLR: Limit KASLR to extract the kernel in immovable memory only
> > 
> > Regressions in current branch:
> > 
> > arch/x86/boot/compressed/acpi.c:37:8: warning: implicit declaration of function 'cmdline_find_option' [-Wimplicit-function-declaration]
> > 
> > Error ids grouped by kconfigs:
> > 
> > recent_errors
> > └── x86_64-randconfig-s4-01290430
> 
> I got a report this morning about x86_64-randconfig-g1-01290904 which I
> already fixed.
> 
> Which config is that x86_64-randconfig-s4-01290430?

Ok, I was able to trigger it. The below should fix it:

---
From: Borislav Petkov <bp@suse.de>
Subject: [PATCH] x86/boot: Fix cmdline_find_option() prototype visibility
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

  ac09c5f43cf6 ("x86/boot: Build the command line parsing code unconditionally")

enabled building the command line parsing code unconditionally but it
forgot to remove the respected ifdeffery around the prototypes in the
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
-- 
2.19.1

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
