Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758949AbeD0RAO (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 13:00:14 -0400
Received: from mail.skyhub.de ([5.9.137.197]:50982 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758851AbeD0RAM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 13:00:12 -0400
Date: Fri, 27 Apr 2018 18:59:39 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Dmitry Vyukov <dvyukov@google.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>, linux-edac@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86, mce: Fix stack out-of-bounds write in
 mce-inject.c:flags_read()
Message-ID: <20180427165939.GG15229@pd.tnic>
References: <CACT4Y+Ys9bKFNaBm7YuCvk04jcZ2SnLiDSxgCojZMwtb2PKVBg@mail.gmail.com>
 <20180427154115.GF15229@pd.tnic>
 <CACT4Y+bptixoADW1cLtJzbJcHfmEAuLyBSnK9txb6u69fZ3n6w@mail.gmail.com>
 <20180427163707.ktaiysvbk3yhk4wm@agluck-desk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180427163707.ktaiysvbk3yhk4wm@agluck-desk>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 27, 2018 at 09:37:08AM -0700, Luck, Tony wrote:
> Each of the strings that we want to put into the buf[MAX_FLAG_OPT_SIZE]
> in flags_read() is two characters. But the sprintf() adds a trailing newline
> and will add a terminating NUL byte. So MAX_FLAG_OPT_SIZE needs to be 4.

... and I dumped the n here:

	n = sprintf(buf, "%s\n", flags_options[inj_type])

and it was 3 but sprintf() calls vsnprintf() and *that* does return:

" * The return value is the number of characters which would
 * be generated for the given input, excluding the trailing
 * '\0', as per ISO C99."

So I'll extend the commit message with that and apply it.

Thanks.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
