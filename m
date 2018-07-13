Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB76EECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 23:38:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B54A20864
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 23:38:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GqP0ClAo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B54A20864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731914AbeGMXzX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 19:55:23 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:44407 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727506AbeGMXzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 19:55:22 -0400
Received: by mail-pf0-f193.google.com with SMTP id j3-v6so23430506pfh.11;
        Fri, 13 Jul 2018 16:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=r5zEE5q2+sWRurJgAFENPKpTy33r2bR6VSFiz5hWKmI=;
        b=GqP0ClAourvZ7FF/IRBIRVXFSmGGccyukcK/mzStrVdRb0Ffu1OrHk3/vNo0y1FfOk
         AKjhFu0igaxuYI1Iw0P7EFqda6BvWcclKDX3bQudgrSZzDpGhtKAHbkWgsTVCJjFX8ev
         8TkKuTZ6DpwxWimAYa7Jtp9UIXvPZRFLBUZA365ZW/2cIvCMgxUw5+zrD+0hDFZlAXgd
         uvcVszeTG3wRzqK25kli9Z95cM6DFFH51gxYqQzMPY3IBnnnYZFWrgWlhFjWE2gvuiIW
         sojJF5RudRydA4pz0h66hTCaXZs38QhlUFLn05a80JKIUtTPBPYuQQLQwBrwU3GwEmtb
         U33w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=r5zEE5q2+sWRurJgAFENPKpTy33r2bR6VSFiz5hWKmI=;
        b=q3nuFVPqsNBs4CJPXlFbrPzNu4/poQBlWSTgMVM9KkT73ik6KVVeuz7APCrz3tx0ZJ
         gL5CvtJa2fALkr1ooCBUo3GQy5DB7hsFtNiRIFA4/f1puDWVwpjR+zJa9VagpNMxaWA/
         saWoCs3lmKqczgvfrtLo3lcb09MTevZJOlw4alrCEUG3o8QHzrH0gsA6VovF28KaDEaK
         rnjGiO3pQ0lzYPife/B8iMwSKdo7TuPCFRTUde2HZtY+e/ufO+dIfB3KgmuwarMxEZbJ
         BCniS64AthG/On58KMlkAxnbxWTe/TcsYuBqe8fm7fk8JnNcx0hywoneT+ebFucP1hBR
         g9hA==
X-Gm-Message-State: AOUpUlHcMFiqFq09LZREsbD3y9ao+GZk4G0aJabpiTNu2LK8jnkt4Jza
        eopGa9m4alCvDgrpQ5NraSQ=
X-Google-Smtp-Source: AAOMgpd31UwUmtjy//YM100D9jYHxtTKDRq0ixhhmnzjfi0qubBSamgAq5/TPSU8MNGN7Oceq4DCBw==
X-Received: by 2002:a63:342:: with SMTP id 63-v6mr7598555pgd.290.1531525113408;
        Fri, 13 Jul 2018 16:38:33 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id c1-v6sm9138749pfi.142.2018.07.13.16.38.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jul 2018 16:38:32 -0700 (PDT)
Date:   Fri, 13 Jul 2018 16:38:31 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-ntb@googlegroups.com, linux-crypto@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Suresh Warrier <warrier@linux.vnet.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [v18,3/7] iomap: introduce io{read|write}64_{lo_hi|hi_lo}
Message-ID: <20180713233831.GA2946@roeck-us.net>
References: <20180622194752.11221-4-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180622194752.11221-4-logang@deltatee.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jun 22, 2018 at 01:47:48PM -0600, Logan Gunthorpe wrote:
> In order to provide non-atomic functions for io{read|write}64 that will
> use readq and writeq when appropriate. We define a number of variants
> of these functions in the generic iomap that will do non-atomic
> operations on pio but atomic operations on mmio.
> 
> These functions are only defined if readq and writeq are defined. If
> they are not, then the wrappers that always use non-atomic operations
> from include/linux/io-64-nonatomic*.h will be used.
> 

This patch causes a build failure in -next when building
ppc:corenet64_smp_defconfig.

In file included from drivers/crypto/caam/qi.c:14:0:
drivers/crypto/caam/regs.h: In function 'wr_reg64':
drivers/crypto/caam/regs.h:143:3:
	error: implicit declaration of function 'iowrite64'; did you mean 'iowrite32'?

Several files are afected; this is only the first error reported.

Bisect log is attached.

Guenter

---
# bad: [483d835c8189f0566a4cbbe47e74ffa314430e98] Add linux-next specific files for 20180713
# good: [1e4b044d22517cae7047c99038abb444423243ca] Linux 4.18-rc4
git bisect start 'HEAD' 'v4.18-rc4'
# good: [a5da8bf5df4436f40f4e28f0be51a4678830fe23] Merge remote-tracking branch 'crypto/master'
git bisect good a5da8bf5df4436f40f4e28f0be51a4678830fe23
# good: [34f19afdf1f94450c325da94559d07f746e9043d] Merge remote-tracking branch 'tip/auto-latest'
git bisect good 34f19afdf1f94450c325da94559d07f746e9043d
# good: [7aac4471307ac631685599b820616fd4c47edf29] Merge remote-tracking branch 'staging/staging-next'
git bisect good 7aac4471307ac631685599b820616fd4c47edf29
# good: [6b674574d58a738035fdf29008a308bee9235a16] Merge remote-tracking branch 'ntb/ntb-next'
git bisect good 6b674574d58a738035fdf29008a308bee9235a16
# bad: [013d0c6f50169c75eb37549f705604103cbeaa0b] module: allow symbol exports to be disabled
git bisect bad 013d0c6f50169c75eb37549f705604103cbeaa0b
# good: [205a106bac127145a4defae7d0d35945001fe924] kernel/memremap, kasan: make ZONE_DEVICE with work with KASAN
git bisect good 205a106bac127145a4defae7d0d35945001fe924
# good: [89ce5b41242240e43de867b0469b71c6b8aa9d5f] mm, swap: fix race between swapoff and some swap operations
git bisect good 89ce5b41242240e43de867b0469b71c6b8aa9d5f
# good: [9760a955e6173bd0c2f58f1507fec8c88aaffc68] proc: fix BUILD_BUG_ON breakage on powerpc64-allyesconfig
git bisect good 9760a955e6173bd0c2f58f1507fec8c88aaffc68
# good: [696b14958b4d620ae7431351b667fd79397d550d] include/asm-generic/bug.h: clarify valid uses of WARN()
git bisect good 696b14958b4d620ae7431351b667fd79397d550d
# good: [e018a02ca17fbe4c34515bec58eceb8b0be94ec6] parisc: iomap: introduce io{read|write}64
git bisect good e018a02ca17fbe4c34515bec58eceb8b0be94ec6
# bad: [e18963b65c6397fdba51416ff70c33197f6c1a84] ntb: ntb_hw_intel: use io-64-nonatomic instead of in-driver hacks
git bisect bad e18963b65c6397fdba51416ff70c33197f6c1a84
# bad: [8f6432de3dbe1d1d222d2998380a495e04ba5fef] io-64-nonatomic: add io{read|write}64[be]{_lo_hi|_hi_lo} macros
git bisect bad 8f6432de3dbe1d1d222d2998380a495e04ba5fef
# bad: [d189c7f6b4a0dec224652af6d868eebb57553345] iomap: introduce io{read|write}64_{lo_hi|hi_lo}
git bisect bad d189c7f6b4a0dec224652af6d868eebb57553345
# first bad commit: [d189c7f6b4a0dec224652af6d868eebb57553345] iomap: introduce io{read|write}64_{lo_hi|hi_lo}
