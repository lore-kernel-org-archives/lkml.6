Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96893ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 19:37:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 483D5208FA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 19:37:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O5yKEUSt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 483D5208FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730552AbeGPUGT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 16:06:19 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:42630 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729792AbeGPUGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 16:06:19 -0400
Received: by mail-pl0-f66.google.com with SMTP id f4-v6so11504594plb.9;
        Mon, 16 Jul 2018 12:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dVBS8lBk2IAtFlynHieMQikspAK8K7hhCUC4JS8UrAQ=;
        b=O5yKEUStlJsM+jgBNJQAC22VlS9JLM8fklDiqLUgrY3QslciIusTgVhJfWhR5SXB34
         2r281cUbP2dwzAIglT3tRhX4KKRUXLnRe2X2I5CUedkYR3s646xS/5BWshS/Sj+gB/HT
         ffUmcC1zjj9nk2su/K7vbkCRmwAnJLSBZXxYqxqWo08zaYtBA1Heekf+Josu0iwaRsq3
         dk/kzBbd8NluLuZrAT6mXL52TK3kI8+l2Yfmf8hsMu099y26l/2HN770MO1Bx8jEDKMl
         EbNO0pxk7N+71YF2gZ/CwYgM2rmNAqUMyxfpSmrowaXDe/1NnOFKs51Qg/5/6M8Yhwsb
         YpaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=dVBS8lBk2IAtFlynHieMQikspAK8K7hhCUC4JS8UrAQ=;
        b=ZrEr4TJ1DdISDvscsp78FeTeTaVIiCkREqSBJeA00jn0agnwHQFUZv2csJ9D5UN5bu
         dMz68bR87h4leh9LzmoO2rQtyX8Dp8SHuXjo+9CJIHTVfcG4i7etJAmyGOrWCKJwbi+E
         k8UqIPZfGKbuNO33uOcRi46aiUTpOwFAbMB3JVoPZa9/+uTI5Sj7IzmJPLD9J2K5Vvv4
         At9/mcWce+gfK4Vgh4yjkdR+f4hXpubeHyIklkOkVJwPLSk+UenAyvMPFLHqKAC7/wHo
         bTVPP2UW0GVZBIBrMt9fHzdj1WpWECU6oP4gT3OoL90KQzPuSyoCu3aXdsOYIQnOrQzM
         rm+Q==
X-Gm-Message-State: AOUpUlHriunkfsdGLeaic85MS7iBxpNQ7F+JceyrZ/cHcYDDjIAbprR5
        JcsAUCPifD5e1IC9OFjXU2A=
X-Google-Smtp-Source: AAOMgpdqxxIdYgBV99FSsZSzUe2mP9lk0+aVbgy8tJRtPQQ6xFxgrgTE4kZ1Scq0FumEoJFE5KxleQ==
X-Received: by 2002:a17:902:8f83:: with SMTP id z3-v6mr17665905plo.111.1531769846264;
        Mon, 16 Jul 2018 12:37:26 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id 21-v6sm30165832pgx.20.2018.07.16.12.37.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jul 2018 12:37:25 -0700 (PDT)
Date:   Mon, 16 Jul 2018 12:37:23 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.9 00/32] 4.9.113-stable review
Message-ID: <20180716193723.GA22356@roeck-us.net>
References: <20180716073504.433996952@linuxfoundation.org>
 <20180716162538.GB12065@roeck-us.net>
 <20180716163136.GA16264@kroah.com>
 <20180716164123.GE12065@roeck-us.net>
 <20180716174332.GA8555@kroah.com>
 <20180716180219.GA12046@roeck-us.net>
 <20180716183120.GA13309@kroah.com>
 <20180716183337.GB13309@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180716183337.GB13309@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2018 at 08:33:37PM +0200, Greg Kroah-Hartman wrote:
