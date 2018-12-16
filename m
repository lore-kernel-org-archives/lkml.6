Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AA1DC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 20:31:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E50B12084A
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 20:31:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="AijvR2uf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730949AbeLPUb0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 15:31:26 -0500
Received: from mail.skyhub.de ([5.9.137.197]:44400 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730772AbeLPUb0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 15:31:26 -0500
Received: from zn.tnic (p200300EC2BE55900158E932065747965.dip0.t-ipconnect.de [IPv6:2003:ec:2be5:5900:158e:9320:6574:7965])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8ADDA1EC0B59;
        Sun, 16 Dec 2018 21:31:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1544992284;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=32nOUmww+vodvB+wVip9dltqYcG/yfF2vY2qh137j6o=;
        b=AijvR2ufuX3JPXKYL8XPfEUiFNNq98CkULGm0ZeC4PYfJcyK15MMns870mG58B/d4Tpjn8
        nGA5KSz8P3uqz4KYM8LAhMLTNCPn9AZSSoiHeORQt5uIg3rtG2+raN23izcaNdBiwS5poJ
        RnT6WOE7WusvBBtHl/8pv2uT/D9p/Bw=
Date:   Sun, 16 Dec 2018 21:31:13 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     kbuild test robot <lkp@intel.com>
Cc:     Chao Fan <fanc.fnst@cn.fujitsu.com>, kbuild-all@01.org,
        linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, keescook@chromium.org,
        bhe@redhat.com, msys.mizuma@gmail.com, indou.takao@jp.fujitsu.com,
        caoj.fnst@cn.fujitsu.com
Subject: Re: [PATCH v13 1/6] x86/boot: Introduce kstrtoull() to boot
 directory instead of simple_strtoull()
Message-ID: <20181216203113.GA23823@zn.tnic>
References: <20181212031053.1815-2-fanc.fnst@cn.fujitsu.com>
 <201812170347.uTJ6Fwb8%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <201812170347.uTJ6Fwb8%fengguang.wu@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2018 at 03:22:39AM +0800, kbuild test robot wrote:
> Hi Chao,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on linus/master]
> [also build test ERROR on v4.20-rc6 next-20181214]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Chao-Fan/x86-boot-KASLR-Parse-ACPI-table-and-limit-KASLR-to-choosing-immovable-memory/20181214-082218
> config: i386-allmodconfig (attached as .config)
> compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=i386 
> 
> All error/warnings (new ones prefixed by >>):
> 
>    In file included from include/linux/kernel.h:207:0,
>                     from arch/x86/boot/string.c:17:
> >> arch/x86/include/asm/div64.h:61:21: error: redefinition of 'div_u64_rem'

Thanks for the report. We need something like this I guess:

---
diff --git a/arch/x86/boot/string.c b/arch/x86/boot/string.c
index 771971efc0d6..4a823481e4e1 100644
--- a/arch/x86/boot/string.c
+++ b/arch/x86/boot/string.c
@@ -191,7 +191,7 @@ char *strchr(const char *s, int c)
 	return (char *)s;
 }
 
-static inline u64 div_u64_rem(u64 dividend, u32 divisor, u32 *remainder)
+static inline u64 __div_u64_rem(u64 dividend, u32 divisor, u32 *remainder)
 {
 	union {
 		u64 v64;
@@ -213,7 +213,7 @@ static inline u64 div_u64_rem(u64 dividend, u32 divisor, u32 *remainder)
 static inline u64 div_u64(u64 dividend, u32 divisor)
 {
 	u32 remainder;
-	return div_u64_rem(dividend, divisor, &remainder);
+	return __div_u64_rem(dividend, divisor, &remainder);
 }
 
 static inline char _tolower(const char c)

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
