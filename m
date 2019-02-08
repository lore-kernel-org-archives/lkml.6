Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F352C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 09:03:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D6E921916
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 09:03:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="n61rcYIj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727511AbfBHJDW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 04:03:22 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:43040 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbfBHJDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 04:03:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=wToFgV8guI5ZF7XVDDs0MZ4aPSSX07QE02y/C1iPIzo=; b=n61rcYIjArVYEghZwev5RuOCP
        hxh4eix15lYmn2cnuqyqcWBP/KCy5u15/wxyqaDQfmkuM5Aj0rJtyBflwWw303AVdJW7Cxu0gRP5c
        VAUlwON1A4ULMxplqYfG9gX5sLYHyxEryJlq1f1ZKs8OiSK27b1pTuyX0kL6oucHvWAuPpq8lJAM2
        jb8NqwgwoHol7Eoh/suZNEFkhWepyi9H4phxf/54lrOPHDy36+TAhoEOsHpE6XgSEkLCAq9KEpi/k
        nezxafFULFRaE1zAvCyO6a54d+labvuUIT6mySU+tNSsd7AB3gnxQivs/v31FOvKnQa/JDXA30a7Y
        fT3ZJe1nw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gs244-0004dZ-Js; Fri, 08 Feb 2019 09:03:16 +0000
Date:   Fri, 8 Feb 2019 01:03:16 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Atish Patra <atish.patra@wdc.com>
Cc:     linux-riscv@lists.infradead.org,
        Patrick =?iso-8859-1?Q?St=E4hlin?= <me@packi.ch>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Alan Kao <alankao@andestech.com>,
        Dmitriy Cherkasov <dmitriy@oss-tech.org>,
        Anup Patel <anup@brainfault.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-kernel@vger.kernel.org, Zong Li <zongbox@gmail.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Andreas Schwab <schwab@suse.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [v3 PATCH 2/8] RISC-V: Move cpuid to hartid mapping to SMP.
Message-ID: <20190208090316.GB16932@infradead.org>
References: <1549590681-24125-1-git-send-email-atish.patra@wdc.com>
 <1549590681-24125-3-git-send-email-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1549590681-24125-3-git-send-email-atish.patra@wdc.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 07, 2019 at 05:51:15PM -0800, Atish Patra wrote:
> Currently, logical CPU id to physical hartid mapping is
> defined for both smp and non-smp configurations. This
> is not required as we need this only for smp configuration.
> The mapping function can define directly boot_cpu_hartid
> for non-smp use case.

Please use up your available 72 chars for the changelog.  (probably also
in other patches).

> 
> The reverse mapping function i.e. hartid to cpuid can be called
> for any valid but not booted harts. So it should return default
> cpu 0 only if it is a boot hartid.
> 
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> Reviewed-by: Anup Patel <anup@brainfault.org>
> ---
>  arch/riscv/include/asm/smp.h | 14 +++++++++++---
>  arch/riscv/kernel/setup.c    |  9 ---------
>  arch/riscv/kernel/smp.c      |  9 +++++++++
>  3 files changed, 20 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/smp.h b/arch/riscv/include/asm/smp.h
> index 41aa73b4..21fd2d75 100644
> --- a/arch/riscv/include/asm/smp.h
> +++ b/arch/riscv/include/asm/smp.h
> @@ -22,12 +22,13 @@
>  /*
>   * Mapping between linux logical cpu index and hartid.
>   */
> -extern unsigned long __cpuid_to_hartid_map[NR_CPUS];
> -#define cpuid_to_hartid_map(cpu)    __cpuid_to_hartid_map[cpu]
>  
> +extern unsigned long boot_cpu_hartid;
>  struct seq_file;

We usually try to keep forward declatations at the top of the file.

Can you add the new external declaration below the forward one?

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