> On Mon, Jul 16, 2018 at 08:31:20PM +0200, Greg Kroah-Hartman wrote:
> > On Mon, Jul 16, 2018 at 11:02:19AM -0700, Guenter Roeck wrote:
> > > On Mon, Jul 16, 2018 at 07:43:32PM +0200, Greg Kroah-Hartman wrote:
> > > > On Mon, Jul 16, 2018 at 09:41:23AM -0700, Guenter Roeck wrote:
> > > > > On Mon, Jul 16, 2018 at 06:31:36PM +0200, Greg Kroah-Hartman wrote:
> > > > > > On Mon, Jul 16, 2018 at 09:25:38AM -0700, Guenter Roeck wrote:
> > > > > > > On Mon, Jul 16, 2018 at 09:36:08AM +0200, Greg Kroah-Hartman wrote:
> > > > > > > > This is the start of the stable review cycle for the 4.9.113 release.
> > > > > > > > There are 32 patches in this series, all will be posted as a response
> > > > > > > > to this one.  If anyone has any issues with these being applied, please
> > > > > > > > let me know.
> > > > > > > > 
> > > > > > > > Responses should be made by Wed Jul 18 07:34:43 UTC 2018.
> > > > > > > > Anything received after that time might be too late.
> > > > > > > >
> > > > > > > 
> > > > > > > Build results:
> > > > > > > 	total: 148 pass: 133 fail: 15
> > > > > > > Failed builds: 
> > > > > > > 	mips:defconfig 
> > > > > > > 	mips:allnoconfig 
> > > > > > > 	mips:defconfig 
> > > > > > > 	mips:allmodconfig 
> > > > > > > 	mips:allnoconfig 
> > > > > > > 	mips:bcm47xx_defconfig 
> > > > > > > 	mips:bcm63xx_defconfig 
> > > > > > > 	mips:nlm_xlp_defconfig 
> > > > > > > 	mips:ath79_defconfig 
> > > > > > > 	mips:ar7_defconfig 
> > > > > > > 	mips:e55_defconfig 
> > > > > > > 	mips:cavium_octeon_defconfig 
> > > > > > > 	mips:malta_defconfig 
> > > > > > > 	mips:rt305x_defconfig 
> > > > > > > 	mips:defconfig 
> > > > > > > Qemu test results:
> > > > > > > 	total: 166 pass: 154 fail: 12
> > > > > > > Failed tests: 
> > > > > > > 	mips:malta_defconfig:nosmp 
> > > > > > > 	mips:malta_defconfig:smp 
> > > > > > > 	mips64:malta_defconfig:nosmp 
> > > > > > > 	mips64:malta_defconfig:smp 
> > > > > > > 	mipsel:24Kf:malta_defconfig:nosmp:initrd 
> > > > > > > 	mipsel:24Kf:malta_defconfig:smp:initrd 
> > > > > > > 	mipsel:24Kf:malta_defconfig:smp:rootfs 
> > > > > > > 	mipsel:mips32r6-generic:malta_32r6_defconfig:smp:rootfs 
> > > > > > > 	mipsel64:malta_defconfig:nosmp:rootfs 
> > > > > > > 	mipsel64:malta_defconfig:smp:initrd 
> > > > > > > 	mipsel64:malta_defconfig:smp:rootfs 
> > > > > > > 	mipsel64:fuloong2e_defconfig:fulong2e:rootfs
> > > > > > > 
> > > > > > > Error is always the same.
> > > > > > > 
> > > > > > > arch/mips/kernel/process.c:637:8:
> > > > > > > 	error: 'call_single_data_t' undeclared here (not in a function)
> > > > > > > arch/mips/kernel/process.c: In function 'raise_backtrace':
> > > > > > > /opt/buildbot/slave/stable-queue-4.9/build/arch/mips/kernel/process.c:648:22:
> > > > > > > 	error: 'csd' undeclared (first use in this function)
> > > > > > 
> > > > > > mips should now be fixed with the updated tree I have pushed out.
> > > > > > 
> > > > > 
> > > > > The above is with v4.9.112-33-g7fb1f5e, which is the latest version
> > > > > available from the git repository (as of right now). My builders
> > > > > pulled it at 4:07am this morning, and there was no subsequent update.
> > > > 
> > > > Odd.  Ok, I've bumped the -rc number to -rc2 now, and pushed it all out
> > > > again.  Let me know if you don't see it show up within an hour or so.
> > > > 
> > > Version is now v4.9.112-33-gb44db2b, so something changed, but I still get
> > > the same build error.
> > > 
> > > Comparing the old and the new version, the only difference is the updated rc.
> > > 
> > > diff --git a/Makefile b/Makefile
> > > index 57f315d00a94..986470ef6f6e 100644
> > > --- a/Makefile
> > > +++ b/Makefile
> > > @@ -1,7 +1,7 @@
> > >  VERSION = 4
> > >  PATCHLEVEL = 9
> > >  SUBLEVEL = 113
> > > -EXTRAVERSION = -rc1
> > > +EXTRAVERSION = -rc2
> > >  NAME = Roaring Lionus
> > > 
> > > The error itself is that single_data_t was replaced in the backport with
> > > call_single_data. It should have been "struct call_single_data".
> > 
> > {sigh}  This is why I asked for a fixup patch.  Let me just go rip that
> > thing out now...
> 
> Ok, -rc3 is out now to hopefully resolve this.  Sorry for the noise.
> 
No worries. Mips images build and boot fine with v4.9.112-32-g30ce843.
I didn't rebuild the other images.

Guenter
