Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46161C4321E
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 21:13:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F35DB206BB
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 21:13:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R0E5Ncrp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F35DB206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbeIICA4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 22:00:56 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36275 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727608AbeIICA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 22:00:56 -0400
Received: by mail-pf1-f195.google.com with SMTP id b11-v6so8612428pfo.3;
        Sat, 08 Sep 2018 14:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ncDnYUUN2hnsDBY/K198ddLUrCarUR9HaXTZR2o6zds=;
        b=R0E5Ncrpn/oaI4y7kQTNe9h+ToXrUbrvRSFnXoG9StUiqOF4fmYlgdpdb50jrZ+GyB
         dHgV280n3TXQQZsCK5r93Hd0LKyzZLGQTB6oICAFP0bRruHHPFn7VQyAHlnggKoEAD6Y
         xzNFvFwRVK8G/fmqsQ8dZzhpHQLMCIXBxGV9rW5m9k6K/p+CRh/mkz8oHFDeUIL4oddF
         weK916VaWBxbSMCFTxQAdcq5avrxxCpt4HxbBl0MwtmV5RlzCCsSFd+JhLfpQGpWo/NR
         UIRFwvmOwATk3i1tGlM2qjqaRD/mNamHIFe6VvnWm/lmX7W/lijdbChFod3BNNTtV3UA
         q9eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ncDnYUUN2hnsDBY/K198ddLUrCarUR9HaXTZR2o6zds=;
        b=CyPzuWNkw6l5RQ8rixvn3rqODr/6wVfpw7IHPm5gSh7UiG5aDxr+BtJg0Oqtr2oEXV
         FGoXkkcllEXa7AU9nZbI4wC+0gj3a9ynSzKNmLUtFDdVoWPAB0ntBDfTmIYUMxLHw0rb
         uHvJXfxnlrL8CTdpfyXscm1H/AI3BWdmPV6p/pzyacw2O2v+xdGq5srcXxNvS9iH44xd
         ryqyFyffDf+1JtibO8bii/ctrsCvzzoskeKt5H03LUHMrmA7YCIFF2+qra4FXetgU/N+
         8GMvSA6RbiSbOI53k8ub6KiLBRJlmldRSJJMnTVoPQSLvZmgfhTz+GcApz3ovOXU4jL2
         OrcQ==
X-Gm-Message-State: APzg51DLAia/a1kfSZMnBvmxcFZUNr/mSUKq3kodD1rvsy68XMR/k6d0
        Uc5oWm2HBkWvFr8933rZbfN9OqRg
X-Google-Smtp-Source: ANB0VdYrDtcC24zJ2ILmKAsl9bJNTkf1KSsg8eD00mJZZvXFhASVVDhbQNKJN1EN/LsYE0o4hbSFAQ==
X-Received: by 2002:a63:3741:: with SMTP id g1-v6mr15087562pgn.59.1536441229708;
        Sat, 08 Sep 2018 14:13:49 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id 186-v6sm5622554pgg.56.2018.09.08.14.13.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Sep 2018 14:13:49 -0700 (PDT)
Subject: Re: [PATCH 4.4 00/47] 4.4.155-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20180907210904.607934824@linuxfoundation.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <198bd18b-727d-ef9a-1553-8e2a99351f86@roeck-us.net>
Date:   Sat, 8 Sep 2018 14:13:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180907210904.607934824@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/07/2018 02:09 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.155 release.
> There are 47 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun Sep  9 21:08:44 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 151 pass: 150 fail: 1
Failed builds:
	powerpc:allmodconfig
Qemu test results:
	total: 281 pass: 281 fail: 0

Details are available at https://kerneltests.org/builders/.

Guenter
