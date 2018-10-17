Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D918BECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 13:19:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91F7121523
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 13:19:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dnIK+OnT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91F7121523
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727528AbeJQVOv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 17:14:51 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38191 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727053AbeJQVOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 17:14:50 -0400
Received: by mail-pf1-f193.google.com with SMTP id f29-v6so13206750pff.5;
        Wed, 17 Oct 2018 06:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Bjy6s2LGi2nm5HfiIbHPY7Jfo/tDkJyaFR2IP6KBeM4=;
        b=dnIK+OnTzq03otN2GILcXoDM1XHnsr3OmoJVKZS6m8BGYtbF0C2R8LVIZhAG6+JJHL
         YPWDz2u26I8ovAGmUWNsr1NRm1k4dAQQW1vOCJeV3M/UwVK3IfSdXcs8BfaiV1P9wK1/
         wPiuDIm14ztuX0YLYSBERq2kD9zebnLK5X9huuBybu5maa79h/cTRZqLC/2nVsNdTz8C
         x7YyKJd+KsssWbnEAukz874IiLX2AIgubCVOHZa2Z0hYiPNRLOD4YftK/tYjA/n2BDin
         BjY8m9zi57Vh3zLAufHW/hogQA5TYS6KTbQMMIFl1BZA8DIUgQedsubqnKOpr+waDHPx
         N55A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Bjy6s2LGi2nm5HfiIbHPY7Jfo/tDkJyaFR2IP6KBeM4=;
        b=O/zro2ShNU6Nl7SiDPx9qctbh7IfUaj/oh/cNiwWsvbflDOe9PaT14xRjmOal5Mncg
         zb9QiYX9UMqqt96V9HvWCqN9BcSpxuf4sP3kNTdOPC1odiGgCTIsM2x3hkuPXKq0Nm3H
         x3b+Y6t3tkAgFauZ6zBSGYfqMREr6/Tx2wumU9zBkHAza0D811cJvrvydFx/HJJJrIX/
         LbAyzW33Syg9yZGNY/uOVrxqQJ+rwkroqFDFEztLt7DcAGAcV1GoRe72y+3S7nt7VCa/
         tSP/BNDD4EN6OTVgLxi9EIvbUSNI3OJXGSd6cGUIIudrdnce1CoHYGh2QsnVGJepPZ5T
         N80g==
X-Gm-Message-State: ABuFfogAb0Gea+R/uqrxdxjeXVVloUlZWR7i3ScnLn/BF2ThztP2VU2R
        HZu48++TJ1uNuUlcL+Ne/HoMF3pE
X-Google-Smtp-Source: ACcGV63TSn+plbQUiWy3KD6smEbaG8JYfeVPs411UUWwKV59kcHIF7r3gI94BHRyUUG39ceRfRg6bQ==
X-Received: by 2002:a63:1752:: with SMTP id 18-v6mr24896930pgx.131.1539782349898;
        Wed, 17 Oct 2018 06:19:09 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id y144-v6sm26764944pfb.81.2018.10.17.06.19.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Oct 2018 06:19:08 -0700 (PDT)
Subject: Re: [PATCH 4.9 00/71] 4.9.134-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20181016170539.315587743@linuxfoundation.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <86b6aaf4-d78e-338d-22a1-e5e377e637b1@roeck-us.net>
Date:   Wed, 17 Oct 2018 06:19:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181016170539.315587743@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/16/2018 10:08 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.134 release.
> There are 71 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu Oct 18 17:05:18 UTC 2018.
> Anything received after that time might be too late.
> 

Boot tests are still going on, but:

powerpc:defconfig (and others):

arch/powerpc/include/asm/book3s/64/pgtable.h: In function 'pte_modify':
arch/powerpc/include/asm/book3s/64/pgtable.h:74:24: error: '_PAGE_DEVMAP' undeclared

Introduced by commit 4091b46b1dfe ("mm: Preserve _PAGE_DEVMAP across mprotect() calls")
which fixes ebd31197931d for ppc64 which is not in v4.9.y. Unfortunately it also fixes
69660fd797c3 ("x86, mm: introduce _PAGE_DEVMAP") which _is_ in the branch. ebd31197931d
doesn't apply cleanly, so either someone needs to backport it, or the ppc changes need
to be dropped from 4091b46b1dfe.


Excellent example why it isn't a good idea to fix two commits with one.

Guenter
