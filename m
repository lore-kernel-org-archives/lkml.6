Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1BABC43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 18:02:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82FD3218D3
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 18:02:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727439AbfADSCZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 13:02:25 -0500
Received: from foss.arm.com ([217.140.101.70]:47982 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725958AbfADSCW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 13:02:22 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D4CCDEBD;
        Fri,  4 Jan 2019 10:02:21 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 955E83F5D4;
        Fri,  4 Jan 2019 10:02:18 -0800 (PST)
Date:   Fri, 4 Jan 2019 18:02:16 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Marc Zyngier <marc.zyngier@arm.com>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Adam Wallis <awallis@codeaurora.org>,
        Amit Kachhap <amit.kachhap@arm.com>,
        Andrew Jones <drjones@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoffer Dall <christoffer.dall@arm.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave P Martin <dave.martin@arm.com>,
        Jacob Bramley <jacob.bramley@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 07/13] arm64: add basic pointer authentication support
Message-ID: <20190104180215.GB7157@lakrids.cambridge.arm.com>
References: <20181207183931.4285-1-kristina.martsenko@arm.com>
 <20181207183931.4285-8-kristina.martsenko@arm.com>
 <20190103202901.GA21564@amd>
 <681a2835-1a70-f3c3-3534-7b4cf6139cac@arm.com>
 <20190104093340.GA28150@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190104093340.GA28150@amd>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 04, 2019 at 10:33:40AM +0100, Pavel Machek wrote:
> On Fri 2019-01-04 09:21:30, Marc Zyngier wrote:
> > On 03/01/2019 20:29, Pavel Machek wrote:
> > > On Fri 2018-12-07 18:39:25, Kristina Martsenko wrote:
> > >> From: Mark Rutland <mark.rutland@arm.com>
> > >> 
> > >> This patch adds basic support for pointer authentication,
> > >> allowing userspace to make use of APIAKey, APIBKey, APDAKey,
> > >> APDBKey, and APGAKey. The kernel maintains key values for each
> > >> process (shared by all threads within), which are initialised to
> > >> random values at exec()
> > > time.
> > > 
> > > ...
> > > 
> > >> +/* + * We give each process its own keys, which are shared by
> > >> all threads. The keys + * are inherited upon fork(), and
> > >> reinitialised upon exec*(). + */ +struct ptrauth_keys { +	struct
> > >> ptrauth_key apia; +	struct ptrauth_key apib; +	struct ptrauth_key
> > >> apda; +	struct ptrauth_key apdb; +	struct ptrauth_key apga; +};
> > > 
> > > intstruction_a, data_a, generic_a? Should be easier to understand
> > > than "apdb" ...
> > 
> > ... until you realize that these names do match the documentation,
> > which makes it even easier to understand how the code uses the
> > architecture.
> 
> See how not even the commit log matches the documentation then?

The commit message exactly matches the documentation, as it refers to:

	APIAKey, APIBKey, APDAKey, APDBKey, and APGAKey

... which are the architected names for those registers, in all the
documentation.

Searching "apga" in the ARM ARM finds all of the relevant information on
APGAKey_EL1. Searching "generic_a" finds precisely nothing, as it's a
term which you invented, that no-one else has previously used.

Likewise for the other key names.

> Naming something "apdb" is just bad... Just because the documentation
> is evil does not mean it should be followed...

It is in no way evil to use the documented names for things.

It is unhelpful to make up terminology that no-one else uses.

Mark.
