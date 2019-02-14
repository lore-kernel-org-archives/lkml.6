Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3340CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:52:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D6D8222A4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:52:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406748AbfBNKwa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 05:52:30 -0500
Received: from mga05.intel.com ([192.55.52.43]:49830 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388138AbfBNKw3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 05:52:29 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Feb 2019 02:52:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,368,1544515200"; 
   d="scan'208";a="134242065"
Received: from djustese-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.254.237])
  by orsmga002.jf.intel.com with ESMTP; 14 Feb 2019 02:52:21 -0800
Date:   Thu, 14 Feb 2019 12:52:21 +0200
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
Message-ID: <20190214105221.GB7956@linux.intel.com>
References: <0147a993d4a94426afa469a8dcc4e5d7@AcuMS.aculab.com>
 <20181022234357.82217-1-ndesaulniers@google.com>
 <alpine.DEB.2.21.1810241136130.3525@jsakkine-mobl1>
 <CAKwvOdn+V8iFJ_V1vr3GBm-NwxzaDbcmK+nW1q3uVky7bRsB3w@mail.gmail.com>
 <CAKwvOdnhDin6TJfBVxm6xsCh_nJeBuA7GqbgJwgLnqc3PrJGxA@mail.gmail.com>
 <20190212231256.GD3977@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190212231256.GD3977@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 01:12:56AM +0200, Jarkko Sakkinen wrote:
> On Mon, Feb 11, 2019 at 10:36:51AM -0800, Nick Desaulniers wrote:
> > On Mon, Oct 29, 2018 at 10:54 AM Nick Desaulniers
> > <ndesaulniers@google.com> wrote:
> > >
> > > On Wed, Oct 24, 2018 at 1:37 AM Jarkko Sakkinen
> > > <jarkko.sakkinen@linux.intel.com> wrote:
> > > >
> > > > On Mon, 22 Oct 2018, ndesaulniers@google.com wrote:
> > > > > Fixes the warning reported by Clang:
> > > > > security/keys/trusted.c:146:17: warning: passing an object that
> > > > > undergoes default
> > > > >      argument promotion to 'va_start' has undefined behavior [-Wvarargs]
> > > > >        va_start(argp, h3);
> > > > >                       ^
> > > > > security/keys/trusted.c:126:37: note: parameter of type 'unsigned
> > > > > char' is declared here
> > > > > unsigned char *h2, unsigned char h3, ...)
> > > > >                               ^
> > > > > Specifically, it seems that both the C90 (4.8.1.1) and C11 (7.16.1.4)
> > > > > standards explicitly call this out as undefined behavior:
> > > > >
> > > > > The parameter parmN is the identifier of the rightmost parameter in
> > > > > the variable parameter list in the function definition (the one just
> > > > > before the ...). If the parameter parmN is declared with ... or with a
> > > > > type that is not compatible with the type that results after
> > > > > application of the default argument promotions, the behavior is
> > > > > undefined.
> > > > >
> > > > > Link: https://github.com/ClangBuiltLinux/linux/issues/41
> > > > > Link: https://www.eskimo.com/~scs/cclass/int/sx11c.html
> > > > > Suggested-by: David Laight <David.Laight@aculab.com>
> > > > > Suggested-by: Denis Kenzior <denkenz@gmail.com>
> > > > > Suggested-by: James Bottomley <jejb@linux.vnet.ibm.com>
> > > > > Suggested-by: Nathan Chancellor <natechancellor@gmail.com>
> > > > > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> > > >
> > > > Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > > >
> > > > /Jarkko
> > >
> > > Bumping the maintainers if this isn't already picked up?
> > 
> > James, Jarkko, or Mimi, can you please pick this up (and let me know
> > what tree it lands in)?
> 
> I can volunteer. Have not done yet v5.1 PR so it would land to that
> release. Is this agreed?

http://git.infradead.org/users/jjs/linux-tpmdd.git/commit/cfb1f7ee3b35e6ba9e9e2de53a8668ced6397f88

/Jarkko
