Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13D4EC2BC61
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 19:21:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF8C020843
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 19:21:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="iNsY5Ex+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF8C020843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbeJ2EHP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 00:07:15 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45118 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726223AbeJ2EHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 00:07:14 -0400
Received: by mail-lj1-f196.google.com with SMTP id j4-v6so5702214ljc.12
        for <linux-kernel@vger.kernel.org>; Sun, 28 Oct 2018 12:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WQpjYn9zfe9ct8Uw61+9tl/qf/I14V+Tlh3I4c+szx0=;
        b=iNsY5Ex+nY5xcFb4um1dLE1RqImv23s2MHS45/PC2EYpmIEVW//ACqUNGDI0Hn8uTB
         YBrjx+W2MaId1t6cfi3n9dK6vwaabsXJxmO/MrLnHtq2gNNFKmQBoQtTz6ibjrCj8+yE
         icUyoF6wmgdtDAzh0M/VEdXA6fYQRCW+tBEUE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WQpjYn9zfe9ct8Uw61+9tl/qf/I14V+Tlh3I4c+szx0=;
        b=tzn1df9aLUb0qti+SmWKtTuquhxRCaeQAtRRZWl2/26Ot4jlDs+DlyuOHgHfVY2s5r
         S/dcnebPZc/HDkMVqlcasv5YUKWOO+2BWsJq32kSuuvi2xYyiaCH/vwJKBpKXEUQHf+2
         l8uJ+khY7ZmwPmrXacTNFeNzVWH7oZOSHpmaNiyQkc67CoO2/JaNGPyJdMUkKAK8tJFX
         KB9VnONppfD8myDsrUCOJ18rKCGhmAMqnnX5mXKrBzjSVnL2vYrW26oZ6VgA1hxqB7lj
         P5mVuMR2heGzW3DkgGPfM+76LzYo+e1y0aTQ38eoeNlHTBD4WmsxbMW+nUxUmJegw+Hg
         8POg==
X-Gm-Message-State: AGRZ1gLxIel59v1lJMWU3jgjgREda5C4HwP+KXF2hdoR0Jt34+03OJgI
        psK/E+8HazXLGwU6ac9El8Dg5PgOQ6I=
X-Google-Smtp-Source: AJdET5chkm+ggGQQxCJ0qfB9VGN/+LcpK6IWvdAQiEHmkMfM0aElfJ0i9F9i92haAWg4L1yfBXhKxA==
X-Received: by 2002:a2e:2f1b:: with SMTP id v27-v6mr7136855ljv.31.1540754497090;
        Sun, 28 Oct 2018 12:21:37 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id v18-v6sm2659512lja.26.2018.10.28.12.21.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Oct 2018 12:21:36 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id g8-v6so2813943ljk.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Oct 2018 12:21:36 -0700 (PDT)
X-Received: by 2002:a2e:9983:: with SMTP id w3-v6mr1541724lji.133.1540754495718;
 Sun, 28 Oct 2018 12:21:35 -0700 (PDT)
MIME-Version: 1.0
References: <20181023200825.GA25444@bombadil.infradead.org>
 <CAHk-=whquhQQY38WRKYsi-_a2vD=_22EPEnfVj4+APEjZPAkMw@mail.gmail.com> <20181028191345.GA28520@bombadil.infradead.org>
In-Reply-To: <20181028191345.GA28520@bombadil.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 28 Oct 2018 12:21:19 -0700
X-Gmail-Original-Message-ID: <CAHk-=whygsqzudQZMNdYuYCcOaM-04f-O7ir73weF9g5Fzh33w@mail.gmail.com>
Message-ID: <CAHk-=whygsqzudQZMNdYuYCcOaM-04f-O7ir73weF9g5Fzh33w@mail.gmail.com>
Subject: Re: [GIT PULL] XArray for 4.20
To:     willy@infradead.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 28, 2018 at 12:13 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Sun, Oct 28, 2018 at 11:50:19AM -0700, Linus Torvalds wrote:
>
> > NOTE! I did get some conflicts with other stuff, and while the
> > conflict resolution all looked pretty straightforward, this does want
> > looking at.
> >
> > Particularly the mm/workingset.c code.
>
> I've been rebasing the xarray-conv branch on your tree pretty regularly
> this week, so I have a fairly good idea how I think it should look.
> I'll check to see if you & I have the same thoughts when you push it out.

It's pushed out now. I'm running the kernel now, but have done only
basic boot testing (in addition to my usual build tests), no real
stress-tests.

                          Linus
