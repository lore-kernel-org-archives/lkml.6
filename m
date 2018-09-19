Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08612ECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 18:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6F4B21521
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 18:26:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zgZ8YEtL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6F4B21521
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733114AbeITAFp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 20:05:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:50408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731233AbeITAFp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 20:05:45 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9683520877;
        Wed, 19 Sep 2018 18:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537381596;
        bh=9tOX1NoSUGVx1Wn9DJGkhzfThR1gzCFiwCbUQO5BDg0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zgZ8YEtLnVgTJBVifXCigja8ArhhnSlGwM5qSxQFS4uMobl7CeEjz1NYhCw2S7bYB
         WwuP8FVdHKdXxgQ2MmWkqY/0rXAhME622AzOqpJsfx4nRnYDOskkQkjMi5H69dPlxc
         zoHE1Cd/huMCyUkSj7ZCFfC7x0W3/dAv5vdrbeOA=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id B6520140260; Wed, 19 Sep 2018 15:26:34 -0300 (-03)
Date:   Wed, 19 Sep 2018 15:26:34 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andi Kleen <andi@firstfloor.org>
Cc:     jolsa@kernel.org, adrian.hunter@intel.com,
        linux-kernel@vger.kernel.org, kim.phillips@arm.com,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v5 5/9] perf, tools, script: Print DSO for callindent
Message-ID: <20180919182634.GG31812@kernel.org>
References: <20180918123214.26728-1-andi@firstfloor.org>
 <20180918123214.26728-6-andi@firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180918123214.26728-6-andi@firstfloor.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Sep 18, 2018 at 05:32:10AM -0700, Andi Kleen escreveu:
> From: Andi Kleen <ak@linux.intel.com>
> 
> Now that we don't need to print the IP/ADDR for callindent the DSO
> is also not printed. It's useful for some cases, so add an own DSO
> printout for callindent for the case when IP/ADDR is not enabled.
> 
> Before:
> 
> % perf script --itrace=cr -F +callindent,-ip,-sym,-symoff,-addr
>          swapper     0 [000]  3377.917072:          1   branches: pt_config
>          swapper     0 [000]  3377.917072:          1   branches:     pt_config
>          swapper     0 [000]  3377.917072:          1   branches:     pt_event_add
>          swapper     0 [000]  3377.917072:          1   branches:     perf_pmu_enable
>          swapper     0 [000]  3377.917072:          1   branches:     perf_pmu_nop_void
>          swapper     0 [000]  3377.917072:          1   branches:     event_sched_in.isra.107
>          swapper     0 [000]  3377.917072:          1   branches:     __x86_indirect_thunk_rax
>          swapper     0 [000]  3377.917072:          1   branches:     perf_pmu_nop_int
>          swapper     0 [000]  3377.917072:          1   branches:     group_sched_in
>          swapper     0 [000]  3377.917072:          1   branches:     event_filter_match
>          swapper     0 [000]  3377.917072:          1   branches:     event_filter_match
>          swapper     0 [000]  3377.917072:          1   branches:     group_sched_in
> 
> After:
> 
>          swapper     0 [000]  3377.917072:          1   branches: ([unknown])   pt_config
>          swapper     0 [000]  3377.917072:          1   branches: ([kernel.kallsyms])       pt_config

Tested, applied.

- Arnaldo
