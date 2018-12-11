Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46BD3C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 17:38:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 100802086D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 17:38:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VeJhC8nh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 100802086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbeLKRiz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 12:38:55 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41820 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726851AbeLKRiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 12:38:55 -0500
Received: by mail-pg1-f194.google.com with SMTP id 70so6954598pgh.8;
        Tue, 11 Dec 2018 09:38:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Dbvfb/eyBRI9T4m2lHBX2h9a0hzwiR2pOyUhQ88MkL0=;
        b=VeJhC8nhWHazW7+gQUSmLP/nm7lQn4lXZHpi8O7eAfnYHXuqgJOONmw2jCaMMXmNJ+
         ycnz3Mjsf+sLsH5acOS8Zw0b2qJO6mPs5TCofU4iOzhjA4RA0qcGY1cp10vgpSAm2nvd
         Q523WYN0ea3GRI7L/HJPPw4ocpKC4LxZASOXQCe62dGl7w7LJw/fPAPtw9DU8X0vjzMz
         VUh9mf8hlRsTquaSZaJ1nmTyB09cQEZ91MUkaABpk6RQHct0TZoi8QqQVgTSQ+8B3wgv
         KPnQnlLde5DcnemmO3cRxK9sPxRwWzYYbgkQPym7MRG7/7x6Txikkz1D1iegJjHFo5ge
         Fkpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Dbvfb/eyBRI9T4m2lHBX2h9a0hzwiR2pOyUhQ88MkL0=;
        b=BRCBOiAR3/Yz70vXvQJaBNRqETdqI7libve0W+Y31nurMoaL/v/8MBbq+Pa9dRtUew
         fOOMcXxKvmuA9E3X0ffQAHCAs6eHwQdf9paFC37OewTMbbJfjueh8VpVwk8Bvp8CR1Vk
         6jqPHXj6Mgqf+6Spcq2TBrKy9LOkdrDL4gULRR6QI3ZiHui3KN5yx8x9zGOt6EMcBWf+
         lEEOc7euz8DRCbeM7MRB9AV2Lt8VyfcD4xBi4L0HJQYUXIN2wVTLKS4BJabQXN5dQQCk
         tVWFrgAK7AwpM8G1k8QKmipToakJ2deFWpDn24c1fRTt9z5NcJutDvQKSJPOwYbGbJgR
         GQvg==
X-Gm-Message-State: AA+aEWbUJ3cCfUJ0xqhx6XNNdG9MN6cvarqldAc3nO0GFzlZmo0iVeji
        AQ2gO2H7P5K4icNH4+6oMd/X6Isc
X-Google-Smtp-Source: AFSGD/UHmXA5KpczsjEJ2WdLHn1JV3BigshS20myJx+PG7IEePSoi+XtJUI7XcnzuaZZaIgrtw5TPw==
X-Received: by 2002:a63:1f4e:: with SMTP id q14mr14755919pgm.88.1544549934219;
        Tue, 11 Dec 2018 09:38:54 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n186sm21270696pfn.137.2018.12.11.09.38.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 09:38:52 -0800 (PST)
Date:   Tue, 11 Dec 2018 09:38:51 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Tree for Dec 11
Message-ID: <20181211173851.GA29028@roeck-us.net>
References: <20181211182627.42b79e40@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181211182627.42b79e40@canb.auug.org.au>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 06:26:27PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20181210:
> 
> The arm64 tree gained a conflict against Linus' tree.
> 
> The f2fs tree gained a conflict against the fscrypt tree.
> 
> The ubifs tree gained a conflict against the fscrypt tree.
> 
> The rdma tree still had its build failure so I used the version from
> next-20181203.
> 
> The tip tree gained a conflict against the hwmon-staging tree.
> 
> The gpio tree lost its build failure.
> 
> The akpm-current tree lost its build failure but gained conflist against
> the arm64 tree.
> 
> Non-merge commits (relative to Linus' tree): 7744
>  8462 files changed, 365061 insertions(+), 211977 deletions(-)
> 

Build results:
	total: 152 pass: 150 fail: 2
Failed builds: 
	arm:allmodconfig 
	arm64:allmodconfig 
Qemu test results:
	total: 337 pass: 137 fail: 200

Build failures:

arm:

In file included from drivers/media/pci/ddbridge/ddbridge.h:22:0,
                 from drivers/media/pci/ddbridge/ddbridge-ci.c:19:
arch/arm/include/asm/irq.h:35:50: error: unknown type name 'cpumask_t'

arm64:

arch/arm64/kernel/entry-ftrace.o:(_kprobe_blacklist+0x0): dangerous relocation:
	unsupported relocation

The latter is with gcc 7.3.0. I'll build and try with gcc 7.4.0 and
the most recent binutils later.

Most of the failing qemu tests fail with something like

Starting init: /sbin/init exists but couldn't execute it (error -95)

Others (such as aarch64) crash silently.

Has anyone reported this already, or do I need to run bisect ?

Guenter
