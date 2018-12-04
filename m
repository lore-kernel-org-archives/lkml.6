Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33029C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 20:47:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA7012081C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 20:47:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA7012081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbeLDUrI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 15:47:08 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46164 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbeLDUrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 15:47:08 -0500
Received: by mail-pg1-f196.google.com with SMTP id w7so7897639pgp.13;
        Tue, 04 Dec 2018 12:47:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EAc4lCmY0yadE1AoTBlcoZQRBo0k/c2Arl6SJg1xnvU=;
        b=s9FYXysZtlBtXKahBU1M2iXoGn05HzZiyPoH/MuT8buRS3tk+mymtkqhZLToWV4Uta
         1tpFlqZIyMsnIUZK3/NCMMo+ZkRzMKpgCNKUJ+8cL4BxhUEvCgK70kGzaa57XKXMaTmT
         Fp//8xzg4m7M/Cv0OGG1AMxtRFxKbC8vi7KIRVECwC7xPgYZ2iSN1d67uI0Lzubf39OQ
         LbrSdaQbs03zsyVBTHFwu13Dm6nG2/uXbGPrTkKC8urN7XxKxkazzYop5qnYgRocszkZ
         3jHSAvNqPQxFSkVGOkggmDktTnKDwVnD3EpjYPTRPRG52q8Fy2HWEoWGQKoZ79xepDM5
         ObUg==
X-Gm-Message-State: AA+aEWaLc++61vOovO2BbvaeOB5aqpP45grxXIG+Y0bnO9WPtEwDGBEk
        5z0byh4ZIwNsbJyNggFwH1M=
X-Google-Smtp-Source: AFSGD/VWq9kCFTGEw590G9vOYh0sasKBPRLPpURfKGVQ0rfXHiUBTuCNsY3rwKZcDOArOr+XbyEnbw==
X-Received: by 2002:a62:8d4f:: with SMTP id z76mr22223261pfd.2.1543956426563;
        Tue, 04 Dec 2018 12:47:06 -0800 (PST)
Received: from garbanzo.do-not-panic.com (c-73-71-40-85.hsd1.ca.comcast.net. [73.71.40.85])
        by smtp.gmail.com with ESMTPSA id z7sm32180007pga.6.2018.12.04.12.47.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Dec 2018 12:47:05 -0800 (PST)
Received: by garbanzo.do-not-panic.com (sSMTP sendmail emulation); Tue, 04 Dec 2018 12:47:01 -0800
Date:   Tue, 4 Dec 2018 12:47:01 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Brendan Higgins <brendanhiggins@google.com>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Eryu Guan <guaneryu@gmail.com>,
        Eric Sandeen <sandeen@sandeen.net>, jeffm@suse.com,
        Sasha Levin <Alexander.Levin@microsoft.com>
Cc:     kieran.bingham@ideasonboard.com,
        Greg KH <gregkh@linuxfoundation.org>,
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
        Frank Rowand <frowand.list@gmail.com>,
        Knut Omang <knut.omang@oracle.com>,
        Felix Guo <felixguoxiuping@gmail.com>,
        Petr Mladek <pmladek@suse.com>, fsdevel@vger.kernel.org
Subject: Re: [RFC v3 11/19] kunit: add Python libraries for handing KUnit
 config and kernel
Message-ID: <20181204204701.GT28501@garbanzo.do-not-panic.com>
References: <20181128193636.254378-1-brendanhiggins@google.com>
 <20181128193636.254378-12-brendanhiggins@google.com>
 <841cf4ae-501b-05ae-5863-a51010709b67@ideasonboard.com>
 <CAFd5g47x-UNja72k-CWPmWz9+LTn8pF8Wj5Poq+2FJ93E=vymA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFd5g47x-UNja72k-CWPmWz9+LTn8pF8Wj5Poq+2FJ93E=vymA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 03, 2018 at 03:48:15PM -0800, Brendan Higgins wrote:
> On Thu, Nov 29, 2018 at 5:54 AM Kieran Bingham
> <kieran.bingham@ideasonboard.com> wrote:
> >
> > Hi Brendan,
> >
> > Thanks again for this series!
> >
> > On 28/11/2018 19:36, Brendan Higgins wrote:
> > > The ultimate goal is to create minimal isolated test binaries; in the
> > > meantime we are using UML to provide the infrastructure to run tests, so
> > > define an abstract way to configure and run tests that allow us to
> > > change the context in which tests are built without affecting the user.
> > > This also makes pretty and dynamic error reporting, and a lot of other
> > > nice features easier.
> >
> >
> > I wonder if we could somehow generate a shared library object
> > 'libkernel' or 'libumlinux' from a UM configured set of headers and
> > objects so that we could create binary targets directly ?
> 
> That's an interesting idea. I think it would be difficult to figure
> out exactly where to draw the line of what goes in there and what
> needs to be built specific to a test a priori. Of course, that leads
> into the biggest problem in general, needed to know what I need to
> build to test the thing that I want to test.
> 
> Nevertheless, I could definitely imagine that being useful in a lot of cases.

Whether or not we can abstract away the kernel into such a mechanism
with uml libraries is a good question worth exploring.

Developers working upstream do modify their kernels a lot, so we'd have
to update such libraries quite a bit, but I think that's fine too. The
*real* value I think from the above suggestion would be enterprise /
mobile distros or stable kernel maintainers which have a static kernel
they need to support for a relatively *long time*, consider a 10 year
time frame. Running unit tests without qemu with uml and libraries for
respective kernels seems real worthy.

The overhead for testing a unit test for said targets, *ideally*, would
just be to to reboot into the system with such libraries available, a
unit test would just look for the respective uname -r library and mimic
that kernel, much the same way enterprise distributions today rely on
having debugging symbols available to run against crash / gdb. Having
debug modules / kernel for crash requires such effort already, so this
would just be an extra layer of other prospect tests.

All ideaware for now, but the roadmap seems to be paving itself.

  Luis
