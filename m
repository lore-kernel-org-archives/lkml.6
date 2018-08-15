Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97B04C46460
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 12:20:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C007215E5
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 12:20:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZEdaKqVQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C007215E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729154AbeHOPM3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 11:12:29 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33639 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728668AbeHOPM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 11:12:28 -0400
Received: by mail-pg1-f195.google.com with SMTP id r5-v6so470397pgv.0;
        Wed, 15 Aug 2018 05:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xpeY99pHTbsN7FbgeDW9L+bn6lb9K93r6xKdWXKXdxI=;
        b=ZEdaKqVQnDhdhsiDodFCV9WmeKOgphLyC23C8CmwnFo2QN5yxF+2TkSp/dW4ZYy0lU
         OdArRcjSEGzrDlxezyGxEm8f1b9XOTUpuyqt90kUKTdI+2rL7CgrSFUbsjCkREqdkS3m
         Zo6bw06skY/z93zRuUdY2BFO8RV1vbe93ikb4KZuFyYrd7YWT2lw3YXq1kflHmJPAIbf
         2jOIpYp7TXm9yGctZvmYetFWC2+cVRv4QrsG2DZ++onovaWjm7OHMLVh697snEWtCRxm
         EPJ3CUHQrjldfaU9fbLak/2qQ6CMUsh6HqW3om7IPtfcxzHkFgREK8Favcxf1eJaLFJU
         L6/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xpeY99pHTbsN7FbgeDW9L+bn6lb9K93r6xKdWXKXdxI=;
        b=N1txc7cjhxidGYk+WyESfx++HkZDJhtYn0SGGGKvAjmXx0Z2ESuUBQfqjX7JxPaRTf
         WISM9im7GdKlMtzm1Hcaszp4cXL3SIZ+TNot0/00rQNCRTqIBR9rr1GWLwChDiGiq1jf
         +QJ6BIu2STCtq9AKhAV401nJ0ch6lZ9G7Bt+x8ydTzauBHRhnceYbDu5NWGKT6QQMJQE
         yBDd9sU/QNJe68dyvbJQZk4dfAY9jCP/SrcM7xqn+2BU/uX3/Dv1DnZ8qPkiCDcb6k3T
         wSkUCbqLTy6NaYHBIWb/uIx5JPjW+E53/oo0CP/mX0f2TNWHGGGEJID6DdvXCO6a8lFg
         2hbQ==
X-Gm-Message-State: AOUpUlE/gl1StrtzuDXHc6IkfXDGA6140BMqKHtOrkQQ39r7mCVpuX1T
        xcIXAPfkuklVMgldoMSKJmL1kHaQ
X-Google-Smtp-Source: AA+uWPwTOdjMIVWwYSaJYexUW0YPqukJslq3kh3EBE7ODXAmPaTy9DQABbWQmsSuUamab5oXZ4Qz+Q==
X-Received: by 2002:a62:3545:: with SMTP id c66-v6mr27657016pfa.63.1534335630865;
        Wed, 15 Aug 2018 05:20:30 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id j5-v6sm26256192pff.139.2018.08.15.05.20.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Aug 2018 05:20:29 -0700 (PDT)
Subject: Re: [PATCH 4.9 000/107] 4.9.120-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20180814171520.883143803@linuxfoundation.org>
 <20180815061445.GC1253@kroah.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <a8508ac4-b01d-e804-09f2-2e9311e7aecc@roeck-us.net>
Date:   Wed, 15 Aug 2018 05:20:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180815061445.GC1253@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/14/2018 11:14 PM, Greg Kroah-Hartman wrote:
> On Tue, Aug 14, 2018 at 07:16:23PM +0200, Greg Kroah-Hartman wrote:
>> This is the start of the stable review cycle for the 4.9.120 release.
>> There are 107 patches in this series, all will be posted as a response
>> to this one.  If anyone has any issues with these being applied, please
>> let me know.
>>
>> Responses should be made by Thu Aug 16 17:14:53 UTC 2018.
>> Anything received after that time might be too late.
>>
>> The whole patch series can be found in one patch at:
>> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.120-rc1.gz
> 
> -rc2 is now out:
>   	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.120-rc2.gz
> 

Heads up: We'll need (at least) one more fix for v4.{9,14,17}. I'll send out backports
after testing.

Guenter
