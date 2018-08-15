Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 367B8C46460
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 13:12:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEB14215A5
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 13:12:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dpZITfYs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEB14215A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729310AbeHOQFC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 12:05:02 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:39419 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728896AbeHOQFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 12:05:01 -0400
Received: by mail-pl0-f67.google.com with SMTP id w14-v6so456612plp.6;
        Wed, 15 Aug 2018 06:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Et73kfN+rWlhgb3GttKujzIbuyeaBNkRRw08BykVxIM=;
        b=dpZITfYslIyBb/ndy085UyFDq7TGxRNYAUSCFpX0M4BkvjnYamvdeGex8yJIXuLLKW
         dSeW24J2/smsnile5zttLR9XMS2g+J/wRBk1g/5mhmFjBf00zGca3I1XIDIH1WOfECud
         KLGYENJE1FeIVtjh08N0mbzhVBk4SlHeaGZ6pKV1XhwZAIA/j5fH6lDa7oVq7WlYnMo6
         +qjUx5t1GTUXfRoy8faORWgFfzn38w4ouao40SgHIABs6NOZkvrMty1c/kR4tIDlQ9Gc
         /YqKlLvFaaRUofiHllRIS7HA+v3dodaRJrVdEBWU60ohzchdsg+KLx9IH1+ieYvOKqC+
         hdEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Et73kfN+rWlhgb3GttKujzIbuyeaBNkRRw08BykVxIM=;
        b=ipJoIBpfZP4LHO26YpmOIYBGfxckSQAloqDQFmnP6x3E/S+iaRg7OK27FN5BDn4KYY
         tcmVBWRo1YAynq9wJLnIiiAC6rVeB3XZFH50ja9zW5u5PSfEfgNNEBJcZuLIFh4W8qGk
         meQCPAL2cJ5JzFVUD9BOqjMuFPWrZdPI0EeRnBP/ECqGihMrpciNbxTVoc3ueSCKELR8
         Ocn+51Cs91m/q/OLWxvGRcqcjFK+Xr06Jpu6dK6jnnvnY7qGhbuYTnNBTVlroASFqBp2
         ayw3983oxq4mDewJqG1cZm0RZO74M4OMhK3xtsSShKVps2JdMmzELJVYj58sJcIHycEs
         AOpA==
X-Gm-Message-State: AOUpUlF48nsz69VRNWfESaofmL/vtcbHyJ2eTcCB3MOj+wfv3q8rasZt
        r/XxlbODpn6WbXtdfLBh1ZNBh9/xY+o=
X-Google-Smtp-Source: AA+uWPxgeKC0bxtL1BUyRU4oDj6csQ+XBjZHKMIYlaxjroIzJ2MW6xHuJDK7KzyU4OEVXzLGHS1oVQ==
X-Received: by 2002:a17:902:123:: with SMTP id 32-v6mr23977547plb.181.1534338774570;
        Wed, 15 Aug 2018 06:12:54 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id x184-v6sm28580770pfd.169.2018.08.15.06.12.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Aug 2018 06:12:54 -0700 (PDT)
Subject: Re: [PATCH 4.9 000/107] 4.9.120-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20180814171520.883143803@linuxfoundation.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <10da4e27-a407-5e1b-5a67-5de854841463@roeck-us.net>
Date:   Wed, 15 Aug 2018 06:12:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180814171520.883143803@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/14/2018 10:16 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.120 release.
> There are 107 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu Aug 16 17:14:53 UTC 2018.
> Anything received after that time might be too late.
> 

For v4.9.119-112-g1a93cfe:

Build results:
	total: 148 pass: 146 fail: 2
Failed builds:
	i386:allnoconfig
	x86_64:allnoconfig
Qemu test results:
	total: 289 pass: 289 fail: 0

Details are available at http://kerneltests.org/builders/.

I'll send another report after the fix has been applied and tested.

Guenter
