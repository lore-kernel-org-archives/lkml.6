Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFF07ECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 16:41:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8514A20869
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 16:41:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vi21aRND"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8514A20869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbeJTArz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 20:47:55 -0400
Received: from mail-pg1-f179.google.com ([209.85.215.179]:36378 "EHLO
        mail-pg1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727549AbeJTAry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 20:47:54 -0400
Received: by mail-pg1-f179.google.com with SMTP id f18-v6so16010061pgv.3;
        Fri, 19 Oct 2018 09:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=ztzJP1FsXxgdEUxn/AIfayVUb2rvJpo3LnslRQw+uXw=;
        b=Vi21aRNDLQQG4/LEjBHr/HRmIGIe1q6KN6Y5axCR6Rj8lD/3JOcvRO275cE9oy1znd
         41jkwq9c4sOL+53x9jGqiagRBbbOE0tkNXT3/XZkriICTN+tgwfwHdnr1pdTQ6QhIz7b
         WD+++Fbe6nttnHED1UGYUoV1HlkFl6NcUbWS1bMiGfRyCb55RBUuP/UDJL+Otz77A/cP
         PfptkdcoTscTyiqytW6YXpHQleDvD8dHKjq6sTYyZIpLPpJmSGUEgIw40dKfEJqxeFde
         JUJ2HYIIWiql7WDW0yxeOxEy9WuPztYfiJ+80ictOzI5iBZuoED5KqlvroZyy/u3/TKA
         32ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=ztzJP1FsXxgdEUxn/AIfayVUb2rvJpo3LnslRQw+uXw=;
        b=j6++AU8kmPU1Qh7R3dDtjXtH3r0kcam5D1aRrE8jS8JtDJUFFWg/Iexz24XVZABiT7
         gidpoECyQIvmM+NArRujoKkm40Pq047h2NffthKerSl8sg58SAFYOnpc2Z2J65iGdLYe
         sboGsxPayrrYXGbH7VdzsCYshk0lFa/N0fSibdT37Hp4QjGadtPAzx4wncc/hW86NHf1
         luNorgj5/uyE52m6bnCMcue15Szf1ASz5iggXqixIu4GwzoYVjke0clenEagWtZRyAXa
         gw3oeeJMnCswgH0V4v5lrv4bIwc+qTO4zTTbjPFJBxcMNhDQ/j7ZP7wyh03iRt2zMGG/
         y1WQ==
X-Gm-Message-State: ABuFfoj5KYpQIySmhtyJB9QcY2366nmo/ZFUs/19TC6m1riarXLQw6jr
        omEl91ZFT7mzmUieF7YstQLrnrYS
X-Google-Smtp-Source: ACcGV635Gy7mDWaqruKnb/ejYEY2aK/Hoq+PYeutQfxwAN8/++S1LmH6T/0iIkcWzl6lHeJFhXe3dg==
X-Received: by 2002:a63:df4f:: with SMTP id h15-v6mr31884010pgj.94.1539967262633;
        Fri, 19 Oct 2018 09:41:02 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id i69-v6sm27950267pfe.106.2018.10.19.09.41.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Oct 2018 09:41:01 -0700 (PDT)
Date:   Fri, 19 Oct 2018 09:41:00 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Tree for Oct 19
Message-ID: <20181019164100.GA5319@roeck-us.net>
References: <20181019181653.198552cd@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181019181653.198552cd@canb.auug.org.au>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 19, 2018 at 06:16:53PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> News: I will not be doing linux-next releases next week.  Unfortunately
> this will probably be the first week of the merge window. :-(
> 
> Changes since 20181018:
> 
> The net-next tree gained a conflict against the net tree and a build
> failure due to an interaction with the rdma tree for which I applied a
> merge fix patch.
> 
> The kvm tree gained a conflict against the tip tree.
> 
> Non-merge commits (relative to Linus' tree): 11382
>  10233 files changed, 562372 insertions(+), 243395 deletions(-)
> 
> ----------------------------------------------------------------------------
> 

Build results:
	total: 135 pass: 125 fail: 10
Failed builds: 
	arm:allmodconfig 
	i386:allyesconfig 
	i386:allmodconfig 
	mips:allmodconfig 
	parisc:allmodconfig 
	powerpc:ppc6xx_defconfig
	s390:allmodconfig 
	sh:dreamcast_defconfig 
	sparc64:allmodconfig 
	xtensa:allmodconfig 
Qemu test results:
	total: 318 pass: 318 fail: 0

---
arm:allmodconfig, i386:allmodconfig, i386:allyesconfig, parisc:allmodconfig

ERROR: "__aeabi_uldivmod" [drivers/scsi/myrs.ko] undefined!
(and similar)

mips:allmodconfig, powerpc:ppc6xx_defconfig:

net/sunrpc/auth_gss/gss_krb5_seal.c: In function 'gss_seq_send64_fetch_and_inc':
net/sunrpc/auth_gss/gss_krb5_seal.c:145:3: error: implicit declaration of function 'cmpxchg64'

s390:allmodconfig, sparc64:allmodconfig:

ERROR: "__node_distance" [drivers/nvme/host/nvme-core.ko] undefined!

sh:dreamcast_defconfig:

drivers/cdrom/gdrom.c: In function 'probe_gdrom':
drivers/cdrom/gdrom.c:797:3: error: 'rc' undeclared

xtensa:allmodconfig:

drivers/net/ethernet/amazon/ena/ena_com.h: In function ‘ena_com_get_next_bounce_buffer’:
build/drivers/net/ethernet/amazon/ena/ena_com.h:1104:2: error: implicit declaration of function ‘prefetchw’

Guenter
