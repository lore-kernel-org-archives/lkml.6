Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52884C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 13:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC28B20827
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 13:50:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T/JLRYYa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC28B20827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727991AbeKIXa4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 18:30:56 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45337 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727793AbeKIXaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 18:30:55 -0500
Received: by mail-pf1-f194.google.com with SMTP id p17-v6so946771pfj.12;
        Fri, 09 Nov 2018 05:50:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BjK7PR5O39/BvvFoC8MLSk5lVwNceqZ0xl84trD3NMk=;
        b=T/JLRYYaoB6x/nVlB8hrhrJi5wuxl1Qn+Si9FD7rAcbx/46DpzJYNVLhZaEV6ktrv2
         FbWvNC6LWtUlzA+UDkFaJSs1RDrjm2ovfBlfy64DoSqKWHBVIF3ZpIGB9madIyuu/+m2
         xxAcvRfM9vVHWnL8IMOMnSvI+eP4F3L65ufPnkjrErGGrThLIDutVPXdIkRWKRHUUZSS
         F3osLLoI9JidLMBflBUl2zLy0cEHMrfR6nqkWnXf1IcMRL+z9/e/yWhQwO6tCBlaIbdy
         2J4tKVTb1SuHLOog5wCJ49ye3VYOwq/PDYy+ClnxEPzBkGch6pySTyiPAejtkqSDeBdv
         Rk9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BjK7PR5O39/BvvFoC8MLSk5lVwNceqZ0xl84trD3NMk=;
        b=B8FY8+IXzHW2Zl1bpnWBcw7vQHa8TEBssoMnva6YaHwka8G9Sqvw87wY0pD6RpbuCu
         t0DF1fHDOHGKrmt0eCfYo/60C/qu51/irD+Y3R7SRvYIw8/byMk8bUkIPYXbGUUYyBo8
         q9vox2GqBYXK9+3tR/f90wmxYLBYyqsT/FrzxYkVWK7WlZRPPaM46mf387r4Rk6w+RgU
         I/dEXz5XRS2W8461Sd92pFEalu+49GUOINRbawURf0ugNtHo0FpO6Nh36bg2nMwGxrcm
         IqSe9jciPZRVedJOv4vk1G9s8pMtHCRJz/iSUYAlSrs84I/TM/kbCcpr03ZdHze+wl42
         +1jA==
X-Gm-Message-State: AGRZ1gJ0R7KszRtG20kfXVjImEjvodLyG7OEpc65Ml1gkEP3YtMYetou
        Aqhv/DmQb3eIsigAKUzZ+X/FfDn7
X-Google-Smtp-Source: AJdET5cD8285k5TvjHmP+GjPInjXCiQC43YGcUsOrLFu/0DPzKf21EFpHNqsdJyoJ2bizNiQCdcb9g==
X-Received: by 2002:a62:8012:: with SMTP id j18-v6mr9006420pfd.202.1541771412178;
        Fri, 09 Nov 2018 05:50:12 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g190sm6802355pgc.28.2018.11.09.05.50.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 05:50:11 -0800 (PST)
Subject: Re: [PATCH 4.4 000/114] 4.4.163-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20181108215059.051093652@linuxfoundation.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <86d97b16-dbbc-27bd-ad7b-9a96210070a4@roeck-us.net>
Date:   Fri, 9 Nov 2018 05:50:09 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181108215059.051093652@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/8/18 1:50 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.163 release.
> There are 114 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat Nov 10 21:50:28 UTC 2018.
> Anything received after that time might be too late.
> 

Building i386:allnoconfig ... failed
--------------
Error log:
kernel/built-in.o: In function `cpu_startup_entry':
(.text+0x1a2e9): undefined reference to `cpuidle_devices'
make[1]: *** [vmlinux] Error 1
make: *** [sub-make] Error 2


Bisect results:

# bad: [70cfa9ca6595d3238b36b9f6b36cf6e18dfd2c3b] Linux 4.4.163-rc1
# good: [24c2342b8e51ab3185e68470709904150a1e3ee0] Linux 4.4.162
git bisect start 'HEAD' 'v4.4.162'
# good: [008f87b2e9c5db7dd3756832a9e449415d837c7d] ixgbe: fix RSS limit for X550
git bisect good 008f87b2e9c5db7dd3756832a9e449415d837c7d
# good: [5d92c564ec3dd9a5833974f3ce113cc7a94e0f6a] mtd: spi-nor: Add support for is25wp series chips
git bisect good 5d92c564ec3dd9a5833974f3ce113cc7a94e0f6a
# good: [71fba871e4a07400eb1400b1e6b45ca3a5487834] rtnetlink: Disallow FDB configuration for non-Ethernet device
git bisect good 71fba871e4a07400eb1400b1e6b45ca3a5487834
# good: [4d1024282b1259209bb4601f4b51dce367cf8a02] IB/ucm: Fix Spectre v1 vulnerability
git bisect good 4d1024282b1259209bb4601f4b51dce367cf8a02
# good: [fe9d47ae282ebd2bb10a36ec2bace1afd0ba050e] Input: elan_i2c - add ACPI ID for Lenovo IdeaPad 330-15IGM
git bisect good fe9d47ae282ebd2bb10a36ec2bace1afd0ba050e
# bad: [573e8431fe60169157440664f74c6af254b3b00e] x86/percpu: Fix this_cpu_read()
git bisect bad 573e8431fe60169157440664f74c6af254b3b00e
# good: [be0ac51f4181a18c458080d79919aeee17ce0c68] sched/fair: Fix throttle_list starvation with low CFS quota
git bisect good be0ac51f4181a18c458080d79919aeee17ce0c68
# first bad commit: [573e8431fe60169157440664f74c6af254b3b00e] x86/percpu: Fix this_cpu_read()

Full results will follow later, after builds are complete.

Guenter
