Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D7D5C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B83732133F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:54:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="C+lWUgz1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B83732133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lca.pw
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729843AbeLNMyT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:54:19 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:38712 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbeLNMyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:54:19 -0500
Received: by mail-qt1-f196.google.com with SMTP id p17so6002695qtl.5
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 04:54:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IDIsjugZ0+zssGZiEzloM69Wr9ndBpcxgmyaXzGXaYU=;
        b=C+lWUgz1Qa2uLWK7CBUlqEANjVXgXT5vc2wsszMWa1T9mhk+HTvHFt3ABke/BR1gSO
         v532aIQ3/JWAylTyaccSRKGIwl3+AfzJxTylrT58DpohjwNjzK3dFOkKWt2cxMQiXqgC
         Qx3Y2alogh8ipu+gFHQg0dUUEMViRGo/744TtTFK17fp18eu9tizePWXXBsUttijmLZH
         66PEPwI0efiZRT+SKVJR4X0lqvK5daG2XB0RNYT4hQF4ea2GZ+hXj7WfAD2jO5jaxUkf
         Sc9Gv/s10onufDcYJvJ18Twi/+PbnPvKIlx9pp2CvpzgITN/AMB1EURnGqRkipbsMV+m
         R2zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IDIsjugZ0+zssGZiEzloM69Wr9ndBpcxgmyaXzGXaYU=;
        b=Ys5a/R9fY0V+2CygJ2bkYixoyyldv2lCW4bAocodpH7Hfh6SJZ/91hsYBDKQmLvRkf
         sXBwMumZBsjNvrpxT8/1WDmEpgUKS93UJGsdBOecwdeZcaeh2dmoK3cRxdvFCYs+zh05
         KbZJMEzj4joEd3WfHMwsUHtdBugoyWnWf3fC01qKM6N4242L9EHj1hgi8dA94kEIh0x+
         1U1WmAYiAcAf7n/IpN0S4GaH2YPHSvJ5A0U7bGGVit0yVXZtnk24xW/IFowwB3qlfT6O
         xIkRQHYHx4vO3dGLLlb51+6ZLiQjSoPNBrlTglvcr/8zMQPfok83GMuCa7AGqntXZ329
         bZXQ==
X-Gm-Message-State: AA+aEWbx3hrcPPp6NkKw6zi92dXWTeKmakc86MrMyTR+xKCzihmw0qLQ
        l5eYOpFAEeJg11YibqEHeeMemQ==
X-Google-Smtp-Source: AFSGD/U0s2exQhAvJ4ZK6CQBRYoy9LXBMxPBiztLWItKxcGZeWpRCcq0okgWxI/AN/k5W6XnLZnqVg==
X-Received: by 2002:aed:358b:: with SMTP id c11mr2458884qte.155.1544792057645;
        Fri, 14 Dec 2018 04:54:17 -0800 (PST)
Received: from ovpn-121-90.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id t43sm3846017qtc.53.2018.12.14.04.54.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Dec 2018 04:54:17 -0800 (PST)
Subject: Re: [PATCH v2] arm64: invalidate TLB just before turning MMU on
To:     Bhupesh Sharma <bhsharma@redhat.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        kexec mailing list <kexec@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        James Morse <james.morse@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
References: <20181213052259.56352-1-cai@lca.pw>
 <20181214040819.58625-1-cai@lca.pw>
 <CACi5LpNQ1WGE54uv35OwNmJkKR_xnqTNqFK+R9oFBVkb683z_Q@mail.gmail.com>
From:   Qian Cai <cai@lca.pw>
Message-ID: <fad4c4e5-73e3-c264-511b-f4f28b7e16f3@lca.pw>
Date:   Fri, 14 Dec 2018 07:54:14 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <CACi5LpNQ1WGE54uv35OwNmJkKR_xnqTNqFK+R9oFBVkb683z_Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/14/18 12:01 AM, Bhupesh Sharma wrote:
> Not sure why I can't reproduce on my HPE Apollo machine, so a couple
> of questions:
> 1. How many CPUs do you enable in the kdump kernel - do you pass
> 'nr_cpus=1' to the kdump kernel to limit the maximum number of cores
> to 1 in the kdump kernel?

Yes

> 2. Which firmware version do you use on your board?

Handle 0x0000, DMI type 0, 26 bytes
BIOS Information
        Vendor: American Megatrends Inc.
        Version: L50_5.13_1.0.6
        Release Date: 07/10/2018
        Address: 0xF0000
        Runtime Size: 64 kB
        ROM Size: 64 MB
        Characteristics:
                PCI is supported
                BIOS is upgradeable
                BIOS shadowing is allowed
                Boot from CD is supported
                Selectable boot is supported
                BIOS ROM is socketed
                ACPI is supported
                BIOS boot specification is supported
                Targeted content distribution is supported
                UEFI is supported
        BIOS Revision: 6.3
