Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69B77C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 14:27:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2912B21722
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 14:27:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2912B21722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbeHTRnh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 13:43:37 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:40005 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbeHTRnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 13:43:37 -0400
Received: from localhost (localhost [127.0.0.1])
        by mailout.easymail.ca (Postfix) with ESMTP id CE44B416D1;
        Mon, 20 Aug 2018 14:27:44 +0000 (UTC)
Received: from mailout.easymail.ca ([127.0.0.1])
        by localhost (emo03-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id UjL-bkmuih5U; Mon, 20 Aug 2018 14:27:44 +0000 (UTC)
Received: from [192.168.1.87] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailout.easymail.ca (Postfix) with ESMTPSA id 3A5C8410D6;
        Mon, 20 Aug 2018 14:27:34 +0000 (UTC)
Subject: Re: [PATCH 18/18] cpupower: change strncpy+truncation to strlcpy
To:     Dominique Martinet <asmadeus@codewreck.org>,
        =?UTF-8?Q?Daniel_D=c3=adaz?= <daniel.diaz@linaro.org>
Cc:     Thomas Renninger <trenn@suse.com>,
        Colin Ian King <colin.king@canonical.com>,
        linux-pm@vger.kernel.org, open list <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>
References: <1531444483-17338-1-git-send-email-asmadeus@codewreck.org>
 <1531445169-19912-1-git-send-email-asmadeus@codewreck.org>
 <CAEUSe78K3bxfXp8mAoxtd64ZeBFVN4v0sJ+puvffM_ZkUNsW+A@mail.gmail.com>
 <20180814192728.GA6264@nautica>
From:   Shuah Khan <shuah@kernel.org>
Message-ID: <379ea973-0234-fbaf-12bc-7ec154833a0a@kernel.org>
Date:   Mon, 20 Aug 2018 08:27:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180814192728.GA6264@nautica>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/14/2018 01:27 PM, Dominique Martinet wrote:
> Daniel Díaz wrote on Tue, Aug 14, 2018:
>> I can't get cpupower to compile anymore now that it made its way to linux-next:
>>   [/linux/tools/power/cpupower]$ make
>>     CC       lib/cpufreq.o
>>   [...]
>>   make[1]: Entering directory '/linux/tools/power/cpupower/bench'
>>     CC       main.o
>>     CC       parse.o
>>   parse.c: In function ‘prepare_config’:
>>   parse.c:224:4: warning: implicit declaration of function ‘strlcpy’
>> [-Wimplicit-function-declaration]
>>       strlcpy(config->governor, val,
>>       ^
>>     CC       system.o
>>     CC       benchmark.o
>>     CC       cpufreq-bench
>>   .//parse.o: In function `prepare_config':
>>   /linux/tools/power/cpupower/bench/parse.c:224: undefined reference
>> to `strlcpy'
>>   collect2: error: ld returned 1 exit status
>>   Makefile:25: recipe for target 'cpufreq-bench' failed
>>   make[1]: *** [cpufreq-bench] Error 1
>>   make[1]: Leaving directory '/linux/tools/power/cpupower/bench'
>>   Makefile:258: recipe for target 'compile-bench' failed
>>   make: *** [compile-bench] Error 2
>>
>> Does it need anything special to make?
> 
> Ugh, no, I am really ashamed about this patch series for insufficient
> testing in general. It is currently "under rework" for an indefinite
> time frame as I have had other priorities but I'll add cpupower to the
> list...
> More precisely, the function is defined in the linux kernel but for
> userspace strlcpy is only available through libbsd, and I don't believe
> we should pull that in just for this.
> 
> I'll send a second patch using snprintf and warning if a truncation
> occurs (which is the proper fix that the gcc folks intended people to do
> anyway) when I get around to it, but I would recommend to just revert
> the patch for now.
> 
> 
> Shuah, could you take the patch off please if you haven't pushed it to
> linus yet?
> 
> 
> Sorry for the time you might have spent on this,
> 
I will go ahead and revert it.

thanks,
-- Shuah
