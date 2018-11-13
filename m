Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4979C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 16:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7384C223DD
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 16:33:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gZAJHGI9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7384C223DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730940AbeKNCcW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 21:32:22 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:34891 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727428AbeKNCcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 21:32:22 -0500
Received: by mail-oi1-f196.google.com with SMTP id v198-v6so10863809oif.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 08:33:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Y9PmHMPf7gQ17MgltaMVtKD3rSJypy3LXU9Ftt1uWiI=;
        b=gZAJHGI9cD7smiV4bMg5aKE7vaNPNbe6xVkRX+oGE639czSo0QKeJvxqgXu0g672OW
         cuH1Groq3vu7EaysBG2D8U5uv6eYxk/zpIdr5+WEuY0i5Y17ZwkKouyn6q840Ov4Ui1Q
         ftA56rLlEMfGCKnJfL0iV0CrlR5S/POBPjQU8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Y9PmHMPf7gQ17MgltaMVtKD3rSJypy3LXU9Ftt1uWiI=;
        b=UGiw44cDZ2bcmAhFu4OI4e8Znp5znHPRvbZcWmtglMvj7+WkJbVQAU5Owsv6z2ZPyv
         u5h6LkcEzvxvURDegtCxyP1gRpyOOXqJC29I8Amn8IIk8w7BuXP1fiehAmsISZ5J64nB
         dbhmducAGhFMQFzjlidTkEQdNmHhbJCPN44qkW0LuWctLIbH6Gri9u/qQAkKlv4sEGiD
         Lqryrb7ectKI9ZBGHCMkEsUPfYju/5qTy7fR4nqj1015yF/MLoxSdTCvmkYxqqKJyYWr
         3WPKW8jYPOFG7u4h5IhEQex+d/gewlKpj8a917B8nunpT2+cXG21FVFLIa3uXcrUqZj0
         WEmQ==
X-Gm-Message-State: AGRZ1gLQcxdAXYP4sI7FB6lhFO0v5cl8JPxKwxuy7I27FRrPjHleNeTV
        apU1xbMm/6jXb7dv3qkgTUxbug==
X-Google-Smtp-Source: AJdET5evSR9tz3s9TsQpctTpUvLOiPA4mxpJYYMFcHE3dElkZ7L4NEYFfO5H8qXV9bioVHEwfoWvGA==
X-Received: by 2002:aca:d984:: with SMTP id q126-v6mr3527223oig.216.1542126811703;
        Tue, 13 Nov 2018 08:33:31 -0800 (PST)
Received: from [172.22.22.26] (c-71-195-29-92.hsd1.mn.comcast.net. [71.195.29.92])
        by smtp.googlemail.com with ESMTPSA id h7sm8063698otb.45.2018.11.13.08.33.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 08:33:31 -0800 (PST)
Subject: Re: [RFC PATCH 02/12] soc: qcom: ipa: DMA helpers
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     David Miller <davem@davemloft.net>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Networking <netdev@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        syadagir@codeaurora.org, mjavid@codeaurora.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
References: <20181107003250.5832-1-elder@linaro.org>
 <20181107003250.5832-3-elder@linaro.org>
 <CAK8P3a3Hur9Kn=QLrn7XDn-Kpgfta1xTxvuwcBze4n2v7fsULw@mail.gmail.com>
From:   Alex Elder <elder@linaro.org>
Message-ID: <7eaef6a8-9d12-31bb-43fb-e710ad171c0f@linaro.org>
Date:   Tue, 13 Nov 2018 10:33:29 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAK8P3a3Hur9Kn=QLrn7XDn-Kpgfta1xTxvuwcBze4n2v7fsULw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/7/18 6:17 AM, Arnd Bergmann wrote:
> On Wed, Nov 7, 2018 at 1:33 AM Alex Elder <elder@linaro.org> wrote:
>>
>> This patch includes code implementing the IPA DMA module, which
>> defines a structure to represent a DMA allocation for the IPA device.
>> It's used throughout the IPA code.
>>
>> Signed-off-by: Alex Elder <elder@linaro.org>
> 
> I looked through all the users of this and couldn't fine one that actually
> benefits from it. I'd say better drop this patch entirely and open-code
> the contents in the callers. That will help readability since the dma
> API is well understood by many people.

Originally this was done to make it more obvious that all DMA allocations
were done with the same device pointer.  Previously there were several
separate devices, and it wasn't very obvious that only one was used (and
required).  Now that we're past that it's not difficult to do as you suggest.

I have now done that, and in the process identified a few more ways to
improve/simplify the code.  The net result is that more lines of code
were removed than were present in "ipa_dma.[ch]".  I see that as a
win (aside from your point below).

> Generally speaking, try not to wrap Linux interfaces into driver specific
> helper functions.

Agreed.  Thanks a lot for your review.

					-Alex

> 
>       Arnd
> 

