Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B0D2C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 22:05:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD4BD24943
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 22:05:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wiQrO+zS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD4BD24943
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754638AbeFVWFj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 18:05:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:49946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754134AbeFVWFi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 18:05:38 -0400
Received: from mail-wr0-f177.google.com (mail-wr0-f177.google.com [209.85.128.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F88924941
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 22:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529705137;
        bh=ldloDqJES8jcoqHuScDh4Q4lGYRkLiW7aoEw38ZRClM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=wiQrO+zSS5PfS6qic1BH3MWhD/pcwZcVK8rIJdqI56x0sWAiFTThY/sPXTWQOcJQe
         LOwuSgkOqovfYK0SrCZ+SxhfViUqmImitbbIKK3si3s4pVfvlloslie3J4Ioj5Xztj
         Vo2ilO0JWyAaxwUlT/wKItse+VR61WVNSchCK4Do=
Received: by mail-wr0-f177.google.com with SMTP id g18-v6so7997687wro.7
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 15:05:37 -0700 (PDT)
X-Gm-Message-State: APt69E0Hj87H27liepRm1TMbhd8zthpSFMzpQQ4MwlIZHFAimil10zei
        xZSUm1U2URWlg5BeonrBq7WKwyEhjTVwL5Mi5kuoKA==
X-Google-Smtp-Source: AAOMgpcKTtnIsoU/cJP8yqme39XZ/3uuVefaL7BZg8RZmVbZ1bAzEppAawMwgnVon6uk5g6lZRcGJCK4vuym97eC+po=
X-Received: by 2002:adf:fe4c:: with SMTP id m12-v6mr2796733wrs.171.1529705136159;
 Fri, 22 Jun 2018 15:05:36 -0700 (PDT)
MIME-Version: 1.0
References: <20180620195652.27251-1-riel@surriel.com> <20180620195652.27251-8-riel@surriel.com>
 <CALCETrXfHhPNe9J0NEabxdtKGRV+XOX=n6vtL7rbOY6e2GXMqA@mail.gmail.com>
 <1529682813.7898.195.camel@surriel.com> <CALCETrXJzhwXkEi5oC9XY58B8fYT26WhMT+KBt-8m2M+foQvsw@mail.gmail.com>
 <1529698739.7898.206.camel@surriel.com>
In-Reply-To: <1529698739.7898.206.camel@surriel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 22 Jun 2018 15:05:24 -0700
X-Gmail-Original-Message-ID: <CALCETrX9PZEHs9bj476bj5qEb1aXtiH0K8G998t1+CbUuiaGmg@mail.gmail.com>
Message-ID: <CALCETrX9PZEHs9bj476bj5qEb1aXtiH0K8G998t1+CbUuiaGmg@mail.gmail.com>
Subject: Re: [PATCH 7/7] x86,idle: do not leave mm in idle state
To:     Rik van Riel <riel@surriel.com>
Cc:     Andrew Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Mike Galbraith <efault@gmx.de>, songliubraving@fb.com,
        kernel-team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 1:19 PM Rik van Riel <riel@surriel.com> wrote:
>
> On Fri, 2018-06-22 at 09:01 -0700, Andy Lutomirski wrote:
> > Hmm, fair enough.  I think a better heuristic would be if the
> > estimated idle duration is more than, say, 10ms.  I *think* the code
> > has been cleaned up enough that this is easy now.  (Using time
> > instead
> > of C6 will make it a lot less dependent on which idle driver is in
> > use.)
>
> This particular bit of code is only in intel_idle
> though, and not every cpuidle governor estimates
> an idle duration, nor does it get passed up the
> stack (presumably because it not always exists).
>
> I will just drop this patch for now, and see if
> adding back in the patch that skips manipulation
> of the mm_cpumask(&init_mm), since that might make
> leave_mm() a little cheaper.
>
> We would still have excess manipulation of the
> bitmask when re-entering the task from what should
> have been lazy TLB mode, but total cache line
> contention would likely still be down from where
> it is before that patch.
>

Agreed.

I think the right solution if you want that last little bit of
performance is to get rid of the code in intel_idle and to add it in
the core idle code.  We have fancy scheduler code to estimate the idle
time, and we should use it here IMO.
