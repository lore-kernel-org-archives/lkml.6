Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA54C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 16:21:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8F8F20825
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 16:21:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="RkSEhifg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8F8F20825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728461AbeKJCCz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 21:02:55 -0500
Received: from conssluserg-01.nifty.com ([210.131.2.80]:56693 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727845AbeKJCCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 21:02:55 -0500
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id wA9GLLGC003141;
        Sat, 10 Nov 2018 01:21:21 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com wA9GLLGC003141
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1541780482;
        bh=n3R2ykxv9WOpfLnl604x9uVs2D2nKLyud1GY4NFC/ik=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RkSEhifgpxTGXnghSkcqIx9s7pRPyV6HqprhmQOYy070cVAh31F2HVTc9wLn+2Te3
         qR8j3lnyGGoqY1PAIMT93ICJkl6BuRcH592l1qBoltBFV71X5xOAMAno7jNB8Gbz6y
         gq0f6G0Fd93QnYLFfghx1Ab1zCTebAe2yOxv6KycpfVo41gpYlMtAo+DCzA6vqYsfH
         wx4B7o7RUcQYFsk1+Ijfvf1LtchOqorTFOxt9CzD0ysCb6jKP/jyRS6vp6hzY1Z4vl
         wIqtKpVPrB4dSDOyFANrHSby1pNfG/NwXhypnp3M/I/iU2OoPlWSeWpbSrMHz5oIV9
         RVnwiYP8fAWZw==
X-Nifty-SrcIP: [209.85.217.44]
Received: by mail-vs1-f44.google.com with SMTP id x1so1331987vsc.10;
        Fri, 09 Nov 2018 08:21:21 -0800 (PST)
X-Gm-Message-State: AGRZ1gLz1ddGY/L64FRQOaiwy4Kqx8PWPJxqWkY4mEvqUd6vxSovWsHr
        n/bK/VdQHGNihmxcYBFD2JMSmnEXHfXv6ZtHbI4=
X-Google-Smtp-Source: AJdET5f9n0S31jjiszo5WGhb91t66AnHZNmZQwFuI2+MSy6f8a0Kkh4klO/ICc5eQf1yECib6z+dMD/lXywPS8TLdys=
X-Received: by 2002:a67:385a:: with SMTP id f87mr4077274vsa.179.1541780480439;
 Fri, 09 Nov 2018 08:21:20 -0800 (PST)
MIME-Version: 1.0
References: <1541405976-13747-1-git-send-email-yamada.masahiro@socionext.com> <68478c42-2703-0d24-bf6b-8d75d024722a@mind.be>
In-Reply-To: <68478c42-2703-0d24-bf6b-8d75d024722a@mind.be>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sat, 10 Nov 2018 01:20:44 +0900
X-Gmail-Original-Message-ID: <CAK7LNARK1B=yjjWyK9QfOPSQMnWSzhpDxewV6wBCByGn46G-Dg@mail.gmail.com>
Message-ID: <CAK7LNARK1B=yjjWyK9QfOPSQMnWSzhpDxewV6wBCByGn46G-Dg@mail.gmail.com>
Subject: Re: [PATCH v2] kconfig: merge_config: avoid false positive matches
 from comment lines
To:     Arnout Vandecappelle <arnout@mind.be>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Petr Vorel <petr.vorel@gmail.com>,
        nasser afshin <afshin.nasser@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 5, 2018 at 6:35 PM Arnout Vandecappelle <arnout@mind.be> wrote:
>
>
>
> On 05/11/18 09:19, Masahiro Yamada wrote:
> > The current SED_CONFIG_EXP could match to comment lines in config
> > fragment files, especially when CONFIG_PREFIX_ is empty. For example,
> > Buildroot uses empty prefixing; starting symbols with BR2_ is just
> > convention.
> >
> > Make the sed expression more robust against false positives from
> > comment lines. The new sed expression matches to only valid patterns.
> >
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > Reviewed-by: Petr Vorel <petr.vorel@gmail.com>
>
> Reviewed-by: Arnout Vandecappelle (Essensium/Mind) <arnout@mind.be>
>
>  Regards,
>  Arnout


Applied to linux-kbuild.



> > ---
> >
> > Changes in v2:
> >   - Another (more precise) implementation approach
> >     based on the option from Arnout Vandecappelle.
> >     This is still easier to read, but adds a bit duplication.
> >
> >  scripts/kconfig/merge_config.sh | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> >
> > diff --git a/scripts/kconfig/merge_config.sh b/scripts/kconfig/merge_config.sh
> > index da66e77..0ef9064 100755
> > --- a/scripts/kconfig/merge_config.sh
> > +++ b/scripts/kconfig/merge_config.sh
> > @@ -102,7 +102,8 @@ if [ ! -r "$INITFILE" ]; then
> >  fi
> >
> >  MERGE_LIST=$*
> > -SED_CONFIG_EXP="s/^\(# \)\{0,1\}\(${CONFIG_PREFIX}[a-zA-Z0-9_]*\)[= ].*/\2/p"
> > +SED_CONFIG_EXP1="s/^\(${CONFIG_PREFIX}[a-zA-Z0-9_]*\)=.*/\1/p"
> > +SED_CONFIG_EXP2="s/^# \(${CONFIG_PREFIX}[a-zA-Z0-9_]*\) is not set$/\1/p"
> >
> >  TMP_FILE=$(mktemp ./.tmp.config.XXXXXXXXXX)
> >
> > @@ -116,7 +117,7 @@ for MERGE_FILE in $MERGE_LIST ; do
> >               echo "The merge file '$MERGE_FILE' does not exist.  Exit." >&2
> >               exit 1
> >       fi
> > -     CFG_LIST=$(sed -n "$SED_CONFIG_EXP" $MERGE_FILE)
> > +     CFG_LIST=$(sed -n -e "$SED_CONFIG_EXP1" -e "$SED_CONFIG_EXP2" $MERGE_FILE)
> >
> >       for CFG in $CFG_LIST ; do
> >               grep -q -w $CFG $TMP_FILE || continue
> > @@ -159,7 +160,7 @@ make KCONFIG_ALLCONFIG=$TMP_FILE $OUTPUT_ARG $ALLTARGET
> >
> >
> >  # Check all specified config values took (might have missed-dependency issues)
> > -for CFG in $(sed -n "$SED_CONFIG_EXP" $TMP_FILE); do
> > +for CFG in $(sed -n -e "$SED_CONFIG_EXP1" -e "$SED_CONFIG_EXP2" $TMP_FILE); do
> >
> >       REQUESTED_VAL=$(grep -w -e "$CFG" $TMP_FILE)
> >       ACTUAL_VAL=$(grep -w -e "$CFG" "$KCONFIG_CONFIG")
> >



-- 
Best Regards
Masahiro Yamada
