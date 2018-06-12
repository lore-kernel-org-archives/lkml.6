Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 70BECC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 18:59:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2774D2086D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 18:59:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2774D2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754371AbeFLS7b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 14:59:31 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:42043 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754026AbeFLS72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 14:59:28 -0400
Received: from p4fea5fc6.dip0.t-ipconnect.de ([79.234.95.198] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fSoVn-0002u8-4d; Tue, 12 Jun 2018 20:59:23 +0200
Date:   Tue, 12 Jun 2018 20:59:22 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "H.J. Lu" <hjl.tools@gmail.com>
cc:     Andy Lutomirski <luto@kernel.org>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
        Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        "Shanbhogue, Vedvyas" <vedvyas.shanbhogue@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        mike.kravetz@oracle.com
Subject: Re: [PATCH 06/10] x86/cet: Add arch_prctl functions for shadow
 stack
In-Reply-To: <CAMe9rOpzcCdje=bUVs+C1WrY6GuwA-8AUFVLOG325LGz7KHJxw@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1806122046520.1592@nanos.tec.linutronix.de>
References: <20180607143807.3611-1-yu-cheng.yu@intel.com> <20180607143807.3611-7-yu-cheng.yu@intel.com> <CALCETrU6axo158CiSCRRkC4GC5hib9hypC98t7LLjA3gDaacsw@mail.gmail.com> <1528403417.5265.35.camel@2b52.sc.intel.com> <CALCETrXz3WWgZwUXJsDTWvmqKUArQFuMH1xJdSLVKFpTysNWxg@mail.gmail.com>
 <CAMe9rOr49V8rqRa_KVsw61PWd+crkQvPDgPKtvowazjmsfgWWQ@mail.gmail.com> <alpine.DEB.2.21.1806121155450.2157@nanos.tec.linutronix.de> <CAMe9rOoCiXQ4iVD3j_AHGrvEXtoaVVZVs7H7fCuqNEuuR5j+2Q@mail.gmail.com> <CALCETrXO8R+RQPhJFk4oiA4PF77OgSS2Yro_POXQj1zvdLo61A@mail.gmail.com>
 <CAMe9rOpLxPussn7gKvn0GgbOB4f5W+DKOGipe_8NMam+Afd+RA@mail.gmail.com> <CALCETrWmGRkQvsUgRaj+j0CP4beKys+TT5aDR5+18nuphwr+Cw@mail.gmail.com> <CAMe9rOpzcCdje=bUVs+C1WrY6GuwA-8AUFVLOG325LGz7KHJxw@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Jun 2018, H.J. Lu wrote:
> On Tue, Jun 12, 2018 at 9:34 AM, Andy Lutomirski <luto@kernel.org> wrote:
> > On Tue, Jun 12, 2018 at 9:05 AM H.J. Lu <hjl.tools@gmail.com> wrote:
> >> On Tue, Jun 12, 2018 at 9:01 AM, Andy Lutomirski <luto@kernel.org> wrote:
> >> > On Tue, Jun 12, 2018 at 4:43 AM H.J. Lu <hjl.tools@gmail.com> wrote:
> >> >> On Tue, Jun 12, 2018 at 3:03 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> >> >> > That works for stuff which loads all libraries at start time, but what
> >> >> > happens if the program uses dlopen() later on? If CET is force locked and
> >> >> > the library is not CET enabled, it will fail.
> >> >>
> >> >> That is to prevent disabling CET by dlopening a legacy shared library.
> >> >>
> >> >> > I don't see the point of trying to support CET by magic. It adds complexity
> >> >> > and you'll never be able to handle all corner cases correctly. dlopen() is
> >> >> > not even a corner case.
> >> >>
> >> >> That is a price we pay for security.  To enable CET, especially shadow
> >> >> shack, the program and all of shared libraries it uses should be CET
> >> >> enabled.  Most of programs can be enabled with CET by compiling them
> >> >> with -fcf-protection.
> >> >
> >> > If you charge too high a price for security, people may turn it off.
> >> > I think we're going to need a mode where a program says "I want to use
> >> > the CET, but turn it off if I dlopen an unsupported library".  There
> >> > are programs that load binary-only plugins.
> >>
> >> You can do
> >>
> >> # export GLIBC_TUNABLES=glibc.tune.hwcaps=-SHSTK
> >>
> >> which turns off shadow stack.
> >>
> >
> > Which exactly illustrates my point.  By making your security story too
> > absolute, you'll force people to turn it off when they don't need to.
> > If I'm using a fully CET-ified distro and I'm using a CET-aware
> > program that loads binary plugins, and I may or may not have an old
> > (binary-only, perhaps) plugin that doesn't support CET, then the
> > behavior I want is for CET to be on until I dlopen() a program that
> > doesn't support it.  Unless there's some ABI reason why that can't be
> > done, but I don't think there is.
> 
> We can make it opt-in via GLIBC_TUNABLES.  But by default, the legacy
> shared object is disallowed when CET is enabled.

That's a bad idea. Stuff has launchers which people might not be able to
change. So they will simply turn of CET completely or it makes them hack
horrible crap into init, e.g. the above export.

Give them sane kernel options:

     cet = off, relaxed, forced

where relaxed allows to run binary plugins. Then let dlopen() call into the
kernel with the filepath of the library to check for CET and that will tell
you whether its ok or or not and do the necessary magic in the kernel when
CET has to be disabled due to a !CET library/application.

That's also making the whole thing independent of magic glibc environment
options and allows it to be used all over the place in the same way.

Thanks,

	tglx





