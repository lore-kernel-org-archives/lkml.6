Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54C58C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 14:20:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E98820868
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 14:20:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nOqwGUi9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E98820868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbeLABaV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 20:30:21 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40496 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726489AbeLABaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 20:30:21 -0500
Received: by mail-pl1-f194.google.com with SMTP id u18so2879578plq.7;
        Fri, 30 Nov 2018 06:20:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9oxNtI/XqZntomgU2D7FhDJ5jw0eegFJ+kQ7TtHocgo=;
        b=nOqwGUi9rZSZrQay0B5Vsg4K09K0fQUwnmsRxmq+627/l8YV8oaxE80jbybmZ2Wv6B
         Hg2qI38SQXBQeMPSqlVpG8aTrxeW5UaDSZ8nWbPHwkfUdy4Pk0v8laFEe626rseuUX+M
         QWFm7REreiMyvuzWC4QJ5tTxFgnjFNNBpugTQkxQWXeiKuDzuTGgx4SlzaiD1DFfWv/n
         Cpqy6mWevJ7U0UQRKO/AwaYTT68dd1fZXaNqyW9hAAJjJ24kDwoEshmBQBl4kFTFxIqB
         4LiIPBxvasj6v5gWhbSm/d9/5qrwg76D6F8JasScKTj9CyRt0M3AXfSsKWKdkiaDFlBS
         h7/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9oxNtI/XqZntomgU2D7FhDJ5jw0eegFJ+kQ7TtHocgo=;
        b=WpPktNRWoFo0UyzGjEdZT7y12MarEeoT15s4nUi731z005pmLp1W7AKGjUOwy16Oku
         VsZ2fBnsVAVhg950ohK3cr4sCPvZu36gOqKFjdxif+Lu2r+R2CgA8VdmOgLkCrlZzy/h
         h5C5ocQ/+Oqm0WG7UX+zgTluNAUMyhPB1ON42MuaT2PcyHXKjTrdfV7UxnyAEzG5ubvZ
         llg8b+S8EPpo37uaij6RXq5c5wCKs4ih+HSy7pFerAY127CiftjF0qi6EIJ2JLbfiC2L
         bVxiJfi8Tfzb9pnGUsJBqvms7lSQjQ411MunvOij1PmlVk9rNiU/ZHIJB6s+CTV8Dg/w
         DWjQ==
X-Gm-Message-State: AA+aEWYafipWGOfLtgO/vYCzAH9xAujAAf/mTnfzeYid6ZduI9pjoRml
        +qrvGriOfOj4ezeLskR1BREQyX+h
X-Google-Smtp-Source: AFSGD/WYDAlhWU8Foty8qJPAL62Y/uq7gywWJ0tbSQVFCiVim2g91KUnkf4HkiwI5x39DEPI/HI48A==
X-Received: by 2002:a17:902:346:: with SMTP id 64mr6003073pld.337.1543587653047;
        Fri, 30 Nov 2018 06:20:53 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g2sm7255594pfi.95.2018.11.30.06.20.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Nov 2018 06:20:51 -0800 (PST)
Subject: Re: [PATCH 4.14 000/100] 4.14.85-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20181129140058.768942700@linuxfoundation.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <e5bf27b0-5611-e2ea-c8b1-d08f3910e9d5@roeck-us.net>
Date:   Fri, 30 Nov 2018 06:20:49 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181129140058.768942700@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/29/18 6:11 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.85 release.
> There are 100 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat Dec  1 14:00:29 UTC 2018.
> Anything received after that time might be too late.
> 

arm:allmodconfig, arm:exynos_defconfig

arch/arm/kernel/smp.c: In function 'secondary_biglittle_init':
arch/arm/kernel/smp.c:117:19: error: implicit declaration of function 'lookup_processor'; did you mean 'lookup_resource'?

Also affects v4.19.5-111-gac4af649901b.

Guenter
