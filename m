Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB86CC46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 21:09:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A414E21A95
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 21:09:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uAGm8S++"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A414E21A95
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731654AbeHHXbU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 19:31:20 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40268 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731180AbeHHXbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 19:31:20 -0400
Received: by mail-wr1-f66.google.com with SMTP id h15-v6so3213754wrs.7;
        Wed, 08 Aug 2018 14:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4M0pIp7E92ruaZ1FPWIfPA/FaSMFGNaouifdcVzT0zc=;
        b=uAGm8S++HlhZ6oCb1gJJya5s3ro9ainrKzv5o03anmw88dcFfuhPs66UxEfYh81meG
         XI54NLeSx3lPReEMK7QGdnMlySZtqsVy8wSVVM0fXBRFDNiODkcsMr1YNDF3ql08RZht
         8LBBk6PWIZPsY2y/KfujrfawX7o0GN3VRw9+N6wVv6Xh8KxvlMwhchNI9ODi7ksEZ8lV
         Y6mM3k59wEgEZ+sv/FYK65xD7BMmYuLClphvHTdvYe0fVim485b2I6GizeqLy1gg8WKJ
         NW9tS3bo/yNqfZRkmnfHxyvUdIm7hUKkUrbnoiu3IUB+LdvCJdWpBcUXh8Z0zg/UBY0+
         w8NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4M0pIp7E92ruaZ1FPWIfPA/FaSMFGNaouifdcVzT0zc=;
        b=XzcfWbHqPEBy+QDdEk3BpZAv4BrBhFBql+q/e9KqRvZgeiPMPiMSSVCgzcpZksY9ey
         oyKfsKL1vDLJaJmm+E1vpITTkheQ2T4PqLdmHcaqRZYi+6IPWqWFDgRAU3ZrZiXUlveE
         +NomIp8rgg+SDZjAfzSLz25p/5GFb8btjlGzQH0ZNh05VLHvEPU3Znq04eV2H/TYBqSI
         UQljNwIGITU8SUCDjc91ixMi4Ytz4PGflcm0xILDrLCwbQEroDpzCGMfP0b07IwRwxa3
         nHkZ8gxXs09cyFnwQNYXy9orL1vqAoUrmJK/dEjok8Ym8VcxcPXlMr2FHWhQieecMd4f
         cdHw==
X-Gm-Message-State: AOUpUlFs0z17s1reVd83khZoW50gCmucudkRRi5FvHBFMMePdJi1g1ez
        MHoDz2RoflXfAOd1KHbGf7AjkPPI
X-Google-Smtp-Source: AA+uWPwTv38WzNufkHNueZ3TWahVZKTLAumVGRx68+Q+Pd7D7TxGWl+z8+MtZkkr69/ovrCnWZfthA==
X-Received: by 2002:adf:d1cf:: with SMTP id m15-v6mr3144173wri.138.1533762591932;
        Wed, 08 Aug 2018 14:09:51 -0700 (PDT)
Received: from [192.168.1.18] (chs174.neoplus.adsl.tpnet.pl. [83.31.16.174])
        by smtp.gmail.com with ESMTPSA id w4-v6sm3746938wrt.40.2018.08.08.14.09.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 14:09:51 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] dt: bindings: lm3697: Add bindings for lm3697
 driver
To:     Dan Murphy <dmurphy@ti.com>, Pavel Machek <pavel@ucw.cz>
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
References: <20180807160442.8937-1-dmurphy@ti.com>
 <20180808195903.GB20912@amd> <f6b3534b-2ee9-782e-35e5-e103c34528bc@ti.com>
 <20180808210215.GA15831@amd> <f18a5616-bb25-da0d-aec8-585e042b4919@ti.com>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <53691469-4554-42a8-c182-762c1a3939b7@gmail.com>
Date:   Wed, 8 Aug 2018 23:09:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <f18a5616-bb25-da0d-aec8-585e042b4919@ti.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

On 08/08/2018 11:04 PM, Dan Murphy wrote:
> On 08/08/2018 04:02 PM, Pavel Machek wrote:
>> Hi!
>>
>>>>> +	- #size-cells : 0
>>>>> +	- control-bank-cfg - : Indicates which sink is connected to which control bank
>>>>> +		0 - All HVLED outputs are controlled by bank A
>>>>> +		1 - HVLED1 is controlled bank B, HVLED2/3 are controlled by bank A
>>>>> +		2 - HVLED2 is controlled bank B, HVLED1/3 are controlled by bank A
>>>>> +		3 - HVLED1/2 are controlled by bank B, HVLED3 is controlled by bank A
>>>>> +		4 - HVLED3 is controlled by bank B, HVLED1/2 are controlled by bank A
>>>>> +		5 - HVLED1/3 is controlled by bank B, HVLED2 is controlled by bank A
>>>>> +		6 - (default) HVLED1 is controlled by bank A, HVLED2/3 are controlled by bank B
>>>>> +		7 - All HVLED outputs are controlled by bank B
>>>>
>>>> This is quite long way to describe a bitmask, no? Could we make
>>>> it so that control-bank-cfg is not needed?
>>>
>>> The problem we have here is there is a potential to control
>>> 3 different LED string but only 2 sinks.  So control bank A can control 2 LED strings and control
>>> bank b can control 1 LED string.  
>>>
>>
>> Can we forget about the LED strings, and just expose the sinks as
>> Linux LED devices?
> 
> 2 sinks 3 LED strings.  How do you know which LED string is which and what bank it belongs
> to when setting the brightness.  Each Bank has a separate register for brightness control.

Just a blind shot, without going into details - could you please check
if led-sources property documented in the common LED bindings couldn't
help here?

-- 
Best regards,
Jacek Anaszewski
