Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 082AEC004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 10:53:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0649208AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 10:53:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wigr2g4D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0649208AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935232AbeFMKxk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 06:53:40 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33165 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934527AbeFMKxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 06:53:38 -0400
Received: by mail-wm0-f68.google.com with SMTP id z6-v6so22940138wma.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 03:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cDMnxijUjd91XDWO9/AWbkO3UOoK0s7JrLFfKprtelI=;
        b=Wigr2g4DMVBvDAUiGtoU8D7sMQIGpIC7fRnjoJO/KH+XEvOJFCX8e2TBspkS3spM+J
         XqTtLiPt7UI+v/YVFdskVvlyIJ7/62zoOkTOyHrNBfX4Qnw7s/5Cdc/PBrNdRVCCUBwN
         ZSnFtvCkGRHYYzT2Gj41+8QIU+GygYz7ImK8o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cDMnxijUjd91XDWO9/AWbkO3UOoK0s7JrLFfKprtelI=;
        b=edhF+xvXurrNQGdBySuskmClQwyWV2tnJkNe1tgVkbL++7f4d3cRkQDOhyWF2AYtHV
         0EXy3TKwuoGbli4StU9vr8PGuP52YHzFLrbLvHEjBzRGbMfPU8MVPkrlN2wogkhn2qBS
         nPR6yvaehKTlf2BR9TCfdBFZtJYbdg5SkgHRPO1J7q8fHA48cP3RHSUvDhI/eMX0Jtja
         JwkgoyPNk1RxGg/MVNjvqJMOzQQP3v4FhPXxvfpwQ2oNW41qt37hCiU5/jP+ogoIMw48
         Di27TZpOrYAo+zmg0/I4YR/ZeIOz4jCVNXn1EGa2go/85f0FI+5tbmntUNDNqZ4Lz9nP
         c5fw==
X-Gm-Message-State: APt69E1TeCi5X2m3HjAJYOxlst206pu24mX0Qh5/NS08lOGGV3JnhtYS
        KmZxtCNr7QEPHcG8Jhh3EjUWcg==
X-Google-Smtp-Source: ADUXVKLFGpAlaDQRhFsTOGb8l6YHoLGS4IyJegrFa9vVtZZAgMIHR/qd1DIA2qCAz7QL+77VgfeVdg==
X-Received: by 2002:a1c:443:: with SMTP id 64-v6mr3371653wme.140.1528887217594;
        Wed, 13 Jun 2018 03:53:37 -0700 (PDT)
Received: from [192.168.0.18] (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.googlemail.com with ESMTPSA id y8-v6sm4601932wrs.0.2018.06.13.03.53.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Jun 2018 03:53:37 -0700 (PDT)
Subject: Re: [PATCH] irqchip/gic-v3: do not access GICR_WAKER if its secured
 register.
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        open list <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org,
        "Nayak, Rajendra" <rnayak@codeaurora.org>,
        bjorn.andersson@linaro.org, sboyd@kernel.org
References: <20180612145516.30897-1-srinivas.kandagatla@linaro.org>
 <86d0ww7ymc.wl-marc.zyngier@arm.com>
 <c4fafe97-fbf4-1037-394c-94c65fff3e21@linaro.org>
 <CAPKp9uYQC+Pw+DgdTny317s3sNcyE=Shthvyrh7wn0r=Qy1tSQ@mail.gmail.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <113cbfb5-9701-c62c-75c1-72c2dda8df8c@linaro.org>
Date:   Wed, 13 Jun 2018 11:53:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <CAPKp9uYQC+Pw+DgdTny317s3sNcyE=Shthvyrh7wn0r=Qy1tSQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13/06/18 09:45, Sudeep Holla wrote:
> On Wed, Jun 13, 2018 at 9:21 AM, Srinivas Kandagatla
> <srinivas.kandagatla@linaro.org> wrote:
>>
>>
>> On 12/06/18 17:34, Marc Zyngier wrote:
>>>
>>> I suggest you find out how the GIC has been integrated on this
>>> platform. If you take a fault on accessing this register, this very
>>> much looks like an integration bug, and it should be quirked as such.
>>
>> Thanks for the suggestion, This is a bug in the firmware which is
>> restricting access to this register. We have been working around this bug
>> for more than 2 years due to this. Now this platform support is in mainline
>> and We/I have no hope that this will be fixed in near future atleast for
>> this platform.
>>
> 
>  From what you are saying, you were aware of the firmware bug for 2 years as
> you had work-around from then. I wish the firmware had come up with the fix
> in those lost 2 years. I understand if it was discovered now, but that doesn't
> seem to be the case here.
> 
> Firmware fixes are now becoming inevitable, so the attitude that firmware can't
> be fixed has to slowing change. I am not saying I am against the quirk, but in
> general I have seen the firmware support of QCOM parts are really bad. I waited
> for almost 2 years for PSCI firmware on previous dragonboard where developer
> are trying to upstream some feature.
I agree with you!

We did wait for more than 2 years for firmware to be fixed. But it never 
happened and very little hopes to get it fixed.

I did try the quirk based on GICD_IIDR and I could boot linus master on 
DB820c!

I will send it out as RFC soon.

thanks,
srini
> 
> --
> Regards,
> Sudeep
> 
