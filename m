Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0F63C64EB1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 17:00:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6BB220989
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 17:00:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="WKa0Rrlm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6BB220989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726161AbeLGRAO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 12:00:14 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36445 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbeLGRAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 12:00:12 -0500
Received: by mail-pg1-f196.google.com with SMTP id n2so1979776pgm.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 09:00:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=oANJ8NTgVfhgBlhgezfxcRi6A0Prx2iNsZ6jeemAImA=;
        b=WKa0RrlmuDD7lG3nKa9hyk5NK0fRzXszOl00nnVvnmiDHB3/wgXlc3utLohtSutJvq
         Njq3QmkB2B0HW8e6kumWBeby22hg6xlfkTcc5nLyY7hZJkLYb7bGnyjOj4RXGvjn/YtB
         3OjPz1JujpZVuFuZJxpUM1a4f1cLhhWkfJwz0keZ3yNY1H+dwkeKghTz3efFL0lSWOK4
         2MBoi6Wp3HkWGTuvPYqUK56aXJELiVfOSuLXhkCmc99fIQbatyugLWrgCK3J3XhZBmgP
         RIFvefo0HfvEA4kS5GMTaU2Dg+utxiFp6UZQtDWQNA5baaUhTiUrwWRJvyuHkURIk5Qd
         hk0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=oANJ8NTgVfhgBlhgezfxcRi6A0Prx2iNsZ6jeemAImA=;
        b=goVpsln0BLaxYbLki9gd/Wh8oNDAoSZXeWaoWZZHXsQfrjJhn+NPJjPIygyvmfxVGs
         Hz8Bw1cmwHoPUrp15unhS0+vjSfB1CQaa4w9GRKa4K0WNNo7Ny/hVISuu7DdboTzM19n
         yKdoA006HpL3/AFHdj5Dq8LjcW0TvYs8al6XSkflxwpHo2N7KRGc2zS2zjhFr46UTgvl
         JunVNnG7eQ5i5UtTG7DCypEWd9J111f/oPHNeT6qcenooGJ/fgYLui+DevzFLD+mprSb
         RXlmC9h2qxnAhc2Fi3XSdcyLcqJUxkvQWCAMP4G17xSKTTOA9uIr7an4tipshbNk3Dw5
         niTg==
X-Gm-Message-State: AA+aEWaUnL+WTU7pfauogbAo1EvZB3EB30pwyfpoFMpxc3LkSg5oawus
        qo64b+j+Wwq1U16GwnG8VEQGqcqiLbc=
X-Google-Smtp-Source: AFSGD/WzvQKc79ImRu1XX5C2cwE2umJQ+JvexswvZTpBQxY3W0YrbtEtF3dLar4MRku0gF6dcpeuaw==
X-Received: by 2002:a65:64c8:: with SMTP id t8mr2603360pgv.31.1544202011254;
        Fri, 07 Dec 2018 09:00:11 -0800 (PST)
Received: from localhost ([216.3.10.7])
        by smtp.gmail.com with ESMTPSA id l3sm9396202pga.92.2018.12.07.09.00.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Dec 2018 09:00:10 -0800 (PST)
Date:   Fri, 07 Dec 2018 09:00:10 -0800 (PST)
X-Google-Original-Date: Fri, 07 Dec 2018 08:59:36 PST (-0800)
Subject:     Re: [PATCH 4/4] RISC-V: Fix non-smp kernel boot on SMP systems
In-Reply-To: <1543870651-16669-5-git-send-email-atish.patra@wdc.com>
CC:     linux-kernel@vger.kernel.org, atish.patra@wdc.com,
        aou@eecs.berkeley.edu, daniel.lezcano@linaro.org,
        devicetree@vger.kernel.org, dmitriy@oss-tech.org,
        linux-riscv@lists.infradead.org, mark.rutland@arm.com,
        robh+dt@kernel.org, tglx@linutronix.de, anup@brainfault.org,
        Damien.LeMoal@wdc.com
From:   Palmer Dabbelt <palmer@sifive.com>
To:     atish.patra@wdc.com
Message-ID: <mhng-4a071ea7-ddf5-4204-8343-790f9bbb3a09@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 03 Dec 2018 12:57:31 PST (-0800), atish.patra@wdc.com wrote:
> Currently, clocksource registration happens for an invalid cpu
> for non-smp kernels. This lead to kernel panic as cpu hotplug
> registration will fail for those cpus.
>
> Do not proceed if hartid is invalid. Take this opprtunity to
> print appropriate error strings for different failure cases.
>
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> ---
>  drivers/clocksource/riscv_timer.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/clocksource/riscv_timer.c b/drivers/clocksource/riscv_timer.c
> index 39de6e49..4af4af47 100644
> --- a/drivers/clocksource/riscv_timer.c
> +++ b/drivers/clocksource/riscv_timer.c
> @@ -108,6 +108,8 @@ static int __init riscv_timer_init_dt(struct device_node *n)
>  	int cpuid, hartid, error;
>
>  	hartid = riscv_of_processor_hartid(n);
> +	if (hartid < 0)
> +		return hartid;

This seems like it's just hiding a bug somewhere else.  We should at least put 
out a WARN here, as I'm not sure the error will propagate anywhere useful.

>  	cpuid = riscv_hartid_to_cpuid(hartid);
>
>  	if (cpuid != smp_processor_id())
> @@ -115,14 +117,19 @@ static int __init riscv_timer_init_dt(struct device_node *n)
>
>  	/* This should be called only for boot cpu */
>  	riscv_timebase = riscv_timebase_frequency(n);
> -	clocksource_register_hz(&riscv_clocksource, riscv_timebase);
> +	error = clocksource_register_hz(&riscv_clocksource, riscv_timebase);
>
> +	if (error) {
> +		pr_err("RISCV timer register failed [%d] for cpu = [%d]\n",
> +		       error, cpuid);
> +		return error;
> +	}
>  	error = cpuhp_setup_state(CPUHP_AP_RISCV_TIMER_STARTING,
>  			 "clockevents/riscv/timer:starting",
>  			 riscv_timer_starting_cpu, riscv_timer_dying_cpu);
>  	if (error)
> -		pr_err("RISCV timer register failed [%d] for cpu = [%d]\n",
> -		       error, cpuid);
> +		pr_err("cpu hp setup state failed for RISCV timer [%d]\n",
> +		       error);
>  	return error;
>  }
