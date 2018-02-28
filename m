Return-Path: <palmer@sifive.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519857255; cv=none;
        d=google.com; s=arc-20160816;
        b=RZAPa1VcEfYduXIfeBAHxJp2gMZ7DKqWLi39T0ezK+aXHgP7hFjd9R7qirTUGmOtPr
         30Xxz7Fhr8Op5wRhPWiaIrI4njH9SETt4Ze6degOz/Cfhj3s3mWGYdqpQ/VAQWQqrzQI
         xl3lyWdLsExZYmYGNhH5KdpC0f7YrSLqAC3WL0qtpnOzTuDh+TTfnjiazlOTMkZmzBFf
         ILO9ucxJr02FOiyIIe6Mtw48Shr9SivjGKg4X9A/zyt0XPh/Iy0dCjwFAbH33MyEOvAJ
         2LNLGyk2LYQV8X4rjmc+noodL+Rh4cFxPVR1Mzn30+6Fxe2PLuKxP20KpVejry6UmdL4
         wk6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:dkim-signature:arc-authentication-results;
        bh=t9PdOXwyqL/0093DG3Z/I02XxbD8MAWewqdxmCxCI2o=;
        b=R/bqL/1/LdwBajE2MxjahhfatC5VT/Sl073EVYi9pnm6ljRiD7DBTs82Kevq6AmK6N
         hlx4H8VFDvrmeX0e9I+COHCS0th1MNjATvMkhU5YNh7mOUhWSKGjtmjp4B5nzywlTLIb
         /pPUy1c2DzZIZVzKoflO4/n7r7kMpN1s7Lqkn0yChZG/pgpMGXqnCNyUNDQll9SN+Hts
         j6141TxiDm8hXOMq2NLut6GenaJ3mLUj/b+S7xwxtdhXeRqZK4BRYfqG8IA48djuy/j1
         ukl6gdjOUdqGELAdl7eqT0LoBmVX3Fojz6UPv9lSfXR4OJFSrL41lWk+OMVJukMcTtt+
         JoQQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@sifive.com header.s=google header.b=dsD+9Rq8;
       spf=pass (google.com: domain of palmer@sifive.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=palmer@sifive.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@sifive.com header.s=google header.b=dsD+9Rq8;
       spf=pass (google.com: domain of palmer@sifive.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=palmer@sifive.com
X-Google-Smtp-Source: AH8x225QW1ZjAc36xX4xLK+fzG6J6+FWh46NHZssAO5pt2a6gFH6O3quTWwhXiUE1bRZLm5Zt4VRPQ==
Date: Wed, 28 Feb 2018 14:34:14 -0800 (PST)
X-Google-Original-Date: Wed, 28 Feb 2018 14:32:22 PST (-0800)
Subject: Re: [PATCH v7 02/13] drivers: base: cacheinfo: setup DT cache properties early
In-Reply-To: <20180228220619.6992-3-jeremy.linton@arm.com>
CC: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
  sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, hanjun.guo@linaro.org, rjw@rjwysocki.net,
  Will Deacon <will.deacon@arm.com>, catalin.marinas@arm.com, Greg KH <gregkh@linuxfoundation.org>,
  mark.rutland@arm.com, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
  wangxiongfeng2@huawei.com, vkilari@codeaurora.org, ahs3@redhat.com, dietmar.eggemann@arm.com,
  morten.rasmussen@arm.com, lenb@kernel.org, john.garry@huawei.com, austinwc@codeaurora.org,
  tnowicki@caviumnetworks.com, jeremy.linton@arm.com
From: Palmer Dabbelt <palmer@sifive.com>
To: jeremy.linton@arm.com
Message-ID: <mhng-a110cedb-912a-4701-b1b4-8546d12e861a@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593684143739692917?=
X-GMAIL-MSGID: =?utf-8?q?1593685841518355225?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 28 Feb 2018 14:06:08 PST (-0800), jeremy.linton@arm.com wrote:
> The original intent in cacheinfo was that an architecture
> specific populate_cache_leaves() would probe the hardware
> and then cache_shared_cpu_map_setup() and
> cache_override_properties() would provide firmware help to
> extend/expand upon what was probed. Arm64 was really
> the only architecture that was working this way, and
> with the removal of most of the hardware probing logic it
> became clear that it was possible to simplify the logic a bit.
>
> This patch combines the walk of the DT nodes with the
> code updating the cache size/line_size and nr_sets.
> cache_override_properties() (which was DT specific) is
> then removed. The result is that cacheinfo.of_node is
> no longer used as a temporary place to hold DT references
> for future calls that update cache properties. That change
> helps to clarify its one remaining use (matching
> cacheinfo nodes that represent shared caches) which
> will be used by the ACPI/PPTT code in the following patches.
>
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> ---
>  arch/riscv/kernel/cacheinfo.c |  1 -
>  drivers/base/cacheinfo.c      | 65 +++++++++++++++++++------------------------
>  2 files changed, 29 insertions(+), 37 deletions(-)
>
> diff --git a/arch/riscv/kernel/cacheinfo.c b/arch/riscv/kernel/cacheinfo.c
> index 10ed2749e246..0bc86e5f8f3f 100644
> --- a/arch/riscv/kernel/cacheinfo.c
> +++ b/arch/riscv/kernel/cacheinfo.c
> @@ -20,7 +20,6 @@ static void ci_leaf_init(struct cacheinfo *this_leaf,
>  			 struct device_node *node,
>  			 enum cache_type type, unsigned int level)
>  {
> -	this_leaf->of_node = node;
>  	this_leaf->level = level;
>  	this_leaf->type = type;
>  	/* not a sector cache */
> diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
> index 09ccef7ddc99..a872523e8951 100644
> --- a/drivers/base/cacheinfo.c
> +++ b/drivers/base/cacheinfo.c
> @@ -71,7 +71,7 @@ static inline int get_cacheinfo_idx(enum cache_type type)
>  	return type;
>  }

This looks good as far as RISC-V is concerned, though that's such a trivial 
part of the changeset it's not worth that much :).  Thanks!
