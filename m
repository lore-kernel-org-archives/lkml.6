Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98606ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 15:09:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BCF2204EC
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 15:09:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ICSPDUuw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BCF2204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732101AbeGTP6b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 11:58:31 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35302 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731797AbeGTP6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 11:58:31 -0400
Received: by mail-wm0-f66.google.com with SMTP id y22-v6so10199634wma.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jul 2018 08:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iZ6HcbI+AwO8sZyirZnhsGp69r8+XIIaejTntbzluPg=;
        b=ICSPDUuwsPhj5Yrzq+2ZSTl7dIwhW5L+tQrAs/HeZEepchzP1mUswIVj6QFYp07+fr
         WtVnu2bBMVAW/3JoWOMJPnKXG4YU4uBY6EcMklE0n/6qR8bwqbk9WL4hDVcQZTSoQarK
         yfE1lGkzQN9FBvruRfLD0KGDptv8i1Tm/yx3A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iZ6HcbI+AwO8sZyirZnhsGp69r8+XIIaejTntbzluPg=;
        b=rPonbSTEGeLns/J0KudfmT0qG0kXXe4QYB/ikHiw+mXzSwvKPEZgUubLYgEr1Gm7a7
         61md8cm4H3dqPw62hrtae3b5jAvSrQYeLPRJK7wZgl/ynxp5nfTqiao/pmdjndmFYzvb
         nS3u4NtnDEVGZmDC6I89sy+nOEkU61pa7boY1C+0In/Rnqgto1o08qJagh66e9+eP6sK
         vwrTOw1xEMJnf0dmzS62fdiTUwczS4Dk4sBurEOeVSyvuMbVYmyY3iUui63zppyjQTP0
         +ypHwLl9drOmgbnkDehIas3q6rdE/LIL7vyaFJ7hjlK3WYmLmoJoSj2qJPh1Rpqi3KRy
         seWA==
X-Gm-Message-State: AOUpUlFbGQEyfc84Nt/ShySiDRPZrbzFAA/OChaBBu9eCq/bbxbqVSsD
        FmCzHItfWYpAIXHY/Q4tjPlSaQ==
X-Google-Smtp-Source: AAOMgpdx8XpCbVfUjPoBKFBO2p1AUsdW5vhyqPif8hP0AV538tuSXlJYwFC6+GuZ2nufieZzu/MDQg==
X-Received: by 2002:a1c:1bc8:: with SMTP id b191-v6mr1799579wmb.10.1532099386204;
        Fri, 20 Jul 2018 08:09:46 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id o4-v6sm3061222wra.3.2018.07.20.08.09.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 20 Jul 2018 08:09:45 -0700 (PDT)
Date:   Fri, 20 Jul 2018 16:09:43 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Julien Thierry <julien.thierry@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        joel@joelfernandes.org, marc.zyngier@arm.com, mark.rutland@arm.com,
        christoffer.dall@arm.com, james.morse@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com
Subject: Re: [PATCH v4 00/26] arm64: provide pseudo NMI with GICv3
Message-ID: <20180720150943.i4u2s7wie7falh7p@holly.lan>
References: <1527241772-48007-1-git-send-email-julien.thierry@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527241772-48007-1-git-send-email-julien.thierry@arm.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 25, 2018 at 10:49:06AM +0100, Julien Thierry wrote:
> This series is a continuation of the work started by Daniel [1]. The goal
> is to use GICv3 interrupt priorities to simulate an NMI.
> 
> To achieve this, set two priorities, one for standard interrupts and
> another, higher priority, for NMIs. Whenever we want to disable interrupts,
> we mask the standard priority instead so NMIs can still be raised. Some
> corner cases though still require to actually mask all interrupts
> effectively disabling the NMI.
> 
> Currently, only PPIs and SPIs can be set as NMIs. IPIs being currently
> hardcoded IRQ numbers, there isn't a generic interface to set SGIs as NMI
> for now. I don't think there is any reason LPIs should be allowed to be set
> as NMI as they do not have an active state.
> When an NMI is active on a CPU, no other NMI can be triggered on the CPU.
> 
> After the big refactoring I get performances similar to the ones I had
> in v3[2], reposting old results here:
> 
> - "hackbench 200 process 1000" (average over 20 runs)
> +-----------+----------+------------+------------------+
> |           | native   | PMR guest  | v4.17-rc6 guest  |
> +-----------+----------+------------+------------------+
> | PMR host  | 40.0336s |   39.3039s |         39.2044s |
> | v4.17-rc6 | 40.4040s |   39.6011s |         39.1147s |
> +-----------+----------+------------+------------------+
> 
> - Kernel build from defconfig:
> PMR host:  13m45.743s
> v4.17-rc6: 13m40.400s
> 
> I'll try to post more detailed benchmarks later if I find notable
> differences with the previous version.

So... I'm rather late sharing these benchmarks but...

I ran some kernel build benchmarks on the Developerbox from 96Boards
(aka Synquacer E-series by Socionext): 24 C-A53 cores running at 1GHz.
This is obviously a real workload and one that anything called
Developerbox needs to care about!

The difference in performance is slight but PMR based locking is
marginally slower than using the I-bit. It varies with the
parrallel-ness of the build slightly but the slowdown on this platform
is between 0.2% and 0.6% [1].

This delta was sufficiently small that I was willing to leave the PMR
masking in place for a fair amount of my day to day work. On that basis
these patches could also be described as:

Tested-by: Daniel Thompson <daniel.thompson@linaro.org> 


Daniel.


[1] For anyone interested in the raw numbers then the spreadsheet where
    I checked the results is here:
https://docs.google.com/spreadsheets/d/1gGxAJd_gL-HjeTF-x0Ut5lWT4JULNRDeTbPvPInZ4H4/edit?usp=sharing
