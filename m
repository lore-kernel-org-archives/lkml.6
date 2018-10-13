Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D87E0C28CF8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 21:21:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CA5420693
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 21:21:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CA5420693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ispras.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbeJNE7T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 00:59:19 -0400
Received: from bran.ispras.ru ([83.149.199.196]:23789 "EHLO smtp.ispras.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725734AbeJNE7S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 00:59:18 -0400
X-Greylist: delayed 395 seconds by postgrey-1.27 at vger.kernel.org; Sun, 14 Oct 2018 00:59:18 EDT
Received: from monopod.intra.ispras.ru (monopod.intra.ispras.ru [10.10.3.121])
        by smtp.ispras.ru (Postfix) with ESMTP id 51A00203CD;
        Sun, 14 Oct 2018 00:14:02 +0300 (MSK)
Date:   Sun, 14 Oct 2018 00:14:02 +0300 (MSK)
From:   Alexander Monakov <amonakov@ispras.ru>
To:     Borislav Petkov <bp@alien8.de>
cc:     Segher Boessenkool <segher@kernel.crashing.org>,
        Ingo Molnar <mingo@kernel.org>,
        Richard Biener <rguenther@suse.de>,
        Michael Matz <matz@suse.de>, gcc@gcc.gnu.org,
        Nadav Amit <namit@vmware.com>, Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Alok Kataria <akataria@vmware.com>,
        Christopher Li <sparse@chrisli.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Jan Beulich <JBeulich@suse.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        linux-sparse@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        virtualization@lists.linux-foundation.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: PROPOSAL: Extend inline asm syntax with size spec
In-Reply-To: <20181013193335.GD31650@zn.tnic>
Message-ID: <alpine.LNX.2.20.13.1810132355180.13914@monopod.intra.ispras.ru>
References: <alpine.LSU.2.21.1810071534220.7867@wotan.suse.de> <20181008073128.GL29268@gate.crashing.org> <alpine.LSU.2.20.1810081105350.16707@zhemvz.fhfr.qr> <20181009145330.GT29268@gate.crashing.org> <alpine.LSU.2.20.1810100909140.16707@zhemvz.fhfr.qr>
 <20181010072240.GB103159@gmail.com> <20181010080324.GV29268@gate.crashing.org> <20181010081906.GA5533@zn.tnic> <20181010185432.GB29268@gate.crashing.org> <20181010191427.GF5533@zn.tnic> <20181013193335.GD31650@zn.tnic>
User-Agent: Alpine 2.20.13 (LNX 116 2015-12-14)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 13 Oct 2018, Borislav Petkov wrote:
> 
> Thoughts, suggestions, etc are most welcome.

I apologize for coming in late here with an alternative proposal, but would
you be happy if GCC gave you a way to designate a portion of the asm template
string that shouldn't be counted as its cost because it doesn't go into the
.text section? This wouldn't interact with your redefinitions of the inline
keyword, and you could do something like (assuming we go with %` ... %`
delimiters)

[if gcc-9 or compatible]

#define ASM_NONTEXT_START "%`\n"
#define ASM_NONTEXT_END   "%`\n"

[else]

#define ASM_NONTEXT_START "\n"
#define ASM_NONTEXT_END   "\n"

[endif]

#define _BUG_FLAGS(ins, flags)						\
do {									\
	asm volatile("1:\t" ins "\n"					\
	             ASM_NONTEXT_START                                  \
		     ".pushsection __bug_table,\"aw\"\n"		\
		     "2:\t" __BUG_REL(1b) "\t# bug_entry::bug_addr\n"	\
		     "\t.word %c0"        "\t# bug_entry::flags\n"	\
		     "\t.org 2b+%c1\n"					\
		     ".popsection"					\
	             ASM_NONTEXT_END                                    \
		     : : "i" (flags),					\
			 "i" (sizeof(struct bug_entry)));		\
} while (0)


I think it's nicer because it also allows the compiler to estimate asm length
for branch range optimization more accurately.

Alexander
