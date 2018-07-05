Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 774D0C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 17:20:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD84D2407A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 17:20:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="T2i6YMTN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD84D2407A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753913AbeGERUy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 13:20:54 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:39054 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753590AbeGERUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 13:20:53 -0400
Received: by mail-wm0-f67.google.com with SMTP id p11-v6so12008219wmc.4
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 10:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jZVBHcZfEuvXFAgyXFUlv6/CSx/WulLJNhM0z512+Zk=;
        b=T2i6YMTNyZhJjc433s1uG/k1oyAJSnWTbu8bFVTyZbxT8QzGf5MOebtb02YEarbfkp
         OKez0wO0Eh2vvIgSaBqudpL+hNgT5OG9Bs72HHcYojFcVGXbLkm8wKyKiIdzgOnfm0Q5
         0vtrbdMt3fjABB3Xo6h0hukqLIPd3xbZaelrc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jZVBHcZfEuvXFAgyXFUlv6/CSx/WulLJNhM0z512+Zk=;
        b=GfvKd106Vloe0YfucGNJ7jD3BrSteLPYPJ9gYEiMVTsQWOksNBUY1HMRrfHBdMUehL
         8Uz3hIfd7PisMutmrrLUi/53AkPYeJWqs2N+0LkI1vPhk+L/fPnS96fXQB4MwffaVFQd
         acOsM/y16h1bWqAr5cs5lD2DLaJ0sN2WUbOZWvgNeLZ8uHgg8Y4KAHkEHA91lJlX99vc
         YOGobBYVuMnBAn8UQASlgtvOOxCXmUtuIa4Rfbt1nNMRmYNDltzNGgfTDCtGBi7J03bk
         GGXrnGnEO747qZztQ82pfDPuh4Gva8yEN15Zd+LCTK1/eKbF4TwKFI9PjeYut0CknOoM
         Rzgw==
X-Gm-Message-State: APt69E1b319c2iDxlaKWXZR3t9OPLOEdmWMEsoE3ZNaFpMZ4PCa3SEi7
        18CldCUhraPSCHzunKJxQ57WSg==
X-Google-Smtp-Source: AAOMgpdaJ6LrEFGTCFeSuw2AwqkjFpYoxWdzx65VLTmbsSAh4djRRZP0gfYKstEnHz5nqa8F0IFDtA==
X-Received: by 2002:a1c:b004:: with SMTP id z4-v6mr4926294wme.70.1530811252289;
        Thu, 05 Jul 2018 10:20:52 -0700 (PDT)
Received: from [192.168.0.18] (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.googlemail.com with ESMTPSA id f2-v6sm7610260wre.16.2018.07.05.10.20.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Jul 2018 10:20:51 -0700 (PDT)
Subject: Re: [PATCH] regmap: slimbus: add support to raw read/writes
To:     Mark Brown <broonie@kernel.org>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
References: <20180705113700.32465-1-srinivas.kandagatla@linaro.org>
 <20180705150857.GA6227@sirena.org.uk>
 <3c958e52-d720-c008-913b-4ff29ea35c00@linaro.org>
 <20180705165011.GC6227@sirena.org.uk>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <5c3bfd3c-f84a-3fa2-f6fd-5624fd052e87@linaro.org>
Date:   Thu, 5 Jul 2018 18:20:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180705165011.GC6227@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/07/18 17:50, Mark Brown wrote:
> On Thu, Jul 05, 2018 at 05:13:21PM +0100, Srinivas Kandagatla wrote:
> 
> 
>> All am trying to do is support paged registers, which seems to be only
>> possible via read/write support at bus level.
> 
> Could you explain what you mean by paged registers?  There's framework
> support for what's normally called pages but perhaps this is some
> slimbus specific thing?

AFAIU, this is not specific to SLIMbus. The way registers are organized 
in WCD9335 codec is in 256 bytes of 6 Pages. Its possible that the 
reason to do this is because SLIMbus has max of 1024 bytes for "User 
Value elements" per device, according to Value Map from SLIMbus Specs.

Access to codec registers is done in 2 steps.

1> Write page number in page register.
2> access register within the page.

This seems to exactly what struct regmap_range_cfg gives.

Adding ranges to regmap_config along with read/write bus callbacks works 
for me.

thanks,
srini
> 
