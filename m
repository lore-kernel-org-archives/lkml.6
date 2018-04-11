Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753612AbeDKRKQ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 13:10:16 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:41707 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752981AbeDKRKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 13:10:14 -0400
X-Google-Smtp-Source: AIpwx48EUqgl1t7YHgnVVs1ftZZFlTBQBMezUS/1cqm5E8ZbjrAWz/V/LOkl/1zNfBoqaUt/KS90qJpsjW3v5rBdFas=
MIME-Version: 1.0
In-Reply-To: <2186798.qrgUIDAn9S@positron.chronox.de>
References: <001a114467482dbc4b05692df8f9@google.com> <2704286.80iLvC0rRL@tauon.chronox.de>
 <CACT4Y+bRmYMt3WuVHE7e624KgRUTXQWa36wn-pr_gm2STq80bQ@mail.gmail.com> <2186798.qrgUIDAn9S@positron.chronox.de>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Wed, 11 Apr 2018 19:09:53 +0200
Message-ID: <CACT4Y+ZxumagMiZTFwzX2e_tdd4U862BzgzHVDsiOACbMXEh_A@mail.gmail.com>
Subject: Re: [PATCH] crypto: DRBG - guard uninstantion by lock
To: =?UTF-8?Q?Stephan_M=C3=BCller?= <smueller@chronox.de>
Cc: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        David Miller <davem@davemloft.net>, linux-crypto@vger.kernel.org,
        Eric Biggers <ebiggers3@gmail.com>,
        syzbot <syzbot+75397ee3df5c70164154@syzkaller.appspotmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3BHANaa003570

On Wed, Apr 11, 2018 at 4:26 PM, Stephan Müller <smueller@chronox.de> wrote:
> Hi Dimitry,
>
> This fix prevents the kernel from crashing when injecting the fault.

Good!

> Stack traces are yet shown but I guess that is expected every time
> a fault is injected.

Yes, nothing to fix here.

> As to why KASAN did not notice this one, I am not sure. Maybe it is
> because I use two buffer pointers to point to (almost) the same memory
> (one that is aligned and one pointing to the complete buffer)?

After looking at the fix, I figured out what happened with KASAN.
Filed https://bugzilla.kernel.org/show_bug.cgi?id=199359. In short,
tricky interplay between kzfree, ksize and double-free detection.
If KASAN worked as intended it would give a nice "double-free in this
stack for object allocated in this stack and previously freed in this
stack", which would probably make debugging much simpler.


> ---8<---
>
> During freeing of the internal buffers used by the DRBG, set the pointer
> to NULL. It is possible that the context with the freed buffers is
> reused. In case of an error during initialization where the pointers
> do not yet point to allocated memory, the NULL value prevents a double
> free.
>
> Signed-off-by: Stephan Mueller <smueller@chronox.de>
> Reported-by: syzbot+75397ee3df5c70164154@syzkaller.appspotmail.com
> ---
>  crypto/drbg.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/crypto/drbg.c b/crypto/drbg.c
> index 4faa2781c964..466a112a4446 100644
> --- a/crypto/drbg.c
> +++ b/crypto/drbg.c
> @@ -1134,8 +1134,10 @@ static inline void drbg_dealloc_state(struct drbg_state *drbg)
>         if (!drbg)
>                 return;
>         kzfree(drbg->Vbuf);
> +       drbg->Vbuf = NULL;
>         drbg->V = NULL;
>         kzfree(drbg->Cbuf);
> +       drbg->Cbuf = NULL;
>         drbg->C = NULL;
>         kzfree(drbg->scratchpadbuf);
>         drbg->scratchpadbuf = NULL;
> --
> 2.14.3
>
>
>
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/2186798.qrgUIDAn9S%40positron.chronox.de.
> For more options, visit https://groups.google.com/d/optout.
