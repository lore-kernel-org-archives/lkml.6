Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF5B6ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 18:02:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79B96208E9
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 18:02:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kUK0spLJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79B96208E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728758AbeGPSax (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 14:30:53 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:36629 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727811AbeGPSaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 14:30:52 -0400
Received: by mail-pl0-f66.google.com with SMTP id e11-v6so2634993plb.3;
        Mon, 16 Jul 2018 11:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/xjlBP6nUopsr7fSwQrEbLkdUESnLz5u3LZwD+3RYWo=;
        b=kUK0spLJ1wzHbh29gFe877OKOyqsioK2jAz5aD6S+Sx0mXzwrrH5LEh+X29l4VKn8b
         pIb/e/QKEGAPzesN+jLGLU7Yp0/ildAGn7S17U5LEU1Gmf5f2CrPTbci9jx/ICZi+VRz
         Oepy07Tdm8c7fTriz13yhfdcdbiKgjw75BrGvMYN6mzXuPGtRQOPrRJpmhOQjcxdqI8l
         Op3C1RWhWZ8UWCUXAizuDYb9wKCUzwsgkyMUU2g3MWo5u73OFfbD91/dM9UWEA1lTm8E
         tEGEoq/CyelF3Dmvqnya2thzMxrX05rCFx0hzX8l5IAHXORdnmf81mYofVQfUgGbxPru
         IUkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=/xjlBP6nUopsr7fSwQrEbLkdUESnLz5u3LZwD+3RYWo=;
        b=Laf6kNtICkVgVqVIIy+5IM/CTpxZ2oczaQ7SmhZOscc602iyHK49t6EFK0+M40XSYr
         hwSC5ss/oaSHVAz9MUaWf7nPKy1TVogVcA3BsQr3mmgLTaNmrHh4AF2Lx0gl2OEj25ET
         2gwkmF17eV+iI+NCJgnWZkSW0xMPtzQyYdZ5ig4A85PHwqYzMnV+t413Y3EYdKgqneNx
         kNeBDtKlwNFOoxl+/2MQd5CZJZkoFB6pTnWV3Ah5PmbQ3VRLm4/bVrmHFM5+S/1fvgvw
         /oDc+DvI5kfEoIKN49Fl9e15i/JCS3OilP8uTe8UEAIukXG/48S9TtFEAJX4I6fAC2ZB
         Lj3g==
X-Gm-Message-State: AOUpUlGidmSNWdniY9rJ1SfgUwMFhhbyy1XUx6DOksYLDiyX17BJMyO5
        yIo9Amf3bL/bN3A+ZxHxs8Y=
X-Google-Smtp-Source: AAOMgpcSoqP682f9OLr04j9o8e1QqhuGy1OdVdjhgf+Pb7ZNuQBuS6xnjEebKqWKuuWXFmnisXFofg==
X-Received: by 2002:a17:902:42a3:: with SMTP id h32-v6mr17387770pld.72.1531764141257;
        Mon, 16 Jul 2018 11:02:21 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id a15-v6sm40064792pfe.32.2018.07.16.11.02.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jul 2018 11:02:20 -0700 (PDT)
Date:   Mon, 16 Jul 2018 11:02:19 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.9 00/32] 4.9.113-stable review
Message-ID: <20180716180219.GA12046@roeck-us.net>
References: <20180716073504.433996952@linuxfoundation.org>
 <20180716162538.GB12065@roeck-us.net>
 <20180716163136.GA16264@kroah.com>
 <20180716164123.GE12065@roeck-us.net>
 <20180716174332.GA8555@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180716174332.GA8555@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2018 at 07:43:32PM +0200, Greg Kroah-Hartman wrote:
