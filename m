Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07A19C04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 20:26:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0A2E2081F
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 20:26:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="OghsouaC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0A2E2081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726218AbeLHUZj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 15:25:39 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34960 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbeLHUZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 15:25:38 -0500
Received: by mail-pg1-f193.google.com with SMTP id s198so3191209pgs.2
        for <linux-kernel@vger.kernel.org>; Sat, 08 Dec 2018 12:25:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=zf7bPVq52POSMrfUrt5neVYgh/TC1AOdO9lXUX5jff0=;
        b=OghsouaCWKSivNi/XjvklEEPKUxAJ4kmmZL4gbJ6d93x8Kgm0dcLb5Pj4NwxzKr/ne
         2vmygzxIAphi7WKbza4dwRj8m0+ALVQni7N0zmQXWHsY9F1oiFSX90tPtfa5WhkClXHI
         ee3OY+WDNBQl4ixVC3iLRT6Xq2SiFSfVcqpkLMHL1hkH426Na9CFGEpxeQdDALwWKVkG
         tPTmZ65VdzFzf+qXE+X1GUJCsOavXSVhZQXdFss3apaz16lW1ke35vTM7XNspJIq6Jr4
         NX11BWxYxUWdCjCvuyBAeyewp8mF2OzAtt8duLRRbakRvtlIXZmhmLq4ScBRbFXcXxak
         pbJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=zf7bPVq52POSMrfUrt5neVYgh/TC1AOdO9lXUX5jff0=;
        b=eCckrEFHWQ4QzEe1B5dRQGkamTKEQMlf8rx6AyP3te1NuAYzw6ZzUalT0/kWywzj6k
         dvxyQ5eJepdxqcaC2QUr28YQlRnP9Ehge1Ufpqi3rZqC+jnv1HxPIlOZPPWpRS3aM4MX
         NDRp6hXzJckJVPLqVf5Z5K20sr/d5iPkI63tyaeTnSMoaei6EsFD6756qVU4Jiy1+/fe
         Dg+7Xie5XukBlkDU6xrgw2Qz0zvxKtRBYeCV3RRpuml/UyO/lIZO9M3oD8o8ehYlj2J3
         UfMrzXedzadGt9acJlKMsG2FwNHVSdbdY4W9LY+P625D3IvNkJE40/hMoSD7+WtjkVDh
         VNSQ==
X-Gm-Message-State: AA+aEWYJCfxv6d+eMSr89AqCJ0juz2qukKZmM1bE8Cs3nfAMkbzjKPZp
        n2lTr98WWzz8bvJmKljG6+eov7bTmX8=
X-Google-Smtp-Source: AFSGD/V+C94EZll93WdKSRwJ8FhV0SgxdbKKUeOa2BHIBb1E0tBkeP4b5uiAkgTNulICTcsxT9QR1g==
X-Received: by 2002:a63:990a:: with SMTP id d10mr6095711pge.279.1544300737726;
        Sat, 08 Dec 2018 12:25:37 -0800 (PST)
Received: from localhost ([216.3.10.7])
        by smtp.gmail.com with ESMTPSA id j70sm9270301pfc.43.2018.12.08.12.25.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Dec 2018 12:25:36 -0800 (PST)
Date:   Sat, 08 Dec 2018 12:25:36 -0800 (PST)
X-Google-Original-Date: Sat, 08 Dec 2018 12:15:39 PST (-0800)
Subject:     Re: [PATCH 4/4] RISC-V: Fix non-smp kernel boot on SMP systems
In-Reply-To: <CAAhSdy1gNB0sMAq4mtGSNJ96BND4tMxHShq==3B1hzL9ebs=oQ@mail.gmail.com>
CC:     atish.patra@wdc.com, linux-kernel@vger.kernel.org,
        aou@eecs.berkeley.edu, daniel.lezcano@linaro.org,
        devicetree@vger.kernel.org, dmitriy@oss-tech.org,
        linux-riscv@lists.infradead.org, mark.rutland@arm.com,
        robh+dt@kernel.org, tglx@linutronix.de, Damien.LeMoal@wdc.com
