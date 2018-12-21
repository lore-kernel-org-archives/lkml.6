Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32A39C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 09:48:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C18F2173C
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 09:48:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389014AbeLUJs3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 04:48:29 -0500
Received: from mx2.suse.de ([195.135.220.15]:42292 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729789AbeLUJs2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 04:48:28 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CC200AF6D;
        Fri, 21 Dec 2018 09:48:25 +0000 (UTC)
Date:   Fri, 21 Dec 2018 10:48:25 +0100 (CET)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Joao Moreira <jmoreira@suse.de>
cc:     Jiri Kosina <jikos@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        yamada.masahiro@socionext.com, michal.lkml@markovi.net,
        jeyu@kernel.org, pmladek@suse.com, linux-kbuild@vger.kernel.org,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kbuild: use -flive-patching when CONFIG_LIVEPATCH is
 enabled
In-Reply-To: <3fec8358-f64c-57e4-fa7f-1ee91a45be9b@suse.de>
Message-ID: <alpine.LSU.2.21.1812211046140.3002@pobox.suse.cz>
References: <20181219141744.32392-1-mbenes@suse.cz> <20181219165428.5udrppedpdvf2u7k@treble> <nycvar.YFH.7.76.1812191756450.17216@cbobk.fhfr.pm> <20181219172127.o753af7pkrsttcgl@treble> <nycvar.YFH.7.76.1812191909490.17216@cbobk.fhfr.pm>
 <alpine.LSU.2.21.1812200919210.28185@pobox.suse.cz> <3fec8358-f64c-57e4-fa7f-1ee91a45be9b@suse.de>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Dec 2018, Joao Moreira wrote:

> On 12/20/18 12:33 AM, Miroslav Benes wrote:
> > On Wed, 19 Dec 2018, Jiri Kosina wrote:
> > 
> >> On Wed, 19 Dec 2018, Josh Poimboeuf wrote:
> >>
> >>> Also the commit message needs an analysis of the performance impacts.
> >>
> >> Agreed. Especially as it's expected (*) to be completely in the noise
> >> particularly for the kernel, it'd be good to have that documented in the
> >> changelog.
> >>
> >> (*) actually measured already for some subset of the IPA optimizations
> > 
> > Ok, we can do that. I don't expect the results to be different from the
> > last measurement as Jiri mentions. The sets of disabled optimizations are
> > similar.
> > 
> > I'll add it to v2.
> > 
> > On Wed, 19 Dec 2018, Jiri Kosina wrote:
> > 
> >> On Wed, 19 Dec 2018, Josh Poimboeuf wrote:
> >>
> >>>>> This option only makes sense for source-based patch generation, so isn't
> >>>>> it a bit premature to make this change without proper source-based patch
> >>>>> tooling?
> >>>>
> >>>> The reality is though that before the full-fledged patch tooling exists,
> >>>> people are actually already writing livepatches by hand, so this option
> >>>> is
> >>>> useful for them.
> >>>
> >>> Fair enough.
> > 
> > Yes, that was the reason I sent it. It would not make sense to wait for
> > the tooling in this case, because -flive-patching is useful even now,
> > since there is a way to prepare livepatches without any tooling.
> > 
> >>> Though, upstream, almost everybody seems to use kpatch-build, for which
> >>> this patch doesn't help.  And people will continue to do so until we
> >>> have decent source-based tooling.  Will the klp-convert patches be
> >>> revived soon?
> >>
> >> Let me add Joao, who's working on that.
> >>
> >> Joao, I think you had something basically ready for upstream exposure,
> >> right?
> > 
> > I think that when Joao posted it a long time ago, the conclusion was that
> > it would be better to wait for the source-based tooling and have the
> > complete solution. I may misremember though.
> 
> Your memories match mine, Miroslav.
> 
> FTR, we recently integrated klp-convert to SLE. There were some fixes in
> comparison with the version which was submitted upstream, thus a v2 of the
> patches is necessary.
> 
> > 
> > If Josh thinks that it would be acceptable to have klp-convert merged even
> > without the tooling, I'm all for it.
> > 
> Of course I can work on that and I'll be glad to do so / submit this new
> version, if this is now something considered useful.

Yes, please.

Some context first. We decided to remove the integration into kbuild at 
SUSE. klp-convert is called from rpm .spec file directly after a livepatch 
module is compiled.

I think we should preserve kbuild process in upstream though. It makes 
more sense there.

Miroslav
