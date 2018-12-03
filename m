Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D3F3C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 23:48:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04DFF20666
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 23:48:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AtZgMxpc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04DFF20666
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726027AbeLCXs3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 18:48:29 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:33855 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbeLCXs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 18:48:29 -0500
Received: by mail-oi1-f196.google.com with SMTP id h25so12686707oig.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 15:48:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FFnzHjzIqoVXouVFnVR88o29Z2x+TykD38ltC36J8Uo=;
        b=AtZgMxpcG5LTnOGf6okC1b8gaJQcJVljKcDkoSE9Ef/A1WxY97rl57Bbymi9ILzzUJ
         5n529l+pOFHN8ubRH4+03JMVv0aUszM2RMZL7CibTisrQXY3OPSPYvM6k6+JpMcSat2s
         l9vmwdCsnuYXa/5Pi49SXK0CeOQJ8BMa8cHg65RRdrtoMi1xnvtybpJtp34WMNRFkagH
         anG6zVOMVLRB1dUEnu8kOUw4O0U1AWR29tc9jUK7eeimsUi3KmiQJoxo/Db9uh7lUAiq
         pkUE0gJWk/FLyotM1dEdydBKqbEXTbLJCOrA9AxGRYVzVGZ3b1Ytn76nMrpTyIVd4959
         ux3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FFnzHjzIqoVXouVFnVR88o29Z2x+TykD38ltC36J8Uo=;
        b=tU8h5Zb0BD9MrIMJczmY23FLOW45lzOmNWySQukbm9IDEtNJ2Cnm0hKMVybrBF51lq
         E1PDrWJnfCaIh4WSKHqvcysCD7v6GSmN0U3SYqs94OzruxH0h4JI95zQV/b9AcSk3QAP
         1iSDVLnOqGWt3S/HMgBXJ/QmgctBqjMOUNdEsz0DGEZhFuNYWt7oObO6RozMaSZA7pp3
         ZWLM2EIslhaTh3qhQiYOmXtqU6bX43i4tmzcyFUfP/7HHv2kDAO1TkPdAxJ7I3ePJduU
         wAEvCnhYi25rw74EniU8w98mHt8ZD6n/yekNU+ojDR1jMvtXwdfUUr4h2FPjH7NTY68T
         gfag==
X-Gm-Message-State: AA+aEWbmg+vBI9Yq0f0eRf6ZMIqxEJKCh00k/FKmByTZ3u8l2CcdNDr6
        mSmDVwj8GeDXrXArWNIofmDn206qC63oYYHIkuNKcg==
X-Google-Smtp-Source: AFSGD/XgaiPLBiw4Uoq1n8D2Qhc6YOuIriSmLH093xe5kIzhBj0zl+Oj3zJbBZQq+Ulf3I0zmhmfr8+SNdMXOhPzLQc=
X-Received: by 2002:aca:bd41:: with SMTP id n62mr11613998oif.348.1543880906906;
 Mon, 03 Dec 2018 15:48:26 -0800 (PST)
MIME-Version: 1.0
References: <20181128193636.254378-1-brendanhiggins@google.com>
 <20181128193636.254378-12-brendanhiggins@google.com> <841cf4ae-501b-05ae-5863-a51010709b67@ideasonboard.com>
In-Reply-To: <841cf4ae-501b-05ae-5863-a51010709b67@ideasonboard.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 3 Dec 2018 15:48:15 -0800
Message-ID: <CAFd5g47x-UNja72k-CWPmWz9+LTn8pF8Wj5Poq+2FJ93E=vymA@mail.gmail.com>
Subject: Re: [RFC v3 11/19] kunit: add Python libraries for handing KUnit
 config and kernel
To:     kieran.bingham@ideasonboard.com
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@google.com>, mcgrof@kernel.org,
        shuah@kernel.org, Joel Stanley <joel@jms.id.au>,
        mpe@ellerman.id.au, joe@perches.com, brakmo@fb.com,
        rostedt@goodmis.org, Tim.Bird@sony.com, khilman@baylibre.com,
        Julia Lawall <julia.lawall@lip6.fr>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jdike@addtoit.com, richard@nod.at, linux-um@lists.infradead.org,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, Rob Herring <robh@kernel.org>,
        dan.j.williams@intel.com, linux-nvdimm@lists.01.org,
        Frank Rowand <frowand.list@gmail.com>,
        Knut Omang <knut.omang@oracle.com>,
        Felix Guo <felixguoxiuping@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 5:54 AM Kieran Bingham
<kieran.bingham@ideasonboard.com> wrote:
>
> Hi Brendan,
>
> Thanks again for this series!
>
> On 28/11/2018 19:36, Brendan Higgins wrote:
> > The ultimate goal is to create minimal isolated test binaries; in the
> > meantime we are using UML to provide the infrastructure to run tests, so
> > define an abstract way to configure and run tests that allow us to
> > change the context in which tests are built without affecting the user.
> > This also makes pretty and dynamic error reporting, and a lot of other
> > nice features easier.
>
>
> I wonder if we could somehow generate a shared library object
> 'libkernel' or 'libumlinux' from a UM configured set of headers and
> objects so that we could create binary targets directly ?

That's an interesting idea. I think it would be difficult to figure
out exactly where to draw the line of what goes in there and what
needs to be built specific to a test a priori. Of course, that leads
into the biggest problem in general, needed to know what I need to
build to test the thing that I want to test.

Nevertheless, I could definitely imagine that being useful in a lot of cases.

> > diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
> > new file mode 100644
> > index 0000000000000..bba7ea7ca1869
> > --- /dev/null
> > +++ b/tools/testing/kunit/kunit_kernel.py
...
> > +     def make(self, jobs):
> > +             try:
> > +                     subprocess.check_output([
> > +                                     'make',
> > +                                     'ARCH=um',
> > +                                     '--jobs=' + str(jobs)])
>
> Perhaps as a future extension:
>
> It would be nice if we could set an O= here to keep the source tree
> pristine.
>
> In fact I might even suggest that this should always be set so that the
> unittesting could live along side an existing kernel build? :
>
>  O ?= $KBUILD_SRC/
>  O := $(O)/kunittest/$(ARCH)/build

I agree with that. It would be pretty annoying to run a unit test and
have it mess up your .config and force you to rebuild everything else.
(I have actually done this to myself a couple of times...)

Cheers
