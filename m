Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FE14ECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 20:54:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 322F62085B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 20:54:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b="mo0sRFPU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 322F62085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=natalenko.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727583AbeJ0Fcr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 01:32:47 -0400
Received: from vulcan.natalenko.name ([104.207.131.136]:22044 "EHLO
        vulcan.natalenko.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbeJ0Fcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 01:32:47 -0400
Received: from mail.natalenko.name (vulcan.natalenko.name [IPv6:fe80::5400:ff:fe0c:dfa0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id 69EDF449E4E;
        Fri, 26 Oct 2018 22:54:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1540587252;
        h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nxKP2yy80pLLKN0UhMo8eYvITXuQ9Ei8lovdPIf+YZc=;
        b=mo0sRFPUNuFD1Je+aLV1VUZBwi4Fl6ar4R2WoIao80ZkflLU3JLQeIHpa8TO+Xh7acPjdG
        p3D/TAp0uwdAfMWo28ypCuOIhccatEyWOcufdCqWKYA/zlGjudeGOxzy8QgNVhd7UF+Obl
        vpGQKBjeP+aW4JAlBmCNqWSmzltqSaY=
DMARC-Filter: OpenDMARC Filter v1.3.2 vulcan.natalenko.name 69EDF449E4E
Authentication-Results: vulcan.natalenko.name; dmarc=fail (p=none dis=none) header.from=natalenko.name
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 26 Oct 2018 22:54:12 +0200
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     Dave Taht <dave.taht@gmail.com>
Cc:     hkallweit1@gmail.com,
        =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
        "David S. Miller" <davem@davemloft.net>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        =?UTF-8?Q?Ji?= =?UTF-8?Q?=C5=99=C3=AD_P=C3=ADrko?= 
        <jiri@resnulli.us>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: CAKE and r8169 cause panic on upload in v4.19
In-Reply-To: <CAA93jw7xoaokrN4oGAyqh6JHAn8nJpUpp_wj-iy+GWNoV-ipNA@mail.gmail.com>
References: <61d09f0db41f269cc9ee13dd68a5c285@natalenko.name>
 <fbd7f0b8-10c8-be17-fce6-327a95d8ea2e@gmail.com>
 <CAA93jw7xoaokrN4oGAyqh6JHAn8nJpUpp_wj-iy+GWNoV-ipNA@mail.gmail.com>
Message-ID: <b80e6819da8ea74f18b6ec0aaf9128fa@natalenko.name>
X-Sender: oleksandr@natalenko.name
User-Agent: Roundcube Webmail/1.3.7
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=arc-20170712; t=1540587252;
        h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nxKP2yy80pLLKN0UhMo8eYvITXuQ9Ei8lovdPIf+YZc=;
        b=UDFQDONIOQQPCqMZVjNPgVkdnZeNVMnDjbCXCiBEPUocTRzl9SPuVg2p65CY5hs4J4Imfe
        uYxRHGBPPSFquVYnHkcpcryelmHkwnmWdJ9vb3/UBDaxfwZ9DGpypdPrSLjk6rXN/vTpoy
        a70hEGJWUiEhwLebfWgIBkvZm/3UPIg=
ARC-Seal: i=1; s=arc-20170712; d=natalenko.name; t=1540587252; a=rsa-sha256;
        cv=none;
        b=KaMfgcuDPmj99bc6cODKJBoed4CuWjnlGEcX4Twf5Hi3auypwyqefqFfymLVgKt66I33c/CDo5+B/YjL9PmB/LYAKIGFTWewDAnCupjSXUlpKMS9oTGQ30ofxJb1ysigRTYi5TRf2EbiJvKPD3N8dmZvpR5e2Htu3NPxy0hbcuA=
ARC-Authentication-Results: i=1;
        vulcan.natalenko.name;
        auth=pass smtp.auth=oleksandr@natalenko.name smtp.mailfrom=oleksandr@natalenko.name
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On 26.10.2018 22:25, Dave Taht wrote:
> Can you repeat your test, disabling gro splitting in cake?
> 
> the option is "no-split-gso"

Still panics. Takes a couple of rounds, but panics.

Moreover, I've stressed my HTB setup like this too for a longer time, 
and it panics as well. So, at least, now I have a proof this is not a 
CAKE-specific thing.

Also, I've stressed it even with noqueue, and the panic is still there. 
So, this thing is not even sch-specific.

Next, I've seen GRO bits in the call trace and decided to disable GRO on 
this NIC. So far, I cannot trigger a panic with GRO disabled even after 
20 rounds of speedtest.

So, must be some generic thing indeed.

-- 
   Oleksandr Natalenko (post-factum)
