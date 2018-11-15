Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CDADC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 10:25:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EF6E20869
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 10:25:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EF6E20869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387590AbeKOUc7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 15:32:59 -0500
Received: from foss.arm.com ([217.140.101.70]:59576 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728801AbeKOUc7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 15:32:59 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D716A80D;
        Thu, 15 Nov 2018 02:25:44 -0800 (PST)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 348FF3F718;
        Thu, 15 Nov 2018 02:25:42 -0800 (PST)
Date:   Thu, 15 Nov 2018 10:25:39 +0000
From:   Dave Martin <Dave.Martin@arm.com>
To:     Will Deacon <will.deacon@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        linux-arch@vger.kernel.org, Jacob Bramley <jacob.bramley@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        linux-kernel@vger.kernel.org, Adam Wallis <awallis@codeaurora.org>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        gorcunov@openvz.org,
        Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>,
        Amit Kachhap <Amit.Kachhap@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v5 07/17] arm64: add basic pointer authentication support
Message-ID: <20181115102537.GL3505@e103592.cambridge.arm.com>
References: <20181005084754.20950-1-kristina.martsenko@arm.com>
 <20181005084754.20950-8-kristina.martsenko@arm.com>
 <20181019111542.6wrvjguirglzg7vg@mbp>
 <20181019112404.GD14246@arm.com>
 <20181114181138.GB2580@brain-police>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181114181138.GB2580@brain-police>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 14, 2018 at 06:11:39PM +0000, Will Deacon wrote:

[...]

> On Fri, Oct 19, 2018 at 12:24:04PM +0100, Will Deacon wrote:

[...]

> > FWIW: I think we should be entertaining a prctl() interface to use a new
> > key on a per-thread basis. Obviously, this would need to be used with care
> > (e.g. you'd fork(); use the prctl() and then you'd better not return from
> > the calling function!).
> > 
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
> I managed to speak to the CRIU developers at LPC. The good news is that
> their preference is for a ptrace()-based interface for getting and setting
> the keys, so the only prctl() operation we need is to set a random key
> (separately for A and B).

That's good if it works for them, and it seems the cleaner approach.

_If_ they run the new thread up to a checkpoint, restoring the memory
and doing all the setup that requires in-thread syscalls, then stop it
in ptrace to finally inject the regs, then it makes sense to set the
keys at that stop -- i.e., you set the keys atomically* with the final
setting of the thread's PC.

(* with respect to the target thread)

So long as you're confident they've understood the implications of
ptrauth for CRIU, I guess this can work.


(In other news, they will also need to do some work to support SVE, but
that's unrelated to ptrauth.)

Cheers
---Dave
