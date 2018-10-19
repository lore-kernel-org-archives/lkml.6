Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFD09ECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 15:54:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C134020869
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 15:54:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C134020869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbeJTABA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 20:01:00 -0400
Received: from foss.arm.com ([217.140.101.70]:55350 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727042AbeJTABA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 20:01:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 05BD680D;
        Fri, 19 Oct 2018 08:54:19 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C20533F71A;
        Fri, 19 Oct 2018 08:54:15 -0700 (PDT)
Date:   Fri, 19 Oct 2018 16:54:10 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Andrew Jones <drjones@redhat.com>,
        Jacob Bramley <jacob.bramley@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Adam Wallis <awallis@codeaurora.org>,
        "Suzuki K . Poulose" <suzuki.poulose@arm.com>,
        Christoffer Dall <christoffer.dall@arm.com>,
        kvmarm@lists.cs.columbia.edu,
        Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>,
        Amit Kachhap <Amit.Kachhap@arm.com>,
        Dave P Martin <Dave.Martin@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Cyrill Gorcunov <gorcunov@openvz.org>
Subject: Re: [PATCH v5 07/17] arm64: add basic pointer authentication support
Message-ID: <20181019155410.wsbmhluq4xqcyty2@lakrids.cambridge.arm.com>
References: <20181005084754.20950-1-kristina.martsenko@arm.com>
 <20181005084754.20950-8-kristina.martsenko@arm.com>
 <20181019111542.6wrvjguirglzg7vg@mbp>
 <20181019112404.GD14246@arm.com>
 <CAGXu5j+2axuzPJji_eCvMZDiPvrPsP3kAnG0CY_rsL5c=uFQFA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5j+2axuzPJji_eCvMZDiPvrPsP3kAnG0CY_rsL5c=uFQFA@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 19, 2018 at 08:36:45AM -0700, Kees Cook wrote:
> On Fri, Oct 19, 2018 at 4:24 AM, Will Deacon <will.deacon@arm.com> wrote:
> > Assuming we want this (Kees -- I was under the impression that everything in
> > Android would end up with the same key otherwise?), then the question is
> > do we want:
> >
> >   - prctl() get/set operations for the key, or
> >   - prctl() set_random_key operation, or
> >   - both of the above?
> >
> > Part of the answer to that may lie in the requirements of CRIU, where I
> > strongly suspect they need explicit get/set operations, although these
> > could be gated on CONFIG_CHECKPOINT_RESTORE=y.
> 
> Oh CRIU. Yikes. I'd like the get/set to be gated by the CONFIG, yes.
> No reason to allow explicit access to the key (and selected algo) if
> we don't have to.

As a minor aside, the PAC algorithm (which can be IMPLEMENTATION
DEFINED) is fixed in HW, and cannot be selected dynamically.

Thus if a process is using pointer authentication, it would not be
possible for CRIU to migrate that process to a CPU with a different PAC
algorithm.

Thanks,
Mark.
