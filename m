Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A99EC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 22:47:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E68D920864
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 22:47:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MiFHArXF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E68D920864
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726026AbeLCWrd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 17:47:33 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:40772 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbeLCWrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 17:47:33 -0500
Received: by mail-oi1-f195.google.com with SMTP id t204so12519068oie.7
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 14:47:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7K2c8Zu+p8wH+EQxu3NfOnoJbOsNB0SzdMA/RAbK7hE=;
        b=MiFHArXFipUF2vR8vAJN+UZyGFW5MwQMNnrAyG9l6LAee5E8luj0E6UmN+m8+zYxmV
         6Uf6qeeX0IKplw7yVgx+ExwZOUIUNqtUHORPjHbDvZ498A3XrE8B3UC4CFWKk+kjxS0n
         WsJx26hRMmVekssCM5YukNgJHxuJSTRjcwcma+po8w6a8cjcNUX8yVZCb0NVzl9MVGB7
         R94iMLCFos4iPqOczukrQazYGJ/hxECCsOSrkT/AgFnX/5PELU5DrwhQv4GuD8DfVtC5
         I+6DIrqSKV4gPL0i2v+K6agPa/9eG3jXIRHX0KA+dnoSLT+TtXADKwHV+Naf7X4+bP38
         wc/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7K2c8Zu+p8wH+EQxu3NfOnoJbOsNB0SzdMA/RAbK7hE=;
        b=J7O4sceZtDgXJk5/4M3VRuYgrcgStU1TI5eI6ghBBboo4hwetJw/6UiKIsaL02jW70
         TQFQFHF2I9K/RVASLEdgbNBHWUYlozJCqBQ3d6UwxL5l7RySMbnVkErG3nRqVdjfo2yl
         CWyDYyvGQW4B/+4N2+c5hmX7giFD5DTFBu8LN7cwtCrbre7OgdYzd4mIDLJkarOcsdgS
         Bb1qBLxCdvLGXO18vgJkIPD/jwdPHnK9uQKfQHNraZvOnlQ9Evxo+MHqBE/q2WawTxt6
         7Q++AnvGzRZt2ZbVCoWSU/PZYm4kIat6Y59wLpqV9InmvWD9gqQhGJQFFMFsLzS6TDfM
         zRkQ==
X-Gm-Message-State: AA+aEWZ9+dyoy9vbk/ZsJkr5IOS7QaSnDiIKgeksWsk5N7KSXWC/k+sa
        ArUbcBbRIjgVhEo5gnHoeavuHKjFMquMwZ5cswiSTg==
X-Google-Smtp-Source: AFSGD/WzsqKdfCa0LLiYoB9cdXOcGVQQVd46diLAJZIrWsPnSFG40HZF6IzHj/AJzDFMUdQicpRF1Re3vMxx5iMNKr8=
X-Received: by 2002:aca:be41:: with SMTP id o62mr10553732oif.206.1543877250827;
 Mon, 03 Dec 2018 14:47:30 -0800 (PST)
MIME-Version: 1.0
References: <20181128193636.254378-1-brendanhiggins@google.com>
 <20181128193636.254378-2-brendanhiggins@google.com> <20181130032802.GG18410@garbanzo.do-not-panic.com>
 <CAFd5g45F0RViYDQyXRwyxVPAU=CO_Goqy3yHz=BbcMeAT7o6-g@mail.gmail.com> <20181201031049.GL28501@garbanzo.do-not-panic.com>
In-Reply-To: <20181201031049.GL28501@garbanzo.do-not-panic.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 3 Dec 2018 14:47:19 -0800
Message-ID: <CAFd5g45DQ7V_pMpkNpRw3iRsCgO-MQvJV=hV7axP4gG++qm2JA@mail.gmail.com>
Subject: Re: [RFC v3 01/19] kunit: test: add KUnit test runner core
To:     mcgrof@kernel.org
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 7:10 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> On Fri, Nov 30, 2018 at 06:08:36PM -0800, Brendan Higgins wrote:
> > On Thu, Nov 29, 2018 at 7:28 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> > >
> > > > +static void kunit_run_case_internal(struct kunit *test,
> > > > +                                 struct kunit_module *module,
> > > > +                                 struct kunit_case *test_case)
> > > > +{
> > > > +     int ret;
> > > > +
> > > > +     if (module->init) {
> > > > +             ret = module->init(test);
> > > > +             if (ret) {
> > > > +                     kunit_err(test, "failed to initialize: %d", ret);
> > > > +                     kunit_set_success(test, false);
> > > > +                     return;
> > > > +             }
> > > > +     }
> > > > +
> > > > +     test_case->run_case(test);
> > > > +}
> > >
> > > <-- snip -->
> > >
> > > > +static bool kunit_run_case(struct kunit *test,
> > > > +                        struct kunit_module *module,
> > > > +                        struct kunit_case *test_case)
> > > > +{
> > > > +     kunit_set_success(test, true);
> > > > +
> > > > +     kunit_run_case_internal(test, module, test_case);
> > > > +     kunit_run_case_cleanup(test, module, test_case);
> > > > +
> > > > +     return kunit_get_success(test);
> > > > +}
> > >
> > > So we are running the module->init() for each test case... is that
> > > correct? Shouldn't the init run once? Also, typically init calls are
> >
> > Yep, it's correct. `module->init()` should run once before every test
> > case, reason being that the kunit_module serves as a test fixture in
> > which each test cases should be run completely independently of every
> > other.
>
> Shouldn't the init be test_case specific as well? Right now we just
> past the struct kunit, but not the struct kunit_case. I though that
> that the struct kunit_case was where we'd customize each specific
> test case as we see fit for each test case. If not, how would we
> do say, a different type of initialization for a different type of
> test (for the same unit)?

Maybe there should be other init functions, but specifying an init
function per case is not typical. In most unit testing frameworks
there is some sort of optional per test case init function that sets
up the fixture common to all cases; it is also fairly common to have
an init function that runs once at the very beginning of the entire
test suite (like what you thought I was doing); however, it is not
used nearly as often as the former, and even then is usually used in
conjunction with the former.

Nevertheless, I don't think I have ever seen a unit test framework
provide a way to make init functions specific to each case. I don't
see any good reason not to do it other than the lack of examples in
the wild suggest it would not get much usage.

In general, some limited initialization specific to a test case is
allowed in the test case itself, and if you have really complicated
initialization that warrants a separate init function, but isn't
shared between cases, you should probably put the test in a separate
test suite with a separate test fixture. I am sure there will be edge
cases that don't fit, but there is no technical reason why you cannot
just do the initialization in the test case itself in these cases.

>
> > init and exit is supposed to allow code common to all test
> > cases to run since it is so common to have dependencies needed for a
> > test to be common to every test case.
>
> Sure things in common make sense, however the differntiating aspects
> seem important as well on init? Or should the author be doing all
> custom specific initializations on run_case() instead?
>

Usually limited initialization specific to a test case will just go in
that test case.

Cheers
