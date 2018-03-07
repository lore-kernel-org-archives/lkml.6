Return-Path: <paullawrence@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520460135; cv=none;
        d=google.com; s=arc-20160816;
        b=pgP/m3nvkPA7o90wmS0aDoRXMtJTtfOgzQTmX2NZIYbWL41oiQYDkbmpP5MSF1Ntxi
         Pn98i/X4tdZO25ISO//LEaYJAaxN/zPIr3dxLAIbm3NaOEtkScsyPMIptuRnAYbamYbE
         CkfgsN3DPUsDz3bpyK1XafMb7UWvW2HVlizMmFjr2F4EJ2bGYOYWw8pea/61EoVPcatz
         yxRnAzhRUe23tmDjnXzhMAwuSozEtSOUOoAa50/g622Z9MEUkFibWGTUQ5hXWcJUqmEU
         QMXTbN1g+PUhK//eSS4+cmvcZc9quS3Xq1SSo5ULmMyhVM7zx96EOXAIBqMFrs5CaJc/
         XAFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=gP/d1m4uoSjOZq3dhqVGZ7IkZ1BjuJaEOZr4guT1OKM=;
        b=rpi9T0z++irLbpjbpmAczBzPr9WBqTVss9CbDEjZyfK+hyvgJaPCSJOJC40MGBH4Pv
         f8Elxia42xq+3uolge35AsFB1XwRZL9X20MPqMpp6thwtqB2qYxnY5NNdp6fYw4Q0sS0
         Znw/yYKBNAzwitr/WsKlWGVkzJaNRl3zkxniGcXBCl1uLWtGADHWU8g7W32xkHcxw7Jg
         C6xxn/dzEoDJ0W1JqbZC4hosnpN+GBfvF0VgO0R3TTwyl8g2qmhHR6KvAGjTsV4UltCC
         Ak4DpOV1p9G9SdLOJ3jHDvAtpvbZ3bYfmZtPGDptoFRZx8pZ6AF0YTjxRTZbM6pNgW33
         X5yg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=BHxdJo33;
       spf=pass (google.com: domain of paullawrence@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=paullawrence@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=BHxdJo33;
       spf=pass (google.com: domain of paullawrence@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=paullawrence@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AG47ELuP0DpyK9zVgrXS1YogE4N+ezhRPwEm90W/VP/8A8oCA/v+qibpKFUClc0A/w4dAXcJrYcuWA6yQ6GHTkAkDTI=
MIME-Version: 1.0
In-Reply-To: <20180307214829.GA15587@flashbox>
References: <20180307214042.135109-1-paullawrence@google.com> <20180307214829.GA15587@flashbox>
From: Paul Lawrence <paullawrence@google.com>
Date: Wed, 7 Mar 2018 14:02:13 -0800
Message-ID: <CAL=UVf7Y0Ga869u66xi0EumQAkULAP0fWf9O69Z0vYJ9G5gmcA@mail.gmail.com>
Subject: Re: [PATCH] staging: android: ashmem: Remove deadlock
To: Nathan Chancellor <natechancellor@gmail.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Ben Hutchings <ben@decadent.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	=?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, devel@driverdev.osuosl.org
Content-Type: multipart/alternative; boundary="94eb2c064b70375d8f0566d9b6e6"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594316660298021299?=
X-GMAIL-MSGID: =?utf-8?q?1594318007997306865?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--94eb2c064b70375d8f0566d9b6e6
Content-Type: text/plain; charset="UTF-8"

Great! We need to make sure this gets backported to 4.4 and 4.9, and to
3.18 with the original dependency, please.

Thanks,

Paul

On Wed, Mar 7, 2018 at 1:48 PM, Nathan Chancellor <natechancellor@gmail.com>
wrote:

> On Wed, Mar 07, 2018 at 01:40:30PM -0800, Paul Lawrence wrote:
> > Regression introduced in commit ce8a3a9e76d0193e2e8d74a06d275b3c324ca652
> > ("staging: android: ashmem: Fix a race condition in pin ioctls")
> > causing deadlock.
> >
> > No need to hold ashmem_mutex while copying from user
> >
> > Stacks are:
> >
> > ashmem_mmap+0x53/0x400 drivers/staging/android/ashmem.c:379
> > mmap_region+0x7dd/0xfd0 mm/mmap.c:1694
> > do_mmap+0x57b/0xbe0 mm/mmap.c:1473
> >
> > and
> >
> > lock_acquire+0x12e/0x410 kernel/locking/lockdep.c:3756
> > __might_fault+0x14a/0x1d0 mm/memory.c:4014
> > copy_from_user arch/x86/include/asm/uaccess.h:705 [inline]
> > ashmem_pin_unpin drivers/staging/android/ashmem.c:719 [inline]
> >
> > Signed-off-by: Paul Lawrence <paullawrence@google.com>
> > Cc: <stable@vger.kernel.org> # 4.9.x
> > Cc: <stable@vger.kernel.org> # 4.4.x
> > Cc: <stable@vger.kernel.org> # 3.18.x: ce8a3a9e76d01
> > Cc: <stable@vger.kernel.org> # 3.18.x
> > Cc: Ben Hutchings <ben@decadent.org.uk>
> > ---
> >  drivers/staging/android/ashmem.c | 8 +++-----
> >  1 file changed, 3 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/staging/android/ashmem.c b/drivers/staging/android/
> ashmem.c
> > index 6dbba5aff191..8c55706c2cfa 100644
> > --- a/drivers/staging/android/ashmem.c
> > +++ b/drivers/staging/android/ashmem.c
> > @@ -702,16 +702,14 @@ static int ashmem_pin_unpin(struct ashmem_area
> *asma, unsigned long cmd,
> >       size_t pgstart, pgend;
> >       int ret = -EINVAL;
> >
> > +     if (unlikely(copy_from_user(&pin, p, sizeof(pin))))
> > +             return -EFAULT;
> > +
> >       mutex_lock(&ashmem_mutex);
> >
> >       if (unlikely(!asma->file))
> >               goto out_unlock;
> >
> > -     if (unlikely(copy_from_user(&pin, p, sizeof(pin)))) {
> > -             ret = -EFAULT;
> > -             goto out_unlock;
> > -     }
> > -
> >       /* per custom, you can pass zero for len to mean "everything
> onward" */
> >       if (!pin.len)
> >               pin.len = PAGE_ALIGN(asma->size) - pin.offset;
> > --
> > 2.16.2.395.g2e18187dfd-goog
> >
>
> Hey Paul,
>
> Looks like this same patch is already in Greg's tree:
> https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/
> staging.git/commit/?id=740a5759bf222332fbb5eda42f89aa25ba38f9b2
>
> Cheers!
> Nathan Chancellor
>

--94eb2c064b70375d8f0566d9b6e6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:tahoma,s=
ans-serif;font-size:small">Great! We need to make sure this gets backported=
 to 4.4 and 4.9, and to 3.18 with the original dependency, please.</div><di=
v class=3D"gmail_default" style=3D"font-family:tahoma,sans-serif;font-size:=
small"><br></div><div class=3D"gmail_default" style=3D"font-family:tahoma,s=
ans-serif;font-size:small">Thanks,</div><div class=3D"gmail_default" style=
=3D"font-family:tahoma,sans-serif;font-size:small"><br></div><div class=3D"=
gmail_default" style=3D"font-family:tahoma,sans-serif;font-size:small">Paul=
</div></div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On We=
d, Mar 7, 2018 at 1:48 PM, Nathan Chancellor <span dir=3D"ltr">&lt;<a href=
=3D"mailto:natechancellor@gmail.com" target=3D"_blank">natechancellor@gmail=
.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div class=3D"=
HOEnZb"><div class=3D"h5">On Wed, Mar 07, 2018 at 01:40:30PM -0800, Paul La=
wrence wrote:<br>
&gt; Regression introduced in commit ce8a3a9e76d0193e2e8d74a06d275b<wbr>3c3=
24ca652<br>
&gt; (&quot;staging: android: ashmem: Fix a race condition in pin ioctls&qu=
ot;)<br>
&gt; causing deadlock.<br>
&gt;<br>
&gt; No need to hold ashmem_mutex while copying from user<br>
&gt;<br>
&gt; Stacks are:<br>
&gt;<br>
&gt; ashmem_mmap+0x53/0x400 drivers/staging/android/<wbr>ashmem.c:379<br>
&gt; mmap_region+0x7dd/0xfd0 mm/mmap.c:1694<br>
&gt; do_mmap+0x57b/0xbe0 mm/mmap.c:1473<br>
&gt;<br>
&gt; and<br>
&gt;<br>
&gt; lock_acquire+0x12e/0x410 kernel/locking/lockdep.c:3756<br>
&gt; __might_fault+0x14a/0x1d0 mm/memory.c:4014<br>
&gt; copy_from_user arch/x86/include/asm/uaccess.<wbr>h:705 [inline]<br>
&gt; ashmem_pin_unpin drivers/staging/android/<wbr>ashmem.c:719 [inline]<br=
>
&gt;<br>
&gt; Signed-off-by: Paul Lawrence &lt;<a href=3D"mailto:paullawrence@google=
.com">paullawrence@google.com</a>&gt;<br>
&gt; Cc: &lt;<a href=3D"mailto:stable@vger.kernel.org">stable@vger.kernel.o=
rg</a>&gt; # 4.9.x<br>
&gt; Cc: &lt;<a href=3D"mailto:stable@vger.kernel.org">stable@vger.kernel.o=
rg</a>&gt; # 4.4.x<br>
&gt; Cc: &lt;<a href=3D"mailto:stable@vger.kernel.org">stable@vger.kernel.o=
rg</a>&gt; # 3.18.x: ce8a3a9e76d01<br>
&gt; Cc: &lt;<a href=3D"mailto:stable@vger.kernel.org">stable@vger.kernel.o=
rg</a>&gt; # 3.18.x<br>
&gt; Cc: Ben Hutchings &lt;<a href=3D"mailto:ben@decadent.org.uk">ben@decad=
ent.org.uk</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 drivers/staging/android/<wbr>ashmem.c | 8 +++-----<br>
&gt;=C2=A0 1 file changed, 3 insertions(+), 5 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/staging/android/<wbr>ashmem.c b/drivers/staging/a=
ndroid/<wbr>ashmem.c<br>
&gt; index 6dbba5aff191..8c55706c2cfa 100644<br>
&gt; --- a/drivers/staging/android/<wbr>ashmem.c<br>
&gt; +++ b/drivers/staging/android/<wbr>ashmem.c<br>
&gt; @@ -702,16 +702,14 @@ static int ashmem_pin_unpin(struct ashmem_area *=
asma, unsigned long cmd,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0size_t pgstart, pgend;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int ret =3D -EINVAL;<br>
&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (unlikely(copy_from_user(&amp;pin, p, sizeof(p=
in))))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EFAULT;<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0mutex_lock(&amp;ashmem_mutex);<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (unlikely(!asma-&gt;file))<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out_unlock;=
<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0if (unlikely(copy_from_user(&amp;pin, p, sizeof(p=
in)))) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D -EFAULT;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out_unlock;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0}<br>
&gt; -<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* per custom, you can pass zero for len to =
mean &quot;everything onward&quot; */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!pin.len)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pin.len =3D PAGE=
_ALIGN(asma-&gt;size) - pin.offset;<br>
&gt; --<br>
&gt; 2.16.2.395.g2e18187dfd-goog<br>
&gt;<br>
<br>
</div></div>Hey Paul,<br>
<br>
Looks like this same patch is already in Greg&#39;s tree:<br>
<a href=3D"https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.g=
it/commit/?id=3D740a5759bf222332fbb5eda42f89aa25ba38f9b2" rel=3D"noreferrer=
" target=3D"_blank">https://git.kernel.org/pub/<wbr>scm/linux/kernel/git/gr=
egkh/<wbr>staging.git/commit/?id=3D<wbr>740a5759bf222332fbb5eda42f89aa<wbr>=
25ba38f9b2</a><br>
<br>
Cheers!<br>
<span class=3D"HOEnZb"><font color=3D"#888888">Nathan Chancellor<br>
</font></span></blockquote></div><br></div>

--94eb2c064b70375d8f0566d9b6e6--
