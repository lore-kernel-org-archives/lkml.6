Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C522AC43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 13:37:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DFDF2075E
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 13:37:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hB+0JN/N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DFDF2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933277AbeFUNhu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 09:37:50 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:42521 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932806AbeFUNhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 09:37:45 -0400
Received: by mail-wr0-f193.google.com with SMTP id w10-v6so3237626wrk.9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 06:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FriD1zN5rha1eGba+f03oFkIXLFDodaRIhinPiyv2ME=;
        b=hB+0JN/NIXEzKNfqRlExmKpn4FxV8PJrWp+GxLTyps6d1K9NkaUwrAqc1PuI9Qs+em
         twcGeXB5s6BlcY33J0+KWs/KMtA5DvTM5vIuvAgLtcntBitlwwuXn+sJ+AU0Wtg1AmkF
         DONAgziWWEccrfPU1YPIXeaYkKS4akFOa2jdgesQUmLHCRVY55u5ubSpeE3boHmCc6lk
         2uEZ9JW2eDq35/+zokp7XoAamQIohMcpwidoyM+RM2S4ZBbpIuuBqRDtMT9r+hk798fY
         E1cve40sjdSrWH+N+XBRbe507D+l5/Q8MzUPt4zl3y61kz50ocPItmS7ey2/eF+r9IZq
         2qmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=FriD1zN5rha1eGba+f03oFkIXLFDodaRIhinPiyv2ME=;
        b=gOlGg9uyllKKrCi6e4GH9usJ3CDWBKKtDbxVPbUV5HG8T5vxZmCg4BdXcpyOJMwEIp
         zc05F1AukvzA5XR6zij+qCh/Aaac+MZraFArW3WqckVZ76vYCy19fpodfUSAYNOBXp8B
         g/KHJk5tKbuvaNavL4XDyex5TtoCVhIeRrIRi+Wf3QTZ15gwgX1vydZMDMnfUkj1S701
         rGkWO5K06DBqZL4f4OgWhLZI/d2n9r97hUKESu/12NbC7+t0plsEflOea2uEI7tUIrlg
         Kto7WV1uwTFVAkDbtk6EtDAM/u2nKVl+YcLwzHFNhEjPmPVIbX4KwxiEAuWT21q2tlb7
         W3wQ==
X-Gm-Message-State: APt69E2L2wFiy83gjB4B/aDZsII9DGpTSyNPYDFf1hvyRna+qR6uBfzz
        mNxToUg068XD94A3xSJMViM=
X-Google-Smtp-Source: ADUXVKIy4faEbrw99R4kZziXsqgwHXOGlIrPvOKeo0MAkvng2NWbnBaLaWrRSvcgJs53uvPSbcabQw==
X-Received: by 2002:adf:8142:: with SMTP id 60-v6mr21015766wrm.192.1529588264208;
        Thu, 21 Jun 2018 06:37:44 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id j10-v6sm7190645wrr.47.2018.06.21.06.37.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Jun 2018 06:37:43 -0700 (PDT)
Date:   Thu, 21 Jun 2018 15:37:41 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Joel Fernandes <joel.opensrc@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chris Zankel <chris@zankel.net>,
        Paul Mackerras <paulus@samba.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Rich Felker <dalias@libc.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: Re: [GIT PULL] breakpoint: Rework arch validation v3
Message-ID: <20180621133741.GA24944@gmail.com>
References: <1527863526-32677-1-git-send-email-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527863526-32677-1-git-send-email-frederic@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Frederic Weisbecker <frederic@kernel.org> wrote:

> Ingo,
> 
> Please pull the perf/breakpoint-v3 branch that can be found at:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
> 	perf/breakpoint-v3
> 
> HEAD: 3c0681cc01b39e7fac6eb810e82380165c9b56f1
> 
> Changes since v2:
> 
> * Constify the struct perf_event_attr passed in hw_breakpoint_parse()
> * Add acks
> 	
> ---
> When we modify a hardware breakpoint, the architecture code fills up
> the architecture data as the validation of generic attributes progresses.
> If something goes wrong in the middle, the architecture data changes
> aren't rolled back and we are left with a halfway fiddled breakpoint.
> 
> This set fixes the various misdesigns that back this bad behaviour.
> 
> Thanks,
> 	Frederic
> ---
> 
> Frederic Weisbecker (12):
>       perf/breakpoint: Split attribute parse and commit
>       perf/breakpoint: Pass arch breakpoint struct to arch_check_bp_in_kernelspace()
>       x86: Implement hw_breakpoint_arch_parse()
>       powerpc: Implement hw_breakpoint_arch_parse()
>       arm: Implement hw_breakpoint_arch_parse()
>       arm64: Implement hw_breakpoint_arch_parse()
>       sh: Remove "struct arch_hw_breakpoint::name" unused field
>       sh: Implement hw_breakpoint_arch_parse()
>       xtensa: Implement hw_breakpoint_arch_parse()
>       perf/breakpoint: Remove default hw_breakpoint_arch_parse()
>       perf/breakpoint: Pass new breakpoint type to modify_breakpoint_slot()
>       perf/breakpoint: Clean up and consolidate modify_user_hw_breakpoint_check()
> 
> 
>  arch/arm/include/asm/hw_breakpoint.h     |   7 +-
>  arch/arm/kernel/hw_breakpoint.c          |  78 +++++++++---------
>  arch/arm64/include/asm/hw_breakpoint.h   |   7 +-
>  arch/arm64/kernel/hw_breakpoint.c        |  86 ++++++++++----------
>  arch/powerpc/include/asm/hw_breakpoint.h |   7 +-
>  arch/powerpc/kernel/hw_breakpoint.c      |  47 ++++++-----
>  arch/sh/include/asm/hw_breakpoint.h      |   8 +-
>  arch/sh/kernel/hw_breakpoint.c           |  53 ++++++-------
>  arch/x86/include/asm/hw_breakpoint.h     |   7 +-
>  arch/x86/kernel/hw_breakpoint.c          | 131 ++++++++++++++++---------------
>  arch/xtensa/include/asm/hw_breakpoint.h  |   7 +-
>  arch/xtensa/kernel/hw_breakpoint.c       |  40 ++++------
>  kernel/events/hw_breakpoint.c            |  92 +++++++++++++---------
>  13 files changed, 294 insertions(+), 276 deletions(-)

Ok, this looks pretty good.

I was trying to apply this series today, but got a few conflicts due to new 
changes in the merge window, in:

	arch/sh/kernel/hw_breakpoint.c
	arch/powerpc/kernel/hw_breakpoint.c

Could you please resolve those conflicts and resend the series?

Thanks!

	Ingo
