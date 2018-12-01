Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A44CC04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 03:10:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56D692082F
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 03:10:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56D692082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbeLAOWW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 09:22:22 -0500
Received: from mail-pl1-f175.google.com ([209.85.214.175]:37397 "EHLO
        mail-pl1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbeLAOWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 09:22:22 -0500
Received: by mail-pl1-f175.google.com with SMTP id b5so3708308plr.4;
        Fri, 30 Nov 2018 19:10:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=d5HSpPPZXlGgKq8ZQqEFJCdQi5p/tiGrBZdDlQAMxmA=;
        b=GZLTILZjMnINSj2kDm6u8xY9L1AVkglb8q+Jc4uOphVHOObIbbE+HDKioq01Z9k92j
         fFuapmPgfpEp3Y2FL2P4HO9UdFZuwUZu5qcQulAgG8rGlZh3pbwgf2KddLABgQ4RJAJb
         q8ULLQ6XS1f3WwC5VaGwF3+bnuueYghL2/nFEcqtEFj5gZSMxjeWt+VP/xSg21zyT8jr
         MyVoofAM2nLtjZQufVG7frU9s92/RmskR0T69FA2FgSkfNBEeuWR3AlvuA98prbYXqyB
         SYW1bSn2IyyEQHyg+mZk0goz7JnjyJ2ll+Kox2yaw7zP3w8wDEf2V267ur8hNulBkTl0
         BybQ==
X-Gm-Message-State: AA+aEWYX9yO+JPn49vbWmI2hf44Nap1dvHlxNu5Qu8WD0MTKYdiVT1ST
        uJ/CYsWRcmzfQyganqIvWlo=
X-Google-Smtp-Source: AFSGD/XSs9FLHgCUEO2ndApo1HrulMae9TCvT0q40lCanBhC32hN3WjNEJJJkJCVMpPLhU1EEPrSjA==
X-Received: by 2002:a17:902:820d:: with SMTP id x13mr8218607pln.229.1543633854305;
        Fri, 30 Nov 2018 19:10:54 -0800 (PST)
Received: from garbanzo.do-not-panic.com (c-73-71-40-85.hsd1.ca.comcast.net. [73.71.40.85])
        by smtp.gmail.com with ESMTPSA id h64sm19124111pfj.186.2018.11.30.19.10.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Nov 2018 19:10:52 -0800 (PST)
Received: by garbanzo.do-not-panic.com (sSMTP sendmail emulation); Fri, 30 Nov 2018 19:10:49 -0800
Date:   Fri, 30 Nov 2018 19:10:49 -0800
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
        Knut Omang <knut.omang@oracle.com>
Subject: Re: [RFC v3 01/19] kunit: test: add KUnit test runner core
Message-ID: <20181201031049.GL28501@garbanzo.do-not-panic.com>
References: <20181128193636.254378-1-brendanhiggins@google.com>
 <20181128193636.254378-2-brendanhiggins@google.com>
 <20181130032802.GG18410@garbanzo.do-not-panic.com>
 <CAFd5g45F0RViYDQyXRwyxVPAU=CO_Goqy3yHz=BbcMeAT7o6-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFd5g45F0RViYDQyXRwyxVPAU=CO_Goqy3yHz=BbcMeAT7o6-g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 06:08:36PM -0800, Brendan Higgins wrote:
> On Thu, Nov 29, 2018 at 7:28 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> >
> > > +static void kunit_run_case_internal(struct kunit *test,
> > > +                                 struct kunit_module *module,
> > > +                                 struct kunit_case *test_case)
> > > +{
> > > +     int ret;
> > > +
> > > +     if (module->init) {
> > > +             ret = module->init(test);
> > > +             if (ret) {
> > > +                     kunit_err(test, "failed to initialize: %d", ret);
> > > +                     kunit_set_success(test, false);
> > > +                     return;
> > > +             }
> > > +     }
> > > +
> > > +     test_case->run_case(test);
> > > +}
> >
> > <-- snip -->
> >
> > > +static bool kunit_run_case(struct kunit *test,
> > > +                        struct kunit_module *module,
> > > +                        struct kunit_case *test_case)
> > > +{
> > > +     kunit_set_success(test, true);
> > > +
> > > +     kunit_run_case_internal(test, module, test_case);
> > > +     kunit_run_case_cleanup(test, module, test_case);
> > > +
> > > +     return kunit_get_success(test);
> > > +}
> >
> > So we are running the module->init() for each test case... is that
> > correct? Shouldn't the init run once? Also, typically init calls are
> 
> Yep, it's correct. `module->init()` should run once before every test
> case, reason being that the kunit_module serves as a test fixture in
> which each test cases should be run completely independently of every
> other.

Shouldn't the init be test_case specific as well? Right now we just
past the struct kunit, but not the struct kunit_case. I though that
that the struct kunit_case was where we'd customize each specific
test case as we see fit for each test case. If not, how would we
do say, a different type of initialization for a different type of
test (for the same unit)?

> init and exit is supposed to allow code common to all test
> cases to run since it is so common to have dependencies needed for a
> test to be common to every test case.

Sure things in common make sense, however the differntiating aspects
seem important as well on init? Or should the author be doing all
custom specific initializations on run_case() instead?

  Luis
