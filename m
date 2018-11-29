Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 632D3C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 13:27:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 274C5208E7
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 13:27:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AZSSefML"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 274C5208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728405AbeK3AdM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 19:33:12 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52682 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726724AbeK3AdM (ORCPT
        <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 19:33:12 -0500
Received: by mail-wm1-f66.google.com with SMTP id r11-v6so2260198wmb.2
        for <Linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 05:27:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RpdHJx1UqEjBn1mikgx3ONm9T30o731TZEN+cf6x54k=;
        b=AZSSefML3SpBe8pbFS7+b51Eel3sAanLBxGJlE5GQvcE7TejB380uAXtAqFp+aDyYf
         n1f9vsdkC7Dxs2JgaIm+y6lWvIOwaYta2+eyUlRJJMxKXn7YWFlDDcUzGNkEONMBAiQI
         nO1107vBJuOhcoDrpbteEsBIEcy53lWTxLzZf9mA9FN0jiQzr4LcFQ27xh3z14OgNmuE
         WgrXyGsyqOfJMmftn8j1yYrfypoURaP7eeB+rKbLi66YWCTt0hio6YJh/CcojFT9Kk87
         Tl8ALFUpgy6uiiT/ijymimWlT8y3hGwLMt/rlgv2SJ4uyNo4psG334C4ercbC8JBe/z4
         jRWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=RpdHJx1UqEjBn1mikgx3ONm9T30o731TZEN+cf6x54k=;
        b=AcSX29o+c4gycMh+F6sUW5veIDrk5ERPPut/OuW9jrhNkjU2wmrjhghQu9EnbgKZb5
         9MVX1JYwQvdGFx6A6xHA+SiuJ/a19j82r/2um6occHvQocUvj/AFxR4ShZCRcYlJvnrX
         TIUNxpCMKcY/kvMMwrQ7IqXFcR+/GB+/pGGvmQl8dITMXzhL/7vobz8vyweycsHCG2uZ
         oelgbag8p7mezMH/QO3e/Ax+CpxbAttblocnpoE7RFn5+aiKpXJ5RjycGgL95kcGfZ0l
         93IGon7EX9oDGd5AYPu7PbztR3adxyctom9skyL2zkgUvLxPmgSdtwDqse4Dif3xT5Y3
         elZA==
X-Gm-Message-State: AA+aEWbDDusoqP0xpxZoan+BkN29p9IukDSoEKSli0knujLpxbnv/SM+
        rqRsEoin3sH/4VhZbZiQ/Ow=
X-Google-Smtp-Source: AFSGD/UFS6RJSWRzaZNisIRSiIm0HBoyJTtYYpd32x2Eu4kV/ff+zirDCFkqxJxcyMZu1ehcZDoQbg==
X-Received: by 2002:a1c:7209:: with SMTP id n9mr1700899wmc.5.1543498069157;
        Thu, 29 Nov 2018 05:27:49 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id j24sm2032536wrd.86.2018.11.29.05.27.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Nov 2018 05:27:48 -0800 (PST)
Date:   Thu, 29 Nov 2018 14:27:46 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v4 4/4] perf report: Documentation average IPC and IPC
 coverage
Message-ID: <20181129132746.GA8748@gmail.com>
References: <1543505978-19808-1-git-send-email-yao.jin@linux.intel.com>
 <1543505978-19808-5-git-send-email-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1543505978-19808-5-git-send-email-yao.jin@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Jin Yao <yao.jin@linux.intel.com> wrote:

> Add explanations for new columns "IPC" and "IPC coverage" in perf
> documentation.
> 
> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> ---
>  tools/perf/Documentation/perf-report.txt | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
> index 474a494..e5a32f3 100644
> --- a/tools/perf/Documentation/perf-report.txt
> +++ b/tools/perf/Documentation/perf-report.txt
> @@ -126,6 +126,14 @@ OPTIONS
>  	And default sort keys are changed to comm, dso_from, symbol_from, dso_to
>  	and symbol_to, see '--branch-stack'.
>  
> +	When the sort key symbol is specified, columns "IPC" and "IPC Coverage"
> +	are enabled automatically. Column "IPC" reports the average IPC per function
> +	and column "IPC coverage" reports the percentage of instructions with
> +	sampled IPC in this function. IPC means Instruction Per Cycle. If it's low,
> +	it indicates there may be performance bottleneck when the function is
> +	executed, such as, memory access bottleneck. If a function has high overhead
> +	and low IPC, it's worth further analysis for performance optimization.

Thank you for adding this!

Just a few small nits:

s/may be performance bottleneck
 /may be a performance bottleneck

s/such as, memory access bottleneck
 /such as a memory access bottleneck

s/it's worth further analysis for performance optimization.
 /it's worth further analyzing it to optimize its performance.

?

Other than that:

Reviewed-by: Ingo Molnar <mingo@kernel.org>

	Ingo
