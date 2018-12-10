Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94EA1C65BB3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 15:47:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 557A520821
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 15:47:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="MK8l7UTs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 557A520821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lca.pw
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbeLJPr6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 10:47:58 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43083 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728050AbeLJPr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 10:47:58 -0500
Received: by mail-qt1-f195.google.com with SMTP id i7so12738564qtj.10
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 07:47:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LCf9Z4VdxxL+ACTRPCvQ1wda3huFplaR4OdG4DSoMUI=;
        b=MK8l7UTs9njLHxQeiKhpqeRDvjmdksChzkMfgty8lnIPOBnjGcCnLrpHNkvOtcz9QF
         TkRBBvxLJBg/nMovERh55Tk672ONANtNgndFwtcYrNrveafQuu1N+HjX0hWmTquES0Zj
         l8Jt3EDSN5hCcOS2rxYMfbrpz1MOzA0OLu+mawLZ1Npo2939B037nnzUEma0858hQFtI
         skmmESHM0H//rhOuhNijAVmpHmh9A2g98oHj+G4aypA7Fo40Z8lWja1oRA9sdz6gbuhF
         SUUC8hWgajPlFvj/Yu3p9UIYmlImeBeAps2pPw59jJ3NKAngZrdY2sVuQQYAwmRGwPZn
         g+Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LCf9Z4VdxxL+ACTRPCvQ1wda3huFplaR4OdG4DSoMUI=;
        b=MFbjGtg4kw1FFWh/iVjpZp6OGf3ndJ0Q/Qp6EhFaMou0u8mLIiStGITzXRAP2ncqce
         l9zXQOiY9GQuq/bNCOugM8b4tyi1WVJibjkN60S+ik3UmlkZYnPSNClM7wlkB++Xl3x5
         wIvUmjwrmExCwXk5VyubMiP4Neo23zviUFN0ofqY/Lw9n8R/y08vAwVN4OP3i4yM757j
         cNjjf9sxJROGfuc85qXE5Yga865kMEWjZ+vX517Jlz/HabMtuowCD59pRzKAPOwxsivR
         A/U5GDE6kYUjDd7NCPbyRHQsYekwNDpdkHuwwPtVYuyrTpLRg6fUGjLg450blQJFuyjk
         DrOQ==
X-Gm-Message-State: AA+aEWZA7qabd1+onkQk54uIWj+/Xlk3UIuZ2ce2USPHRsFYNURv/9Re
        Tx1a+dpwxJex4ytVyn7hIfknvCN5Y7I=
X-Google-Smtp-Source: AFSGD/WzVOsT+FTzkS6a5OBVN1mhZ8uWPLV6dsu1Wxthq6TpRPsga8PU/vx6ChMsJQhCIRs99WaqcQ==
X-Received: by 2002:a0c:f212:: with SMTP id h18mr12274818qvk.106.1544456876413;
        Mon, 10 Dec 2018 07:47:56 -0800 (PST)
Received: from ovpn-121-90.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id k189sm6196469qkf.64.2018.12.10.07.47.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 07:47:55 -0800 (PST)
Subject: Re: [RESEND PATCH v2] clocksource/arm_arch_timer: fix a lockdep
 warning
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     akpm@linux-foundation.org, mark.rutland@arm.com,
        marc.zyngier@arm.com, daniel.lezcano@linaro.org,
        tglx@linutronix.de, mingo@kernel.org, longman@redhat.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1543877121-4098-1-git-send-email-cai@gmx.us>
 <20181210135228.49751-1-cai@lca.pw>
 <20181210140703.GM5289@hirez.programming.kicks-ass.net>
From:   Qian Cai <cai@lca.pw>
Message-ID: <929c17bd-1397-69d2-79c7-b81b9ae50346@lca.pw>
Date:   Mon, 10 Dec 2018 10:47:54 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20181210140703.GM5289@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/10/18 9:07 AM, Peter Zijlstra wrote:
> On Mon, Dec 10, 2018 at 08:52:28AM -0500, Qian Cai wrote:
>> Booting this Huawei TaiShan 2280 arm64 server generated this lockdep
>> warning.
>>
>> [    0.000000]  lockdep_assert_cpus_held+0x50/0x60
>> [    0.000000]  static_key_enable_cpuslocked+0x30/0xe8
>> [    0.000000]  arch_timer_check_ool_workaround+0x128/0x2d0
>> [    0.000000]  arch_timer_acpi_init+0x274/0x6ac
>> [    0.000000]  acpi_table_parse+0x1ac/0x218
>> [    0.000000]  __acpi_probe_device_table+0x164/0x1ec
>> [    0.000000]  timer_probe+0x1bc/0x254
>> [    0.000000]  time_init+0x44/0x98
>> [    0.000000]  start_kernel+0x4ec/0x7d4
> 
> It seems to me we want something like:

Tested-by: Qian Cai <cai@lca.pw>

> 
> ---
>  kernel/cpu.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index 91d5c38eb7e5..e1ee8caf28b5 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -313,6 +313,8 @@ void cpus_write_unlock(void)
>  
>  void lockdep_assert_cpus_held(void)
>  {
> +	if (system_state < SYSTEM_RUNNING)
> +		return;
>  	percpu_rwsem_assert_held(&cpu_hotplug_lock);
>  }
>  
> 
