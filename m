Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61299C04EB9
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 01:03:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34ECB20834
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 01:03:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34ECB20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726036AbeLDBDk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 20:03:40 -0500
Received: from gate.crashing.org ([63.228.1.57]:45997 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725943AbeLDBDj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 20:03:39 -0500
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id wB4138Lj002163;
        Mon, 3 Dec 2018 19:03:08 -0600
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id wB3NOgsV026184;
        Mon, 3 Dec 2018 17:24:42 -0600
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Mon, 3 Dec 2018 17:24:41 -0600
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Joel Stanley <joel@jms.id.au>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>, Jinsong Ji <jji@us.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2] raid6/ppc: Fix build for clang
Message-ID: <20181203232440.GB3803@gate.crashing.org>
References: <20181102004455.10157-1-joel@jms.id.au> <CAKwvOdni_iJ4beAWYkUUpZss_PYZezMGR7hN9k1rm9J0iB0gHQ@mail.gmail.com> <CACPK8XdbWzb=52iFV_fj0Y5KMWPgsRv_A8PZgfKn9vm96y3LOw@mail.gmail.com> <CAKwvOdndyeRZApOqbp-6evEpYgzHyGo4qqaMKd_DQ4U9x8_5wA@mail.gmail.com> <CACPK8Xcz4YzfnFAHGOcJZkt0UFfQ02YabtEQDHXdSFsH57xRiQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACPK8Xcz4YzfnFAHGOcJZkt0UFfQ02YabtEQDHXdSFsH57xRiQ@mail.gmail.com>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2018 at 08:43:47AM +1030, Joel Stanley wrote:
> On Tue, 4 Dec 2018 at 05:15, Nick Desaulniers <ndesaulniers@google.com> wrote:
> > > > > +ifdef CONFIG_CC_IS_CLANG
> > > > > +# clang ppc port does not yet support -maltivec when -msoft-float is
> > > > > +# enabled. A future release of clang will resolve this
> > > > > +# https://bugs.llvm.org/show_bug.cgi?id=31177

> > As in clang itself crashes, and cc-option/kbuild can't handle that gracefully?
> 
> The developer gets something like this:
> 
> SplitVectorResult #0: t196: v16i8 = llvm.ppc.altivec.vcmpgtsb
> TargetConstant:i64<4823>, t146, t195
> fatal error: error in backend: Do not know how to split the result of
> this operator!
> clang-8: error: clang frontend command failed with exit code 70 (use
> -v to see invocation)

-msoft-float simply means not to use FPRs, and nothing more or less, so
that is a pretty interesting failure (will probably turn out to be a typo
or something else boring, but it is fun while it lasts).


Segher
