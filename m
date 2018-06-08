Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id WNn5GIK9Glu8bAAAmS7hNA
	; Fri, 08 Jun 2018 17:32:21 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 6A9D2607DC; Fri,  8 Jun 2018 17:32:21 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id F0124605A2;
	Fri,  8 Jun 2018 17:32:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F0124605A2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752734AbeFHRcS (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 13:32:18 -0400
Received: from foss.arm.com ([217.140.101.70]:36120 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751241AbeFHRcP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 13:32:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5BF6B1529;
        Fri,  8 Jun 2018 10:32:15 -0700 (PDT)
Received: from armageddon.cambridge.arm.com (armageddon.cambridge.arm.com [10.1.206.84])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1E91A3F557;
        Fri,  8 Jun 2018 10:32:09 -0700 (PDT)
Date: Fri, 8 Jun 2018 18:32:07 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Yury Norov <ynorov@caviumnetworks.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org, Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
        Joseph Myers <joseph@codesourcery.com>,
        Steve Ellcey <sellcey@caviumnetworks.com>,
        Prasun Kapoor <Prasun.Kapoor@caviumnetworks.com>,
        Andreas Schwab <schwab@suse.de>,
        Alexander Graf <agraf@suse.de>,
        Bamvor Zhangjian <bamv2005@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Adam Borowski <kilobyte@angband.pl>,
        Manuel Montezelo <manuel.montezelo@gmail.com>,
        James Hogan <james.hogan@imgtec.com>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Andrew Pinski <pinskia@gmail.com>,
        Lin Yongting <linyongting@huawei.com>,
        Alexey Klimov <klimov.linux@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
        Florian Weimer <fweimer@redhat.com>,
        Nathan_Lynch <Nathan_Lynch@mentor.com>,
        James Morse <james.morse@arm.com>,
        Ramana Radhakrishnan <ramana.gcc@googlemail.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Christoph Muellner <christoph.muellner@theobroma-systems.com>
Subject: Re: [PATCH 04/24] 32-bit userspace ABI: introduce ARCH_32BIT_OFF_T
 config option
Message-ID: <20180608173207.nwoi25jee52gpdwy@armageddon.cambridge.arm.com>
References: <20180516081910.10067-1-ynorov@caviumnetworks.com>
 <20180516081910.10067-5-ynorov@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180516081910.10067-5-ynorov@caviumnetworks.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 16, 2018 at 11:18:49AM +0300, Yury Norov wrote:
> diff --git a/arch/Kconfig b/arch/Kconfig
> index 76c0b54443b1..ee079244dc3c 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -264,6 +264,21 @@ config ARCH_THREAD_STACK_ALLOCATOR
>  config ARCH_WANTS_DYNAMIC_TASK_STRUCT
>  	bool
>  
> +config ARCH_32BIT_OFF_T
> +	bool
> +	depends on !64BIT
> +	help
> +	  All new 32-bit architectures should have 64-bit off_t type on
> +	  userspace side which corresponds to the loff_t kernel type. This
> +	  is the requirement for modern ABIs. Some existing architectures
> +	  already have 32-bit off_t. This option is enabled for all such
> +	  architectures explicitly. Namely: arc, arm, blackfin, cris, frv,
> +	  h8300, hexagon, m32r, m68k, metag, microblaze, mips32, mn10300,
> +	  nios2, openrisc, parisc32, powerpc32, score, sh, sparc, tile32,
> +	  unicore32, x86_32 and xtensa. This is the complete list. Any
> +	  new 32-bit architecture should declare 64-bit off_t type on user
> +	  side and so should not enable this option.

Do you know if this is the case for riscv and nds32, merged in the
meantime? If not, I suggest you drop this patch altogether and just
define force_o_largefile() for arm64/ilp32 as we don't seem to stick to
"all new 32-bit architectures should have 64-bit off_t".

-- 
Catalin
