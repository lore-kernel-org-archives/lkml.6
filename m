Return-Path: <SRS0=M2MR=LX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 060DDC4321E
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 15:52:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9133B20833
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 15:52:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FIzwirIs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9133B20833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726662AbeIIUmH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Sep 2018 16:42:07 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39506 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbeIIUmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Sep 2018 16:42:07 -0400
Received: by mail-pg1-f196.google.com with SMTP id i190-v6so9223422pgc.6;
        Sun, 09 Sep 2018 08:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pRLoWALX6OC1KcENdysykGJD7M5zzI+gWeZohTAm34I=;
        b=FIzwirIsVx0IGqDBYyo3YiM7GQgV92w7Bz85wyBrnYMB/bZt9b7HMyM9UyswIeCvgO
         AUCLsRmW5yVkxl1cCDC2781QNpn7UwOce+dlGJpLVgGnnJouUj5A2WpArt1AJ+q5InEJ
         F9facj8BQeOBw6wVlk1qX70sqB07hW4yE5pYIQ0NxCQc0iR8B1RZr32ILHgf8pern0Q8
         rQ5Gc+yykmH8ILqg2gQAjwPkBHHD5Lf3mPf7K2A89WUF2OawnS2CAm4qleZjzKnvhrJl
         JahipPnwzW7p91aybz/CM0kgJxFwmKqozKfu6WuJ3Zn9vF3n03ugaBQ5XVC04y40xkZI
         ef8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pRLoWALX6OC1KcENdysykGJD7M5zzI+gWeZohTAm34I=;
        b=nym2+A3rO+2wgY0IdRA3w2PiKAZMMhRuQkqWhSAlbDqZ7AwUYaLIieqDu5rQQp7/FB
         zNbMvMCtSrQ4BI2+wVyxyVJpLnHwaOggesTSpmv91VbyBKl/3QClsKNdJQMRB8a4Lj7V
         94yhW4Qw9GXkH4ohHkS9SPSYa5u0ZZNzECPa168LWWCcoJQaYkNJ19Og4TJcCNHJVYhi
         WFWH8Jli2gxcbhmBhqyZu5ubNxcepHdAihlU9gGzpOPKRSHblB7vX1kRJa7pHumYcvWB
         eUAprfAY0m/amTkX0tFz7c/Ct5QRPNr9gl8qMdbkVRcNMw4oAByOSbBJZf1cFlpzCDWw
         yC/A==
X-Gm-Message-State: APzg51C9tI5X6HwThd50qZj3cV5y1cdnEAhGlTziWJfcw/0qix+re+2R
        xVrq6iIyaUY96cyVfg3HDA0fPtag
X-Google-Smtp-Source: ANB0VdYb7EERzculYDQ70u1xEWap+boWT3INMkC9+0LsRr4BxCG7ZHS4ew4dW93diMNy9Wfe6+cIcA==
X-Received: by 2002:a63:b507:: with SMTP id y7-v6mr18463434pge.425.1536508321679;
        Sun, 09 Sep 2018 08:52:01 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id f87-v6sm36785090pfh.168.2018.09.09.08.51.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Sep 2018 08:52:00 -0700 (PDT)
Subject: Re: [PATCH 3.18 00/29] 3.18.122-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20180907210909.523240901@linuxfoundation.org>
 <e0e9b658-d740-3306-0da6-25200c0ce0dd@roeck-us.net>
 <20180909092854.GA7927@kroah.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <86531e99-3a54-6485-488e-183bb46e4dbd@roeck-us.net>
Date:   Sun, 9 Sep 2018 08:51:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180909092854.GA7927@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/09/2018 02:28 AM, Greg Kroah-Hartman wrote:
> On Sat, Sep 08, 2018 at 02:12:54PM -0700, Guenter Roeck wrote:
>> On 09/07/2018 02:10 PM, Greg Kroah-Hartman wrote:
>>> This is the start of the stable review cycle for the 3.18.122 release.
>>> There are 29 patches in this series, all will be posted as a response
>>> to this one.  If anyone has any issues with these being applied, please
>>> let me know.
>>>
>>> Responses should be made by Sun Sep  9 21:08:52 UTC 2018.
>>> Anything received after that time might be too late.
>>>
>>
>> Build results:
>> 	total: 139 pass: 138 fail: 1
>> Failed builds:
>> 	powerpc:allmodconfig
>> Qemu test results:
>> 	total: 217 pass: 217 fail: 0
>>
>> Details are available at https://kerneltests.org/builders/.
> 
> Pushed out a -rc2 with this fixed up.
> 

For v3.18.121-30-g60d7419e2ba3:

Build results:
	total: 139 pass: 139 fail: 0
Qemu test results:
	total: 217 pass: 217 fail: 0

Guenter
