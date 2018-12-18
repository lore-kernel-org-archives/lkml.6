Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9BCFC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 23:26:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7590F217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 23:26:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727997AbeLRX0h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 18:26:37 -0500
Received: from mga03.intel.com ([134.134.136.65]:1157 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727639AbeLRX0h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 18:26:37 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Dec 2018 15:26:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,370,1539673200"; 
   d="scan'208";a="110495523"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by fmsmga008.fm.intel.com with ESMTP; 18 Dec 2018 15:26:36 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 30519300B49; Tue, 18 Dec 2018 15:26:36 -0800 (PST)
Date:   Tue, 18 Dec 2018 15:26:36 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Martin Jambor <mjambor@suse.cz>, Miroslav Benes <mbenes@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: objtool warnings for kernel/trace/trace_selftest_dynamic.o
Message-ID: <20181218232636.GM25620@tassilo.jf.intel.com>
References: <20181217213126.lsqhyszoulel6uq6@treble>
 <20181217173644.391c2070@gandalf.local.home>
 <20181218000618.GA25620@tassilo.jf.intel.com>
 <20181218024916.vmfnyqzouhfxhyvc@treble>
 <alpine.LSU.2.21.1812181022570.9644@pobox.suse.cz>
 <ri6h8fbqbdf.fsf@suse.cz>
 <20181218211501.GD25620@tassilo.jf.intel.com>
 <20181218165713.4309797a@gandalf.local.home>
 <20181218221338.GK25620@tassilo.jf.intel.com>
 <20181218171620.365c1c51@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181218171620.365c1c51@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 05:16:20PM -0500, Steven Rostedt wrote:
> On Tue, 18 Dec 2018 14:13:38 -0800
> Andi Kleen <ak@linux.intel.com> wrote:
> 
> > > Again, that's not the ftrace case. It doesn't care about more than one
> > > out of line instance. Thus, for this particular use, "used" should be
> > > good enough.  
> > 
> > You mean noinline used? 
> 
> I thought that someone said that "used" would also prevent inlining.

that's not correct. You need noinline

-Andi

[ak@tassilo tsrc]$ cat tinline.c

int i;

inline __attribute__((used)) int finline(void)
{
        i++;
}


main()
{
        finline();
}

[ak@tassilo tsrc]$ gcc -O2 -S tinline.c
tinline.c:10:1: warning: return type defaults to ‘int’ [-Wimplicit-int]
 main()
 ^~~~
[ak@tassilo tsrc]$
[ak@tassilo tsrc]$ cat tinline.s
        .file   "tinline.c"
        .text
        .section        .text.startup,"ax",@progbits
        .p2align 4,,15
        .globl  main
        .type   main, @function
main:
.LFB1:
        .cfi_startproc
        addl    $1, i(%rip)
        xorl    %eax, %eax
        ret
        .cfi_endproc
.LFE1:
        .size   main, .-main
        .comm   i,4,4
        .ident  "GCC: (GNU) 8.2.1 20181105 (Red Hat 8.2.1-5)"
        .section        .note.GNU-stack,"",@progbits
[ak@tassilo tsrc]$




