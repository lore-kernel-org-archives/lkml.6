Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77BCAC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 12:25:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B16920671
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 12:25:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="DMvpEBva"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B16920671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732638AbeITSIf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 14:08:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:45024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726177AbeITSIe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 14:08:34 -0400
Received: from [192.168.1.75] (cpe-24-28-70-126.austin.res.rr.com [24.28.70.126])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 504A420671;
        Thu, 20 Sep 2018 12:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537446319;
        bh=U73pkOvAPrx9zmElSX46ox5xEYNnNYQ/PvD0oI91cqI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=DMvpEBva+wuyP4WplUbpyZuNVpC1QohEQ510WFUjKZtaEiaOqCFDBBam2RWcuvILe
         AyCG1L09lF6he1+WBme1AFSZ0y6/f0Ej1GimrBZ7fACYDF8Kpn/YOybxRZ7pz+G9mh
         JNf0d5xU8LZUUlFeptI3k5NshbbDHmMVEFwphl1M=
Subject: Re: [PATCH] gpiolib: Show correct direction from the beginning
To:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>, swboyd@chromium.org,
        linux-gpio@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <20180914070839.4667-1-ricardo.ribalda@gmail.com>
 <20180914070839.4667-2-ricardo.ribalda@gmail.com>
 <CACRpkdbqmK=MzGsOYLdtFO3AAbKHhzy_RD=Gr6wj3WnQunyCGg@mail.gmail.com>
 <CAPybu_0iDqSn02iGLEg8Ge9EdyCCNhRVV3JgHg180qrXK+bcdw@mail.gmail.com>
 <d84ee082-f578-3ed3-32be-dbeb9562980e@kernel.org>
 <CAPybu_39xtDfoHVo2dv2GZcU5hCQYjBpU7tW2hf3vfUwbUK1mQ@mail.gmail.com>
From:   Timur Tabi <timur@kernel.org>
Message-ID: <ebcc344a-469a-d3c0-3e0e-cdabe046cbf3@kernel.org>
Date:   Thu, 20 Sep 2018 07:25:17 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAPybu_39xtDfoHVo2dv2GZcU5hCQYjBpU7tW2hf3vfUwbUK1mQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/19/18 10:27 AM, Ricardo Ribalda Delgado wrote:
> "The get_direction callback normally triggers
> a  read/write to hardware, but we shouldn't be touching the hardware
> for   an individual GPIO until after it's been properly claimed." is
> an statement specific for your platform 

That is definitely not true.

> and should be fixed in your
> driver.

There is no bug in my driver.  The driver reports only a subset of the 
GPIOs, because that's all that are available.  Attempting to access an 
invalid GPIO generates an XPU violation.  The original code was 
attempting to access GPIOs that the driver said don't exist.

The code that we have today is the result of months of discussion, 
negotiation, and trial-and-error.
