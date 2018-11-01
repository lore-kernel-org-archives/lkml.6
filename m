Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5EAEC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 11:29:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A724B205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 11:29:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A724B205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728292AbeKAUcX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 16:32:23 -0400
Received: from foss.arm.com ([217.140.101.70]:55158 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727507AbeKAUcX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 16:32:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 71F8DA78;
        Thu,  1 Nov 2018 04:29:50 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 57DCA3F71D;
        Thu,  1 Nov 2018 04:29:49 -0700 (PDT)
Date:   Thu, 1 Nov 2018 11:29:43 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org,
        tipbuild@zytor.com, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [tip:locking/core 5/6] /bin/bash:
 scripts/atomic/check-atomics.sh: No such file or directory
Message-ID: <20181101112943.4zwlwsmkeebg7p5k@lakrids.cambridge.arm.com>
References: <201811011821.G9DTgwnD%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201811011821.G9DTgwnD%fengguang.wu@intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 01, 2018 at 06:16:22PM +0800, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/core
> head:   30bc7baa9de81efc0584b9290ce8040a1130f156
> commit: 85f8507192fbfb4ad2ac01de879cb50045f4247f [5/6] locking/atomics: Check generated headers are up-to-date
> config: i386-tinyconfig (attached as .config)
> compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
> reproduce:
>         git checkout 85f8507192fbfb4ad2ac01de879cb50045f4247f
>         # save the attached .config to linux build tree
>         make ARCH=i386 
> 
> All errors (new ones prefixed by >>):
> 
> >> /bin/bash: scripts/atomic/check-atomics.sh: No such file or directory
>    make[2]: *** [old-atomics] Error 127
>    make[2]: Target '__build' not remade because of errors.
>    make[1]: *** [prepare0] Error 2
>    make[1]: Target 'prepare' not remade because of errors.
>    make: *** [sub-make] Error 2

It looks like we accidentally dropped execute permissions from the
scripts when picking them from the list. Locally I get a slightly
different failure:

  ALL    scripts/atomic/check-atomics.sh
  scripts/atomic/check-atomics.sh: line 16: 
  scripts/atomic/gen-atomic-instrumented.sh: Permission denied
  warning: include/asm-generic/atomic-instrumented.h is out-of-date.
  scripts/atomic/check-atomics.sh: line 16: 
  scripts/atomic/gen-atomic-long.sh: Permission denied
  warning: include/asm-generic/atomic-long.h is out-of-date.
  scripts/atomic/check-atomics.sh: line 16: 
  scripts/atomic/gen-atomic-fallback.sh: Permission denied
  warning: include/linux/atomic-fallback.h is out-of-date.

I've sent a patch [1] to fix this.

Thanks,
Mark.

[1] https://lkml.kernel.org/r/20181101112654.55898-1-mark.rutland@arm.com
