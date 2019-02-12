Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE5F9C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 11:25:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B760206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 11:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549970747;
	bh=3zK/aH2Ouvu5RqURS6zwbc9TJJqCn5rgPlVfhD0NwfQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=W2bViYTlUjU/w+JNWReu4cMeNDxtBPATj5fjCUbrBWcGeSbSSHSjcE53U9zEM4Mt2
	 aim/xpeBIMfobfnJ2I71Pi0gtaqVIbO+C7yV84q5c2cRU4Kgj2a/cofTbLsRkWukbE
	 1FLUVWh/AGQlAkbnK0gnLaHF5ctbLEdOABmK/B8g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729116AbfBLLZp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 06:25:45 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:45414 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727312AbfBLLZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 06:25:45 -0500
Received: by mail-lf1-f67.google.com with SMTP id b20so1675279lfa.12
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 03:25:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lhvGX1o+vxxf5Lqqc1aR1wxCxsaRLfHTlWErhsSrynQ=;
        b=ql8q21EJHu+HyapG10aBJnJLgoVTVTLZWFaz9EuESFxkh01rw6pJ1CXZ7VRwTnhfVw
         qcNGaNT7xwuGe7KbF/CJS0FeaHgirvEe/EMYqT4DI6/6SC870h8sx4hKFoxzdY0cS1+k
         LSJ0XbDzLVUu0vLK2b3/cDqqbFSxzVX5YHfP4GchbCQeaQwqWlHzyUcw9p8dEVi/kgTv
         Qa79d6KEZWFgJ9rTacu0kiHNh1DEA8Z+UYdstguZJAxgshwSGvq7E+6vY3bScbwOaJYE
         QxGfiB2P9231kYqLs5kGhgfZXe4CnITnVMxenAnYgfOxTSvli6k6Fj3PmoQksgsu89JY
         h+qg==
X-Gm-Message-State: AHQUAua9VgItFfIIMwtZ1EDT66oprhWdEMUmG71KRh5Q1YcPxuIcFXqg
        b8W5K76N6d6IF0vo1mqM8Vdt0loI
X-Google-Smtp-Source: AHgI3IbMK0/0I5K2Yvctlr3ogxzo33+W9x4iykN3NsGLcKHGGGhESJPMsIZKnBXYkb7Tg0eS9h0rig==
X-Received: by 2002:a19:4f15:: with SMTP id d21mr2099389lfb.86.1549970741912;
        Tue, 12 Feb 2019 03:25:41 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id v29-v6sm2618417ljd.44.2019.02.12.03.25.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 03:25:41 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1gtWBy-00053z-HI; Tue, 12 Feb 2019 12:25:34 +0100
Date:   Tue, 12 Feb 2019 12:25:34 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Atish Patra <atish.patra@wdc.com>
Cc:     linux-riscv@lists.infradead.org, Alan Kao <alankao@andestech.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andreas Schwab <schwab@suse.de>,
        Anup Patel <anup@brainfault.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Dmitriy Cherkasov <dmitriy@oss-tech.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Johan Hovold <johan@kernel.org>, linux-kernel@vger.kernel.org,
        Marc Zyngier <marc.zyngier@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [v4 PATCH 8/8] RISC-V: Assign hwcap as per comman capabilities.
Message-ID: <20190212112534.GB28278@localhost>
References: <1549969812-22502-1-git-send-email-atish.patra@wdc.com>
 <1549969812-22502-9-git-send-email-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1549969812-22502-9-git-send-email-atish.patra@wdc.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 03:10:12AM -0800, Atish Patra wrote:
> Currently, we set hwcap based on first valid hart from DT. This may not
> be correct always as that hart might not be current booting cpu or may
> have a different capability.
> 
> Set hwcap as the capabilities supported by all possible harts with "okay"
> status.
> 
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> ---
>  arch/riscv/kernel/cpufeature.c | 41 ++++++++++++++++++++++-------------------
>  1 file changed, 22 insertions(+), 19 deletions(-)
> 
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> index e7a4701f..a1e4fb34 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -20,6 +20,7 @@
>  #include <linux/of.h>
>  #include <asm/processor.h>
>  #include <asm/hwcap.h>
> +#include <asm/smp.h>
>  
>  unsigned long elf_hwcap __read_mostly;
>  #ifdef CONFIG_FPU
> @@ -42,28 +43,30 @@ void riscv_fill_hwcap(void)
>  
>  	elf_hwcap = 0;
>  
> -	/*
> -	 * We don't support running Linux on hertergenous ISA systems.  For
> -	 * now, we just check the ISA of the first "okay" processor.
> -	 */
>  	for_each_of_cpu_node(node) {
> -		if (riscv_of_processor_hartid(node) >= 0)
> -			break;
> -	}
> -	if (!node) {
> -		pr_warn("Unable to find \"cpu\" devicetree entry\n");
> -		return;
> -	}
> +		unsigned long this_hwcap = 0;
>  
> -	if (of_property_read_string(node, "riscv,isa", &isa)) {
> -		pr_warn("Unable to find \"riscv,isa\" devicetree entry\n");
> -		of_node_put(node);
> -		return;
> -	}
> -	of_node_put(node);
> +		if (riscv_of_processor_hartid(node) < 0)
> +			continue;
>  
> -	for (i = 0; i < strlen(isa); ++i)
> -		elf_hwcap |= isa2hwcap[(unsigned char)(isa[i])];
> +		if (of_property_read_string(node, "riscv,isa", &isa)) {
> +			pr_warn("Unable to find \"riscv,isa\" devicetree entry\n");
> +			return;

Did you want "continue" here to continue processing the other harts?

Note that you currently leak the device node when returning.

Johan
