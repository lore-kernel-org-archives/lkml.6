Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E481FC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 16:46:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81C17206C2
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 16:46:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bHhcPYUw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729996AbeLNQqi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 11:46:38 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:37357 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729409AbeLNQqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 11:46:38 -0500
Received: by mail-yw1-f67.google.com with SMTP id h193so2538953ywc.4
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 08:46:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zm7h0/w1ttFLUS/6AK66YZHsBfI+p9pvmmurz0CNelQ=;
        b=bHhcPYUwDdIKmIFXiRRj2f5n8veoddZBWlnr5omnwWcGpCvGmXMYxvmDh5DhbSVcfb
         eByw9XNVW74s0uLZptlKfiDK/EF7Rh0vpoBUT71KHwfsfKDLOBTpAT7bcu7Dahm0eDJr
         8PpN2vQv4uLwHcNaPk/DfB4knffWEBhGJALXo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zm7h0/w1ttFLUS/6AK66YZHsBfI+p9pvmmurz0CNelQ=;
        b=mjlp/vijMFrI4/SUyee/mtLmFCZ2gMjyYHWrJw78Tz1MeWWLILcvNM9AjvWT1IHonP
         I6PIeNNh2zod8I7LUro5fwwKPcra7CbCH7ynyFgQw4LMDRre+K7eKo5NUIy+DLqpuCTR
         IpIBDe1sKIhoz7w5xweFw543RWB9mnfD0Ir2Lr0r/XWUOqaGVCIk15EvCy94stUxbzz4
         s20DV0ix7HkvdwWSld2CLedwaaTSe17ZaU/EnVce102PpjJ8+9zH/Mg3xHrfB1vyaB0m
         Hmq63bxdBvmYwDEUrs7mdAcLvbbAzc3QfrK55hSxkzfBsvBvfM7i7COJ+AQwzg26R3VN
         sZbg==
X-Gm-Message-State: AA+aEWbzLTfP+zPx1LuSLXpLlBIAIcOeUtSaUJvt2izKYbHo9LKxFwAi
        oXh4vkExPTKztXIVFjYbM93zFUoDeIU=
X-Google-Smtp-Source: AFSGD/WqmduTJeGJ9DL8uUt7SvD/WaSIFqn+byrdIJR0WSem2UQX/e0YpcQsPc/QvfU51E/Xle4RaA==
X-Received: by 2002:a81:11d5:: with SMTP id 204mr3790372ywr.287.1544805996256;
        Fri, 14 Dec 2018 08:46:36 -0800 (PST)
Received: from mail-yw1-f53.google.com (mail-yw1-f53.google.com. [209.85.161.53])
        by smtp.gmail.com with ESMTPSA id j134sm1772865ywb.91.2018.12.14.08.46.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Dec 2018 08:46:35 -0800 (PST)
Received: by mail-yw1-f53.google.com with SMTP id n21so1497697ywd.10
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 08:46:34 -0800 (PST)
X-Received: by 2002:a81:2890:: with SMTP id o138mr3962790ywo.168.1544805994386;
 Fri, 14 Dec 2018 08:46:34 -0800 (PST)
MIME-Version: 1.0
References: <BLUPR13MB0289EFEB79833470EE62F48EDFD10@BLUPR13MB0289.namprd13.prod.outlook.com>
 <20181128135242.gy3avmbp2pdmjaka@twin.jikos.cz> <5C0654EE.5040001@oberhumer.com>
 <SN1PR13MB030484F09EE8A00DB094CDFADFA80@SN1PR13MB0304.namprd13.prod.outlook.com>
 <5C093A30.4020705@oberhumer.com> <BLUPR13MB0289EC81589A10E95912675FDFA70@BLUPR13MB0289.namprd13.prod.outlook.com>
 <5C110083.8060502@oberhumer.com> <CAFLxGvzj=P2FY6w7CBYztsUjJ5Td53zCzGa_FUjrfxA94cmSgA@mail.gmail.com>
