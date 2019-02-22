Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6EA4C10F00
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 23:30:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7671020651
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 23:30:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EzoMNHLH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbfBVXaV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 18:30:21 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44718 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbfBVXaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 18:30:21 -0500
Received: by mail-pg1-f195.google.com with SMTP id j3so1768616pgm.11;
        Fri, 22 Feb 2019 15:30:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VRTT7uHRvIAPbDy5tXtKWWAf2Z//qPoldB7n/zg4DMA=;
        b=EzoMNHLH+WLUIaOQ5hW4MAzwwB370PLF9pyYOUDPLRpfTbgNobyQ22p1EetK2pC76f
         /T2W6NepXi6rEs7154Z+9kyHkW/p6xGmiqM4Sm2NaoE4fppbfrBFyi4YynypDgKjDZni
         7Tbg3KDQ4OXqnkLDhlUD3WpnrCzKocJ72ionIJmZapql3SgrlavDxKMTue2Jr7afi4nC
         QdH/ymcpkdK+2gD+pXMkw++U3lTKpLF8Hikdi/wO1jagGfUowWDJzfngVlAMhoghCAcj
         4lVVHv/P1aIV0jOJO/r+fswpBqbTU14hxo/iXZfnj+KaWxDCxbYY67+zP3VyYmMX2M7m
         rJug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=VRTT7uHRvIAPbDy5tXtKWWAf2Z//qPoldB7n/zg4DMA=;
        b=XSQbC55V9qmfk+ogzx1AZLT3N5gSBCPsXjUg+XBQC4LUZkRBTOWpQzPcRFcqKvBNOg
         cMJ5gCLvv2pk21dKUCnWPJn5gpSC6M8ozkmYGeuK3df89nrG9c5mcK68Ck7HtRN8Pmue
         afsiBSC6nnmGzzJN/cYuLBi83ciDLfDcgYnoGuYXYnI4QmcJ9aphABaKZgrgZJaeI5vU
         smb1x/sZLxdA83uhx8N2vR77mlkDZte0Fd3bgo67EjuhwkGlvDO5DGqaGtn6tYj3uQpv
         h+2a2F5ZefyFKSJATFa9IBiw5FgtjGzmkgd/bMVtDf0XMsJEFCwjfPYMLJNPUg6S1Sfw
         YBdw==
X-Gm-Message-State: AHQUAuYNxoAVEGNnqGchYHKnQBGXT+BEziAAL7AfjsKGc+kH305LPQ/P
        OQ00oyKGrFnFbMd1SnV5dZH1WH6p
X-Google-Smtp-Source: AHgI3IaTBWRdbMWkqY5EY0LxMVVufCcIQq2h8BYSmW1LhOniW0idaduHLZDq27pLYnHoXoMIUYy/Dg==
X-Received: by 2002:a63:6a47:: with SMTP id f68mr6305338pgc.82.1550878220350;
        Fri, 22 Feb 2019 15:30:20 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j4sm3541726pfn.132.2019.02.22.15.30.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 15:30:19 -0800 (PST)
Date:   Fri, 22 Feb 2019 15:30:17 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 3.18 00/13] 3.18.136-stable review
Message-ID: <20190222233017.GA25975@roeck-us.net>
References: <20190221125240.091472334@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190221125240.091472334@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 03:35:31PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 3.18.136 release.
> There are 13 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat Feb 23 12:52:12 UTC 2019.
> Anything received after that time might be too late.
> 
Build results:
	total: 155 pass: 155 fail: 0
Qemu test results:
	total: 226 pass: 226 fail: 0

Guenter
