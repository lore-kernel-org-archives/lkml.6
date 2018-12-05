Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD0E7C04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 07:43:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0A8720850
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 07:43:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="l5l7Merw";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="hIxhtCy2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0A8720850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727230AbeLEHna (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 02:43:30 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:45818 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbeLEHn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 02:43:29 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 0ECF1601B4; Wed,  5 Dec 2018 07:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543995809;
        bh=12jFmU5tXf+SVFRvSVCk4b+WJPpbE6/LMwvc845YAaM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=l5l7MerwvLtJgM55fSy5V0rdRmIE1JDB4+mfdF4CHPYx2qtKz30CQ1TgjqDhMEXb8
         BI0mgOzmtOt9nrGueFM7kz8tZehF+rsXMuomghwd2pT1fbmhKw2CL7YPGxATgq6KIm
         0FHaPuSuMs/PAgS4B/8CA4w9HWkUXjW37VtDaIuU=
Received: from [10.204.79.22] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2C756601B4;
        Wed,  5 Dec 2018 07:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543995808;
        bh=12jFmU5tXf+SVFRvSVCk4b+WJPpbE6/LMwvc845YAaM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=hIxhtCy2JVUrok4W0+/tpNl4z9+gRLRewk7htvmQih+aPvhM2sp0phr+wgw2ZkxYC
         szv7svadzmqC7wrPnL4QnYhqEgsMFHzA+1MBa2ourk41WAJ8/nK4XVR4WgugdtB6fm
         QEyVN0GhfdvUn4lrJR+wRqRgsTXi3po0Ks5WCtwQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2C756601B4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] perf/core: declare the percpu variable properly
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
References: <1543310012-7967-1-git-send-email-mojha@codeaurora.org>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <d3fe7070-6529-902f-7e8c-96ef244893c7@codeaurora.org>
Date:   Wed, 5 Dec 2018 13:13:17 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1543310012-7967-1-git-send-email-mojha@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Can you please review the change ?

Thanks,
Mukesh


On 11/27/2018 2:43 PM, Mukesh Ojha wrote:
> Sparse reports the current declaration of percpu variable with
> below warning
>
> warning: incorrect type in initializer (different address spaces)
>           expected void const [noderef] <asn:3>*__vpp_verify
>           got struct perf_cpu_context *<noident>
>
> Fix it by declaring it properly.
>
> Signed-off-by: Mukesh Ojha <mojha@codeaurora.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
>
> ---
>   include/linux/perf_event.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index 53c500f..1d5c551 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -262,8 +262,8 @@ struct pmu {
>   	 */
>   	int				capabilities;
>   
> -	int * __percpu			pmu_disable_count;
> -	struct perf_cpu_context * __percpu pmu_cpu_context;
> +	int __percpu			*pmu_disable_count;
> +	struct perf_cpu_context __percpu *pmu_cpu_context;
>   	atomic_t			exclusive_cnt; /* < 0: cpu; > 0: tsk */
>   	int				task_ctx_nr;
>   	int				hrtimer_interval_ms;

