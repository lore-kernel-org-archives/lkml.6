Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.9 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 782D1C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 10:47:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D0872086A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 10:47:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Km0pXQnG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D0872086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728094AbeJLSTi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 14:19:38 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45390 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726664AbeJLSTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 14:19:38 -0400
Received: by mail-wr1-f68.google.com with SMTP id q5-v6so12918952wrw.12;
        Fri, 12 Oct 2018 03:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=X7zYOLPVzOHfykKcboT77A16GE5FEmmP9puvCadh9zc=;
        b=Km0pXQnG3ffD0XdR1Yo3eHOVpkYHY0eQb82zgFecfkudTmgV0yqqAaXwZFG2k47j17
         5o2kOIsovrbyLJkcH7HV2/jon5GzvYR25xVd7WV22igNbpz0A+GpI7LIVqZZ3Doqcemu
         p4nN1tcYleesJ8V++6vab3UJZ96zZqaYbAsOD2AR167CjEe/egUBXL3gt7rF7/VYID5Q
         Z3Jwc70RQOXYO47YSepK15nzyGSsu/K/7WuNeIyvfyd8qP/bRqB5UqHMtUMaAI2GC4h+
         W6k1nyHxpeqOkX81IEwJuTzEtvMZIqESt/5oM0sXJ52nNfcKfrrKEbR4cs1IYoAg44g/
         1K+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=X7zYOLPVzOHfykKcboT77A16GE5FEmmP9puvCadh9zc=;
        b=WtziwCJeVqdETVsOtlivNWjfJtnFznGuBAgmWpkRK7M7Djn22SBHEp1pChj+S7OukX
         lQOi7BNDlmA6Tyc0wMLo1UsvCzBlC5ynbHMbwgUuvBwt5t3+xwz2eHe0TL3D5U901zyc
         qhcHGltnducbroD7jd7brC9Q//3LtRxqBUcWowUL4YQT1GT8DtfPS+551kE6+0Nmcz5c
         EYlQX683qgzPezRTGFgRqOOO/13L/UFXwGqSjQumDzYBFXcHhCmL1dIJAj5iu+uiOUjd
         Cv83EvuTnnWrIqi1cuhnLbGz1nChQxB95Vc3EB/hAezMgOCYmAGDu/mCe6SItsqT9gqp
         kr1Q==
X-Gm-Message-State: ABuFfohBGtXsYyE3IgNutbyxMAo9E1wrn7QrePMu0XgddX8aAvcVdKiW
        BZqed1UrKZwfPfcBEzfe2F/n5wPK
X-Google-Smtp-Source: ACcGV61gmWGS7qZ0fXHi5++ASyz3xyIZvRn2eBFfnaHIVWNxBnEHEbHe8poUAzNkIZuUuH3kl+Hqaw==
X-Received: by 2002:adf:db45:: with SMTP id f5-v6mr4871960wrj.237.1539341267243;
        Fri, 12 Oct 2018 03:47:47 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id o126-v6sm738850wmo.3.2018.10.12.03.47.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Oct 2018 03:47:46 -0700 (PDT)
Date:   Fri, 12 Oct 2018 12:47:44 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Ingo Molnar <mingo@elte.hu>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: linux-next: manual merge of the tip tree with Linus' tree
Message-ID: <20181012104744.GA105548@gmail.com>
References: <20181012131444.605564b5@canb.auug.org.au>
 <CAGXu5jKVnDhu5sv+K+W=AWg0BqtTfoK9=1m6u-0dpDxP9ow74Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5jKVnDhu5sv+K+W=AWg0BqtTfoK9=1m6u-0dpDxP9ow74Q@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Kees Cook <keescook@chromium.org> wrote:

> On Thu, Oct 11, 2018 at 7:14 PM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > Hi all,
> >
> > Today's linux-next merge of the tip tree got a conflict in:
> >
> >   arch/x86/mm/pgtable.c
> >
> > between commit:
> >
> >   184d47f0fd36 ("x86/mm: Avoid VLA in pgd_alloc()")
> >
> > from Linus' tree and commit:
> >
> >   1be3f247c288 ("x86/mm: Avoid VLA in pgd_alloc()")
> >
> > from the tip tree.
> >
> > I fixed it up (I used the version from Linus' tree) and can carry the
> > fix as necessary. This is now fixed as far as linux-next is concerned,
> > but any non trivial conflicts should be mentioned to your upstream
> > maintainer when your tree is submitted for merging.  You may also want
> > to consider cooperating with the maintainer of the conflicting tree to
> > minimise any particularly complex conflicts.

This is the correct resolution, thanks Stephen!

> Ingo, it looks like that commit needs to be split up again ... Linus's
> tree still needs the fix for the fix?

-next still had the old commit, I've now refreshed tip:auto-latest so the
conflict should go away in the next iteration.

Linus's tree has the correct fix.

Thanks,

	Ingo
