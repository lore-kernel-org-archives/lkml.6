Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCAF1C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 10:32:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95E3E223C8
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 10:32:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fL8q+Fzf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95E3E223C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729214AbeKLUYk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 15:24:40 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:37967 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728054AbeKLUYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 15:24:39 -0500
Received: by mail-qk1-f195.google.com with SMTP id d19so12346747qkg.5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 02:32:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QfyL5gdd8ia+wwZCsKzHWOlfmosweDqK9OtqY/Qz9YU=;
        b=fL8q+FzfsNzHbqbI1fIo7xOcoCY/xoNc6DufLAL9Ea5I1YzP5M2SYbEKcuc4JxJqjW
         bLjpWjdcnZLeklU/hJYe6B+WfpLQQeI8fG7EQ1/z60lrWJwFRooFO0F70D6mXAak6AMy
         BayBxDvcfBChHU2QZ3am+fIf8r62lKb2jxR5c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=QfyL5gdd8ia+wwZCsKzHWOlfmosweDqK9OtqY/Qz9YU=;
        b=EWKpvSQ2+wCbuFgx5a7UvEtN+nN6Rf0s0f6wIH82OVBLWGU6QgvJqgqG08jk71dlqa
         T3rxHY+/6wupBX1F1aQVCD9c6U6KCmt/0+DrdpRPL9cWefb+AI5PPkLzBCeeITL1Ttdn
         sHo6Zbu19dm8Gz2G7yBAPW0f7uUd4O4Q4esJEh+24edNLm1nOmmVUcsnmRwkbqdNsE17
         W+KkMxjL1rIqZu0NYFzglQUizp4LxmcdNofh24A5zrTkSeOPUY0DHUzqBlG1PjLYxmlI
         mEh23yA7ai8o0g7wH9EDyQxwBZ9gWOnf2lFlCKmKFr8aPH8AM12B3UZLjK3AT+N50U1R
         g26Q==
X-Gm-Message-State: AGRZ1gIuk+g/0aQTRGtGskAqxoZFcgtKOTqyJoWTHEdFDbxhGS6mxoHu
        WGAFsgz6yMuRFl8ZAc4CsX9/Tg==
X-Google-Smtp-Source: AJdET5cyl00zc0Fa2cZCrQWh1pCVbUrxxxb/K5hH7LMsfkPkYmi2/5uHmfUmWw6aUDUmiIdcDwjs7A==
X-Received: by 2002:ac8:3971:: with SMTP id t46mr288274qtb.331.1542018721407;
        Mon, 12 Nov 2018 02:32:01 -0800 (PST)
Received: from [192.168.48.13] ([168.181.50.245])
        by smtp.gmail.com with ESMTPSA id p31sm10907999qkh.86.2018.11.12.02.31.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 02:32:00 -0800 (PST)
Subject: Re: [PATCH AUTOSEL 4.9 11/48] cpupower: Fix coredump on VMWare
To:     Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Prarit Bhargava <prarit@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Stafford Horne <shorne@gmail.com>, gregkh@linuxfoundation.org
References: <20181031231054.29333-1-sashal@kernel.org>
 <20181031231054.29333-11-sashal@kernel.org>
From:   Rafael David Tinoco <rafael.tinoco@linaro.org>
Organization: Linaro
Message-ID: <87a22cde-f6a8-0103-c20e-150f2d8157ba@linaro.org>
Date:   Mon, 12 Nov 2018 08:31:57 -0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181031231054.29333-11-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/31/18 9:10 PM, Sasha Levin wrote:
> From: Prarit Bhargava <prarit@redhat.com>
> 
> [ Upstream commit f69ffc5d3db8f1f03fd6d1df5930f9a1fbd787b6 ]
> 
> cpupower crashes on VMWare guests.  The guests have the AMD PStateDef MSR
> (0xC0010064 + state number) set to zero.  As a result fid and did are zero
> and the crash occurs because of a divide by zero (cof = fid/did).  This
> can be prevented by checking the enable bit in the PStateDef MSR before
> calculating cof.  By doing this the value of pstate[i] remains zero and
> the value can be tested before displaying the active Pstates.
> 
> Check the enable bit in the PstateDef register for all supported families
> and only print out enabled Pstates.
> 
> Signed-off-by: Prarit Bhargava <prarit@redhat.com>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Stafford Horne <shorne@gmail.com>
> Signed-off-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>   tools/power/cpupower/utils/cpufreq-info.c | 2 ++
>   tools/power/cpupower/utils/helpers/amd.c  | 5 +++++
>   2 files changed, 7 insertions(+)
> 
> diff --git a/tools/power/cpupower/utils/cpufreq-info.c b/tools/power/cpupower/utils/cpufreq-info.c
> index 590d12a25f6e..8d7580e4b299 100644
> --- a/tools/power/cpupower/utils/cpufreq-info.c
> +++ b/tools/power/cpupower/utils/cpufreq-info.c
> @@ -202,6 +202,8 @@ static int get_boost_mode(unsigned int cpu)
>   		printf(_("    Boost States: %d\n"), b_states);
>   		printf(_("    Total States: %d\n"), pstate_no);
>   		for (i = 0; i < pstate_no; i++) {
> +			if (!pstates[i])
> +				continue;
>   			if (i < b_states)
>   				printf(_("    Pstate-Pb%d: %luMHz (boost state)"
>   					 "\n"), i, pstates[i]);
> diff --git a/tools/power/cpupower/utils/helpers/amd.c b/tools/power/cpupower/utils/helpers/amd.c
> index 6437ef39aeea..82adfb33d7a5 100644
> --- a/tools/power/cpupower/utils/helpers/amd.c
> +++ b/tools/power/cpupower/utils/helpers/amd.c
> @@ -103,6 +103,11 @@ int decode_pstates(unsigned int cpu, unsigned int cpu_family,
>   		}
>   		if (read_msr(cpu, MSR_AMD_PSTATE + i, &pstate.val))
>   			return -1;
> +		if ((cpu_family == 0x17) && (!pstate.fam17h_bits.en))
> +			continue;
> +		else if (!pstate.bits.en)
> +			continue;
> +
>   		pstates[i] = get_cof(cpu_family, pstate);
>   	}
>   	*no = i;
> 

Sasha,

This commit is causing:

$ make V=1 -C tools/power/cpupower all

gcc -fPIC -DVERSION=\"4.9.136.142.g36c7703\" -DPACKAGE=\"cpupower\" 
-DPACKAGE_BUGREPORT=\"linux-pm@vger.kernel.org\" -D_GNU_SOURCE -pipe 
-DNLS -Wall -Wchar-subscripts -Wpointer-arith -Wsign-compare 
-Wno-pointer-sign -Wdeclaration-after-statement -Wshadow -O1 -g -DDEBUG 
-I./lib -I ./utils -o utils/helpers/amd.o -c utils/helpers/amd.c
utils/helpers/amd.c: In function ‘decode_pstates’:
utils/helpers/amd.c:106:39: error: ‘union msr_pstate’ has no member 
named ‘fam17h_bits’
    if ((cpu_family == 0x17) && (!pstate.fam17h_bits.en))

I think it should be dropped from v4.4 and v4.9 RCs, since this is a fix 
for a CPU that isn't supported for those 2.

Thanks
--
Rafael D. Tinoco
Linaro Kernel Validation
