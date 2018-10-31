Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D66CC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 04:19:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5421320821
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 04:19:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="xD3+W3Eb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5421320821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729047AbeJaNPk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 09:15:40 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37510 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728995AbeJaNPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 09:15:40 -0400
Received: by mail-lj1-f195.google.com with SMTP id c4-v6so13531695lja.4
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 21:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=N3V0Lulgag0cmBAUtys8wXfVZQd7Fw3ojVbLDCb179c=;
        b=xD3+W3EbZ1RrUDqBWvSlA/s3agm7UC4Bx4d5Au2X5wRwmH0M2qlCh4JgPauRDooXuA
         02KP2aJLP0MUZo38rCG8mpIGf/wCFyAN/2O2IP7w7aoxwWcYNUq4Oczt0KRxLWt/rRWG
         1u3gzFUMDseuvCi0TF2BsCu3dTdxi0by0kxL8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=N3V0Lulgag0cmBAUtys8wXfVZQd7Fw3ojVbLDCb179c=;
        b=q1JIdeTco/5+axkVBq5dutIL8jfKqAJtckLvc6gBn55Z2DAp42cCJhS2suIpg0/cpw
         TvSYcyKYf3LNXfIzv0OhsVvvP3BqUrV2W6tUYrjlUgYwRsc3OEhRTNzpYEeqyedKlqoz
         qMZxjPy8IE0Iri6PXiJnU27gXBB7qMkANGbcBy0xCrJhg9dMbHRe+p13s3d0M6XKKNxh
         9hYXWsSa+Yi4kYswBaNQO6Lz1KNgYrE6jGsPHsGe0i1oK6mwZHMX7K9XEzB6XLn1Zpnj
         sFDqbWQ/v81Q2o/1qjGErSrV1BbaO0Tc7qDy3mEIZMtCiVEkc2wy8ft3P7h/1TCF49tS
         mEqg==
X-Gm-Message-State: AGRZ1gIYHBJfw5wpztPUAsu+jtgvP62JKlpSy7VCL4NslRgYrG1UyGcR
        4BjN77XuvqYHqfQySo2CMgJqnUKBGZI0eHzq1O3Q/Q==
X-Google-Smtp-Source: AJdET5e5gVupL9vHejqlWTWsimaApQQMAKkEzqcEn2/+IUw1a0V7gpzp/yIzdmi3LiodiD5yX4DIoC+l9d8mymfJhUs=
X-Received: by 2002:a2e:1b47:: with SMTP id b68-v6mr723677ljb.104.1540959557936;
 Tue, 30 Oct 2018 21:19:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:650a:0:0:0:0:0 with HTTP; Tue, 30 Oct 2018 21:19:17
 -0700 (PDT)
In-Reply-To: <1540958265198.28846@xiaomi.com>
References: <20181030075234.21137-1-wangpeng15@xiaomi.com> <20181030213818.GA32621@google.com>
 <CAGXu5j+tRWseaecob04U5iXHa-P_z=Hvj3PmhE5YWFUO=LT7Sw@mail.gmail.com>
 <20181030221605.GA44036@joelaf.mtv.corp.google.com> <1540958265198.28846@xiaomi.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Tue, 30 Oct 2018 21:19:17 -0700
