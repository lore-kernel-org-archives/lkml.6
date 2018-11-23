Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E147C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 16:38:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10A0F206B2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 16:38:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MuaqHBQJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10A0F206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440597AbeKXDXu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 22:23:50 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45626 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730360AbeKXDXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 22:23:49 -0500
Received: by mail-pg1-f196.google.com with SMTP id y4so3266740pgc.12;
        Fri, 23 Nov 2018 08:38:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=59K0zcHDoiq8CsenLJw3lP0RJrvRo4671nFFiCTE7NY=;
        b=MuaqHBQJa3cNUIBvEPKhj6cRnbi0Cz6Y9fE8uM1QNRIn3BbtCLf71J9ovR1rHu7aMG
         Bn5kfpLFcBYtt8ANPz2ZWOn5Kq7aJlNass0OkzlneuJM/H1fqLzjliKif/zObqSl/PvL
         /vGIYc6u0//mhCkZL6d+wehj4rzgzbdP6MhLLzS6LhesOLx7nekLCHSEZui6ceR/7DaL
         o+4l0edtdIDKbypQQjA/c7pWZNbM2B6cCPBl+Baf0x3v78iIJFkJeN+rZ15ZGkNI3Vl9
         FrWcVRZAeti9rSw8sF6NnrdUuCMX0QaC6mBd9XHejwcBih9tINxWvMGRsyYR/MCH/Wr5
         dYkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=59K0zcHDoiq8CsenLJw3lP0RJrvRo4671nFFiCTE7NY=;
        b=D7i5pvdb/ue0fs1n0fBKJ/Xf0czzfRO2Y+WxHzeaaSPRSLSr+wFx8W+vTNk4bAmEmK
         fWk99CnVeIJbV/nZs5L7BQpYHYLt1JHUmNRaSOQQ4lQtRitDoFcua0u1SF9M6xNvHqyo
         AiJ0i5/BeJvxt8cAG1cNtUOJOA5AOoSk1Sbgvc7AgPktRoJV490nsNDD76QKSWIfe+wZ
         iD604PoKoSP7L3u4d5EqXqfe8wwxpy43+DgmrQ3Zbv/z/66iv69wxmbEbpOD62hAKFYJ
         zPg6llG9R9oVxiB3sW4qtlCJqk7De/rnfyxJAhC/nZmYHSqrvZBmgYM4n55ICa5wIRq0
         LLVg==
X-Gm-Message-State: AA+aEWbnrxlJOr4wilFkiJ19ju3VmNJdl47f9m9Be3w2F9ToIt7k97tp
        IPFS8IQawqWOtxT6pEcTNzFXyIOP
X-Google-Smtp-Source: AFSGD/UJqT9CIz1m5X279R07bmHAJbNX8QlJ711oqyE2izvBMtJme9UA4mrU6GEyW4Z3BfaU/h18ew==
X-Received: by 2002:a63:7044:: with SMTP id a4mr14420439pgn.359.1542991132230;
        Fri, 23 Nov 2018 08:38:52 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l72-v6sm62604224pfi.149.2018.11.23.08.38.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Nov 2018 08:38:51 -0800 (PST)
Subject: Re: [PATCH] hwmon (ina3221) Add single-shot mode support
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org
References: <20181113042353.1507-1-nicoleotsuka@gmail.com>
 <20181113043248.GB11205@roeck-us.net>
 <20181113045823.GB26327@Asurada-Nvidia.nvidia.com>
 <20181113172102.GA21714@roeck-us.net>
 <20181114001141.GA14925@Asurada-Nvidia.nvidia.com>
 <20181114172330.GA25592@roeck-us.net>
 <20181117015131.GA10407@Asurada-Nvidia.nvidia.com>
 <20181119174559.GC27435@roeck-us.net>
 <20181119221842.GA26382@Asurada-Nvidia.nvidia.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <b1a34c68-d5e3-9a6f-67b1-6b6d2332f1c6@roeck-us.net>
Date:   Fri, 23 Nov 2018 08:38:50 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181119221842.GA26382@Asurada-Nvidia.nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/19/18 2:18 PM, Nicolin Chen wrote:
> On Mon, Nov 19, 2018 at 09:45:59AM -0800, Guenter Roeck wrote:
>>> In short, other than exposing it via a generic ABI to the user
>>> space, how about defining some policy to maintaining it within
>>> the driver?
> 
>> I think that would be a bad idea. It changes timing for everyone
>> curently using the driver. It also effectively disables monitoring,
>> which is the main purpose for using this chip (and other hardware
>> monitoring chips). This is indeed a key difference between iio
>> and hwmon - the main purpose of chips in the iio subsystem is to
>> be able report data efficiently to user space, not hardware monitoring.
>> I do not think it is appropriate to use iio requirements as argument
>> to change hwmon driver behavior (and vice versa).
> 
> OK...what about setting a default mode via DT? I didn't expect it
> to be possible until I found this existing solution. Though it is
> still in an iio driver, I don't think this should be iio specific.
> 
>    commit 023e30fb0d3a3b9d6b8dc9e47590aa544d58a22f
>    Author: Adriana Reus <adriana.reus@intel.com>
>    Date:   Tue Nov 24 12:59:49 2015 +0200
> 
>      Documentation: devicetree: Add property for controlling power saving
>                     mode for the us5182 als sensor
> 
>      Add a property to allow changing the default power-saving mode.
>      By default, at read raw the chip will activate and provide
>      one measurent, then it will shut itself down. However, the
>      chip can also work in "continuous" mode which may be more reliable
>      but is also more power consuming.
> 
>      Signed-off-by: Adriana Reus <adriana.reus@intel.com>
>      Acked-by: Rob Herring <robh@kernel.org>
>      Signed-off-by: Jonathan Cameron <jic23@kernel.org>
> 
> Would it be possible for me to apply a similar one? Since hwmon
> driver uses continuous mode by default, I will add a "one-shot"
> property instead of "continuous" -- all existing users won't be
> effected unless they place one-shot properties in DT bindings.
> 

I would accept such a patch, but it would for all practical purposes
disable the monitoring of limits. Make sure that is well documented.

Guenter
