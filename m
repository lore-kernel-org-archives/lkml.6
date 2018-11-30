Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF4A5C04EB9
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 00:59:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A33F820868
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 00:59:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A33F820868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727147AbeK3MHP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 07:07:15 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38726 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbeK3MHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 07:07:15 -0500
Received: by mail-pf1-f194.google.com with SMTP id q1so1904755pfi.5;
        Thu, 29 Nov 2018 16:59:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kfVXRjRZrPPrdiUZuAjzCn7iej00UTf1A9WV8y58yxE=;
        b=ub6//Qs13Jyn8WEyLwwYj7QtZEnhe/as0TS66+gB2MqJoRsf2go1FP9BTdmLl+oM7D
         hm3c7AHvoF2qhWIwEtaM+qZ1Jf/ioBcQDy9AiYJ5I9xNk7c51MWgRExhGFYxlI+NT35p
         bFTqWcyA8MSgPP3GxY30Xlus0FLUX9ZHM/1TO+ptMVtLoMLthx+gQtlZjuOekkj8CjOX
         459s0oHaPuaxtVjRmHrV/TmSnSbPMrGH4TecHcr4khnPv2s+QYe6Uc0jokWxsNZtXwwZ
         MdzbdeIg0dhC9Iz4C+IgfjhBzZ6iYXT+8p+D7x1kytoNtKT/0t6ZVrM1B3nJFYbsX540
         yHcw==
X-Gm-Message-State: AA+aEWZ/UcczsD1el/CjozolBKT5hgl2lG3EET507Af1d0VwXxGWarA1
        Lf9ABdo9+HTfVdtxQOt5cf8=
X-Google-Smtp-Source: AFSGD/WkG17m4Hd4xPw53F7EoAyeaaih9T+4HLo7jtIryNyNisTwTTpdVeKlVKfyCVf+5mqXQpfw5w==
X-Received: by 2002:a62:29c3:: with SMTP id p186mr3656331pfp.117.1543539587563;
        Thu, 29 Nov 2018 16:59:47 -0800 (PST)
Received: from garbanzo.do-not-panic.com (c-73-71-40-85.hsd1.ca.comcast.net. [73.71.40.85])
        by smtp.gmail.com with ESMTPSA id p2sm4915230pfp.125.2018.11.29.16.59.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Nov 2018 16:59:45 -0800 (PST)
Received: by garbanzo.do-not-panic.com (sSMTP sendmail emulation); Thu, 29 Nov 2018 16:59:42 -0800
Date:   Thu, 29 Nov 2018 16:59:42 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     shuah <shuah@kernel.org>
Cc:     Knut Omang <knut.omang@oracle.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@google.com>, brakmo@fb.com, richard@nod.at,
        dri-devel@lists.freedesktop.org, linux-nvdimm@lists.01.org,
        mpe@ellerman.id.au, Tim.Bird@sony.com,
        linux-um@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        rostedt@goodmis.org, kieran.bingham@ideasonboard.com,
        Julia Lawall <julia.lawall@lip6.fr>,
        Joel Stanley <joel@jms.id.au>, linux-kselftest@vger.kernel.org,
        khilman@baylibre.com, joe@perches.com, dan.j.williams@intel.com,
        jdike@addtoit.com, kunit-dev@googlegroups.com,
        hidenori.yamaji@sony.com, alan.maguire@oracle.com
Subject: Re: [RFC v2 00/14] kunit: introduce KUnit, the Linux kernel unit
 testing framework
Message-ID: <20181130005942.GL4922@garbanzo.do-not-panic.com>
References: <20181023235750.103146-1-brendanhiggins@google.com>
 <1543036529.4680.655.camel@oracle.com>
 <CAFd5g45oPSp870hJLDSHiMfU7Mh-EvpYcFdAaOQxecXNde5PSw@mail.gmail.com>
 <1543434888.4680.862.camel@oracle.com>
 <abf3aff0-dfb3-717e-f14f-02dbe5574f49@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abf3aff0-dfb3-717e-f14f-02dbe5574f49@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2018 at 01:50:01PM -0700, shuah wrote:
> On 11/28/18 12:54 PM, Knut Omang wrote:
> > On Mon, 2018-11-26 at 17:41 -0800, Brendan Higgins wrote:
> > Both approaches provide assertion macros for running tests inside the kernel,
> > I doubt the kernel community would like to see yet two such sets of macros,
> > with differing syntax merged. One of the good reasons to have a *framework*
> > is that it is widely used and understood, so that people coming from one part of the
> > kernel can easily run, understand and relate to selected tests from another part.
> > 
> > The goal with KTF is to allow this for any kernel, old or new, not just kernels
> > built specifically for testing purposes. We felt that providing it as a separate git
> > module (still open source, for anyone to contribute to) is a more efficient approach
> > until we have more examples and experience with using it in different parts
> > of the kernel. We can definitely post the kernel side of KTF as a patch series fairly soon
> > if the community wants us to. Except for hybrid tests, the ktf.ko module works fine
> > independently of any user side support, just using the debugfs interface to run and
> > examine tests.
> > 
> 
> Having test framework in the kernel sources tree has benefits. It allows
> us (kernel developers) to do co-development of kernel features and tests
> for these features.

Agreed!

> It encourages developers to write regression tests. More importantly,
> kernel features and tests for these features are included in the same
> release in most cases and/or allows us freedom to do so if test framework
> and tests are part of the kernel sources.
> 
> We have seen this with our experience with kselftest. It would not have
> see the same level of attention and growth if it stayed outside the
> kernel sources.
> 
> Most kernel developers would not want to include a externally maintained
> module for testing. As a general rule, it has to be easy to run tests.
> 
> > I think there are good uses cases for having the ability to maintain a
> > single source for tests that can be run against multiple kernels,
> > also distro kernels that the test framework cannot expect to be able to modify,
> > except from using the module interfaces.
> 
> Same reasons as above. Having the tests included in the kernel sources
> makes it easier for distros to run those tests and include running them
> during their qualification.

Also... selftests are an example of tests which *are* upstream and yet
there are teams out there using them to test these tests on older
kernels. So the scripts for instance are supposed to work with older
kernels. So if you expand on a feature your selftest script should
detect if the new mechanism is present or not, and also be backward
compatible with older kernels.

> > And there are good arguments for having (at least parts of)
> > the test framework easily available within the kernel under test.
> > 
> 
> When Kernel unit, functional, and regressions tests reside in the kernel
> sources, they evolve quicker as kernel developers contribute tests as
> part of their kernel work-flow. Maintaining tests and framework
> separately will make it harder to maintain them and keep them updated
> for us the kernel community.

Agreed!

Also, I actually see no issue with having *both* kunit / ktest merged
upstream. IMHO we should not be forcing people to pick one or the other
but rather we should: let the best test framework win. Similar as we
did with LSMs. Each test framework has its own gains / advantages.

  Luis
