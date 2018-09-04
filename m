Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E845C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 12:12:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 145162077C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 12:12:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="TamJFqnQ";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="W3oA9wr6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 145162077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727235AbeIDQhq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 12:37:46 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:38758 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbeIDQhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 12:37:46 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 54099607DC; Tue,  4 Sep 2018 12:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536063173;
        bh=fLmRZQ11VO7cYaYDJEesM73Gj/xoAB/Jj7saknszTFE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=TamJFqnQf0ABfyMiGgNhfhl/hrwnPgC/CpQ1nXgiUmcgPQjsoNH1HKO8UBWreeOBg
         r+FWICNZ0GjVxWI2yy2fs6UEYJmO0rhy0casavqe+qqW1+es0I6Zx8TUogkYi8rzEE
         qlq7OX5uktQR+r4FCSXu7JObXwaIvGTQptKs7Odc=
Received: from [10.204.79.100] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EC1DB6044B;
        Tue,  4 Sep 2018 12:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536063172;
        bh=fLmRZQ11VO7cYaYDJEesM73Gj/xoAB/Jj7saknszTFE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=W3oA9wr6j6RL5W7jdIq36pxKItUPfxdBAaZLCykwkHbhYLiDQ7P8CkRXrn0n7XL3B
         PoP5jzXHs3wO9vIcd8fRZvpbUuOObAsJtDNMhGA/aRXEhteTeOcLLRm+E7KbmJmN3y
         HRIzznHQUfrWm5+WeoIwzO5rhytZLBggAMhw8c18=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EC1DB6044B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] cpu/hotplug: Fix rollback during error-out in
 takedown_cpu()
To:     Neeraj Upadhyay <neeraju@codeaurora.org>, tglx@linutronix.de,
        josh@joshtriplett.org, peterz@infradead.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dzickus@redhat.com,
        brendan.jackman@arm.com, malat@debian.org
Cc:     linux-kernel@vger.kernel.org, sramana@codeaurora.org,
        linux-arm-msm@vger.kernel.org
References: <1536042803-6152-1-git-send-email-neeraju@codeaurora.org>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <26a4e734-088c-dbd7-30d2-34065787e925@codeaurora.org>
Date:   Tue, 4 Sep 2018 17:42:28 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1536042803-6152-1-git-send-email-neeraju@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/4/2018 12:03 PM, Neeraj Upadhyay wrote:
> If takedown_cpu() fails during _cpu_down(), st->state is reset,
> by calling cpuhp_reset_state(). This results in an additional
> increment of st->state, which results in CPUHP_AP_SMPBOOT_THREADS
> state being skipped during rollback. Fix this by not calling
> cpuhp_reset_state() and doing the state reset directly in
> _cpu_down().
>
> Fixes: 4dddfb5faa61 ("smp/hotplug: Rewrite AP state machine core")
> Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>
> ---
>   kernel/cpu.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index aa7fe85..9f49edb 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -970,7 +970,14 @@ static int __ref _cpu_down(unsigned int cpu, int tasks_frozen,
>   	 */
>   	ret = cpuhp_down_callbacks(cpu, st, target);
>   	if (ret && st->state > CPUHP_TEARDOWN_CPU && st->state < prev_state) {
> -		cpuhp_reset_state(st, prev_state);
> +		/*
> +		 * As st->last is not set, cpuhp_reset_state() increments
> +		 * st->state, which results in CPUHP_AP_SMPBOOT_THREADS being
> +		 * skipped during rollback. So, don't use it here.
> +		 */
> +		st->rollback = true;
> +		st->target = prev_state;
> +		st->bringup = !st->bringup;

Acked-by: Mukesh Ojha <mojha@codeaurora.org>

looks valid for this case.

>   		__cpuhp_kick_ap(st);
>   	}
>   

