Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92B2BC5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 12:04:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3983C20BEC
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 12:04:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3983C20BEC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732626AbeGKMIi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 08:08:38 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:34272 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726457AbeGKMIi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 08:08:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CBB3480D;
        Wed, 11 Jul 2018 05:04:37 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9AAFD3F589;
        Wed, 11 Jul 2018 05:04:37 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 99F8F1AE3828; Wed, 11 Jul 2018 13:05:19 +0100 (BST)
Date:   Wed, 11 Jul 2018 13:05:19 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     "Yandong.Zhao" <yandong77520@gmail.com>
Cc:     Dave.Martin@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ard.biesheuvel@linaro.org,
        catalin.marinas@arm.com, zhaoyd@thundersoft.com,
        zhaoxb@thundersoft.com, fanlc0801@thundersoft.com
Subject: Re: [PATCH] arm64: neon: Fix function may_use_simd() return error
 status
Message-ID: <20180711120519.GC15725@arm.com>
References: <1531307188-12032-1-git-send-email-yandong77520@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531307188-12032-1-git-send-email-yandong77520@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 07:06:28PM +0800, Yandong.Zhao wrote:
> From: Yandong Zhao <yandong77520@gmail.com>
> 
> It does not matter if the caller of may_use_simd() migrates to
> another cpu after the call, but it is still important that the
> kernel_neon_busy percpu instance that is read matches the cpu the
> task is running on at the time of the read.
> 
> This means that raw_cpu_read() is not sufficient.  kernel_neon_busy
> may appear true if the caller migrates during the execution of
> raw_cpu_read() and the next task to be scheduled in on the initial
> cpu calls kernel_neon_begin().
> 
> This patch replaces raw_cpu_read() with this_cpu_read() to protect
> against this race.
> 
> Fixes: cb84d11e1625 ("arm64: neon: Remove support for nested or hardirq kernel-mode NEON")
> Reviewed-by: Dave Martin <Dave.Martin@arm.com>
> Signed-off-by: Yandong Zhao <yandong77520@gmail.com>
> ---
>  arch/arm64/include/asm/simd.h | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Does this need to go to stable?

Will
