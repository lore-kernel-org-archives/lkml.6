Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0AB1C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 16:33:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D12320824
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 16:33:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nY1IC+dy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D12320824
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438169AbeKWDNc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 22:13:32 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40117 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395187AbeKWDNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 22:13:32 -0500
Received: by mail-pg1-f196.google.com with SMTP id z10so1938647pgp.7;
        Thu, 22 Nov 2018 08:33:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fgXpEMFhErw5nU42UM+AY5pVVMoOG+0uzA99UtLqiZM=;
        b=nY1IC+dylV4WEmtPtMx57cMjmwLbFtkgkAbZeFdz5P/mRUcCNmOh+ZnpJBdROpOfoM
         kgQ/IXP8MW2TydVHz1KlC0zGCfkiPUaF+NC9cavIXy9TMQhaKL1R9RjWMku2zVO6ZSOt
         AFPugzPBNvZ0IE7LrS/cBF0slkaJ7R7sNijJeAZ9GIewhF6CrbnoLCOf/MV3Mq2FYwVi
         rsggZED8m/auBxjwc8Ut8uM7mehtn2jdL2fFM4MlB8LHWxyJSx6eRVGO1xM2aAcyDnS9
         9sleVYx/uqHUJ+E/pIK+3cBONzJGuR364EY9pzWP0PrG2ZDt+r0M28JUy3rYwG2gCY72
         DLOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fgXpEMFhErw5nU42UM+AY5pVVMoOG+0uzA99UtLqiZM=;
        b=p1s6gkyRRp4ZpoUwa9OpyflOJNSRtTrb1eZbPoCSukAD31eOKrZpWuFRrhY9IkSGcp
         ycBJ/3iMcB1+xffBII+MBNGJHKG/Cz+qu+yzWvCsFK1bicLK+xJoYzosFuP4UPjhfijF
         LCSkD9wY31LaJcB6h66c3isHEPBIQiyigJEDxgVRdygUQVCbNsY+0tDKSGI5cmOmlYp9
         CRp65dKh9eQWZ1ROw2b63Yc7AhGmlt75dm2jThpqwAAfG/sQBT7jW2Vzyfu1SXxV/tEd
         cG9grkTxVRPNF6bdpyco54mNK+lqhJOFUTEmu0HcPU7oStcb6za8Hi08JL7jrKhkKWGr
         8//w==
X-Gm-Message-State: AA+aEWbfJtSrTxjjGCsD0q76wHLYz+KisqdiSYLWsdHMxwwPfixJXERM
        oHYMJLhervy4m5fecpGtsD4=
X-Google-Smtp-Source: AFSGD/VrbO8ejSD+1LPigcLYj33VwO3JKTxR1ELUrz/nRap98UshroZ/O6NwVjqbbM9vZZ2csilzVw==
X-Received: by 2002:a65:48c4:: with SMTP id o4mr10362209pgs.371.1542904405717;
        Thu, 22 Nov 2018 08:33:25 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 139sm48994963pfb.127.2018.11.22.08.33.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Nov 2018 08:33:24 -0800 (PST)
Subject: Re: [PATCH 4.9 00/59] 4.9.139-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org,
        Murilo Fossa Vicentini <muvic@linux.vnet.ibm.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
References: <20181121183508.262873520@linuxfoundation.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <b642656d-4b0d-cb68-f862-9d90bacc88cc@roeck-us.net>
Date:   Thu, 22 Nov 2018 08:33:23 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181121183508.262873520@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/21/18 11:06 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.139 release.
> There are 59 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri Nov 23 18:34:55 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 150 pass: 149 fail: 1
Failed builds:
	powerpc:allmodconfig
Qemu test results:
	total: 283 pass: 283 fail: 0

drivers/net/ethernet/ibm/ibmvnic.c: In function 'ibmvnic_xmit':
drivers/net/ethernet/ibm/ibmvnic.c:789:40: error: implicit declaration of function 'skb_vlan_tag_present'

Caused by 5f51bb855fa1 ("ibmvnic: fix accelerated VLAN handling").
Problem is missing include of linux/if_vlan.h, which was added upstream
with commit 6052d5e2a1961b ("ibmvnic: Insert header on VLAN tagged
received frame").

I have no idea if the offending patch fixes 6052d5e2a1961b, if both are
independent, if both are needed, or if none is needed.
Copying the authors of both patches.

Guenter
