Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0D75C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 05:53:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C1DB208EC
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 05:53:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C1DB208EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbeGKF4H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 01:56:07 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:56858 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726200AbeGKF4H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 01:56:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 15F9C80D;
        Tue, 10 Jul 2018 22:53:32 -0700 (PDT)
Received: from salmiak (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 20A853F318;
        Tue, 10 Jul 2018 22:53:30 -0700 (PDT)
Date:   Wed, 11 Jul 2018 06:53:28 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH] perf/core: fix possible spectre-v1 write
Message-ID: <20180711055327.5l23y4z7nk4wv7uz@salmiak>
References: <20180710180607.56624-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180710180607.56624-1-mark.rutland@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2018 at 07:06:07PM +0100, Mark Rutland wrote:
> It's possible for userspace to control event_id. Sanitize event_id when
> using it as an array index, to inhibit the potential spectre-v1 write
> gadget.
> 
> This class of issue is also known as CVE-2018-3693, or "bounds check bypass
> store".
> 
> Found by smatch.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> ---
>  kernel/events/core.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> For Arm CPUs, more details can be found in the Arm Cache Speculation
> Side-channels whitepaper, available from the Arm security updates site [1].
> 
> Mark.
> 
> [1] https://developer.arm.com/support/arm-security-updates/speculative-processor-vulnerability
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 8f0434a9951a..eece719bd18e 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -8155,6 +8155,7 @@ struct static_key perf_swevent_enabled[PERF_COUNT_SW_MAX];
>  static void sw_perf_event_destroy(struct perf_event *event)
>  {
>  	u64 event_id = event->attr.config;
> +	event_id = array_index_nospec(event_id, PERF_COUNT_SW_MAX);

As the kbuild test robot has pointed out, I've failed to include
<linux/nospec.h> for this to compile.

I'll spin a v2 with that added, and the result tested.

Thanks,
Mark.