Message-ID: <CAEXW_YTcFzH-5SvT12xrJVUsNp=tgr8E0iuGB2ec76unTHwNJA@mail.gmail.com>
Subject: Re: [PATCH v4] pstore: Avoid duplicate call of persistent_ram_zap()
To:     =?UTF-8?B?UGVuZzE1IFdhbmcg546L6bmP?= <wangpeng15@xiaomi.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "vipwangerxiao@gmail.com" <vipwangerxiao@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2018 at 8:57 PM, Peng15 Wang =E7=8E=8B=E9=B9=8F <wangpeng15=
@xiaomi.com> wrote:
>
>>From: Joel Fernandes <joel@joelfernandes.org>
>>Sent: Wednesday, October 31, 2018 6:16
>>To: Kees Cook
>>Cc: Peng15 Wang =E7=8E=8B=E9=B9=8F; Anton Vorontsov; Colin Cross; Tony Lu=
ck; LKML; vipwangerxiao@gmail.com
>>Subject: Re: [PATCH v4] pstore: Avoid duplicate call of persistent_ram_za=
p()
>>
>>On Tue, Oct 30, 2018 at 02:52:43PM -0700, Kees Cook wrote:
>>> On Tue, Oct 30, 2018 at 2:38 PM, Joel Fernandes <joel@joelfernandes.org=
> wrote:
>>> > On Tue, Oct 30, 2018 at 03:52:34PM +0800, Peng Wang wrote:
>>> >> When initialing prz with invalid data in buffer(no PERSISTENT_RAM_SI=
G),
>>> >> function call path is like this:
>>> >>
>>> >> ramoops_init_prz ->
>>> >> |
>>> >> |-> persistent_ram_new -> persistent_ram_post_init -> persistent_ram=
_zap
>>> >> |
>>> >> |-> persistent_ram_zap
>>> >>
>>> >> As we can see, persistent_ram_zap() is called twice.
>>> >> We can avoid this by adding an option to persistent_ram_new(), and
>>> >> only call persistent_ram_zap() when it is needed.
>>> >>
>>> >> Signed-off-by: Peng Wang <wangpeng15@xiaomi.com>
>>> >> ---
>>> >>  fs/pstore/ram.c            | 4 +---
>>> >>  fs/pstore/ram_core.c       | 5 +++--
>>> >>  include/linux/pstore_ram.h | 1 +
>>> >>  3 files changed, 5 insertions(+), 5 deletions(-)
>>> >>
>>> >> diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
>>> >> index ffcff6516e89..b51901f97dc2 100644
>>> >> --- a/fs/pstore/ram.c
>>> >> +++ b/fs/pstore/ram.c
>>> >> @@ -640,7 +640,7 @@ static int ramoops_init_prz(const char *name,
>>> >>
>>> >>       label =3D kasprintf(GFP_KERNEL, "ramoops:%s", name);
>>> >>       *prz =3D persistent_ram_new(*paddr, sz, sig, &cxt->ecc_info,
>>> >> -                               cxt->memtype, 0, label);
>>> >> +                               cxt->memtype, PRZ_FLAG_ZAP_OLD, labe=
l);
>>> >>       if (IS_ERR(*prz)) {
>>> >>               int err =3D PTR_ERR(*prz);
>>> >
>>> > Looks good to me except the minor comment below:
>>> >
>>> >>
>>> >> @@ -649,8 +649,6 @@ static int ramoops_init_prz(const char *name,
>>> >>               return err;
>>> >>       }
>>> >>
>>> >> -     persistent_ram_zap(*prz);
>>> >> -
>>> >>       *paddr +=3D sz;
>>> >>
>>> >>       return 0;
>>> >> diff --git a/fs/pstore/ram_core.c b/fs/pstore/ram_core.c
>>> >> index 12e21f789194..2ededd1ea1c2 100644
>>> >> --- a/fs/pstore/ram_core.c
>>> >> +++ b/fs/pstore/ram_core.c
>>> >> @@ -505,15 +505,16 @@ static int persistent_ram_post_init(struct per=
sistent_ram_zone *prz, u32 sig,
>>> >>                       pr_debug("found existing buffer, size %zu, sta=
rt %zu\n",
>>> >>                                buffer_size(prz), buffer_start(prz));
>>> >>                       persistent_ram_save_old(prz);
>>> >> -                     return 0;
>>> >> +                     if (!(prz->flags & PRZ_FLAG_ZAP_OLD))
>>> >> +                             return 0;
>>> >
>>> > This could be written differently.
>>> >
>>> > We could just do:
>>> >
>>> > if (prz->flags & PRZ_FLAG_ZAP_OLD)
>>> >         persistent_ram_zap(prz);
>>> >
>>> > And remove the zap from below below.
>>>
>>> I actually rearranged things a little to avoid additional round-trips
>>> on the mailing list. :)
>>>
>>> > Since Kees already took this patch, I can just patch this in my serie=
s if
>>> > Kees and you are Ok with this suggestion.
>>>
>>> I've put it up here:
>>> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/commit/?=
h=3Dpstore/devel&id=3Dac564e023248e3f4d87917b91d12376ddfca5000
>>
>>Cool, it LGTM :)
>>
>>- Joel
>>
>
> Thank you all for these warm help.
>
> This is my first time to submit a patch to community. Feel great!

Congrats and welcome to the mother ship ;-)

 - Joel
