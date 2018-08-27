Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAF8FC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 17:47:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9657A2088E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 17:47:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9657A2088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbeH0Vek (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 17:34:40 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:58318 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbeH0Vek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 17:34:40 -0400
Received: from localhost (localhost [127.0.0.1])
        by mailout.easymail.ca (Postfix) with ESMTP id 45A7F21388;
        Mon, 27 Aug 2018 17:47:06 +0000 (UTC)
Received: from mailout.easymail.ca ([127.0.0.1])
        by localhost (emo02-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id CaXPrkDzHIZ6; Mon, 27 Aug 2018 17:47:06 +0000 (UTC)
Received: from [192.168.1.87] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailout.easymail.ca (Postfix) with ESMTPSA id 3B6572143A;
        Mon, 27 Aug 2018 17:46:59 +0000 (UTC)
Subject: Re: [PATCH] cpupower: remove stringop-truncation waring
To:     Anders Roxell <anders.roxell@linaro.org>, trenn@suse.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>
References: <20180821120225.3516-1-anders.roxell@linaro.org>
From:   Shuah Khan <shuah@kernel.org>
Message-ID: <a25c0c8b-10e3-c4c1-fc09-09bd39442b0e@kernel.org>
Date:   Mon, 27 Aug 2018 11:46:49 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180821120225.3516-1-anders.roxell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/21/2018 06:02 AM, Anders Roxell wrote:
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
> Passing the length of the input argument to strncpy() is almost always
> wrong and provides no extra benefit over strcpy(), and since 'ondemand'
> fits within 15 bytes" and it null terminates the string its safe to use
> strcpy().
> 
> Fixes: 7fe2f6399a84 ("cpupowerutils - cpufrequtils extended with quite some features")
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---
>  tools/power/cpupower/bench/parse.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/power/cpupower/bench/parse.c b/tools/power/cpupower/bench/parse.c
> index 9ba8a44ad2a7..91b5b768ffd2 100644
> --- a/tools/power/cpupower/bench/parse.c
> +++ b/tools/power/cpupower/bench/parse.c
> @@ -145,7 +145,7 @@ struct config *prepare_default_config()
>  	config->cpu = 0;
>  	config->prio = SCHED_HIGH;
>  	config->verbose = 0;
> -	strncpy(config->governor, "ondemand", 8);
> +	strcpy(config->governor, "ondemand");
This change is fine, however continuing to use strncpy with sizeof(config->governor).

thanks,
-- Shuah
