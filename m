Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CDA4C282C9
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 11:14:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 471C1218CD
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 11:14:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728701AbfAZLOF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 06:14:05 -0500
Received: from www1102.sakura.ne.jp ([219.94.129.142]:10458 "EHLO
        www1102.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbfAZLOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 06:14:05 -0500
Received: from fsav302.sakura.ne.jp (fsav302.sakura.ne.jp [153.120.85.133])
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x0QBDmWc001322;
        Sat, 26 Jan 2019 20:13:48 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
Received: from www1102.sakura.ne.jp (219.94.129.142)
 by fsav302.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav302.sakura.ne.jp);
 Sat, 26 Jan 2019 20:13:48 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav302.sakura.ne.jp)
Received: from [192.168.1.2] (119.104.232.153.ap.dti.ne.jp [153.232.104.119])
        (authenticated bits=0)
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x0QBDmgY001317
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Sat, 26 Jan 2019 20:13:48 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
Subject: Re: [PATCH] clk: fractional-divider: check parent rate only for
 general approximation
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20190107132124.27788-1-katsuhiro@katsuster.net>
From:   Katsuhiro Suzuki <katsuhiro@katsuster.net>
Message-ID: <063dea80-a13e-3af2-1008-1c0c2bbe2706@katsuster.net>
Date:   Sat, 26 Jan 2019 20:13:48 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190107132124.27788-1-katsuhiro@katsuster.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping...

On 2019/01/07 22:21, Katsuhiro Suzuki wrote:
> Custom approximation of fractional-divider may not need parent clock
> rate checking. For example Rockchip SoCs work fine using grand parent
> clock rate evne if target rate is greater than parent.
> 
> This patch removes parent clock rate check from custom approximation.
> 
> Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
> ---
>   drivers/clk/clk-fractional-divider.c | 10 +++++++---
>   1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/clk/clk-fractional-divider.c b/drivers/clk/clk-fractional-divider.c
> index 545dceec0bbf..b0fc5509e0ff 100644
> --- a/drivers/clk/clk-fractional-divider.c
> +++ b/drivers/clk/clk-fractional-divider.c
> @@ -79,13 +79,17 @@ static long clk_fd_round_rate(struct clk_hw *hw, unsigned long rate,
>   	unsigned long m, n;
>   	u64 ret;
>   
> -	if (!rate || rate >= *parent_rate)
> +	if (!rate)
>   		return *parent_rate;
>   
> -	if (fd->approximation)
> +	if (fd->approximation) {
>   		fd->approximation(hw, rate, parent_rate, &m, &n);
> -	else
> +	} else {
> +		if (rate >= *parent_rate)
> +			return *parent_rate;
> +
>   		clk_fd_general_approximation(hw, rate, parent_rate, &m, &n);
> +	}
>   
>   	ret = (u64)*parent_rate * m;
>   	do_div(ret, n);
> 

