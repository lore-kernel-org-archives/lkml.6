Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 63736C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 21:00:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F31B208BA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 21:00:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="nW/vi0Sp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F31B208BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755542AbeFNVAD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 17:00:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:34050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755406AbeFNU76 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 16:59:58 -0400
Received: from mail-yb0-f175.google.com (mail-yb0-f175.google.com [209.85.213.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DDC90208D7;
        Thu, 14 Jun 2018 20:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529009998;
        bh=cIFdctODhYXkgIdyNBMuOXwZLpKnia7PgsfKJp6GXW8=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=nW/vi0Spj/LuYxgsRtdsSaRqurqWaovc0MY7zdMfEX2HbAuFQaYidjkgzO3Jhztlu
         YSA4SCDkoUaMQNAkzJPSmcepnstpKrjkACXJogpg2jDeGRz63HiS+4yeQMcJdzsb9G
         csSGZGCz+BMt7hfN2ln0OZ1j3+L/f+DAS1TBynAM=
Received: by mail-yb0-f175.google.com with SMTP id n23-v6so2760554ybg.1;
        Thu, 14 Jun 2018 13:59:57 -0700 (PDT)
X-Gm-Message-State: APt69E29GPVHKIWKvzR2y11S2AuogD/WmsVT3PWNQM8+YyPWgiHVfVeH
        NeplxwhkKf3jfYiQAYf6AJx4nbNf8ZQ7Mtv7SV4=
X-Google-Smtp-Source: ADUXVKIiqpvTxZoKhYcLcHQGnQibARMxiGYJIrE6Tf6Uh2B8hxI2oZkU3z618WtnGeAj+nuOIk62t83io81sEyHbswM=
X-Received: by 2002:a25:40c2:: with SMTP id n185-v6mr2412882yba.122.1529009997060;
 Thu, 14 Jun 2018 13:59:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5b:b87:0:0:0:0:0 with HTTP; Thu, 14 Jun 2018 13:59:16 -0700 (PDT)
In-Reply-To: <b8c7cd9e-a841-a4b7-2366-6f08328b2b8f@gmail.com>
References: <1520208889-3908-1-git-send-email-frowand.list@gmail.com>
 <1520208889-3908-2-git-send-email-frowand.list@gmail.com> <CANk1AXQZ6ax5j9QOrLZA9qT2xGpiU0BQLxAmKQFEqSb6NrbeRQ@mail.gmail.com>
 <CANk1AXSvVD5x7TKQV_HZm=9Lzeymm5H3p7DZPiAc-RRRxdAOZg@mail.gmail.com> <b8c7cd9e-a841-a4b7-2366-6f08328b2b8f@gmail.com>
From:   Alan Tull <atull@kernel.org>
Date:   Thu, 14 Jun 2018 15:59:16 -0500
X-Gmail-Original-Message-ID: <CANk1AXSvgHMWidmb+6k6paTdpj9HfSoyKoiMgLxH=8SoC-4qnw@mail.gmail.com>
Message-ID: <CANk1AXSvgHMWidmb+6k6paTdpj9HfSoyKoiMgLxH=8SoC-4qnw@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] of: cache phandle nodes to reduce cost of of_find_node_by_phandle()
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, cpandya@codeaurora.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fpga@vger.kernel.org, Moritz Fischer <mdf@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 13, 2018 at 4:47 PM, Frank Rowand <frowand.list@gmail.com> wrot=
e:
> On 06/13/18 07:42, Alan Tull wrote:
>> On Tue, Jun 12, 2018 at 1:16 PM, Alan Tull <atull@kernel.org> wrote:
>>> On Sun, Mar 4, 2018 at 6:14 PM,  <frowand.list@gmail.com> wrote:
>>>
>>> Hi Frank,
>>>
>>> I'm investigating a refcount use-after-free warning that happens after
>>> overlays are applied, removed, reapplied a few (typically three) times
>>> (see below).  This is new in v4.17, didn't happen in v4.16.  As I was
>>> investigating I found that rebuilding the phandle_cache after overlays
>>> are applied or removed seems to help.
>>
>> I was probably wrong about this.  The more I look at the phandle_cache c=
ode,
>> the more it looks looks good and straightforward.  Probably disabling
>> phandle_cache is 'fixing' things through some weird side effect.  I'll
>> keep investigating.  Sorry for the noise.
>
> I suspect that you have found an issue, even if it is not the cause of
> the refcount issue.  I noted in a reply to v4 of the patch:
>
>   >> +static void of_populate_phandle_cache(void)
>   >> +{
>   >> +=C3=82 =C3=82 =C3=82  unsigned long flags;
>   >> +=C3=82 =C3=82 =C3=82  u32 cache_entries;
>   >> +=C3=82 =C3=82 =C3=82  struct device_node *np;
>   >> +=C3=82 =C3=82 =C3=82  u32 phandles =3D 0;
>   >> +
>   >> +=C3=82 =C3=82 =C3=82  raw_spin_lock_irqsave(&devtree_lock, flags);
>   >> +
>   >> +=C3=82 =C3=82 =C3=82  kfree(phandle_cache);
>   >
>   > I couldn't understood this. Everything else looks good to me.
>
>   I will be adding a call to of_populate_phandle_cache() from the
>   devicetree overlay code.  I put the kfree here so that the previous
>   cache memory is freed when a new cache is created.
>
>   Adding the call from the overlay code is not done in this
>   series because I have a patch series modifying overlays and
>   I do not want to create a conflict or ordering between that
>   series and that patch.  The lack of the call from overlay
>   code means that overlay code will gain some of the overhead
>   reduction from this patch, but possibly not the entire reduction.
>
> Sorry I'm not giving a link to the archive of this message - I have
> a class I have to go to so I don't have enough time to find it.

I understand, that's cool.  I've found the email chain, thanks for
pointing me to it!

>  The
> email was
>
>   Subject: Re: [PATCH v3] of: cache phandle nodes to reduce cost of
>   of_find_node_by_phandle()
>   Date: Fri, 16 Feb 2018 14:20:22 -0800
>   Message-ID: <46d5fc76-33e3-d54a-26b8-e9bb8332924d@gmail.com>
>
> Quickly looking at the current code, I don't see the overlay patch
> that I mentioned.  I have to dig into what happened to that.
>
> Leaving a phandle from an overlay in the phandle cache after the
> overlay is removed would clearly be a bug.

Yes that's totally it, when I get a match of a phandle and the np
address is stale, then comes the kernel warning.

I added more debug code to print out the results of looking up dynamic
nodes only (nodes > the highest node added when the cache was
originally built).  Also I added debug code to also force the lookup
code to go back and look up dynamic nodes the slow, uncached way so I
could see if it got the correct np address.  I'm unloading and
reloading an overlay, so sometimes the new np (after the overlay was
removed and reapplied) is at the same address, but sometimes it isn't
and then I get the kernel warning.  Just for entertainment value, here
is my prints of the np from the cache and the correct np that' at a
different address.  The '88' is the phandle, after that is the np
address, then the np=3D<full_name>.  Note also the corruption in the
cached node's full_name

OF: of_find_node_by_phandle line 1108 found dynamic node in cache 88
ee518680 np=3D/soc/base_fpga_region/\300\252~\356ze_controller@0x100000450

OF: of_find_node_by_phandle line 1119 found the slow way: 88 eeaf2d00
np=3D/soc/base_fpga_region/freeze_controller@0x100000450

I'm just scratching my head and wondering: should we be zeroing out
some things in memory after an overlay is removed?  Then this bug
would led to a pointer that would have thrown an oops.

If it's useful for you, next week I can send a cleaned up version of
my patch that rebuilds the cache after overlays are applied or
removed.

Alan

>
> -Frank
