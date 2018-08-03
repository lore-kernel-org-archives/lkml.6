Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84E94C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 17:32:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BB6021784
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 17:32:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="t0cSkKir"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BB6021784
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729842AbeHCT33 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 15:29:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:37078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728116AbeHCT33 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 15:29:29 -0400
Received: from [192.168.0.112] (cpe-174-109-247-98.nc.res.rr.com [174.109.247.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB18021779;
        Fri,  3 Aug 2018 17:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533317533;
        bh=ujwSJ393ced9oY/Tny1p3Cq/bVK556N+V1gLDypXL4E=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=t0cSkKirqGbnEizW5/X9rBgVKxZvo9BougT8u234YNNFpyFhbrm9kBPUjAbux+Lf6
         G5nBgs8Sn9R0Xw810g1qB+lMcCMyQ0Um0OinLZgsg8thvg5xNQeaeB9cF6pxGLwF63
         C76Q/tIQgEdjntUr0D7kAJAl4efbY2swJMr9lhe0=
Subject: Re: framebuffer corruption due to overlapping stp instructions on
 arm64
To:     Mikulas Patocka <mpatocka@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Matt Sealey <neko@bakuhatsu.net>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        libc-alpha@sourceware.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-pci@vger.kernel.org
References: <alpine.LRH.2.02.1808021242320.31834@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHCPf3tFGqkYEcWNN4LaWThw_rVqT316pzLv6T7RfxwO-eZ0EA@mail.gmail.com>
 <alpine.LRH.2.02.1808030212340.17672@file01.intranet.prod.int.rdu2.redhat.com>
 <CAKv+Gu8DeuksZhk1g3q_msSKV_hSY_2e1uzVten9-oGO3j9Sqg@mail.gmail.com>
 <20180803094129.GB17798@arm.com>
 <alpine.LRH.2.02.1808031235410.31584@file01.intranet.prod.int.rdu2.redhat.com>
From:   Sinan Kaya <okaya@kernel.org>
Message-ID: <f0ab7c55-c104-241e-99d1-8247b2c567d1@kernel.org>
Date:   Fri, 3 Aug 2018 13:32:10 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.02.1808031235410.31584@file01.intranet.prod.int.rdu2.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/3/2018 1:09 PM, Mikulas Patocka wrote:
>>> Most accelerated graphics drivers rely heavily on the ability to map
>>> the VRAM normal-non-cacheable (ioremap_wc, basically), and treat it as
>>> ordinary memory.
>> Yeah, I'd expect framebuffers to be mapped as normal NC. That should be
>> fine for prefetchable BARs, no?
>>
>> Will
> So - why does it corrupt data then? I've created this program that
> reproduces the data corruption quicky. If I run it on /dev/fb0, I get an
> instant failure. Sometimes a few bytes are not written, sometimes a few
> bytes are written with a value that should be 16 bytes apart.
> 
> I tried to run it on system RAM mapped with the NC attribute and I didn't
> get any corruption - that suggests the the bug may be in the PCIE
> subsystem.

Note that normal-NC gives you write combining whereas device
nGnRE doesn't have any write-combining support.
normal-NC is typically mapped to prefetchable BAR space where
write-combining is welcome.

It could be an issue on the SOC itself too. I suggest you contact your
board vendor.
