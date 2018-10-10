Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53D9FC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 16:49:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05B422086E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 16:49:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05B422086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbeJKAMT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 20:12:19 -0400
Received: from foss.arm.com ([217.140.101.70]:55312 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726656AbeJKAMT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 20:12:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7DCC2ED1;
        Wed, 10 Oct 2018 09:49:20 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 423C83F5B3;
        Wed, 10 Oct 2018 09:49:20 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id F3F841AE088A; Wed, 10 Oct 2018 17:49:19 +0100 (BST)
Date:   Wed, 10 Oct 2018 17:49:19 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Sodagudi Prasad <psodagud@codeaurora.org>
Cc:     catalin.marinas@arm.com, gregkh@linuxfoundation.org,
        ard.biesheuvel@linaro.org, robin.murphy@arm.com,
        ynorov@caviumnetworks.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: livelock with hrtimer cpu_base->lock
Message-ID: <20181010164919.GA16512@arm.com>
References: <8f671ebb6b331cd00ce17d111f28c548@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f671ebb6b331cd00ce17d111f28c548@codeaurora.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prasad,

On Tue, Oct 09, 2018 at 01:56:14PM -0700, Sodagudi Prasad wrote:
> This is regarding - thread "try to fix contention between expire_timers and
> try_to_del_timer_sync".
> https://lkml.org/lkml/2017/7/28/172
> 
> I think this live lockup issue was discussed earlier but the final set of
> changes were not concluded.

Well we basically need a way to pick a value for CPU_RELAX_WFE_THRESHOLD.
Do you have any ideas? It could be determined at runtime if necessary.

> I would like to check whether you have new updates on this issue or not.
> This problem is observed with 4.14 .64 stable kernel too.
> We see this problem 2 times in overnight testing.
> 
> I have to add the following code to avoid live lock. I am thinking that
> fixing this at the cpu_relax() level.
> 
> +++ b/kernel/time/hrtimer.c
> @@ -52,6 +52,7 @@
>  #include <linux/timer.h>
>  #include <linux/freezer.h>
>  #include <linux/compat.h>
> +#include <linux/delay.h>
> 
>  #include <linux/uaccess.h>
> 
> @@ -152,6 +153,7 @@ struct hrtimer_clock_base *lock_hrtimer_base(const
> struct hrtimer *timer,
> raw_spin_unlock_irqrestore(&base->cpu_base->lock, *flags);
>                 }
>                 cpu_relax();
> +               udelay(1);
>         }
>  }
> 
> @@ -1067,6 +1069,7 @@ int hrtimer_cancel(struct hrtimer *timer)
>                 if (ret >= 0)
>                         return ret;
>                 cpu_relax();
> +               udelay(1);
>         }
>  }
>  EXPORT_SYMBOL_GPL(hrtimer_cancel);

This is just another bodge and likely to hurt in places where 1us is
excessive because there isn't contention.

Will
