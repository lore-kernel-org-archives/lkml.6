Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD743C67839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 22:37:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D72B20672
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 22:37:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dLHDEH97"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D72B20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbeLKWhi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 17:37:38 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35616 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbeLKWhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 17:37:37 -0500
Received: by mail-pf1-f196.google.com with SMTP id z9so7835107pfi.2;
        Tue, 11 Dec 2018 14:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vHrNXJDpHuFpC33K4F1WkbPjFb7DpEgc/vW/cic0BDY=;
        b=dLHDEH97E47Y6QfXCfOY3O8SzvPigRfn7x4oR0P5ZV4kN+4XS5fBPeuXrekkc3B6hz
         sY7vVK4tDLQjlCHV5g9WhK2/31VZZCy+abaRMIYJ8+nmhalfg9imsFF/hjf1TQovS0Iz
         bWWX3PVI6k8mOCF+aSSYytTwxVHXDk04T5GrXzY7L0BuWE/um7z8CbbpFj/RooSyAQEB
         siVRY0MQmqlw8GlComrmDK53l8f3dxhMIuSr0njxgkh43dw6cF7PPK5G+F2dyRb5dz7s
         IRWGLgeLoXa0gSFvBhk3vWugpma33zLiXjsEUxggbAytM8Gf2CSVoqS645hd7e6zEmTr
         C0OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=vHrNXJDpHuFpC33K4F1WkbPjFb7DpEgc/vW/cic0BDY=;
        b=ADBqK/j0JWLFR0smGhaKfcppLFRJeuiStkSYIMiZxmKXq0qAYUvwl9m/t4iQAF0xxE
         rmlgz0hvzaxTx//o+PjHuLM1m02echS7KIXa38AmXjxiqCiv5dTjfBcRq9ykriS2MTIs
         TJBnylybQZt2ggeHsMK8ZMQAnCZMmlAWUYzcz5KBXK0BUasWK4fXl1d3GYsN0tbfGbW7
         uZi7MCmfLkt/1MVikAbtyRg/bbV8GlSRciq2a5cA9WNji3BbOwCQ14PCq/WyspDfBGQs
         l80Xmvbb1pTz4rz7EJQte4KrmAQd0EElxB+nJu4OMns5HLXJu21EphsuG6RPorW3GfQB
         Rlvg==
X-Gm-Message-State: AA+aEWZPO2YdhzDeAK//uTqezEzgH2omLrPx9t7ecmvFt1VvPjOmvhEE
        LoH6zUkCDw1YCqxY8Ynl0rjo7r15
X-Google-Smtp-Source: AFSGD/V6G8mPTrpIt76k9+7o0X0Q++UfWb1olgptB+hSqJfckaQiUp7ZfmB7lmrQBybh3a5qJeczLA==
X-Received: by 2002:a63:e445:: with SMTP id i5mr16214913pgk.307.1544567856938;
        Tue, 11 Dec 2018 14:37:36 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v190sm20465284pfv.26.2018.12.11.14.37.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 14:37:35 -0800 (PST)
Date:   Tue, 11 Dec 2018 14:37:34 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Tree for Dec 11
Message-ID: <20181211223734.GA2923@roeck-us.net>
References: <20181211182627.42b79e40@canb.auug.org.au>
 <20181211173851.GA29028@roeck-us.net>
 <20181211180437.GA28010@flashbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181211180437.GA28010@flashbox>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 11:04:37AM -0700, Nathan Chancellor wrote:
> On Tue, Dec 11, 2018 at 09:38:51AM -0800, Guenter Roeck wrote:
> > On Tue, Dec 11, 2018 at 06:26:27PM +1100, Stephen Rothwell wrote:
> > > Hi all,
> > > 
> > > Changes since 20181210:
> > > 
> > > The arm64 tree gained a conflict against Linus' tree.
> > > 
> > > The f2fs tree gained a conflict against the fscrypt tree.
> > > 
> > > The ubifs tree gained a conflict against the fscrypt tree.
> > > 
> > > The rdma tree still had its build failure so I used the version from
> > > next-20181203.
> > > 
> > > The tip tree gained a conflict against the hwmon-staging tree.
> > > 
> > > The gpio tree lost its build failure.
> > > 
> > > The akpm-current tree lost its build failure but gained conflist against
> > > the arm64 tree.
> > > 
> > > Non-merge commits (relative to Linus' tree): 7744
> > >  8462 files changed, 365061 insertions(+), 211977 deletions(-)
> > > 
> > 
> > Build results:
> > 	total: 152 pass: 150 fail: 2
> > Failed builds: 
> > 	arm:allmodconfig 
> > 	arm64:allmodconfig 
> > Qemu test results:
> > 	total: 337 pass: 137 fail: 200
> > 
> > Build failures:
> > 
> > arm:
> > 
> > In file included from drivers/media/pci/ddbridge/ddbridge.h:22:0,
> >                  from drivers/media/pci/ddbridge/ddbridge-ci.c:19:
> > arch/arm/include/asm/irq.h:35:50: error: unknown type name 'cpumask_t'
> > 
> 
> Just FYI, I noticed this one yesterday on next-20181210 and sent a patch:
> https://lore.kernel.org/linux-media/20181210233514.3069-1-natechancellor@gmail.com/
> 
Excellent, thanks!

> > arm64:
> > 
> > arch/arm64/kernel/entry-ftrace.o:(_kprobe_blacklist+0x0): dangerous relocation:
> > 	unsupported relocation
> > 
> > The latter is with gcc 7.3.0. I'll build and try with gcc 7.4.0 and
> > the most recent binutils later.
> > 
A build with gcc 7.4.0 has exactly the same problem.

> > Most of the failing qemu tests fail with something like
> > 
> > Starting init: /sbin/init exists but couldn't execute it (error -95)
> > 
> > Others (such as aarch64) crash silently.
> > 
> > Has anyone reported this already, or do I need to run bisect ?
> > 
Turns out this is due to "fsverity: Move verity status check to
fsverity_file_open", and the author should be aware of the problem.

Guenter