In-Reply-To: <CAFLxGvzj=P2FY6w7CBYztsUjJ5Td53zCzGa_FUjrfxA94cmSgA@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Fri, 14 Dec 2018 08:46:20 -0800
X-Gmail-Original-Message-ID: <CAGXu5jLR06ti_xhC8OODbF8m+Tsf6a0ebJLBe8KLcC+csG_i=w@mail.gmail.com>
Message-ID: <CAGXu5jLR06ti_xhC8OODbF8m+Tsf6a0ebJLBe8KLcC+csG_i=w@mail.gmail.com>
Subject: Re: [PATCH v2] lzo: fix ip overrun during compress.
To:     richard -rw- weinberger <richard.weinberger@gmail.com>
Cc:     markus@oberhumer.com, liyueyi@live.com, dsterba@suse.cz,
        Greg KH <gregkh@linuxfoundation.org>, Willy Tarreau <w@1wt.eu>,
        Don Bailey <donb@securitymouse.com>,
        Jiri Kosina <jikos@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2018 at 5:56 AM Richard Weinberger
<richard.weinberger@gmail.com> wrote:
>
> [CC'ing Kees]
>
> On Wed, Dec 12, 2018 at 1:37 PM Markus F.X.J. Oberhumer
> <markus@oberhumer.com> wrote:
> >
> > I still claim that (0xfffffffffffff000, 4096) is not a valid C "pointer
> > to an object" according to the C standard - please see my reply below.
> >
> > And I thought ASLR was introduced to improve security and not to create
> > new security problems - someone from the ASLR team has to comment on this.
> >
> > Cheers,
> > Markus
> >
> >
> > On 2018-12-12 06:21, Yueyi Li wrote:
> > > Hi Markus,
> > >
> > > OK, thanks. I`ll change it in v3.
> > >
> > > Thanks,
> > > Yueyi
> > >
> > > On 2018/12/6 23:03, Markus F.X.J. Oberhumer wrote:
> > >> Hi Yueyi,
> > >>
> > >> yes, my LZO patch works for all cases.
> > >>
> > >> The reason behind the issue in the first place is that if KASLR
> > >> includes the very last page 0xfffffffffffff000 then we do not have a
> > >> valid C "pointer to an object" anymore because of address wraparound.
> > >>
> > >> Unrelated to my patch I'd argue that KASLR should *NOT* include the
> > >> very last page - indeed that might cause similar wraparound problems
> > >> in lots of code.
> > >>
> > >> Eg, look at this simple clear_memory() implementation:
> > >>
> > >> void clear_memory(char *p, size_t len) {
> > >>          char *end = p + len;
> > >>          while (p < end)
> > >>                  *p++= 0;
> > >> }
> > >>
> > >> Valid code like this will fail horribly when (p, len) is the very
> > >> last virtual page (because end will be the NULL pointer in this case).
> > >>
> > >> Cheers,
> > >> Markus
> > >>
> > >>
> > >>
> > >> On 2018-12-05 04:07, Yueyi Li wrote:
> > >>> Hi Markus,
> > >>>
> > >>> Thanks for your review.
> > >>>
> > >>> On 2018/12/4 18:20, Markus F.X.J. Oberhumer wrote:
> > >>>> Hi,
> > >>>>
> > >>>> I don't think that address space wraparound is legal in C, but I
> > >>>> understand that we are in kernel land and if you really want to
> > >>>> compress the last virtual page 0xfffffffffffff000 the following
> > >>>> small patch should fix that dubious case.
> > >>> I guess the VA 0xfffffffffffff000 is available because KASLR be
> > >>> enabled. For this case we can see:

This is a weird case: I would expect the top 4k to be unmapped to
leave room of ERR_PTR, etc.

> > >>>
> > >>> crash> kmem 0xfffffffffffff000
> > >>>         PAGE               PHYSICAL      MAPPING       INDEX CNT FLAGS
> > >>> ffffffbfffffffc0        1fffff000 ffffffff1655ecb9  7181fd5  2
> > >>> 8000000000064209 locked,uptodate,owner_priv_1,writeback,reclaim,swapbacked
> > >>>
> > >>>> This also avoids slowing down the the hot path of the compression
> > >>>> core function.
> > >>>>
> > >>>> Cheers,
> > >>>> Markus
> > >>>>
> > >>>>
> > >>>>
> > >>>> diff --git a/lib/lzo/lzo1x_compress.c b/lib/lzo/lzo1x_compress.c
> > >>>> index 236eb21167b5..959dec45f6fe 100644
> > >>>> --- a/lib/lzo/lzo1x_compress.c
> > >>>> +++ b/lib/lzo/lzo1x_compress.c
> > >>>> @@ -224,8 +224,8 @@ int lzo1x_1_compress(const unsigned char *in, size_t in_len,
> > >>>>
> > >>>>           while (l > 20) {
> > >>>>                   size_t ll = l <= (M4_MAX_OFFSET + 1) ? l : (M4_MAX_OFFSET + 1);
> > >>>> -               uintptr_t ll_end = (uintptr_t) ip + ll;
> > >>>> -               if ((ll_end + ((t + ll) >> 5)) <= ll_end)
> > >>>> +               // check for address space wraparound
> > >>>> +               if (((uintptr_t) ip + ll + ((t + ll) >> 5)) <= (uintptr_t) ip)
> > >>>>                           break;

Please just use the standard add overflow checks from the kernel. See
include/linux/overflow.h

Specifically, check_add_overflow(operand1, operand2, &result). I
assume something like:

if (check_add_overflow(ip, ll, &ll_end))
   freak_out();

?

> > >>>>                   BUILD_BUG_ON(D_SIZE * sizeof(lzo_dict_t) > LZO1X_1_MEM_COMPRESS);
> > >>>>                   memset(wrkmem, 0, D_SIZE * sizeof(lzo_dict_t));
> > >>> I parsed panic ramdump and loaded CPU register values,  can see:
> > >>>
> > >>> -000|lzo1x_1_do_compress(
> > >>>       |    in = 0xFFFFFFFFFFFFF000,
> > >>>       |  ?,
> > >>>       |    out = 0xFFFFFFFF2E2EE000,
> > >>>       |    out_len = 0xFFFFFF801CAA3510,
> > >>>       |  ?,
> > >>>       |    wrkmem = 0xFFFFFFFF4EBC0000)
> > >>>       |  dict = 0xFFFFFFFF4EBC0000
> > >>>       |  op = 0x1
> > >>>       |  ip = 0x9
> > >>>       |  ii = 0x9
> > >>>       |  in_end = 0x0
> > >>>       |  ip_end = 0xFFFFFFFFFFFFFFEC
> > >>>       |  m_len = 0
> > >>>       |  m_off = 1922
> > >>> -001|lzo1x_1_compress(
> > >>>       |    in = 0xFFFFFFFFFFFFF000,
> > >>>       |    in_len = 0,
> > >>>       |    out = 0xFFFFFFFF2E2EE000,
> > >>>       |    out_len = 0x00000001616FB7D0,
> > >>>       |    wrkmem = 0xFFFFFFFF4EBC0000)
> > >>>       |  ip = 0xFFFFFFFFFFFFF000
> > >>>       |  op = 0xFFFFFFFF2E2EE000
> > >>>       |  l = 4096
> > >>>       |  t = 0
> > >>>       |  ll = 4096
> > >>>
> > >>> ll = l = in_len = 4096 in lzo1x_1_compress,  so your patch is working
> > >>> for this panic case, but, I`m
> > >>> not sure, is it possible that in = 0xFFFFFFFFFFFFF000 and  in_len < 4096?
> > >>>
> > >>>
> > >>> Thanks,
> > >>> Yueyi
> > >>>
> > >
> > >
> >
> > --
> > Markus Oberhumer, <markus@oberhumer.com>, http://www.oberhumer.com/
>
>
>
> --
> Thanks,
> //richard



-- 
Kees Cook
