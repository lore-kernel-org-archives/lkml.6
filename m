Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88989ECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 09:08:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EC0521523
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 09:08:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="dStrq5uY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EC0521523
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbeJQRDJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 13:03:09 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33684 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726964AbeJQRDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 13:03:08 -0400
Received: by mail-ed1-f68.google.com with SMTP id l14-v6so15141280edq.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 02:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=xFeAn0Md0DOhEPy2vuKmIJiDNrUMQMrsi2vip2Gh92k=;
        b=dStrq5uY7QG46KSaszPThv5ad3BWhu7ICtP6VfDeroP8CdnxH3q3X3tTyN843Fzq5k
         t3kASHFx4c8esYPlCWpykYnrsX2PjHmFDcHPl0Xc+LU8BCY/vzHjusdxCYAd3M2kq2+A
         AwwqiXZW8PtzMSHo3TPSSLxGI/aT0iLCBxWN0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=xFeAn0Md0DOhEPy2vuKmIJiDNrUMQMrsi2vip2Gh92k=;
        b=HnwyoYiVSDLZH24ELU9mmQKga98+KXQLJ9d8X05jCEI56+YG2NXqY3CVsMSucUZvt9
         Ucu24SHoU5vJlBRmKgKBaNKiKAAf/p8vd38KQm4ErdllR1wTUVH7srW8j1nZWMiL9/fa
         Twv6tcoWhDVSi8bcCi9cgcVr/2Sp3ofge8D2U1hOuzGFkAsdHqVfHBS6vKZwkb/lwKC7
         GyO4+e+FR4umh6Q2ugbquN2EREn20NALpuprp2347WgS+LftTn32oQNdf5vOR3SgATAE
         WZt+KVev63NRYFxgpNfTIE8UJfFoMErCbFI6Vkmkuw0ePEh5LTo4E3rDfr2VZcOdhlud
         g0iw==
X-Gm-Message-State: ABuFfohLWWhva4bvONx+BNtnF+7XZ+l+9tKOWhzuK3dbDUoOILJpFQ8P
        Tg2UgT6z6ODYoSeYr7IlbRPDMQ==
X-Google-Smtp-Source: ACcGV60SddTGIx4G66wZZJCaEPz64bdOETjFk451PJjfGgx50/WDbafqfliDDf7b+wbVqKrUr1x3aA==
X-Received: by 2002:a50:9247:: with SMTP id j7-v6mr31515eda.124.1539767302305;
        Wed, 17 Oct 2018 02:08:22 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id p23-v6sm3479786ejj.16.2018.10.17.02.08.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Oct 2018 02:08:21 -0700 (PDT)
Date:   Wed, 17 Oct 2018 11:08:19 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     gregkh@linuxfoundation.org, keescook@google.com, mcgrof@kernel.org,
        shuah@kernel.org, joel@jms.id.au, mpe@ellerman.id.au,
        joe@perches.com, brakmo@fb.com, rostedt@goodmis.org,
        Tim.Bird@sony.com, khilman@baylibre.com, julia.lawall@lip6.fr,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, jdike@addtoit.com, richard@nod.at,
        linux-um@lists.infradead.org,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        IGT development <igt-dev@lists.freedesktop.org>
Subject: Re: [RFC v1 00/31] kunit: Introducing KUnit, the Linux kernel unit
 testing framework
Message-ID: <20181017090819.GM31561@phenom.ffwll.local>
Mail-Followup-To: Brendan Higgins <brendanhiggins@google.com>,
        gregkh@linuxfoundation.org, keescook@google.com, mcgrof@kernel.org,
        shuah@kernel.org, joel@jms.id.au, mpe@ellerman.id.au,
        joe@perches.com, brakmo@fb.com, rostedt@goodmis.org,
        Tim.Bird@sony.com, khilman@baylibre.com, julia.lawall@lip6.fr,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, jdike@addtoit.com, richard@nod.at,
        linux-um@lists.infradead.org,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        IGT development <igt-dev@lists.freedesktop.org>
References: <20181016235120.138227-1-brendanhiggins@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181016235120.138227-1-brendanhiggins@google.com>
X-Operating-System: Linux phenom 4.14.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 04:50:49PM -0700, Brendan Higgins wrote:
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

We've started our own unit test framework (very early, and not any real
infrastructure yet) under drivers/gpu/drm/selftests. They're all meant to
test functions and small pieces of functionality of our libraries in
isolation, without any need for a real (or virtual) gpu driver. It kinda
integrates both with kselftests and with our graphics test suite, but
directly running tests using UML as part of the build process sounds much,
much better. Having proper and standardized infrastructure for kernel unit
tests sounds terrific.

In other words: I want.

Please keep dri-devel@lists.freedesktop.org in the loop on future
versions.

Cheers, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
