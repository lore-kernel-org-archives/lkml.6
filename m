Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A799C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 14:28:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E213D208A5
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 14:28:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="AN9SsSom"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E213D208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732370AbeGaQJP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 12:09:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:40260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732247AbeGaQJP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 12:09:15 -0400
Received: from jouet.infradead.org (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F86920841;
        Tue, 31 Jul 2018 14:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533047319;
        bh=5MkboiCKMzr08mwicjMR0chtSWeMts/OBa4kUxDgg4Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AN9SsSomDHp8kkXReteVrD8cW3zH2nKxRw19eXFXDb5qz1JknuBljXRNWXvT/6Z1a
         QpYgxEKuli45WywGfdIi0IOAdLrnUpZc2YJBVdFe1rjYKk6nzIOi0pK7HT7Qj4ViCH
         isezHTo//YEVGQBvTHSTazP1myLw/B1JRqduEvp8=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id ACE9E1403B8; Tue, 31 Jul 2018 11:28:35 -0300 (-03)
Date:   Tue, 31 Jul 2018 11:28:35 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, peterz@infradead.org, mingo@redhat.com,
        Will.Deacon@arm.com, mark.rutland@arm.com,
        jnair@caviumnetworks.com, Robert.Richter@cavium.com,
        Vadim.Lomovtsev@cavium.com, Jan.Glauber@cavium.com,
        gklkml16@gmail.com
Subject: Re: [PATCH] perf vendor events arm64: Update ThunderX2
 implementation defined pmu core events
Message-ID: <20180731142835.GC4909@kernel.org>
References: <20180731100251.23575-1-ganapatrao.kulkarni@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180731100251.23575-1-ganapatrao.kulkarni@cavium.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jul 31, 2018 at 03:32:51PM +0530, Ganapatrao Kulkarni escreveu:
> Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>

Can you please consider to provide an example of such counters being
used, i.e. with a simple C synthetic test that causes these events to
take place, then run it via 'perf stat' to show that indeed, they are
being programmed and read correctly?

Ideally for all of them, but if that becomes too burdensome, for a few
of them?

Thanks,

- Arnaldo

> ---
>  .../arch/arm64/cavium/thunderx2/core-imp-def.json  | 87 +++++++++++++++++++++-
>  1 file changed, 84 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/pmu-events/arch/arm64/cavium/thunderx2/core-imp-def.json b/tools/perf/pmu-events/arch/arm64/cavium/thunderx2/core-imp-def.json
> index bc03c06..752e47e 100644
> --- a/tools/perf/pmu-events/arch/arm64/cavium/thunderx2/core-imp-def.json
> +++ b/tools/perf/pmu-events/arch/arm64/cavium/thunderx2/core-imp-def.json
> @@ -12,6 +12,21 @@
>          "ArchStdEvent": "L1D_CACHE_REFILL_WR",
>      },
>      {
> +        "ArchStdEvent": "L1D_CACHE_REFILL_INNER",
> +    },
> +    {
> +        "ArchStdEvent": "L1D_CACHE_REFILL_OUTER",
> +    },
> +    {
> +        "ArchStdEvent": "L1D_CACHE_WB_VICTIM",
> +    },
> +    {
> +        "ArchStdEvent": "L1D_CACHE_WB_CLEAN",
> +    },
> +    {
> +        "ArchStdEvent": "L1D_CACHE_INVAL",
> +    },
> +    {
>          "ArchStdEvent": "L1D_TLB_REFILL_RD",
>      },
>      {
> @@ -24,9 +39,75 @@
>          "ArchStdEvent": "L1D_TLB_WR",
>      },
>      {
> +        "ArchStdEvent": "L2D_TLB_REFILL_RD",
> +    },
> +    {
> +        "ArchStdEvent": "L2D_TLB_REFILL_WR",
> +    },
> +    {
> +        "ArchStdEvent": "L2D_TLB_RD",
> +    },
> +    {
> +        "ArchStdEvent": "L2D_TLB_WR",
> +    },
> +    {
>          "ArchStdEvent": "BUS_ACCESS_RD",
> -   },
> -   {
> +    },
> +    {
>          "ArchStdEvent": "BUS_ACCESS_WR",
> -   }
> +    },
> +    {
> +        "ArchStdEvent": "MEM_ACCESS_RD",
> +    },
> +    {
> +        "ArchStdEvent": "MEM_ACCESS_WR",
> +    },
> +    {
> +        "ArchStdEvent": "UNALIGNED_LD_SPEC",
> +    },
> +    {
> +        "ArchStdEvent": "UNALIGNED_ST_SPEC",
> +    },
> +    {
> +        "ArchStdEvent": "UNALIGNED_LDST_SPEC",
> +    },
> +    {
> +        "ArchStdEvent": "EXC_UNDEF",
> +    },
> +    {
> +        "ArchStdEvent": "EXC_SVC",
> +    },
> +    {
> +        "ArchStdEvent": "EXC_PABORT",
> +    },
> +    {
> +        "ArchStdEvent": "EXC_DABORT",
> +    },
> +    {
> +        "ArchStdEvent": "EXC_IRQ",
> +    },
> +    {
> +        "ArchStdEvent": "EXC_FIQ",
> +    },
> +    {
> +        "ArchStdEvent": "EXC_SMC",
> +    },
> +    {
> +        "ArchStdEvent": "EXC_HVC",
> +    },
> +    {
> +        "ArchStdEvent": "EXC_TRAP_PABORT",
> +    },
> +    {
> +        "ArchStdEvent": "EXC_TRAP_DABORT",
> +    },
> +    {
> +        "ArchStdEvent": "EXC_TRAP_OTHER",
> +    },
> +    {
> +        "ArchStdEvent": "EXC_TRAP_IRQ",
> +    },
> +    {
> +        "ArchStdEvent": "EXC_TRAP_FIQ",
> +    }
>  ]
> -- 
> 2.9.4
