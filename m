Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B51CC65BA7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 13:48:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 413352084D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 13:48:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bFoPL//G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 413352084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728839AbeJEUrp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 16:47:45 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39095 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728278AbeJEUrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 16:47:45 -0400
Received: by mail-pl1-f196.google.com with SMTP id w14-v6so6896430plp.6;
        Fri, 05 Oct 2018 06:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=H7YnJzaX46oHsg1DO42jtw2RZc1ROIEqIp+2fQXgjAM=;
        b=bFoPL//GZW9DIzuobqBjBuTYPUhPABNfmOLpBZFyctgLTdAOu5semAlChTqTFwI6iI
         ZGiZrybYgOb5xfnS0WXUmJ3DkXsGrtwMUGRRr2Cybx7jtLRzgAl14maRPV1vd+ejH7jK
         rMKCmqU/kAAPb4MNg5DRgz1S51NOguuXuumIrs7h1ZSeL1c55Wz6yDSfpVE9f6mku4WY
         9kMAjoqCdzwTgqUFIzOYX7Dqs7z8UzhSfoF3/Z8vjza54OhgK+OEXoepCWRe5zNfnC7M
         rg4L/w2uwLq4rXMcuilLxZNhaVKE9B9wuEpEmU2ee4wIU+COxdxfQF7m/uXyaH/hE0Q6
         9/OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=H7YnJzaX46oHsg1DO42jtw2RZc1ROIEqIp+2fQXgjAM=;
        b=XX5hI+APom3VB8lkeohg8EJTynEx2SP4WCn4bwqnDLCYQ7fIox7ToQacic8TzqxZIS
         XE1n37DFZqtPM0GqPlB4N8u3lRaAI9+XKPF+qnCPUczi1Myc8qDVm8jKO+O07ugkR+Tr
         w/tnp5PI+EL3+PAvqOEFTVvHS9fmWjh+BgT47gjWZ2p9165ATtti75Ah45UlAwrgV2io
         MYCE1NcLmPhIk0Iir3RhMOo9wQbbBR8ogX5wD8VV57YYHAmbSBMgL3Uiq/3tjmmkCxjf
         WVRssLVEcc5SWsX/SiK2+iK43rDvjG8VEPc9/hXu7D8pLNiBc0nEncozLg7ZAez0EINx
         R/fg==
X-Gm-Message-State: ABuFfoh7mg29aIQnw9wVaRQSTBaM2VZ9mvjxCHI3yYY3oXB2VI853bN3
        b/a/waJjT0tFXvycsWSnqvex7PIg
X-Google-Smtp-Source: ACcGV63jt2pgmiO/AJiGhnPLM40RaVj+hOGJUJhv6HT7uauh3P0QtRJ6hYrBQSrYYhUh+WkRrlk2cw==
X-Received: by 2002:a17:902:b213:: with SMTP id t19-v6mr11973373plr.51.1538747336525;
        Fri, 05 Oct 2018 06:48:56 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id f22-v6sm12626455pff.29.2018.10.05.06.48.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Oct 2018 06:48:55 -0700 (PDT)
Date:   Fri, 5 Oct 2018 06:48:54 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Tree for Oct 5
Message-ID: <20181005134854.GA17709@roeck-us.net>
References: <20181005163943.3f8d4f32@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181005163943.3f8d4f32@canb.auug.org.au>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 05, 2018 at 04:39:43PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20181004:
> 
> I added a supplied patch to the dma-mapping tree to fix overnight boot
> problems.
> 
> I added a supplied patch to the nfs tree to fix an overnight build
> problem.
> 
> The nfsd tree gained a build failure due to an interaction with the nfs
> tree for which I applied a merge fix patch. And another build failure
> so I used the version from next-20181004.
> 
> The bpf-next tree lost its build failure.
> 
> The drm-msm tree gained a build failure, so I used the version from
> next-20181004.
> 
> The tty tree lost its build failure.
> 
> The slave-dma tree lost its build failure.
> 
> The akpm-current tree gained a conflict against the btrfs-kdave tree.
> 
> The akpm tree gained a build failure due to an interaction with the
> powerpc tree for which I added a merge fix patch.
> 
> Non-merge commits (relative to Linus' tree): 8415
>  8136 files changed, 377585 insertions(+), 173429 deletions(-)
> 

Build results:
	total: 135 pass: 129 fail: 6
Failed builds: 
	mips:allmodconfig 
	powerpc:ppc6xx_defconfig
	s390:defconfig 
	s390:allmodconfig 
	s390:allnoconfig 
	sparc32:allmodconfig 
Qemu test results:
	total: 318 pass: 315 fail: 3
Failed tests: 
	s390:defconfig:initrd 
	s390:defconfig:virtio-blk-ccw:rootfs 
	s390:defconfig:scsi[virtio-ccw]:rootfs

---
mips:allmodconfig, powerpc:ppc6xx_defconfig;

net/sunrpc/auth_gss/gss_krb5_seal.c: In function 'gss_seq_send64_fetch_and_inc':
net/sunrpc/auth_gss/gss_krb5_seal.c:144:3: error:
	implicit declaration of function 'cmpxchg64'

---
s390:

s390-linux-ld:./arch/s390/kernel/vmlinux.lds:41: syntax error

qemu tests also affected. Fixed with:

https://lore.kernel.org/patchwork/patch/993576/

---
sparc32:allmodconfig:

Various "relocation truncated to fit" errors. Also seen in mainline.
It is probably time to drop the build.

---

Guenter
