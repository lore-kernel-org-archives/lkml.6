Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68EC5C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 20:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33E282081C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 20:48:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33E282081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbeLDUsQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 15:48:16 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38517 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbeLDUsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 15:48:15 -0500
Received: by mail-pg1-f194.google.com with SMTP id g189so7910255pgc.5;
        Tue, 04 Dec 2018 12:48:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ATZABLl9Bqbp1x1mZMnGmiXL3gq2GOvFyXJbrsiveeI=;
        b=UAobD5kCs4t6TsC6Ip4VXK53MkJ8pHBUrnuEQDzWH5h53tcF7KRWplFS0GbK+LSPQH
         mxAXpXWzpKlQwK+5BwgDVimTGEINGV+HzazWsgOgSEpdSKoVhfinipl1lShVBirVED2m
         Bv3SaDpcevMo4LYUHxxzbg1jrMD/BrCVQwgEMuVHnEjqGTC8hPqB2A/9aODKBcAuRETx
         9Efib6MpRZXvVCRXSBBZPMfOD+McUGam5FIqKq7cgo0jb4fAlKAngNZlTFx3+d6CInbJ
         9F0Pn9CuXDIv7/tY+U3OLRjIEwShJVSxzb436pdsm8wOmgAXUyMvFgQHjtvJ5+XP4CVH
         4/Yw==
X-Gm-Message-State: AA+aEWaXf3hLw4i6sjjiyrL5XBR6ucWis0puDPJbwxHuC7BgAOOW1pBj
        UkRBfNzrVloWD1CObm+nEEQ=
X-Google-Smtp-Source: AFSGD/Vdn1T0BG6alMhunJUXrxgIuveC+wGVaaou8MIb4wLy8h5txEMQsvEMhgnn13OZfYN/j/ELEA==
X-Received: by 2002:a63:d40a:: with SMTP id a10mr17694223pgh.394.1543956494466;
        Tue, 04 Dec 2018 12:48:14 -0800 (PST)
Received: from garbanzo.do-not-panic.com (c-73-71-40-85.hsd1.ca.comcast.net. [73.71.40.85])
        by smtp.gmail.com with ESMTPSA id q75sm35343000pfa.38.2018.12.04.12.48.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Dec 2018 12:48:13 -0800 (PST)
Received: by garbanzo.do-not-panic.com (sSMTP sendmail emulation); Tue, 04 Dec 2018 12:48:10 -0800
Date:   Tue, 4 Dec 2018 12:48:10 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@google.com>, shuah@kernel.org,
        Joel Stanley <joel@jms.id.au>, mpe@ellerman.id.au,
        joe@perches.com, brakmo@fb.com, rostedt@goodmis.org,
        Tim.Bird@sony.com, khilman@baylibre.com,
        Julia Lawall <julia.lawall@lip6.fr>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jdike@addtoit.com, richard@nod.at, linux-um@lists.infradead.org,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, Rob Herring <robh@kernel.org>,
        dan.j.williams@intel.com, linux-nvdimm@lists.01.org,
        kieran.bingham@ideasonboard.com,
        Frank Rowand <frowand.list@gmail.com>,
        Knut Omang <knut.omang@oracle.com>,
        Felix Guo <felixguoxiuping@gmail.com>
Subject: Re: [RFC v3 11/19] kunit: add Python libraries for handing KUnit
 config and kernel
Message-ID: <20181204204810.GU28501@garbanzo.do-not-panic.com>
References: <20181128193636.254378-1-brendanhiggins@google.com>
 <20181128193636.254378-12-brendanhiggins@google.com>
 <20181130034425.GO18410@garbanzo.do-not-panic.com>
 <CAFd5g44L1dV61CPm9GUvOgs-tH_urN-Twm-fj=Pw6h-kgfZ5rQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFd5g44L1dV61CPm9GUvOgs-tH_urN-Twm-fj=Pw6h-kgfZ5rQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 03, 2018 at 03:50:48PM -0800, Brendan Higgins wrote:
> On Thu, Nov 29, 2018 at 7:44 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> >
> > On Wed, Nov 28, 2018 at 11:36:28AM -0800, Brendan Higgins wrote:
> > > The ultimate goal is to create minimal isolated test binaries; in the
> > > meantime we are using UML to provide the infrastructure to run tests, so
> > > define an abstract way to configure and run tests that allow us to
> > > change the context in which tests are built without affecting the user.
> > > This also makes pretty and dynamic error reporting, and a lot of other
> > > nice features easier.
> > >
> > > kunit_config.py:
> > >   - parse .config and Kconfig files.
> > >
> > >
> > > kunit_kernel.py: provides helper functions to:
> > >   - configure the kernel using kunitconfig.
> >
> > We get the tools to run the config stuff, build, etc, but not a top
> > level 'make kunitconfig' or whatever. We have things like 'make
> > kvmconfig' and 'make xenconfig', I think it would be reasonable to
> > add similar for this.
> 
> Are you just asking for a defconfig for KUnit, or are you asking for a
> way to run KUnit from make?

At least the first. The later seems intrusive as a top level Makefile
thing.

  Luis
