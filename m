Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 4BE18C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 15:51:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00643208B1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 15:51:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PS5LWgGu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00643208B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934310AbeFLPvo (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 11:51:44 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:38465 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933460AbeFLPvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 11:51:40 -0400
Received: by mail-wm0-f67.google.com with SMTP id 69-v6so24284751wmf.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 08:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cXbJdLJkeA8bBJXhYqE11peq1+5Wl+JIddU66XNeY10=;
        b=PS5LWgGuDIzEz8HMwHcEKKjuHxuJ+hFslkeTGdpNOfxr9xqoriBJ92mrZS8LEn2R4Y
         h3EKDA1ZY6EYH8frtElsgHLVSKDbH6jIwOdPFS+l2neHcdNm4AH4aBqUVRUXuV0azVGP
         0Dov/q1YLZtn+vMkkb+3kjpu8vVqDEgRLZIkc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cXbJdLJkeA8bBJXhYqE11peq1+5Wl+JIddU66XNeY10=;
        b=SgKzyK98vo6pSz2ZVfBqIIp7qaiORgmx07Dds1zyQ0S0Nv8jCPegDVUP2M/HApCLZp
         /aOGW6Fic40Z0R9wKOAfYIg/EWIIX7CgXuyY9rl8P6kenijd51HcicagHkILBYft0rVw
         lmMprbsSoIIVvzUIl2tc0pLwD+RsWYs33p4y5f6WbO0TMfuMKwFod+8OaKYfQ5qScoGm
         7HXoBekYINyoO/uYmxkviPcJcnAveQ2UXAL7z40Opx+Q5/Y2OjwmWovbU5loQXKQqsE9
         zJwRKJeZaj/7V1HwWByJDectcIdW8rZPUaDJS+WBnyYjiyZ5n5SM7EFUh4Y39/EBg8bB
         OHsA==
X-Gm-Message-State: APt69E1WubSqDdNOr3GlHv+p4S3Nj3WeCKlbnikFvtOn/XGlNHmRGZvS
        +Tdq2g6UWQnMwGHVKcwc3LxOJzaz5zA=
X-Google-Smtp-Source: ADUXVKJb2JmH8JTrWAD+lz6XLzoV/uhzWdvatoPoiiimwue38569XsiuO/s9bzRBzuyydwdUDZVhtg==
X-Received: by 2002:a1c:71db:: with SMTP id d88-v6mr649272wmi.117.1528818699759;
        Tue, 12 Jun 2018 08:51:39 -0700 (PDT)
Received: from [192.168.0.18] (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.googlemail.com with ESMTPSA id g88-v6sm1125140wmc.27.2018.06.12.08.51.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Jun 2018 08:51:39 -0700 (PDT)
Subject: Re: [PATCH] irqchip/gic-v3: do not access GICR_WAKER if its secured
 register.
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        open list <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org,
        "Nayak, Rajendra" <rnayak@codeaurora.org>,
        bjorn.andersson@linaro.org, sboyd@kernel.org
References: <20180612145516.30897-1-srinivas.kandagatla@linaro.org>
 <CAPKp9uaJK8AQPgqYCmVmpS0RsMBPGUAK_xXkHsNDg+2e3MygyQ@mail.gmail.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <65400c1c-7575-cba8-0919-3f426bc71d4b@linaro.org>
Date:   Tue, 12 Jun 2018 16:51:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <CAPKp9uaJK8AQPgqYCmVmpS0RsMBPGUAK_xXkHsNDg+2e3MygyQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/06/18 16:24, Sudeep Holla wrote:
> On Tue, Jun 12, 2018 at 3:55 PM, Srinivas Kandagatla
> <srinivas.kandagatla@linaro.org> wrote:
>> GICR_WAKER can be a secured register, check this before accessing it
>> as its done in power management code.
>>
>> Without this patch Qualcomm DB820c board crashes.
>>
> 
> Are you sure this is the one causing the crash ?
> 
Yep, am 100% sure its the write in gic_enable_redist(). Very first zero 
write to GICR_WAKER is the one which is crashing my system.

If I add return before writing then I can boot my system fine.

Not sure why writes are not ignored?

Also why does other parts of the code have checks while accessing this 
register?

thanks,
srini

> As per GIC specification:
> "When GICD_CTLR.DS==1, this register is always accessible.
>   When GICD_CTLR.DS==0, this is a Secure register. This register is RAZ/WI
>   to Non-secure accesses."
> 
> 
> --
> Regards,
> Sudeep
> 
