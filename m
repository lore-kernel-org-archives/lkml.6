Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8681EC5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:04:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48C8E20855
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:04:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="OPczIJ4F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48C8E20855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731209AbeLKQEE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 11:04:04 -0500
Received: from conssluserg-02.nifty.com ([210.131.2.81]:26017 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730552AbeLKQED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 11:04:03 -0500
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id wBBG3Zxa004409;
        Wed, 12 Dec 2018 01:03:35 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com wBBG3Zxa004409
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1544544216;
        bh=yybUklpXv+i3ZvDZN0IW/BOVhtWK4rILiidGaAjhMpM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OPczIJ4FOYy580LZ7DS/3nKvrqqoOMHIZIKWccecRRjdvtFhKfsasloqP+Dao9mEm
         yzIvnhZYIU23eLSWDkv5eknjQSTX81s+9ltfglUEI9fvClHdaKOOIV0hO2IbCPtae5
         cU9qNLWUULDw8JVFXwonarCPtCbPoaKBO6MB1qZxmij13lnLAV6E9ZPLkrDQlccFhG
         Nvs9c5jSADVSTLnT7pFwfBpGaFqq76gCdwKJ5HV/jPocJnHYkPkZ8QYjqAq0l478+r
         Q0qx8ITQFTQfN63dUPdk+p7cMblUVHzDlDv83AUwvUQbE3b0yFbwuVZGN8cnpvfj0R
         IO0sQl7AJbqKg==
X-Nifty-SrcIP: [209.85.222.47]
Received: by mail-ua1-f47.google.com with SMTP id k10so5303937ual.6;
        Tue, 11 Dec 2018 08:03:35 -0800 (PST)
X-Gm-Message-State: AA+aEWazi+9hQx0qqBC1uJwACTeKIT5TYSo8sjvQYGax6aOZnekq9qRz
        vD5vJz5j0CRuen2MuTOS0eVOHb/uA3qo8E87qsg=
X-Google-Smtp-Source: AFSGD/XZc79/L4SuKcG1VJ0VKvjIawgbFQtNLlqIpxPcLm8VGbMkBdVTmt2/WSQVL+Vpd0inHxvZI+sz8UNKgKFxppM=
X-Received: by 2002:ab0:849:: with SMTP id b9mr3720525uaf.93.1544544214488;
 Tue, 11 Dec 2018 08:03:34 -0800 (PST)
MIME-Version: 1.0
References: <20181210203225.11179-1-robh@kernel.org> <CAK7LNAThtAOy4PQiYZ2X0oWrHdcLi7on8ctSXJ=bfT0HNh7NFQ@mail.gmail.com>
 <CAL_JsqL7n2sjLbJVieVDQ4YtKMi2COCaijO9ZNu7ggzmXXxLEg@mail.gmail.com>
In-Reply-To: <CAL_JsqL7n2sjLbJVieVDQ4YtKMi2COCaijO9ZNu7ggzmXXxLEg@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 12 Dec 2018 01:02:58 +0900
X-Gmail-Original-Message-ID: <CAK7LNARkr-g9ae+74QE6GMuxLM0JPgEqYOkwb0njXcb9-=nBdQ@mail.gmail.com>
Message-ID: <CAK7LNARkr-g9ae+74QE6GMuxLM0JPgEqYOkwb0njXcb9-=nBdQ@mail.gmail.com>
Subject: Re: [PATCH v3] kbuild: Add support for DT binding schema checks
To:     Rob Herring <robh@kernel.org>
Cc:     DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        darknighte@darknighte.com, Frank Rowand <frowand.list@gmail.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        grant.likely@arm.com, Kumar Gala <kumar.gala@linaro.org>,
        arm-soc <arm@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Michal Marek <michal.lkml@markovi.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2018 at 12:13 AM Rob Herring <robh@kernel.org> wrote:

>
> > > +$(obj)/%.example.dts: $(src)/%.yaml FORCE
> > > +       $(call if_changed,chk_binding)
> > > +
> > > +DT_TMP_SCHEMA := .schema.yaml.tmp
> >
> >
> > BTW, why does this file start with a period?
> > What is the meaning of '.tmp' extension?
>
> Nothing really. Just named it something so it gets cleaned and ignored by git.


It is cleaned whatever file name you use.


See scripts/Makefile.clean

__clean-files   := $(extra-y) $(extra-m) $(extra-)       \
                   $(always) $(targets) $(clean-files)   \
                   $(hostprogs-y) $(hostprogs-m) $(hostprogs-) \
                   $(hostlibs-y) $(hostlibs-m) $(hostlibs-) \
                   $(hostcxxlibs-y) $(hostcxxlibs-m)


$(extra-y) is cleaned.



You are adding *.example.dts to .gitignore

Why not "schema.yaml" ?




> > > +extra-y += $(DT_TMP_SCHEMA)
> > > +
> > > +quiet_cmd_mk_schema = SCHEMA  $@
> > > +      cmd_mk_schema = mkdir -p $(obj); \
> > > +                      rm -f $@; \
> > > +                      $(DT_MK_SCHEMA) $(DT_MK_SCHEMA_FLAGS) -o $@ $(filter-out FORCE, $^)
> >
> >
> > "mkdir -p $(obj)" is redundant.
> >
> >
> > Why is 'rm -f $@' necessary ?
> > Can't dt-mk-schema overwrite the output file?
>
> It is for error case when the output file is not generated. I can
> handle this within dt-mk-schema instead.
> > > +DT_DOCS = $(shell cd $(srctree)/$(src) && find * -name '*.yaml')
> > > +DT_SCHEMA_FILES ?= $(addprefix $(src)/,$(DT_DOCS))
> > > +
> > > +extra-y += $(patsubst $(src)/%.yaml,%.example.dts, $(DT_SCHEMA_FILES))
> > > +extra-y += $(patsubst $(src)/%.yaml,%.example.dtb, $(DT_SCHEMA_FILES))
> >
> >
> >
> > I assume you intentionally did not do like this:
> >
> > extra-y += $(patsubst %.yaml,%.example.dtb, $(DT_DOCS))
> >
> > From the commit description, DT_SCHEMA_FILES might be overridden by a user.
> > So, I think this is OK.
> >
> >
> >
> >
> > > +$(obj)/$(DT_TMP_SCHEMA): | $(addprefix $(obj)/,$(patsubst $(src)/%.yaml,%.example.dtb, $(DT_SCHEMA_FILES)))
> >
> > I do not understand this line.
> > Why is it necessary?
> >
> > *.example.dtb files are generated anyway
> > since they are listed in extra-y.
>
> It is enforcing the ordering. Without it, the binding checks and
> building .schema.yaml.tmp happen in parallel because both only have
> the source files as dependencies. The '|' keeps the dependencies out
> of the dependency list($^).


What kind problem would you see if
the binding checks and building .schema.yaml.tmp
happen in parallel?



-- 
Best Regards
Masahiro Yamada
