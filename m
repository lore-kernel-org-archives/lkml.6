Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92CB2C677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:37:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52EEC20644
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:37:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52EEC20644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbeJHWt5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 18:49:57 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:43480 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726977AbeJHWt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 18:49:56 -0400
Received: by mail-lf1-f66.google.com with SMTP id p34-v6so14247691lfg.10;
        Mon, 08 Oct 2018 08:37:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=toSEbHkjbqE84TJ4IKHTjjCp5FiiMMY43inH3kwYcgk=;
        b=kZeLxsrZxdBtiF/7yRcBnPL5APVfGziI6KcZf0GHCY5usbbxLpNJKUqkenTmtlZt7J
         rQyTICYBf2B71RCBWhET5tgNRhh+B5u08QLUYMgQLS406Ufg2yOlg2kiNOABY8Kl0biK
         VLZ9NjKPRjyhw8d2jIx9nf/X2fNrr/ymI2nCNDTuxwbqCQfoj+rcDMxM57lYBpmMn46P
         IjCh3U/bi/5vTjbJIbhOuhYM3LSIOeZVJtTKspMUjnKHsYLbx11oeZJaLcDJlTC6/4to
         zjHPB+GTVKskA+zu5SvXZAe7wLjLHX4p1/rVg4FPLtnxwud1N+wXaeXJkpX/NXibFcwb
         7qeA==
X-Gm-Message-State: ABuFfoit2PGlXrrELJ8udQXiaPPt/727KpyL273l13FJx40TlxhLhyqV
        b3xtjPrOToYXgsYLTKqgJPtHlfQq/ZjbHSyh1VY5lJPR
X-Google-Smtp-Source: ACcGV62lAnLa4KheKEOXOcAI5/5z0Ef7vClbwAwhnkW4eyWRlMncmQG3NK+hihJuau1AZgFbM92fEYwIXd2i1DN7fIM=
X-Received: by 2002:a19:6f0a:: with SMTP id k10-v6mr13682985lfc.8.1539013056560;
 Mon, 08 Oct 2018 08:37:36 -0700 (PDT)
MIME-Version: 1.0
References: <20181005161845.959919-1-arnd@arndb.de> <CAOi1vP8Wy0DjEWBWh05iSx-RJS41hTc1rs2TXdz_1mcNpf68Dg@mail.gmail.com>
In-Reply-To: <CAOi1vP8Wy0DjEWBWh05iSx-RJS41hTc1rs2TXdz_1mcNpf68Dg@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 8 Oct 2018 17:37:19 +0200
Message-ID: <CAK8P3a0xpFdKC0AtBDC9UvMfwpx3HTbAdio4ApmYhrb2FakK9g@mail.gmail.com>
Subject: Re: [PATCH] ceph: use an enum instead of 'static const' to define constants
To:     Ilya Dryomov <idryomov@gmail.com>
Cc:     Zheng Yan <zyan@redhat.com>, Sage Weil <sage@redhat.com>,
        gregkh <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        lhenriques@suse.com, ceph-devel <ceph-devel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 8, 2018 at 4:23 PM Ilya Dryomov <idryomov@gmail.com> wrote:
> On Fri, Oct 5, 2018 at 6:18 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > @@ -71,7 +71,7 @@
> >   * This ensures that no two versions who have different meanings for
> >   * the bit ever speak to each other.
> >   */
> > -
> > +enum ceph_features {
> >  DEFINE_CEPH_FEATURE( 0, 1, UID)
> >  DEFINE_CEPH_FEATURE( 1, 1, NOSRCADDR)
> >  DEFINE_CEPH_FEATURE_RETIRED( 2, 1, MONCLOCKCHECK, JEWEL, LUMINOUS)
> > @@ -170,13 +170,13 @@ DEFINE_CEPH_FEATURE(61, 1, CEPHX_V2)             // *do not share this bit*
> >
> >  DEFINE_CEPH_FEATURE(62, 1, RESERVED)           // do not use; used as a sentinal
> >  DEFINE_CEPH_FEATURE_DEPRECATED(63, 1, RESERVED_BROKEN, LUMINOUS) // client-facing
> > -
> > +};
>
> I don't particularly like this because it looks like lower constants
> are actually ints and the rest are unsigned longs, even though they all
> have ULL suffixes.  The standard seems to require that enum constants
> be representable as ints, is the non-pedantic behaviour documented
> somewhere?

I had not realized that this is a gcc extension, or that it behaves slightly
differently from the standard C++ behavior that apparently adopted a
saner variant (all values in an enum have the same type).

How about we just add a __maybe_unused to DEFINE_CEPH_FEATURE
then to shut up the warning?

     Arnd
