Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4757C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 08:44:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFB39222B6
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 08:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550047493;
	bh=yl2a51TtKApn4BcfDPfEWEnE8qT94fDdhkPcd+ofXLk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bsHkJDO4iU3lBYJOiF8rZClVZH+3MfSjjnjKF1fsjTp4VkIiZzeXLsRm1Mf/ivpKU
	 fwckpDCxkOmjxc5VnPk2WQ/YyG4I7dUTW1j+7fqyBumk4oBcg2SxnbwIp+0I+0p+Ry
	 9cAqTk8uSRAHotdTpB00a2w163loyYJOo6dzl1DY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390635AbfBMIow (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 03:44:52 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33928 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731887AbfBMIow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 03:44:52 -0500
Received: by mail-lj1-f195.google.com with SMTP id v14-v6so1303187ljv.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 00:44:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Izvgryl2iiTiX+PEw/PVUMFMisAtBv+xAMEzVWOHECE=;
        b=O7X7oXV0SybTExzB0JDE9W9Li0qAoiPZxU6p54bRMFMq8pJGCLiOjXWvZ7OgmE7+4Q
         AnOX230SmXJ4gXKRdPuVnaDIijxgUaCVnZs25GB3PDuTVnt6Qx3EIWrAP53XnrYg+rkc
         NwVkGAy5EF5mYdaxBHcFIdXxiaFi2MHbty08CZj5eKbvKTqN8gQBjoeYhaHdYP81TccV
         vBks26EtJB+6z0LQOTT7oAcPb+dVXCq8PeRSepkmfIiKskBwFoLYsmGUDtjy3+mXDf33
         94rtSy8BXx3WSvxXyigiyCp4hqNZm7PSX6r5ufPh/Hr6gdAXAhqXZZvE9v5PbdzcjSOr
         v7yw==
X-Gm-Message-State: AHQUAuazQwgso7MHuAMIQDswHLrEriz1CVG2YA1Jm9WCA6rr9E73/EXM
        GLnn6t1Ii8HaDY4RRfF52toZjVCW
X-Google-Smtp-Source: AHgI3IZwB4eU9yM/xPqwCI8H6mFu49zMH3KaR9qsu+No+msoLEIPRgPLErKmcDBcq0CkQ2wgHHRswA==
X-Received: by 2002:a2e:4942:: with SMTP id b2-v6mr4487935ljd.168.1550047489794;
        Wed, 13 Feb 2019 00:44:49 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id t14sm347210lft.96.2019.02.13.00.44.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 00:44:48 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1gtq9q-0002gA-9M; Wed, 13 Feb 2019 09:44:42 +0100
Date:   Wed, 13 Feb 2019 09:44:42 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Atish Patra <atish.patra@wdc.com>
Cc:     Johan Hovold <johan@kernel.org>, Rob Herring <robh@kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jason Cooper <jason@lakedaemon.net>,
        Alan Kao <alankao@andestech.com>,
        Dmitriy Cherkasov <dmitriy@oss-tech.org>,
        Andreas Schwab <schwab@suse.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <anup@brainfault.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [v4 PATCH 8/8] RISC-V: Assign hwcap as per comman capabilities.
Message-ID: <20190213084442.GD28278@localhost>
References: <1549969812-22502-1-git-send-email-atish.patra@wdc.com>
 <1549969812-22502-9-git-send-email-atish.patra@wdc.com>
 <20190212112534.GB28278@localhost>
 <61766631-42f4-ec25-3b5c-ae892da44ccb@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61766631-42f4-ec25-3b5c-ae892da44ccb@wdc.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 11:58:10AM -0800, Atish Patra wrote:
> On 2/12/19 3:25 AM, Johan Hovold wrote:
> > On Tue, Feb 12, 2019 at 03:10:12AM -0800, Atish Patra wrote:
> >> Currently, we set hwcap based on first valid hart from DT. This may not
> >> be correct always as that hart might not be current booting cpu or may
> >> have a different capability.
> >>
> >> Set hwcap as the capabilities supported by all possible harts with "okay"
> >> status.
> >>
> >> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> >> ---
> >>   arch/riscv/kernel/cpufeature.c | 41 ++++++++++++++++++++++-------------------
> >>   1 file changed, 22 insertions(+), 19 deletions(-)
> >>
> >> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> >> index e7a4701f..a1e4fb34 100644
> >> --- a/arch/riscv/kernel/cpufeature.c
> >> +++ b/arch/riscv/kernel/cpufeature.c
> >> @@ -20,6 +20,7 @@
> >>   #include <linux/of.h>
> >>   #include <asm/processor.h>
> >>   #include <asm/hwcap.h>
> >> +#include <asm/smp.h>
> >>   
> >>   unsigned long elf_hwcap __read_mostly;
> >>   #ifdef CONFIG_FPU
> >> @@ -42,28 +43,30 @@ void riscv_fill_hwcap(void)
> >>   
> >>   	elf_hwcap = 0;
> >>   
> >> -	/*
> >> -	 * We don't support running Linux on hertergenous ISA systems.  For
> >> -	 * now, we just check the ISA of the first "okay" processor.
> >> -	 */
> >>   	for_each_of_cpu_node(node) {
> >> -		if (riscv_of_processor_hartid(node) >= 0)
> >> -			break;
> >> -	}
> >> -	if (!node) {
> >> -		pr_warn("Unable to find \"cpu\" devicetree entry\n");
> >> -		return;
> >> -	}
> >> +		unsigned long this_hwcap = 0;
> >>   
> >> -	if (of_property_read_string(node, "riscv,isa", &isa)) {
> >> -		pr_warn("Unable to find \"riscv,isa\" devicetree entry\n");
> >> -		of_node_put(node);
> >> -		return;
> >> -	}
> >> -	of_node_put(node);
> >> +		if (riscv_of_processor_hartid(node) < 0)
> >> +			continue;
> >>
> 
> >> -	for (i = 0; i < strlen(isa); ++i)
> >> -		elf_hwcap |= isa2hwcap[(unsigned char)(isa[i])];
> >> +		if (of_property_read_string(node, "riscv,isa", &isa)) {
> >> +			pr_warn("Unable to find \"riscv,isa\" devicetree entry\n");
> >> +			return;
> > 
> > Did you want "continue" here to continue processing the other harts?
> 
> Hmm. If a cpu node doesn't have isa in DT, that means DT is wrong. A 
> "continue" here will let user space use other harts just with a warning 
> message?
> 
> Returning here will not set elf_hwcap which forces the user to fix the 
> DT. I am not sure what should be the defined behavior in this case.
>
> Any thoughts ?

The problem is that the proposed code might still set elf_hwcap -- it
all depends on the order of the hart nodes in dt (i.e. it will only be
left unset if the first node is malformed).

For that reason, I'd say it's better to either bail out (hard or at
least with elf_hwcap unset) or to continue processing the other nodes.

The former might break current systems with malformed dt, though.

And since the harts are expected to have the same ISA, continuing the
processing while warning and ignoring the malformed node might be
acceptable.

Johan
