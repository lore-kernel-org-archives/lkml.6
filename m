Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7236C46460
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 13:16:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A6E6215A5
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 13:16:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CDJhGO1+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A6E6215A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729390AbeHOQIY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 12:08:24 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41417 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728885AbeHOQIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 12:08:24 -0400
Received: by mail-pg1-f193.google.com with SMTP id z8-v6so505365pgu.8;
        Wed, 15 Aug 2018 06:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LXK5YK6Tk55EFmQJGRJWrUnMiLJzi0ttEiUtC764ChE=;
        b=CDJhGO1+wcu0BFgp6379C11FGtXp9Nf1nyrwKvyc4fPiIqs3kuH1qK73yQeyY7bsx0
         xbDZvUtvcu1wzDdvhIN+OMlRoe+mO+2yeocHubd+ptZoPP3C5RkMVyog89f/oB8CjV4q
         83J07A4J+/ky6mwZBRIzazYzUnuhzOnfBD68wKRL34og3l5EW3v1vkgkJ35MBGvopsxm
         n8Ut9WEQlMlLAOtVqxV1jwVLM+5W9AIZBLmgnsA1eIEWlqUKUSIpraHgqvC2TmGOYF3O
         APdrouVRvJNisFHZohsCX78K8eViGSPP2vT8gExI5wmQZekTiFMNah0JjkpI0imPR5kg
         34ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LXK5YK6Tk55EFmQJGRJWrUnMiLJzi0ttEiUtC764ChE=;
        b=uW6gfdpEB4p8ezwdhbpld2bC5s+1g7RNstmccRPtYUjlKcBqmzhzbQ4vyz7D7VTFkw
         i4zrHApmcMitSb/nrsde06iiAAu70BFh+popryd2ruvBYKB53YXDYovIu3FWZJdqDScp
         Dge75T+PgTwzTbeKBdxoySCyCRR8BYu/3QgHLWgW7/bFgTA2EnUM8Mt2sPXrt99MoUEU
         BVfPOyySs8sfXbuM3h+EHbpQIj4OIqOv5S9RWjiSpoNWB6bMyaxaFVv2zjRR+n8bWnyG
         Yh+Iv7Wu7a+dzMCpEzrs2JaLxRLBj7G7euhx8BSdFagQj8KF269Ig1YIU8SAIeg0Pv/D
         tSyQ==
X-Gm-Message-State: AOUpUlF/NyFoc6I1dyjr72U+06DPQk+RECfVXLg189jxW7Jjnul3SCey
        A+hS1KF9HZismJEPzqKI47mlrbaQdbI=
X-Google-Smtp-Source: AA+uWPw6yiBcMYuBmFMqf/npiwsaM4BPH8T534amliusXsjOB1ey0mwKNAJqC3bs6XbXB9c+MJGaQg==
X-Received: by 2002:a63:f80a:: with SMTP id n10-v6mr10016034pgh.82.1534338976199;
        Wed, 15 Aug 2018 06:16:16 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id r19-v6sm41618655pgo.68.2018.08.15.06.16.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Aug 2018 06:16:15 -0700 (PDT)
Subject: Re: [PATCH 4.18 00/79] 4.18.1-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20180814171336.799314117@linuxfoundation.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <43f1c290-ffbf-eed7-cabc-e860ebc30c2b@roeck-us.net>
Date:   Wed, 15 Aug 2018 06:16:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180814171336.799314117@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/14/2018 10:16 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.18.1 release.
> There are 79 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu Aug 16 17:13:16 UTC 2018.
> Anything received after that time might be too late.
> 

For v4.18-83-g8105f76:

Build results:
	total: 134 pass: 134 fail: 0
Qemu test results:
	total: 302 pass: 302 fail: 0

Details are available at http://kerneltests.org/builders/.

Guenter
