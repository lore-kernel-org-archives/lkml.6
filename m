Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3AC6ECDFBB
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 13:38:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AD7F20856
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 13:38:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JQHCY0Tj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AD7F20856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbeGUObh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 10:31:37 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34202 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727518AbeGUObg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 10:31:36 -0400
Received: by mail-pg1-f194.google.com with SMTP id y5-v6so9083833pgv.1;
        Sat, 21 Jul 2018 06:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1YSsi5a62d+GfJ52+US677OjhRU1dFR9Q4ajtuZOFXI=;
        b=JQHCY0TjFRhBggHJbm4RJM/Rvp5FsNCPxIP7khRCneHvAtOvpPoVSe3WjxmRhIYSW3
         wXfSajmaIuzebTSV+L38DGZF36XhcriOobTx2beMPxmHOnwH0M72I4UNepwqmFmFwps+
         swLEjAr49fB6DUOMBaDK/Yb0V0RWi9IgtpIgzQ/BXewrnMOHADkffXBRm4EHdx/rBvN+
         Yqsp96qsHrCbXpJCsQ07TwW1J7nITs0e++OIMV2sJQg0ap/kKTkLFjZo/VeqUto8D+99
         cxcu1zdFyjwfEBOc4yzdntFiKG1UnbE05aSfTjM+63I/vQimTFXhq2KMnfYbdZRcJzF/
         kodg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1YSsi5a62d+GfJ52+US677OjhRU1dFR9Q4ajtuZOFXI=;
        b=ESLqHvjuOzElbw5HBJu/DDbz/YvxY0jMNEKRkm4Ic/zqDmS5N8Y7PvI2fqvKSGuyEg
         D0/6lXCgfoyH43zX8q7Q0/dFDRs5w5PPscBvqLLHm9z62HrRIuWWBP3bE1yTYeFNf4hO
         39AyvqzWNPQgqMZAgoGtmOw5tEwhEIVGhrFAoKN/fzDW99zu8XXt2NfkPFsgcqKQv+V6
         JlbFOyQ05b+ASY/XKv7hFUEEl4sg1qNwZ8Bmf5+NV3mYyyWCWlG1KR+sYD9bm40ISrQZ
         CWVBL12Dr0pIgfwseBCQQCVe8fjRhI1hu+RayfK7mlqDY37yxBT8ViCOr5lkmRHNM+rD
         ZOsA==
X-Gm-Message-State: AOUpUlGNWfQpE60EqgrJwbpfYUn9ccjGIV90j6Bzk9XKCfDCwiVL8AoJ
        UGuAObnbBQ9htYDAfVBv+UmLuzZP
X-Google-Smtp-Source: AAOMgpdfLpM/y9hvvIHfB9Ut5cxbkcc37bfVo80hXtkjv8L6qxzRGdLLB2Jmt54DIPQCAyXzNZK93A==
X-Received: by 2002:a62:9c17:: with SMTP id f23-v6mr6110283pfe.209.1532180328236;
        Sat, 21 Jul 2018 06:38:48 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id u185-v6sm6676382pfu.134.2018.07.21.06.38.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 06:38:47 -0700 (PDT)
Subject: Re: [PATCH 3.18 00/29] 3.18.116-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20180720115158.974693829@linuxfoundation.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <6151f47d-c0d5-c4e3-ce97-5f11e196e5a6@roeck-us.net>
Date:   Sat, 21 Jul 2018 06:38:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180720115158.974693829@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/20/2018 05:10 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 3.18.116 release.
> There are 29 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun Jul 22 11:51:47 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 138 pass: 138 fail: 0
Qemu test results:
	total: 132 pass: 132 fail: 0

Details are available at http://kerneltests.org/builders/.

Guenter