> On Mon, Jul 16, 2018 at 09:41:23AM -0700, Guenter Roeck wrote:
> > On Mon, Jul 16, 2018 at 06:31:36PM +0200, Greg Kroah-Hartman wrote:
> > > On Mon, Jul 16, 2018 at 09:25:38AM -0700, Guenter Roeck wrote:
> > > > On Mon, Jul 16, 2018 at 09:36:08AM +0200, Greg Kroah-Hartman wrote:
> > > > > This is the start of the stable review cycle for the 4.9.113 release.
> > > > > There are 32 patches in this series, all will be posted as a response
> > > > > to this one.  If anyone has any issues with these being applied, please
> > > > > let me know.
> > > > > 
> > > > > Responses should be made by Wed Jul 18 07:34:43 UTC 2018.
> > > > > Anything received after that time might be too late.
> > > > >
> > > > 
> > > > Build results:
> > > > 	total: 148 pass: 133 fail: 15
> > > > Failed builds: 
> > > > 	mips:defconfig 
> > > > 	mips:allnoconfig 
> > > > 	mips:defconfig 
> > > > 	mips:allmodconfig 
> > > > 	mips:allnoconfig 
> > > > 	mips:bcm47xx_defconfig 
> > > > 	mips:bcm63xx_defconfig 
> > > > 	mips:nlm_xlp_defconfig 
> > > > 	mips:ath79_defconfig 
> > > > 	mips:ar7_defconfig 
> > > > 	mips:e55_defconfig 
> > > > 	mips:cavium_octeon_defconfig 
> > > > 	mips:malta_defconfig 
> > > > 	mips:rt305x_defconfig 
> > > > 	mips:defconfig 
> > > > Qemu test results:
> > > > 	total: 166 pass: 154 fail: 12
> > > > Failed tests: 
> > > > 	mips:malta_defconfig:nosmp 
> > > > 	mips:malta_defconfig:smp 
> > > > 	mips64:malta_defconfig:nosmp 
> > > > 	mips64:malta_defconfig:smp 
> > > > 	mipsel:24Kf:malta_defconfig:nosmp:initrd 
> > > > 	mipsel:24Kf:malta_defconfig:smp:initrd 
> > > > 	mipsel:24Kf:malta_defconfig:smp:rootfs 
> > > > 	mipsel:mips32r6-generic:malta_32r6_defconfig:smp:rootfs 
> > > > 	mipsel64:malta_defconfig:nosmp:rootfs 
> > > > 	mipsel64:malta_defconfig:smp:initrd 
> > > > 	mipsel64:malta_defconfig:smp:rootfs 
> > > > 	mipsel64:fuloong2e_defconfig:fulong2e:rootfs
> > > > 
> > > > Error is always the same.
> > > > 
> > > > arch/mips/kernel/process.c:637:8:
> > > > 	error: 'call_single_data_t' undeclared here (not in a function)
> > > > arch/mips/kernel/process.c: In function 'raise_backtrace':
> > > > /opt/buildbot/slave/stable-queue-4.9/build/arch/mips/kernel/process.c:648:22:
> > > > 	error: 'csd' undeclared (first use in this function)
> > > 
> > > mips should now be fixed with the updated tree I have pushed out.
> > > 
> > 
> > The above is with v4.9.112-33-g7fb1f5e, which is the latest version
> > available from the git repository (as of right now). My builders
> > pulled it at 4:07am this morning, and there was no subsequent update.
> 
> Odd.  Ok, I've bumped the -rc number to -rc2 now, and pushed it all out
> again.  Let me know if you don't see it show up within an hour or so.
> 
Version is now v4.9.112-33-gb44db2b, so something changed, but I still get
the same build error.

Comparing the old and the new version, the only difference is the updated rc.

diff --git a/Makefile b/Makefile
index 57f315d00a94..986470ef6f6e 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 VERSION = 4
 PATCHLEVEL = 9
 SUBLEVEL = 113
-EXTRAVERSION = -rc1
+EXTRAVERSION = -rc2
 NAME = Roaring Lionus

The error itself is that single_data_t was replaced in the backport with
call_single_data. It should have been "struct call_single_data".

Guenter
