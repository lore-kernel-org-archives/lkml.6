Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBE43C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 18:32:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89731223AE
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 18:32:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LNR2N8nR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89731223AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727551AbeKNEbu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 23:31:50 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:35767 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726459AbeKNEbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 23:31:49 -0500
Received: by mail-it1-f196.google.com with SMTP id v11so19991452itj.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 10:32:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zlca0T0EYrXqtOfnHKohlWU7P1OTjKQ7GWHaTJ7BHB4=;
        b=LNR2N8nR89/IcDp4WtpH6lAtrTcRnqMCisYv8ytAViOIo4WC2EmRm72bKZCTcTD8Yj
         5tHLfbBrHBaYM7JNAOFvTYxHmFsYv8NArtpWaO4KWAtmedvtb/oWLhL3/ubjTSvKtu3f
         oBWfWHD5lv1EXIEbNo3FnUjmkBJ5nZMvvHkpE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zlca0T0EYrXqtOfnHKohlWU7P1OTjKQ7GWHaTJ7BHB4=;
        b=K6FgSPLnIilKiyFClJeRKGE8b4EqmOFQOWk4i75FPuABZk2rSdnDugZI6BNU0+HfKV
         MYAxJ/cjLO1N844uV+Dqplwl1AbUwN2liBxq4VYY/EioQ+/1z4X639QDsz2OdZKUt2M7
         nuoGKhmB1KGu6eiTEeQQZcpTY7JGUydzhVJRuS47dIJaBoCM/JqbkCFTs4WOTu5iACNj
         b2swScTXe8XH0mpW24K2EL6ieG+HYvw6gsDOoMSTr/J9QAybYEa5P/3cJZ7fSm47q4uk
         p9gNQVYMHxh7vmh7l6fFiJGNbw5cvekEfBqSalONC8CI0r9J6DEAlficl+Qhosq+paeB
         8dYA==
X-Gm-Message-State: AGRZ1gLdQlRn24JrDUAlBFsLHRWk9rjRnBxqxN3PhKn+06wIPAuTqsNV
        k8sr9f1yqjVt2JdUDw7g/RfbSV1hnEA=
X-Google-Smtp-Source: AJdET5cEjIAocqxh9MdGhuKm1gY1bH/UsMbalFA7tJdpgRc2kzPAIYY5pCbs3/sM1gz3LElNs3a75Q==
X-Received: by 2002:a24:90c2:: with SMTP id x185-v6mr4805380itd.170.1542133950427;
        Tue, 13 Nov 2018 10:32:30 -0800 (PST)
Received: from mail-it1-f174.google.com (mail-it1-f174.google.com. [209.85.166.174])
        by smtp.gmail.com with ESMTPSA id p22-v6sm6448236iog.3.2018.11.13.10.32.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 10:32:28 -0800 (PST)
Received: by mail-it1-f174.google.com with SMTP id m15so19961961itl.4
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 10:32:28 -0800 (PST)
X-Received: by 2002:a24:9582:: with SMTP id m124-v6mr4295613itd.109.1542133948005;
 Tue, 13 Nov 2018 10:32:28 -0800 (PST)
MIME-Version: 1.0
References: <CA+ASDXN40pvbZKvsO3Cb8256AQJ3fyQh5TWdT+GDk_ncq11nMw@mail.gmail.com>
 <CAK7LNAR5etb-oJDaxNZbH9-FmC3+hC3A_cwnbuWPQx0maHaDng@mail.gmail.com>
 <20181109183436.GA45531@google.com> <20181110.085826.230851261@genki.is>
 <m24lcpjjss.fsf@linux-m68k.org> <20181110.201050.925673938@genki.is>
 <CAJ1xhMXDFAdiWMV6ODcJM8bfjs-ddyv8utf6N+Yh7+-Ne-KaHw@mail.gmail.com>
 <20181111.174140.002789201@genki.is> <CAJ1xhMUA4GUzeDANqR1WafELmEpE+-V569t7e0xCotTG2Lvbyw@mail.gmail.com>
 <CAJ1xhMWw8Mi2dubTFNOxhoP6hk+__Qjo-0+9sQbpqP5K-n4mVw@mail.gmail.com>
 <20181113000938.GA16783@google.com> <CAJ1xhMVFt6bYgwY+N5VoFXNpm5kS1j_HV8-ZS8SkavNgZx1HOg@mail.gmail.com>
