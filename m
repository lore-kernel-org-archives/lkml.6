Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751515AbeCTRAP (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 13:00:15 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:59501 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751186AbeCTRAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 13:00:14 -0400
Date: Tue, 20 Mar 2018 14:00:03 -0300
From: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
To: Yonghong Song <yhs@fb.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH] test_bpf: Fix testing with CONFIG_BPF_JIT_ALWAYS_ON=y on
 other arches
Message-ID: <20180320170001.GC3632@calabresa>
References: <20180320125851.19650-1-cascardo@canonical.com>
 <4a497245-1864-3036-074e-107134e4b9b5@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a497245-1864-3036-074e-107134e4b9b5@fb.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 20, 2018 at 09:05:15AM -0700, Yonghong Song wrote:
> 
> 
> On 3/20/18 5:58 AM, Thadeu Lima de Souza Cascardo wrote:
> > Function bpf_fill_maxinsns11 is designed to not be able to be JITed on
> > x86_64. So, it fails when CONFIG_BPF_JIT_ALWAYS_ON=y, and
> > commit 09584b406742 ("bpf: fix selftests/bpf test_kmod.sh failure when
> > CONFIG_BPF_JIT_ALWAYS_ON=y") makes sure that failure is detected on that
> > case.
> > 
> > However, it does not fail on other architectures, which have a different
> > JIT compiler design. So, test_bpf has started to fail to load on those.
> 
> Here, you mentioned that it did not fail on other architectures. Have you
> verified all of them or just looked through the algorithm.

>From our testing, I know at least I get an UNEXPECTED_PASS on arm64, arm, s390x
and ppc64le. i386 doesn't have JIT, so it doesn't have
CONFIG_BPF_JIT_ALWAYS_ON=y.

> 
> Could you give a little bit details about other architectures are okay while
> x86 is not? Maybe, x86 JIT can be improved some how?

As the comment on that functions says:

        /* Hits 70 passes on x86_64, so cannot get JITed there. */

And looking at x86_64 JIT compiler, you will notice it's looping trying to
minimize the size of the code, limited to 10 passes. If it does not converge,
it goes back to the non-JIT code.

That's not the case on powerpc or arm, that do not do multiple passes. sparc
seem to do 3 passes, but does not seem to go back to non-JIT code.

Cascardo.

> 
> Thanks!
> 
> > 
> > After this fix, test_bpf loads fine on both x86_64 and ppc64el.
> > 
> > Fixes: 09584b406742 ("bpf: fix selftests/bpf test_kmod.sh failure when CONFIG_BPF_JIT_ALWAYS_ON=y")
> > Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
> > ---
> >   lib/test_bpf.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/lib/test_bpf.c b/lib/test_bpf.c
> > index 2efb213716faa..3e9335493fe49 100644
> > --- a/lib/test_bpf.c
> > +++ b/lib/test_bpf.c
> > @@ -5467,7 +5467,7 @@ static struct bpf_test tests[] = {
> >   	{
> >   		"BPF_MAXINSNS: Jump, gap, jump, ...",
> >   		{ },
> > -#ifdef CONFIG_BPF_JIT_ALWAYS_ON
> > +#if defined(CONFIG_BPF_JIT_ALWAYS_ON) && defined(CONFIG_X86)
> >   		CLASSIC | FLAG_NO_DATA | FLAG_EXPECTED_FAIL,
> >   #else
> >   		CLASSIC | FLAG_NO_DATA,
> > 
