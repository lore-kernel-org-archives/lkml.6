Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B69EC004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 09:14:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 469712075D
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 09:14:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="B+Ih6l3B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 469712075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727885AbeJXRmM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 13:42:12 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:41412 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726256AbeJXRmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 13:42:12 -0400
Received: by mail-ed1-f67.google.com with SMTP id x31-v6so4312635edd.8
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 02:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Rll5fRjdmRFE9SuJ9NXDroqWqJU9sfTs/EaQEL0iybE=;
        b=B+Ih6l3Bihp1w/AiucB+nR7l2NAkAXqODlTecCLDhGQO7uhbVf2hb+rzCdoH8+rZEQ
         ozN+WOUnovPJwV4e0wcqqhlc3yn0bgTmCbXPWkmiofzDPsGVx/BQo3clLcNdn2PtBmLj
         hIhsrdjRxCZMn6f7VXy0abJt2NLxmg1MKsgJo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=Rll5fRjdmRFE9SuJ9NXDroqWqJU9sfTs/EaQEL0iybE=;
        b=tjVpCzG4cF7aV7h8/8kHt3f65v0H5pvB7m+X8LBs8PPYVjwAAQf9ZbNUKktcsu4581
         0qnZBnGP4rdAHzzBznJbkArICNiWpNMer0g5roDmh4hkxclR2gTk1HUtjAyFYRPB5kWF
         Z1nM1X0EKaQRQAEprHxoyPEX+HmvO5Oxn/xDzgtT9J3XHXgLS+AR85iXupWNDoDsEYoL
         dH2ag+u0lXw3b6FfCB1WAnmhl5p6Qm7kxmY92wJgGcaSizPuTkusLrafdBsIPVwuANhU
         GNI80jWQoF/d9YRyBO/4ccLOqHyHwW2myEkxmyBM+7iGUo8NjLgSWDgGUeZuBSWNxmcD
         cfvQ==
X-Gm-Message-State: AGRZ1gJv3Yhe6xbNAPEj9s6djPKRmA7oRuEQeE6Gjg7Q/fwpKXCuGMKu
        XH5pQRUM2ejHmHR2lNKsSuM6Wg==
X-Google-Smtp-Source: AJdET5dnSrBqha6pB/z87ZBkiF98OMq/X1IBy3l0sjtxePRS2VRcW/ARusS1HrAz8t+yD8dKDvUKgQ==
X-Received: by 2002:a17:906:454:: with SMTP id e20-v6mr936856eja.167.1540372492540;
        Wed, 24 Oct 2018 02:14:52 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id p13-v6sm867903ejg.57.2018.10.24.02.14.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Oct 2018 02:14:51 -0700 (PDT)
Date:   Wed, 24 Oct 2018 11:14:49 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     gregkh@linuxfoundation.org, keescook@google.com, mcgrof@kernel.org,
        shuah@kernel.org, joel@jms.id.au, mpe@ellerman.id.au,
        joe@perches.com, brakmo@fb.com, rostedt@goodmis.org,
        Tim.Bird@sony.com, khilman@baylibre.com, julia.lawall@lip6.fr,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, jdike@addtoit.com, richard@nod.at,
        linux-um@lists.infradead.org, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, robh@kernel.org,
        dan.j.williams@intel.com, linux-nvdimm@lists.01.org,
        kieran.bingham@ideasonboard.com
Subject: Re: [RFC v2 00/14] kunit: introduce KUnit, the Linux kernel unit
 testing framework
Message-ID: <20181024091449.GL324@phenom.ffwll.local>
Mail-Followup-To: Brendan Higgins <brendanhiggins@google.com>,
        gregkh@linuxfoundation.org, keescook@google.com, mcgrof@kernel.org,
        shuah@kernel.org, joel@jms.id.au, mpe@ellerman.id.au,
        joe@perches.com, brakmo@fb.com, rostedt@goodmis.org,
        Tim.Bird@sony.com, khilman@baylibre.com, julia.lawall@lip6.fr,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, jdike@addtoit.com, richard@nod.at,
        linux-um@lists.infradead.org, dri-devel@lists.freedesktop.org,
        robh@kernel.org, dan.j.williams@intel.com,
        linux-nvdimm@lists.01.org, kieran.bingham@ideasonboard.com
References: <20181023235750.103146-1-brendanhiggins@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181023235750.103146-1-brendanhiggins@google.com>
X-Operating-System: Linux phenom 4.18.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 23, 2018 at 04:57:36PM -0700, Brendan Higgins wrote:
> This patch set proposes KUnit, a lightweight unit testing and mocking
> framework for the Linux kernel.
> 
> Unlike Autotest and kselftest, KUnit is a true unit testing framework;
> it does not require installing the kernel on a test machine or in a VM
> and does not require tests to be written in userspace running on a host
> kernel. Additionally, KUnit is fast: From invocation to completion KUnit
> can run several dozen tests in under a second. Currently, the entire
> KUnit test suite for KUnit runs in under a second from the initial
> invocation (build time excluded).
> 
> KUnit is heavily inspired by JUnit, Python's unittest.mock, and
> Googletest/Googlemock for C++. KUnit provides facilities for defining
> unit test cases, grouping related test cases into test suites, providing
> common infrastructure for running tests, mocking, spying, and much more.
> 
> ## What's so special about unit testing?
> 
> A unit test is supposed to test a single unit of code in isolation,
> hence the name. There should be no dependencies outside the control of
> the test; this means no external dependencies, which makes tests orders
> of magnitudes faster. Likewise, since there are no external dependencies,
> there are no hoops to jump through to run the tests. Additionally, this
> makes unit tests deterministic: a failing unit test always indicates a
> problem. Finally, because unit tests necessarily have finer granularity,
> they are able to test all code paths easily solving the classic problem
> of difficulty in exercising error handling code.
> 
> ## Is KUnit trying to replace other testing frameworks for the kernel?
> 
> No. Most existing tests for the Linux kernel are end-to-end tests, which
> have their place. A well tested system has lots of unit tests, a
> reasonable number of integration tests, and some end-to-end tests. KUnit
> is just trying to address the unit test space which is currently not
> being addressed.
> 
> ## More information on KUnit
> 
> There is a bunch of documentation near the end of this patch set that
> describes how to use KUnit and best practices for writing unit tests.
> For convenience I am hosting the compiled docs here:
> https://google.github.io/kunit-docs/third_party/kernel/docs/
> 
> ## Changes Since Last Version
> 
>  - Updated patchset to apply cleanly on 4.19.
>  - Stripped down patchset to focus on just the core features (I dropped
>    mocking, spying, and the MMIO stuff for now; you can find these
>    patches here: https://kunit-review.googlesource.com/c/linux/+/1132),
>    as suggested by Rob.
>  - Cleaned up some of the commit messages and tweaked commit order a
>    bit based on suggestions.

Do you have some example unit tests somewhere? The docs are all neat, but
real example helps a lot with the tried&true art of copypasting :-)

I'd like to give this a test spin with some of the unit tests we already
have in drm. And especially figuring out how we could integrate this with
our existing infrastructure.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