In-Reply-To: <CAJ1xhMVFt6bYgwY+N5VoFXNpm5kS1j_HV8-ZS8SkavNgZx1HOg@mail.gmail.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Tue, 13 Nov 2018 10:32:16 -0800
X-Gmail-Original-Message-ID: <CA+ASDXPcYp_joFeyGQ7TXFBSK-7i6bNFzaA1z=YYSDEjyMABdg@mail.gmail.com>
Message-ID: <CA+ASDXPcYp_joFeyGQ7TXFBSK-7i6bNFzaA1z=YYSDEjyMABdg@mail.gmail.com>
Subject: Re: [PATCH] scripts/setlocalversion: Improve -dirty check with
 git-status --no-optional-locks
To:     alexander.kapshuk@gmail.com
Cc:     sky@genki.is, schwab@linux-m68k.org, yamada.masahiro@socionext.com,
        Doug Anderson <dianders@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>, lists@nerdbynature.de,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexander,

On Tue, Nov 13, 2018 at 12:36 AM Alexander Kapshuk
<alexander.kapshuk@gmail.com> wrote:
>
> On Tue, Nov 13, 2018 at 2:09 AM Brian Norris <briannorris@chromium.org> wrote:
> >
> > On Mon, Nov 12, 2018 at 10:42:26AM +0200, Alexander Kapshuk wrote:
> > > An even simpler approach would be:
> > >
> > > {
> > >         git --no-optional-locks status -uno --porcelain 2>/dev/null ||
> > >         git diff-index --name-only HEAD
> > > } | grep -qv scripts/package &&
> > >         printf '%s' -dirty
> > >
> > > Sample run:
> > > cmd
> > > sh: cmd: command not found
> > >
> > > {
> > >         cmd 2>/dev/null ||
> > >         date
> > > } | grep -q 2018 &&
> > >         printf '%s' ok
> > > ok
> >
> > You lose accuracy here, because now you're skipping any line that
> > contains 'scripts/package', which would include, e.g., paths like
> >
> >   tools/some/other-scripts/package
> >
> > Maybe if the grep expression were more like this?
> >
> >   grep -qv '^\(.. \)\?scripts/package'
> >
> > I think it'd be safe enough to ignore paths that start with two
> > characters and a space, like:
> >
> > xy scripts/package
> > x/ scripts/package
> >
> > Brian
>
> Thanks for your input.
> I've found the following grep command, that uses extended regular
> expressions, to work as required:

Is there any good reason you switched to extended? It looks like my
(basic regex) grep was equivalent.

> {
>         echo hello
>         echo scripts/package
>         echo '.. scripts/package'
>         echo tools/some/other-scripts/package
> } | grep -Ev '^(.. )?scripts/package'
>
> [Output]
> hello
> tools/some/other-scripts/package
>
> If the participants of this email exchange consider the proposed
> implementation as fitting the bill,
>
> {
>         git --no-optional-locks status -uno --porcelain 2>/dev/null ||
>         git diff-index --name-only HEAD
> } | grep -Eqv '^(.. )?scripts/package' &&
>         printf '%s' -dirty
>
> Was the original committer of the patch proposed here,
> https://lkml.org/lkml/2018/11/10/55, going to take it in, and resend it
> as v2 of the patch, or did you want me to submit the patch instead?
> I would be happy with either way.

I can submit it. I expect Masahiro-san would prefer a proper v2 patch
for review, given how much would change from my v1.

And this time, I'll actually test it with a non-dirty tree! (Of
course, my tree is naturally dirty when developing the patch, but I
missed testing post-commit...)

Brian
