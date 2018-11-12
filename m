Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9392C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 10:29:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F095223C8
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 10:29:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ao5tRvyZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F095223C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729210AbeKLUWJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 15:22:09 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:43925 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728054AbeKLUWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 15:22:09 -0500
Received: by mail-qk1-f195.google.com with SMTP id r71so12331812qkr.10
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 02:29:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jMRdyhLLMJKOEkmEMbuj8qee+hZYiQAo/NnFJD9rw/s=;
        b=Ao5tRvyZ6k4+yECUa4/CFqKQMdD9nTt6PHUixk7cgdwMcCHvPhh5dr0S2z9MVpavhY
         GlkGwBT+GN8hgiMIcQBzcyuYj4NYLRruVrMSWV4mcyFUSVFEreWOZDLXr3Ka+oW5WWDZ
         qZAtVbp/NcyTbirE7rc7V+pf/hh2D+z0kr/Vg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=jMRdyhLLMJKOEkmEMbuj8qee+hZYiQAo/NnFJD9rw/s=;
        b=VOoiQwRzJjUztUd2fnAtffqifv4NjeJMhLlyu/8eCdvQbED6a/+eUNqLvbtISoSqGq
         /4rbtxHMdoD2Nduz/DssgYIbdLGwjbuJRBufnMVyiRgSKcIoVrwOx7dTxdfaCG4WCatp
         bgkcAssdjzX+u2DzrXTVBDpVcvqd1qQCOv9eok3r6XsFwrnIKg76i1Yc2CMb5Xv9Sua8
         T4V5vJdI5jHWwUsb7ZfriQdCL240W4+5a3B1jjft3K4/dd3dKL5ZliR20ZSon+WvB5lU
         ueXetCokU1m0dF87nkQLtsaJkAUq/tNtOiAvkleDKfaVuPWS9k5GH9i53mX8F6RaplVv
         nwjQ==
X-Gm-Message-State: AGRZ1gJO6wSKYi/7ZzyKQfoBJgfEKceNthHWAGHt0zJO6jbYev9t9ol0
        l0GkkzZvqY1wE74585UP6B/Xnd/O4Hftug==
X-Google-Smtp-Source: AJdET5dHLzRxrkM0Fyu6ZeWzCoTwuI/AOq7EqB49zjvDJYM92gaewz40xTz5bEWg8MdsRcfTDBJAJw==
X-Received: by 2002:aed:2dc5:: with SMTP id i63mr304317qtd.173.1542018571858;
        Mon, 12 Nov 2018 02:29:31 -0800 (PST)
Received: from [192.168.48.13] ([168.181.50.245])
        by smtp.gmail.com with ESMTPSA id a68sm9670169qkj.63.2018.11.12.02.29.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 02:29:31 -0800 (PST)
Subject: Re: [PATCH AUTOSEL 4.4 07/32] cpupower: Fix coredump on VMWare
To:     Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Prarit Bhargava <prarit@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Stafford Horne <shorne@gmail.com>, gregkh@linuxfoundation.org
References: <20181031231137.29429-1-sashal@kernel.org>
 <20181031231137.29429-7-sashal@kernel.org>
From:   Rafael David Tinoco <rafael.tinoco@linaro.org>
Organization: Linaro
Message-ID: <a5f213e5-a671-d587-5329-5b919965134e@linaro.org>
Date:   Mon, 12 Nov 2018 08:29:27 -0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181031231137.29429-7-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/31/18 9:11 PM, Sasha Levin wrote:
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
> index 0e6764330241..f9b064ac8d94 100644
> --- a/tools/power/cpupower/utils/cpufreq-info.c
> +++ b/tools/power/cpupower/utils/cpufreq-info.c
> @@ -200,6 +200,8 @@ static int get_boost_mode(unsigned int cpu)
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

gcc -fPIC -DVERSION=\"4.4.163.99.g0d9e7b\" -DPACKAGE=\"cpupower\" 
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
