Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41C67C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 17:40:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E5E420652
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 17:40:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sHun4qzk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728442AbfBURkH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 12:40:07 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55982 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbfBURkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 12:40:06 -0500
Received: by mail-wm1-f67.google.com with SMTP id q187so10433293wme.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 09:40:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+2J32TOrFx9IW9ja/f9lE8rW+cBKzT7xODEj+b0W0z0=;
        b=sHun4qzkSSIUHw6P5YElBVubSVud/p9N8FYAmj5vkUznA8KacFWf1EqyZtdJY+efCh
         FEsKUHJaNarkMxwtsSzLEfvUMn8Yy2qUK1h+MlM4uhgFbTUd1zAYciyKvqanA4rmuTAB
         095NX32xLZviUKnKwVUNZ4kW8yXkex/3MPYJzYyEpNJZYL1XazVjM1XJe1TVsvX+8Jhx
         bglDGzbu34Ydjx+PUMlECu0JiqDiLEpxO48Dr5vPfZEwDDGhA6QoQeeo6of1Wjyp2iqz
         b7Rkt3WMb4O4Gi3/heEkD7wpuwVGa6xiUgvAn91gwGe3+sPDPSUIQRX/jIuI31JmlCYP
         nNxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+2J32TOrFx9IW9ja/f9lE8rW+cBKzT7xODEj+b0W0z0=;
        b=EYAKzIakqdFx/o2cVNz2eInmyivlxvxCFvBO03wVeoXB03WsRiuQ9Ec3I1WcYOPc+R
         8XzuyALNCUz/vOyilxXVy1lH1JU8rxgxXlbZZ9bBSp5ZRGtfiJNbgdzujA6ojvY/Yk1h
         yxU4l9R3A6g8lIjEOTZBo+vhwJsAGURcRrhpyJ1ipiokPBtDEdQc1EtCds3QcH1Xqjsz
         y52rWfMrEzbCHcDS7e/Y4JYE1XAQxbFKQO3LEwPLWPxoa2N1yYojMWIl0KsTLqr5FPLQ
         GA0g7fNESav2lsV5la3tWXSmxm11jq2wCc+J8m6R1X0GLUFQBDDZEN1BkHrgZaAQHEZJ
         HQqg==
X-Gm-Message-State: AHQUAubpgE4LrZifwFE0u2yKF+Qi2Ie3r/eNufJL/tjJndQxOuCiEdOV
        6SzbBOUm2R6wXHic0JkSxK0ZMnMnO7s=
X-Google-Smtp-Source: AHgI3IYaLbppXSENLjdZ8BqMbN6SvDUIJK389U5TQJCZFLjuTT+RtBKKKSqf1ObtOS9WWrHfYzdzcw==
X-Received: by 2002:a1c:a3c3:: with SMTP id m186mr11152909wme.16.1550770804169;
        Thu, 21 Feb 2019 09:40:04 -0800 (PST)
Received: from [192.168.0.41] (222.51.92.92.rev.sfr.net. [92.92.51.222])
        by smtp.googlemail.com with ESMTPSA id z17sm22508309wrs.75.2019.02.21.09.40.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Feb 2019 09:40:03 -0800 (PST)
Subject: Re: [PATCH] cpuidle: Add a predict callback for the governors
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20190221145631.26356-1-daniel.lezcano@linaro.org>
 <CAJZ5v0iCkMA=LVvV+-jqr8fCYz2mwaqtiKmNTfxf0dxZ=MvdiQ@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <d315736a-2aa0-3c8d-f3cf-f73b60e7ebe0@linaro.org>
Date:   Thu, 21 Feb 2019 18:40:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0iCkMA=LVvV+-jqr8fCYz2mwaqtiKmNTfxf0dxZ=MvdiQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/02/2019 17:18, Rafael J. Wysocki wrote:
> On Thu, Feb 21, 2019 at 3:56 PM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>> Predicting the next event on the current CPU is implemented in the
>> idle state selection function, thus the selection logic and the
>> prediction are tied together and it is hard to decorrelate both.
>>
>> The following change introduces the cpuidle function to give the
>> opportunity to the governor to store the guess estimate of the
>> different source of wakeup and then reuse them in the selection
>> process. Consequently we end up with two separate operations clearly
>> identified.
>>
>> As the next events are stored in the cpuidle device structure it is
>> easy to propagate them in the different governor callbacks.
> 
> Can you explain a bit how you would use this new callback in a governor?

Sure.

Today we have the selection and the prediction tied together. The
prediction is modulated with some inputs coming from the governor's
policy (eg. performance multiplier).

It is hard to know if the prediction is correct or not, hard to know the
duration of the computation for the next event and hard to know if the
idle state selection succeeded because of a good prediction or a good
governor policy.

I propose to provide the callback where we fill the guess estimated next
events on the system, so we can trace them and benchmark the computation
time.

The selection of the idle state becomes an separate action where we can
apply any specific governor heuristic or policy.

By separating the selection and the prediction, we can identify where
the weakness is in our test scenario: the prediction or the governor
selection policy.



-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

