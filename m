Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F6F6C43441
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 23:53:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E069820855
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 23:53:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E069820855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727656AbeKIJa6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 04:30:58 -0500
Received: from mail.skyhub.de ([5.9.137.197]:33266 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727016AbeKIJa6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 04:30:58 -0500
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id fNVI4CNEJSxL; Fri,  9 Nov 2018 00:52:59 +0100 (CET)
Received: from zn.tnic (p200300EC2BD03D00329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bd0:3d00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 060FD1EC026E;
        Fri,  9 Nov 2018 00:52:59 +0100 (CET)
Date:   Fri, 9 Nov 2018 00:52:44 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Balbir Singh <bsingharora@gmail.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>
Subject: Re: [PATCH v5 04/27] x86/fpu/xstate: Add XSAVES system states for
 shadow stack
Message-ID: <20181108235244.GK7543@zn.tnic>
References: <20181011151523.27101-1-yu-cheng.yu@intel.com>
 <20181011151523.27101-5-yu-cheng.yu@intel.com>
 <20181108184038.GJ7543@zn.tnic>
 <bb049aa9578bae7cfc6bd7c05b540f033f6685cc.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bb049aa9578bae7cfc6bd7c05b540f033f6685cc.camel@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 08, 2018 at 12:40:02PM -0800, Yu-cheng Yu wrote:
> In fpu_init_system_xstate(), we test and clear features that are not enabled.
> There we depend on the order of these elements.  This is the tenth "unknown
> xstate feature".

Aha, those are *reserved* bits - not unused, in XCR0.

Do an s/unused/reserved/g pls.

Now let's see, you have 0 for the 10th bit which happens to be

#define X86_FEATURE_FPU                 ( 0*32+ 0) /* Onboard FPU */

too. And if we look at the code:

        for (i = 0; i < ARRAY_SIZE(xsave_cpuid_features); i++) {
                if (!boot_cpu_has(xsave_cpuid_features[i]))
                        xfeatures_mask_all &= ~BIT_ULL(i);

guess what happens if i == 10.

I know, the subsequent & SUPPORTED_XFEATURES_MASK saves you from the
#GP but that's still not good enough. The loop should not even call
boot_cpu_has() for reserved feature bits.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
