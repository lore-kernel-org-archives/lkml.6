Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1521BC5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 12:58:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D03A52084A
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 12:58:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D03A52084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387437AbeGKNCn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 09:02:43 -0400
Received: from foss.arm.com ([217.140.101.70]:35220 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387405AbeGKNCn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 09:02:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 90C497A9;
        Wed, 11 Jul 2018 05:58:29 -0700 (PDT)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E99443F5AD;
        Wed, 11 Jul 2018 05:58:27 -0700 (PDT)
Date:   Wed, 11 Jul 2018 13:58:25 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Will Deacon <will.deacon@arm.com>
Cc:     "Yandong.Zhao" <yandong77520@gmail.com>, zhaoxb@thundersoft.com,
        ard.biesheuvel@linaro.org, catalin.marinas@arm.com,
        linux-kernel@vger.kernel.org, zhaoyd@thundersoft.com,
        linux-arm-kernel@lists.infradead.org, fanlc0801@thundersoft.com
Subject: Re: [PATCH] arm64: neon: Fix function may_use_simd() return error
 status
Message-ID: <20180711125825.GM9486@e103592.cambridge.arm.com>
References: <1531307188-12032-1-git-send-email-yandong77520@gmail.com>
 <20180711120519.GC15725@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180711120519.GC15725@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 01:05:19PM +0100, Will Deacon wrote:
> On Wed, Jul 11, 2018 at 07:06:28PM +0800, Yandong.Zhao wrote:
> > From: Yandong Zhao <yandong77520@gmail.com>
> > 
> > It does not matter if the caller of may_use_simd() migrates to
> > another cpu after the call, but it is still important that the
> > kernel_neon_busy percpu instance that is read matches the cpu the
> > task is running on at the time of the read.
> > 
> > This means that raw_cpu_read() is not sufficient.  kernel_neon_busy
> > may appear true if the caller migrates during the execution of
> > raw_cpu_read() and the next task to be scheduled in on the initial
> > cpu calls kernel_neon_begin().
> > 
> > This patch replaces raw_cpu_read() with this_cpu_read() to protect
> > against this race.
> > 
> > Fixes: cb84d11e1625 ("arm64: neon: Remove support for nested or hardirq kernel-mode NEON")
> > Reviewed-by: Dave Martin <Dave.Martin@arm.com>
> > Signed-off-by: Yandong Zhao <yandong77520@gmail.com>
> > ---
> >  arch/arm64/include/asm/simd.h | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> Does this need to go to stable?

It should, yes, so we should probably add

Cc: stable@vger.kernel.org


Are you OK to pick that up?

Cheers
---Dave
