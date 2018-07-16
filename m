Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43FC7ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 16:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF5EF208AD
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 16:41:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yr5HTYxA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF5EF208AD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728556AbeGPRJi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 13:09:38 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:46903 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727411AbeGPRJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 13:09:37 -0400
Received: by mail-oi0-f66.google.com with SMTP id y207-v6so76012089oie.13;
        Mon, 16 Jul 2018 09:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=P9NFfQ1lE/f1tahoK0D4Lqpti8VQOZJ2jt18N+mvsaY=;
        b=Yr5HTYxAhTmLPyn/qXhPeK/1H02tFGZs1rFyHgw0D6KlOX2/9xdOng5glSJFvvzJZN
         +Bs0suGlkImGIC2lmvCs3WscteUZg4mdL8gd4fkn4kKkAVwUD2/H0pympnfQU6gcjJ5w
         g9hSaQaXara8uiSiaiwEaaln7bdYUUFBZZWkhVOkamiFa1RAqUfNCYvdLNVvp7jYvMDV
         H3/CXls7TsjMa0TN4wguixG/KGk9Vb+bT1IopCcL0piDUYwIIdr9f6gxEIfKRiFzOwTN
         2PMx+jPKTp3cdwNIpBl/eYYFhNUpYypwzkY0Nhc/fpay3BvH2OCtjAojrQszPAHxdCbF
         Ecog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=P9NFfQ1lE/f1tahoK0D4Lqpti8VQOZJ2jt18N+mvsaY=;
        b=j7BKnpvF7prtNgrb1xy3MVg8QbnNKMlOP7tRHBdZg4tdjT2GRnSAHivitVNjuJzzB+
         w9YmYJIdRR8jJp4fpW5tMNjB5GRduZVkpiKn5hWZvJ6vBADPCanXE/c/DPGUYM6/Odo7
         TWJkq8w66L6cDSoTSnom9uZpkAuEZ1wk9c4VM8O1TicATPVxITmX5G80V5rR7T5jQfOd
         umf6oFh1Yivb1fAlO3O9kyV7EuIP0LuvznA1lpHeP/U3btybpn/duLVsEjkHv5K+CPzt
         tqym/r/qfEVRqM5/VC2DKJyQbIx0QUVGsF6iME7Aw4WbCw8O6UVaxB1DR9hAQlEoNvSF
         TaEA==
X-Gm-Message-State: AOUpUlGdHC4wxkUpkWQ4tsB/ZgSddIC4XCTKe6YREWunH5BE3Ncg0RVY
        NSMhEDlF3h/jFPxCxQxD+jw=
X-Google-Smtp-Source: AAOMgpeYogij7nu234mMBldHm5rgizwxR2lDuSELM9isBQmGvW1xQmUU5M2P2XIwWIVUJEpMRiz+cQ==
X-Received: by 2002:aca:f383:: with SMTP id r125-v6mr101937oih.6.1531759284935;
        Mon, 16 Jul 2018 09:41:24 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id q124-v6sm15137631oif.8.2018.07.16.09.41.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jul 2018 09:41:24 -0700 (PDT)
Date:   Mon, 16 Jul 2018 09:41:23 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.9 00/32] 4.9.113-stable review
Message-ID: <20180716164123.GE12065@roeck-us.net>
References: <20180716073504.433996952@linuxfoundation.org>
 <20180716162538.GB12065@roeck-us.net>
 <20180716163136.GA16264@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180716163136.GA16264@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2018 at 06:31:36PM +0200, Greg Kroah-Hartman wrote:
> On Mon, Jul 16, 2018 at 09:25:38AM -0700, Guenter Roeck wrote:
> > On Mon, Jul 16, 2018 at 09:36:08AM +0200, Greg Kroah-Hartman wrote:
> > > This is the start of the stable review cycle for the 4.9.113 release.
> > > There are 32 patches in this series, all will be posted as a response
> > > to this one.  If anyone has any issues with these being applied, please
> > > let me know.
> > > 
> > > Responses should be made by Wed Jul 18 07:34:43 UTC 2018.
> > > Anything received after that time might be too late.
> > >
> > 
> > Build results:
> > 	total: 148 pass: 133 fail: 15
> > Failed builds: 
> > 	mips:defconfig 
> > 	mips:allnoconfig 
> > 	mips:defconfig 
> > 	mips:allmodconfig 
> > 	mips:allnoconfig 
> > 	mips:bcm47xx_defconfig 
> > 	mips:bcm63xx_defconfig 
> > 	mips:nlm_xlp_defconfig 
> > 	mips:ath79_defconfig 
> > 	mips:ar7_defconfig 
> > 	mips:e55_defconfig 
> > 	mips:cavium_octeon_defconfig 
> > 	mips:malta_defconfig 
> > 	mips:rt305x_defconfig 
> > 	mips:defconfig 
> > Qemu test results:
> > 	total: 166 pass: 154 fail: 12
> > Failed tests: 
> > 	mips:malta_defconfig:nosmp 
> > 	mips:malta_defconfig:smp 
> > 	mips64:malta_defconfig:nosmp 
> > 	mips64:malta_defconfig:smp 
> > 	mipsel:24Kf:malta_defconfig:nosmp:initrd 
> > 	mipsel:24Kf:malta_defconfig:smp:initrd 
> > 	mipsel:24Kf:malta_defconfig:smp:rootfs 
> > 	mipsel:mips32r6-generic:malta_32r6_defconfig:smp:rootfs 
> > 	mipsel64:malta_defconfig:nosmp:rootfs 
> > 	mipsel64:malta_defconfig:smp:initrd 
> > 	mipsel64:malta_defconfig:smp:rootfs 
> > 	mipsel64:fuloong2e_defconfig:fulong2e:rootfs
> > 
> > Error is always the same.
> > 
> > arch/mips/kernel/process.c:637:8:
> > 	error: 'call_single_data_t' undeclared here (not in a function)
> > arch/mips/kernel/process.c: In function 'raise_backtrace':
> > /opt/buildbot/slave/stable-queue-4.9/build/arch/mips/kernel/process.c:648:22:
> > 	error: 'csd' undeclared (first use in this function)
> 
> mips should now be fixed with the updated tree I have pushed out.
> 

The above is with v4.9.112-33-g7fb1f5e, which is the latest version
available from the git repository (as of right now). My builders
pulled it at 4:07am this morning, and there was no subsequent update.

Guenter
