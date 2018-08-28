Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9131C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 21:48:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EB882087B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 21:48:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EB882087B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727375AbeH2BmM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 21:42:12 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:34819 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727166AbeH2BmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 21:42:12 -0400
Received: from localhost (localhost [127.0.0.1])
        by mailout.easymail.ca (Postfix) with ESMTP id 2F4A2C1257;
        Tue, 28 Aug 2018 21:48:35 +0000 (UTC)
Received: from mailout.easymail.ca ([127.0.0.1])
        by localhost (emo01-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 7X7IoSqw3QWN; Tue, 28 Aug 2018 21:48:35 +0000 (UTC)
Received: from [192.168.1.87] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailout.easymail.ca (Postfix) with ESMTPSA id 5A096C1203;
        Tue, 28 Aug 2018 21:48:27 +0000 (UTC)
Subject: Re: [PATCH v2] cpupower: remove stringop-truncation waring
To:     Anders Roxell <anders.roxell@linaro.org>, trenn@suse.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>
References: <a25c0c8b-10e3-c4c1-fc09-09bd39442b0e@kernel.org>
 <20180828093118.28326-1-anders.roxell@linaro.org>
From:   Shuah Khan <shuah@kernel.org>
Message-ID: <a886478f-e068-415a-44b6-e31a6d593a48@kernel.org>
Date:   Tue, 28 Aug 2018 15:48:20 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180828093118.28326-1-anders.roxell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/28/2018 03:31 AM, Anders Roxell wrote:
> The strncpy doesn't null terminate the string because the size is too
> short by one byte.
> 
> parse.c: In function ‘prepare_default_config’:
> parse.c:148:2: warning: ‘strncpy’ output truncated before terminating
>     nul copying 8 bytes from a string of the same length
>     [-Wstringop-truncation]
>   strncpy(config->governor, "ondemand", 8);
>   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> The normal method of passing the length of the destination buffer works
> correctly here.
> 
> Fixes: 7fe2f6399a84 ("cpupowerutils - cpufrequtils extended with quite some features")
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---
>  tools/power/cpupower/bench/parse.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/power/cpupower/bench/parse.c b/tools/power/cpupower/bench/parse.c
> index 9ba8a44ad2a7..84caee38418f 100644
> --- a/tools/power/cpupower/bench/parse.c
> +++ b/tools/power/cpupower/bench/parse.c
> @@ -145,7 +145,7 @@ struct config *prepare_default_config()
>  	config->cpu = 0;
>  	config->prio = SCHED_HIGH;
>  	config->verbose = 0;
> -	strncpy(config->governor, "ondemand", 8);
> +	strncpy(config->governor, "ondemand", sizeof(config->governor));
>  
>  	config->output = stdout;
>  
> 

Thanks. Applied to cpupower git for 4.19-rc3

thanks,
-- Shuah
