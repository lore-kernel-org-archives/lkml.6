Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96488C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 23:13:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E14E222C2
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 23:13:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731269AbfBLXNF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 18:13:05 -0500
Received: from mga03.intel.com ([134.134.136.65]:47418 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730495AbfBLXNF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 18:13:05 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Feb 2019 15:13:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,362,1544515200"; 
   d="scan'208";a="124013186"
Received: from briva-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.254.236])
  by fmsmga008.fm.intel.com with ESMTP; 12 Feb 2019 15:12:57 -0800
Date:   Wed, 13 Feb 2019 01:12:56 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        zohar@linux.vnet.ibm.com, David Howells <dhowells@redhat.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        David.Laight@aculab.com, denkenz@gmail.com, jmorris@namei.org,
        serge@hallyn.com, keyrings@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2] [PATCH] KEYS: trusted: fix -Wvarags warning
Message-ID: <20190212231256.GD3977@linux.intel.com>
References: <0147a993d4a94426afa469a8dcc4e5d7@AcuMS.aculab.com>
 <20181022234357.82217-1-ndesaulniers@google.com>
 <alpine.DEB.2.21.1810241136130.3525@jsakkine-mobl1>
 <CAKwvOdn+V8iFJ_V1vr3GBm-NwxzaDbcmK+nW1q3uVky7bRsB3w@mail.gmail.com>
 <CAKwvOdnhDin6TJfBVxm6xsCh_nJeBuA7GqbgJwgLnqc3PrJGxA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdnhDin6TJfBVxm6xsCh_nJeBuA7GqbgJwgLnqc3PrJGxA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 10:36:51AM -0800, Nick Desaulniers wrote:
> On Mon, Oct 29, 2018 at 10:54 AM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > On Wed, Oct 24, 2018 at 1:37 AM Jarkko Sakkinen
> > <jarkko.sakkinen@linux.intel.com> wrote:
> > >
> > > On Mon, 22 Oct 2018, ndesaulniers@google.com wrote:
> > > > Fixes the warning reported by Clang:
> > > > security/keys/trusted.c:146:17: warning: passing an object that
> > > > undergoes default
> > > >      argument promotion to 'va_start' has undefined behavior [-Wvarargs]
> > > >        va_start(argp, h3);
> > > >                       ^
> > > > security/keys/trusted.c:126:37: note: parameter of type 'unsigned
> > > > char' is declared here
> > > > unsigned char *h2, unsigned char h3, ...)
> > > >                               ^
> > > > Specifically, it seems that both the C90 (4.8.1.1) and C11 (7.16.1.4)
> > > > standards explicitly call this out as undefined behavior:
> > > >
> > > > The parameter parmN is the identifier of the rightmost parameter in
> > > > the variable parameter list in the function definition (the one just
> > > > before the ...). If the parameter parmN is declared with ... or with a
> > > > type that is not compatible with the type that results after
> > > > application of the default argument promotions, the behavior is
> > > > undefined.
> > > >
> > > > Link: https://github.com/ClangBuiltLinux/linux/issues/41
> > > > Link: https://www.eskimo.com/~scs/cclass/int/sx11c.html
> > > > Suggested-by: David Laight <David.Laight@aculab.com>
> > > > Suggested-by: Denis Kenzior <denkenz@gmail.com>
> > > > Suggested-by: James Bottomley <jejb@linux.vnet.ibm.com>
> > > > Suggested-by: Nathan Chancellor <natechancellor@gmail.com>
> > > > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> > >
> > > Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > >
> > > /Jarkko
> >
> > Bumping the maintainers if this isn't already picked up?
> 
> James, Jarkko, or Mimi, can you please pick this up (and let me know
> what tree it lands in)?

I can volunteer. Have not done yet v5.1 PR so it would land to that
release. Is this agreed?

/Jarkko
