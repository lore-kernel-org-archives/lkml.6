Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFF9DC4321E
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 14:02:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63ACE20844
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 14:02:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ly5vK3RC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63ACE20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbeIHSrz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 14:47:55 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36078 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbeIHSry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 14:47:54 -0400
Received: by mail-pl1-f193.google.com with SMTP id p5-v6so335187plk.3;
        Sat, 08 Sep 2018 07:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=huWQYU/mPdlGJyamLKoRE1tP3nNasH5F5LgqjENTVQc=;
        b=Ly5vK3RCHXz7dS9O51ZBjJDQH9anjoug++wUDkc2j43IzpxxKh9ilPFKvkXIB0PSqQ
         AyBib4Zm7ibYjmna5GXBmcZf9ADgzzRr8Msimos9qsM/+ufg3XO1/Zp0VyysJd1JbcxY
         zcgqDlhQtT5Ja2A2fxs4Bjtik0SvUFtBOgnBfKIg2GL5QAyvMc0OAdd63eypzzg/0BBa
         G8TWWorgyGXe8FLZh/H+KNiS8Zesvu9Tqu6glDwg0DyTBdvTnF6Vxld8W50oO8/ZF2b0
         y3Ky8Uu349a/PfHroUSBAFbpz4HuWqOGRvdg8FSletUcgFkBp5IgD+WY/lp9BomrEclA
         J62g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=huWQYU/mPdlGJyamLKoRE1tP3nNasH5F5LgqjENTVQc=;
        b=cc19DkF2FHhN2uKiqIzPTBYIphMvvrKmeQfp/qsHvt344Md9kHZJQgXxzGN9utGSO+
         VzsmwUw0MrtYv52Wn+kNVsWQILCEHqF/smNM+M1wRrxeUWg+81a8ZDv9dwkECTMvAV0a
         KQl15g3xzicfkCXTOnNpYCez7GrtQVAUzQjyH2yWsFpSeDfB5aX0btNHcF0ndpZyZEVa
         06SGUKzYHzBOhn8daSQa/D8DZe9J3MctKzcGTeRXKU5Z/jCyCNnQTusX42fajm78mlMN
         vGjOMEKw5vmW34A0k++OZADmQKroLGq+KX+6pHT2WWCRvn94duz6+OLzucR465bcXOca
         jIEQ==
X-Gm-Message-State: APzg51ARePSLV9kYf9mYRRWtRnLPPDsdobprsMeb1ya3cHYFBsGXOj0b
        dEnMoIH2ke9mdCaiSv1MAMBnG7Sm
X-Google-Smtp-Source: ANB0VdZuuqvOLtYedXiPf3KXgEJZ0dM9krXB/qRzwaI88FR92n7VYtd9Bk5thF2ugUWHQPv83ZTdaw==
X-Received: by 2002:a17:902:ab94:: with SMTP id f20-v6mr13114043plr.231.1536415320431;
        Sat, 08 Sep 2018 07:02:00 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id d6-v6sm22287104pgt.66.2018.09.08.07.01.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Sep 2018 07:01:59 -0700 (PDT)
Subject: Re: [PATCH 3.18 00/29] 3.18.122-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20180907210909.523240901@linuxfoundation.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <76192117-e7b6-fdad-c093-467d12c8a489@roeck-us.net>
Date:   Sat, 8 Sep 2018 07:01:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180907210909.523240901@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/07/2018 02:10 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 3.18.122 release.
> There are 29 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun Sep  9 21:08:52 UTC 2018.
> Anything received after that time might be too late.
> 

Affects at least 3.18, 4.4, 4.9:

Building powerpc:allmodconfig ... failed
--------------
Error log:
arch/powerpc/kernel/fadump.c: In function 'free_crash_memory_ranges':
arch/powerpc/kernel/fadump.c:733:2: error: implicit declaration of function 'kfree'

arch/powerpc/kernel/fadump.c: In function 'allocate_crash_memory_ranges':
arch/powerpc/kernel/fadump.c:752:2: error: implicit declaration of function 'krealloc'

Affects at least 4.9 (on top of the above):

Building powerpc:defconfig ... failed
Building powerpc:allmodconfig ... failed
--------------
arch/powerpc/platforms/powernv/pci-ioda.c: In function 'pnv_pci_enable_bridge':
arch/powerpc/platforms/powernv/pci-ioda.c:3145:4: error: implicit declaration of function 'pci_err'

4.14, 4,18 unknown.

Very preliminary; the builds will take a while to complete. My builders
are struggling with stability problems when running 4.18.6 kernels.

Guenter
