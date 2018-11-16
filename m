Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B23DC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 16:12:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D31252086C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 16:12:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="aIx6K7vD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D31252086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390081AbeKQCZe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 21:25:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:39180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728175AbeKQCZe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 21:25:34 -0500
Received: from localhost (unknown [64.114.255.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F34320825;
        Fri, 16 Nov 2018 16:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542384755;
        bh=LRegiqYLctp1ISE6hxFczIO9Zcy3+1/7fqBJSq8Mq9w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aIx6K7vD1T+90FD8NmRNI0Zcml6qO3yapLecMiZhQ4CVYNAu28JccSAvLBrJJDJP+
         bKgTHNc7vOOwHDnYYmigB91YXbMfSHjgiakLw8SqokQTupRI0Abzo0PXrhaJ2KT36S
         ngrVIPrVu2SyxAe1gGq09DcRFedFfSzcEhVvxL94=
Date:   Fri, 16 Nov 2018 11:12:35 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     kan.liang@linux.intel.com
Cc:     tglx@linutronix.de, peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, ak@linux.intel.com,
        yao.jin@linux.intel.com, stable@vger.kernel.org
Subject: Re: [PATCH] perf/x86/intel/uncore: Fix client IMC events return huge
 result
Message-ID: <20181116161235.GF1706@sasha-vm>
References: <20181116131945.5480-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20181116131945.5480-1-kan.liang@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 16, 2018 at 05:19:45AM -0800, kan.liang@linux.intel.com wrote:
>From: Kan Liang <kan.liang@linux.intel.com>
>
>The client IMC bandwidth events return very huge result.
>  perf stat -e uncore_imc/data_reads/ -e uncore_imc/data_writes/ -I
>10000 -a
>  10.000117222 34,788.76 MiB uncore_imc/data_reads/
>  10.000117222 8.26 MiB uncore_imc/data_writes/
>  20.000374584 34,842.89 MiB uncore_imc/data_reads/
>  20.000374584 10.45 MiB uncore_imc/data_writes/
>  30.000633299 37,965.29 MiB uncore_imc/data_reads/
>  30.000633299 323.62 MiB uncore_imc/data_writes/
>  40.000891548 41,012.88 MiB uncore_imc/data_reads/
>  40.000891548 6.98 MiB uncore_imc/data_writes/
>  50.001142480 1,125,899,906,621,494.75 MiB uncore_imc/data_reads/
>  50.001142480 6.97 MiB uncore_imc/data_writes/
>
>The client IMC events are freerunning counters. They still use the
>old event encoding format (0x1 for data_read and 0x2 for data write).
>The counter bit width is calculated by common code, which assume that
>the standard encoding format is used for the freerunning counters.
>Error bit width information is calculated.
>
>The event->attr.config, which directly from user space, should not be
>used by the functions of freerunning counters.
>For client IMC events, the attr.config needs to be converted to the
>standard encoding format. The modified event config will be stored in
>event->hw.config.
>For other freerunning counters, the attr.config has the correct format.
>Just save it in event->hw.config.
>Using event->hw.config to replace event->attr.config for the functions
>of freerunning counters.
>
>Fix: commit 9aae1780e7e8 ("perf/x86/intel/uncore: Clean up client IMC
>uncore")

Please use a "fixes" (vs "fix") tag here, a few folks have automation
around this. It should look something like this:

	Fixes: commit 9aae1780e7e8 ("perf/x86/intel/uncore: Clean up client IMC uncore")

Also, if you intend for this to go in stable trees, please add a stable
tag rather than just cc it to the stable mailing list. Something like
this:

	Cc: stable@kernel.org

--
Thanks,
Sasha