From:   Palmer Dabbelt <palmer@sifive.com>
To:     anup@brainfault.org
Message-ID: <mhng-13731457-9a18-4add-983c-decbae526c81@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 07 Dec 2018 09:20:57 PST (-0800), anup@brainfault.org wrote:
> On Fri, 7 Dec, 2018, 10:30 PM Palmer Dabbelt <palmer@sifive.com wrote:
>
>> On Mon, 03 Dec 2018 12:57:31 PST (-0800), atish.patra@wdc.com wrote:
>> > Currently, clocksource registration happens for an invalid cpu
>> > for non-smp kernels. This lead to kernel panic as cpu hotplug
>> > registration will fail for those cpus.
>> >
>> > Do not proceed if hartid is invalid. Take this opprtunity to
>> > print appropriate error strings for different failure cases.
>> >
>> > Signed-off-by: Atish Patra <atish.patra@wdc.com>
>> > ---
>> >  drivers/clocksource/riscv_timer.c | 13 ++++++++++---
>> >  1 file changed, 10 insertions(+), 3 deletions(-)
>> >
>> > diff --git a/drivers/clocksource/riscv_timer.c
>> b/drivers/clocksource/riscv_timer.c
>> > index 39de6e49..4af4af47 100644
>> > --- a/drivers/clocksource/riscv_timer.c
>> > +++ b/drivers/clocksource/riscv_timer.c
>> > @@ -108,6 +108,8 @@ static int __init riscv_timer_init_dt(struct
>> device_node *n)
>> >       int cpuid, hartid, error;
>> >
>> >       hartid = riscv_of_processor_hartid(n);
>> > +     if (hartid < 0)
>> > +             return hartid;
>>
>> This seems like it's just hiding a bug somewhere else.  We should at least
>> put
>> out a WARN here, as I'm not sure the error will propagate anywhere useful.
>>
>
> We need separate DT node for riscv_timer. The riscv_timer is nothing but
> SOC timer accessed via rdtime and SBI calls. It can be viewed as one
> device. In fact, this is how it's done in ARM/ARM64.

We had that at some point, but this was changed.  The logic was that, since the 
RISC-V ISA mandates the presence of this timer for all harts, the RISC-V CPU 
node is sufficient to encode the presence of a RISC-V timer.

I'm OK changing this, but you should look at the old thread (which I can't 
find) to make sure all the arguments are taken into account.

>> >       cpuid = riscv_hartid_to_cpuid(hartid);
>> >
>> >       if (cpuid != smp_processor_id())
>> > @@ -115,14 +117,19 @@ static int __init riscv_timer_init_dt(struct
>> device_node *n)
>> >
>> >       /* This should be called only for boot cpu */
>> >       riscv_timebase = riscv_timebase_frequency(n);
>> > -     clocksource_register_hz(&riscv_clocksource, riscv_timebase);
>> > +     error = clocksource_register_hz(&riscv_clocksource,
>> riscv_timebase);
>> >
>> > +     if (error) {
>> > +             pr_err("RISCV timer register failed [%d] for cpu = [%d]\n",
>> > +                    error, cpuid);
>> > +             return error;
>> > +     }
>> >       error = cpuhp_setup_state(CPUHP_AP_RISCV_TIMER_STARTING,
>> >                        "clockevents/riscv/timer:starting",
>> >                        riscv_timer_starting_cpu, riscv_timer_dying_cpu);
>> >       if (error)
>> > -             pr_err("RISCV timer register failed [%d] for cpu = [%d]\n",
>> > -                    error, cpuid);
>> > +             pr_err("cpu hp setup state failed for RISCV timer [%d]\n",
>> > +                    error);
>> >       return error;
>> >  }
>>
>
> Regards,
> Anup
>
>>
