Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA5DDC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 17:59:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ED9D2080A
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 17:59:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="KyNB7+OG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438072AbfBNR7L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 12:59:11 -0500
Received: from a9-54.smtp-out.amazonses.com ([54.240.9.54]:35474 "EHLO
        a9-54.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727852AbfBNR7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 12:59:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1550167149;
        h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type:Feedback-ID;
        bh=eBf2c5u+rFMWbJXqlzWgo7tdnCY2i7jL5vluukLr+Gc=;
        b=KyNB7+OGNJVlLqLzr4dHHh/FQx/4gPm8T9umBwZSV2Z7vZjdTsKyy2ifGuwyEckt
        Vq9ylGERSB/aRgH/IM6X9sk0LOFC+8S3kcYDW98gbwslIfundqeAWdsUqrqEXD2Y7aD
        UvQf0PFQSvNcreG5K7CXPZ7pZVP1gRl2vBBCV+fM=
Date:   Thu, 14 Feb 2019 17:59:09 +0000
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To:     Atish Patra <atish.patra@wdc.com>
cc:     linux-riscv@lists.infradead.org, Albert Ou <aou@eecs.berkeley.edu>,
        Jason Cooper <jason@lakedaemon.net>,
        Alan Kao <alankao@andestech.com>,
        Dmitriy Cherkasov <dmitriy@oss-tech.org>,
        Anup Patel <anup@brainfault.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Johan Hovold <johan@kernel.org>, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Andreas Schwab <schwab@suse.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [v5 PATCH 5/8] RISC-V: Compare cpuid with NR_CPUS before
 mapping.
In-Reply-To: <1550089092-28783-6-git-send-email-atish.patra@wdc.com>
Message-ID: <01000168ed298ba3-fea3ca2b-436b-4ce6-a0df-cebe727bf55c-000000@email.amazonses.com>
References: <1550089092-28783-1-git-send-email-atish.patra@wdc.com> <1550089092-28783-6-git-send-email-atish.patra@wdc.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-SES-Outgoing: 2019.02.14-54.240.9.54
Feedback-ID: 1.us-east-1.fQZZZ0Xtj2+TD7V5apTT/NrT6QKuPgzCT/IC7XYgDKI=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Feb 2019, Atish Patra wrote:

> --- a/arch/riscv/kernel/smpboot.c
> +++ b/arch/riscv/kernel/smpboot.c
> @@ -66,6 +66,11 @@ void __init setup_smp(void)
>  			found_boot_cpu = 1;
>  			continue;
>  		}
> +		if (cpuid >= NR_CPUS) {

Use nr_cpu_ids instead? Its initialized to NR_CPUS but can be restricted
if we can determine on boot how many processor we truly have.
