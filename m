Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D612C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 16:01:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 168F024568
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 16:01:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="SVr+Zv76"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 168F024568
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934060AbeFVQBU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 12:01:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:46566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933853AbeFVQBS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 12:01:18 -0400
Received: from mail-wr0-f169.google.com (mail-wr0-f169.google.com [209.85.128.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1810324570
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 16:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529683278;
        bh=qg39sZCuTUHjdt474ebG5Px8rjFDzInqtB8YrPqqhns=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SVr+Zv76Zjyd3t71huEmtgkX96oi7N/6tjXHJa7XaHCc9X2ElT3R/fbuZ6Fe1ZZvN
         Aaz+FcLNCbZ3F48vuejHubdYs6cSenUss6KOB8zD4WtxEJMNBvXXKMlUQVSMID+UUv
         cXrh0jBgtEUoKCEG8zlIqHTmJiiVKty+Co77l3pg=
Received: by mail-wr0-f169.google.com with SMTP id g18-v6so7198504wro.7
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 09:01:18 -0700 (PDT)
X-Gm-Message-State: APt69E0FbvkBNnyW0iKxJ7DqT+JnvaXq/GJpq8AKF+WW1rbeEWgamiUo
        vqVyeqLaQTrViCSC9Fu2gaYaFCulXED+JOO5mQpqHw==
X-Google-Smtp-Source: AAOMgpdUPIO3uw/p06/lanuhtwMwBTOXnV6V8dhSPFpQPHc87zgUmx+J/4wpZzkL5LAfnjcvsJlDeqsB5uLLZmGIc7s=
X-Received: by 2002:adf:fe4c:: with SMTP id m12-v6mr2021658wrs.171.1529683276546;
 Fri, 22 Jun 2018 09:01:16 -0700 (PDT)
MIME-Version: 1.0
References: <20180620195652.27251-1-riel@surriel.com> <20180620195652.27251-8-riel@surriel.com>
 <CALCETrXfHhPNe9J0NEabxdtKGRV+XOX=n6vtL7rbOY6e2GXMqA@mail.gmail.com> <1529682813.7898.195.camel@surriel.com>
In-Reply-To: <1529682813.7898.195.camel@surriel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 22 Jun 2018 09:01:04 -0700
X-Gmail-Original-Message-ID: <CALCETrXJzhwXkEi5oC9XY58B8fYT26WhMT+KBt-8m2M+foQvsw@mail.gmail.com>
Message-ID: <CALCETrXJzhwXkEi5oC9XY58B8fYT26WhMT+KBt-8m2M+foQvsw@mail.gmail.com>
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

Hmm, fair enough.  I think a better heuristic would be if the
estimated idle duration is more than, say, 10ms.  I *think* the code
has been cleaned up enough that this is easy now.  (Using time instead
of C6 will make it a lot less dependent on which idle driver is in
use.)
On Fri, Jun 22, 2018 at 8:53 AM Rik van Riel <riel@surriel.com> wrote:
>
> On Fri, 2018-06-22 at 08:36 -0700, Andy Lutomirski wrote:
> > On Wed, Jun 20, 2018 at 12:57 PM Rik van Riel <riel@surriel.com>
> > wrote:
> > >
> > > Do not call leave_mm when going into a cstate. Now that mprotect
> > > and
> > > madvise no longer send IPIs for TLB shootdowns to idle CPUs, there
> > > is
> > > no real reason to disable lazy TLB mode in idle states.
> > >
> > > This seems to help performance on Broadwell systems. Haswell
> > > performance
> > > numbers are inconclusive.
> >
> > I'm skeptical.  The code you're removing is more about power
> > consumption than about performance.  If a task migrates from one cpu
> > to another, runs for awhile, and exits, we don't want to IPI the old
> > CPU if the old CPU is deeply asleep.  The logic you're removing is a
> > bit awkwardly written, but the intent is to only do the leave_mm() in
> > deep sleep.  We should arguably change the condition to check the
> > expected sleep duration instead of the microarchitectural properties
> > of the target state, though.
>
> That is fair.
>
> A quick hack could be to just remove the tlb flush
> from C3 state (which gets called a lot), but keep
> it for C6 state and deeper (which get called more
> when a CPU is really idle).
>
> --
> All Rights Reversed.
