Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9E7FC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 09:55:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AB5820883
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 09:55:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AB5820883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729207AbeGZLLz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 07:11:55 -0400
Received: from foss.arm.com ([217.140.101.70]:51714 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728956AbeGZLLy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 07:11:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B530380D;
        Thu, 26 Jul 2018 02:55:49 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 43CA03F575;
        Thu, 26 Jul 2018 02:55:49 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id EACE21AE13AE; Thu, 26 Jul 2018 10:55:48 +0100 (BST)
Date:   Thu, 26 Jul 2018 10:55:48 +0100
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
Message-ID: <20180726095548.GB28088@arm.com>
References: <1531341400-12077-1-git-send-email-alex.popov@linux.com>
 <20180720214154.2940-1-labbott@redhat.com>
 <20180724163807.GE25888@arm.com>
 <20180725114954.GD30289@arm.com>
 <fbf890f6-7424-362e-95dd-223262e5f19e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fbf890f6-7424-362e-95dd-223262e5f19e@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laura,

On Wed, Jul 25, 2018 at 03:05:58PM -0700, Laura Abbott wrote:
> On 07/25/2018 04:49 AM, Will Deacon wrote:
> >arch/arm64/kernel/sdei.c: At top level:
> >arch/arm64/kernel/sdei.c:127:6: error: conflicting types for ‘_on_sdei_stack’
> >  bool _on_sdei_stack(unsigned long sp,
> >       ^~~~~~~~~~~~~~
> >In file included from ./include/linux/arm_sdei.h:14:0,
> >                  from arch/arm64/kernel/sdei.c:5:
> >./arch/arm64/include/asm/sdei.h:45:6: note: previous declaration of ‘_on_sdei_stack’ was here
> >  bool _on_sdei_stack(unsigned long sp, struct stack_info *info);
> >       ^~~~~~~~~~~~~~
> >arch/arm64/kernel/sdei.c: In function ‘_on_sdei_stack’:
> >arch/arm64/kernel/sdei.c:136:33: error: ‘info’ undeclared (first use in this function); did you mean ‘int’?
> >   if (on_sdei_critical_stack(sp, info))
> >                                  ^~~~
> >                                  int
> >arch/arm64/kernel/sdei.c:131:21: warning: unused variable ‘high’ [-Wunused-variable]
> >   unsigned long low, high;
> >                      ^~~~
> >arch/arm64/kernel/sdei.c:131:16: warning: unused variable ‘low’ [-Wunused-variable]
> >   unsigned long low, high;
> >                 ^~~
> >make[1]: *** [arch/arm64/kernel/sdei.o] Error 1
> >make[1]: *** Waiting for unfinished jobs....
> >make: *** [arch/arm64/kernel] Error 2
> >
> 
> Ugh this was a failure that I missed folding in, sorry about that

That's ok, thanks for the quick fixup. I'll fold it in and push this out
later on.

Cheers,

Will
