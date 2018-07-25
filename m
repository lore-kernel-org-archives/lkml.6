Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1233EC67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 11:49:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5CE620843
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 11:49:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5CE620843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728943AbeGYNBP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 09:01:15 -0400
Received: from foss.arm.com ([217.140.101.70]:37450 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728681AbeGYNBO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 09:01:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1F2F080D;
        Wed, 25 Jul 2018 04:49:55 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E4E703F575;
        Wed, 25 Jul 2018 04:49:54 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id DA0B71AE3B5E; Wed, 25 Jul 2018 12:49:54 +0100 (BST)
Date:   Wed, 25 Jul 2018 12:49:54 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Laura Abbott <labbott@redhat.com>
Cc:     Alexander Popov <alex.popov@linux.com>,
        Kees Cook <keescook@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        kernel-hardening@lists.openwall.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>, james.morse@arm.com
Subject: Re: [PATCHv3 0/2] Stackleak for arm64
Message-ID: <20180725114954.GD30289@arm.com>
References: <1531341400-12077-1-git-send-email-alex.popov@linux.com>
 <20180720214154.2940-1-labbott@redhat.com>
 <20180724163807.GE25888@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180724163807.GE25888@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laura,

On Tue, Jul 24, 2018 at 05:38:07PM +0100, Will Deacon wrote:
> On Fri, Jul 20, 2018 at 02:41:52PM -0700, Laura Abbott wrote:
> > This is the version of stackleak for arm64, hopefully ready for queueing
> 
> Thanks. I'll push these into linux-next tomorrow, once I've had a chance
> to test my conflict resolution in entry.S.

I've run into a couple of issues with this series:

1. I had to install libmpc-dev to get GCC_PLUGINS to appear, otherwise the
   hostcc check would silently fail. I guess that's a general observation,
   but it might be nice to print a message about the missing dependencies.

2. It breaks arm64 allmodconfig build. Log below.

Please can you take a look at the build failure? Otherwise, the patches
look good to me.

Cheers,

Will

--->8

arch/arm64/kernel/sdei.c: In function ‘on_sdei_normal_stack’:
arch/arm64/kernel/sdei.c:101:7: error: dereferencing pointer to incomplete type ‘struct stack_info’
   info->low = low;
       ^~
arch/arm64/kernel/sdei.c:103:16: error: ‘STACK_TYPE_SDEI_NORMAL’ undeclared (first use in this function); did you mean ‘SCHED_NORMAL’?
   info->type = STACK_TYPE_SDEI_NORMAL;
                ^~~~~~~~~~~~~~~~~~~~~~
                SCHED_NORMAL
arch/arm64/kernel/sdei.c:103:16: note: each undeclared identifier is reported only once for each function it appears in
arch/arm64/kernel/sdei.c: In function ‘on_sdei_critical_stack’:
arch/arm64/kernel/sdei.c:121:16: error: ‘STACK_TYPE_SDEI_CRITICAL’ undeclared (first use in this function)
   info->type = STACK_TYPE_SDEI_CRITICAL;
                ^~~~~~~~~~~~~~~~~~~~~~~~
arch/arm64/kernel/sdei.c: At top level:
arch/arm64/kernel/sdei.c:127:6: error: conflicting types for ‘_on_sdei_stack’
 bool _on_sdei_stack(unsigned long sp,
      ^~~~~~~~~~~~~~
In file included from ./include/linux/arm_sdei.h:14:0,
                 from arch/arm64/kernel/sdei.c:5:
./arch/arm64/include/asm/sdei.h:45:6: note: previous declaration of ‘_on_sdei_stack’ was here
 bool _on_sdei_stack(unsigned long sp, struct stack_info *info);
      ^~~~~~~~~~~~~~
arch/arm64/kernel/sdei.c: In function ‘_on_sdei_stack’:
arch/arm64/kernel/sdei.c:136:33: error: ‘info’ undeclared (first use in this function); did you mean ‘int’?
  if (on_sdei_critical_stack(sp, info))
                                 ^~~~
                                 int
arch/arm64/kernel/sdei.c:131:21: warning: unused variable ‘high’ [-Wunused-variable]
  unsigned long low, high;
                     ^~~~
arch/arm64/kernel/sdei.c:131:16: warning: unused variable ‘low’ [-Wunused-variable]
  unsigned long low, high;
                ^~~
make[1]: *** [arch/arm64/kernel/sdei.o] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [arch/arm64/kernel] Error 2
