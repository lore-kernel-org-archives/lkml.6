Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EA78C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 23:47:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B50620894
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 23:47:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hfXePZFO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B50620894
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732074AbeHBBfr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 21:35:47 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45059 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbeHBBfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 21:35:46 -0400
Received: by mail-pg1-f194.google.com with SMTP id f1-v6so167754pgq.12;
        Wed, 01 Aug 2018 16:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=FVYnHHyRNeQ21znDeizxq5y0SmlgkgD2rxRXgdgg/9g=;
        b=hfXePZFOViPtwILCSXzQ6hp8fSoy8ArNX/DqN5RQLitENz0lOAztiAfdA5UxgYE/d8
         Q1R46HAsip6eogQkxbXqKJ2xwhYQyr4nQSMj4PhmZPIrAHU+6ck1Ig6zp/ujn613U0Vi
         Zhymx5O0TYCIh1Jn5fhdGT3j+DLX8QAqh4y4drCJs2cQvP6sy9fst0l3EzLd57ibDLOP
         p/y6UGv6C0P+c3yjcKg5F+KFuSwadbejrG5kOwJpXGlEw8FG/zWyTIXclW5YZboYIj0g
         z//g/+zzvhXC/haUqbKtPh3gaPeak28iGHR1j3P7Gk/miFe8uuOOHr4HSH4GItHIxsEx
         74gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=FVYnHHyRNeQ21znDeizxq5y0SmlgkgD2rxRXgdgg/9g=;
        b=U41yL9OBt28CP2DszbbB3SiZJJ5GSPKUd8u/C9GzgaWqbpososzfO5RS51t5WEKOr0
         BLcIVgR+UUsTP9u70ONPaBesYWa1/fGA4pG0q/u5ESpfdVWEHs7VXNMQ7V7cHK1fu45J
         WE4F7DUxXc+m5wgLXEoEO5p26ndyUnh89cc9qcssGAePJEgo4BoABPlgLpJS0zMZdAkZ
         P63mxE/oPahVTN4DWLTZNMu52Bm+zVc+hQpMZePKolt0NHtr2mB9AIqvGj2bBpfRN6XR
         wLCp1wB2dGdwxHW0SS5OAJ0Z41fSh2hkv6tXLg6Ej02Q51R4UlxL8rvQHc30fA3MDZf7
         XA2w==
X-Gm-Message-State: AOUpUlGzFO04z3D4RP7VFrygVldgaR61ZIep8oMlmPuf0+oVuVGWEuKl
        LpKiQwTbMJn3QLq+KJQqPWe6mnV6
X-Google-Smtp-Source: AAOMgpfnUWezk2grFu9mUOvxyd8uKtYYI5Bqx48RQK1IY6wQrofl2ypfu9iZDed/LQW4/gbFphGWQw==
X-Received: by 2002:a62:d24a:: with SMTP id c71-v6mr431924pfg.242.1533167249572;
        Wed, 01 Aug 2018 16:47:29 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id v20-v6sm318838pfk.12.2018.08.01.16.47.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Aug 2018 16:47:28 -0700 (PDT)
Date:   Wed, 1 Aug 2018 16:47:27 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-scsi <linux-scsi@vger.kernel.org>
Subject: Re: linux-next: Tree for Aug 1
Message-ID: <20180801234727.GA3762@roeck-us.net>
References: <20180801175852.36549130@canb.auug.org.au>
 <20180801224813.GA13074@roeck-us.net>
 <1533163965.3158.1.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1533163965.3158.1.camel@HansenPartnership.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 01, 2018 at 03:52:45PM -0700, James Bottomley wrote:
> On Wed, 2018-08-01 at 15:48 -0700, Guenter Roeck wrote:
> > On Wed, Aug 01, 2018 at 05:58:52PM +1000, Stephen Rothwell wrote:
> > > Hi all,
> > > 
> > > Changes since 20180731:
> > > 
> > > The pci tree gained a conflict against the pci-current tree.
> > > 
> > > The net-next tree gained a conflict against the bpf tree.
> > > 
> > > The block tree lost its build failure.
> > > 
> > > The staging tree still had its build failure due to an interaction
> > > with
> > > the vfs tree for which I disabled CONFIG_EROFS_FS.
> > > 
> > > The kspp tree lost its build failure.
> > > 
> > > Non-merge commits (relative to Linus' tree): 10070
> > >  9137 files changed, 417605 insertions(+), 179996 deletions(-)
> > > 
> > > -----------------------------------------------------------------
> > > -----------
> > > 
> > 
> > The widespread kernel hang issues are still seen. I managed
> > to bisect it after working around the transient build failures.
> > Bisect log is attached below. Unfortunately, it doesn't help much.
> > The culprit is reported as:
> > 
> > 2d542828c5e9 Merge remote-tracking branch 'scsi/for-next'
> > 
> > The preceding merge,
> > 
> > 453f1d821165 Merge remote-tracking branch 'cgroup/for-next'
> > 
> > checks out fine, as does the tip of scsi-next (commit 103c7b7e0184,
> > "Merge branch 'misc' into for-next"). No idea how to proceed.
> 
> This sounds like you may have a problem with this patch:
> 
>     commit d5038a13eca72fb216c07eb717169092e92284f1
>      Author: Johannes Thumshirn <jthumshirn@suse.de>
>      Date:   Wed Jul 4 10:53:56 2018 +0200
> 
>          scsi: core: switch to scsi-mq by default
> 
> To verify, boot with the additional kernel parameter
> 
> scsi_mod.use_blk_mq=0
> 
> Which will reverse the effect of the above patch.
> 
Yes, that fixes the problem.

Guenter

> We already have one report of this patch causing boot failures:
> 
> https://marc.info/?t=153305327000002
> 
> So I've added linux-scsi to see if they want any more information.
> 
> James
> 
> > 
> > Guenter
> > 
> > ---
> > bisect (mips:malta_defconfig and i386):
> > 
> > # bad: [d9bd94c0bcaa42d9cace337590718afd22c47bcc] Add linux-next
> > specific files for 20180801
> > # good: [acb1872577b346bd15ab3a3f8dff780d6cca4b70] Linux 4.18-rc7
> > git bisect start 'HEAD' 'v4.18-rc7'
> > # good: [f7952a1210bce43e88d69f371c6226aed481f307] Merge remote-
> > tracking branch 'spi-nor/spi-nor/next'
> > git bisect good f7952a1210bce43e88d69f371c6226aed481f307
> > # good: [fa3bb608cd0d41a02583a7ceb3d162c4dee7e0e4] Merge remote-
> > tracking branch 'spi/for-next'
> > git bisect good fa3bb608cd0d41a02583a7ceb3d162c4dee7e0e4
> > # good: [39c5cce976449c934b60e31cec9cea6986531b94] Merge remote-
> > tracking branch 'char-misc/char-misc-next'
> > git bisect good 39c5cce976449c934b60e31cec9cea6986531b94
> > # good: [453f1d8211658b75542f4581759f022420bdaea8] Merge remote-
> > tracking branch 'cgroup/for-next'
> > git bisect good 453f1d8211658b75542f4581759f022420bdaea8
> > # bad: [f11e9f9af170533e660c5deddccc4c494784c1fa] Merge remote-
> > tracking branch 'nvdimm/libnvdimm-for-next'
> > git bisect bad f11e9f9af170533e660c5deddccc4c494784c1fa
> > # bad: [d8a758324b2e012cdba05b82ecbda6b84905f6ec] Merge remote-
> > tracking branch 'rpmsg/for-next'
> > git bisect bad d8a758324b2e012cdba05b82ecbda6b84905f6ec
> > # good: [97fe222524f8fdbcc528b44d160d1df71d96af86] scsi: arcmsr: Fix
> > error of resuming from hibernation for adapter type E
> > git bisect good 97fe222524f8fdbcc528b44d160d1df71d96af86
> > # bad: [2d542828c5e94490480b2900f8a0cb7a8c46afb0] Merge remote-
> > tracking branch 'scsi/for-next'
> > git bisect bad 2d542828c5e94490480b2900f8a0cb7a8c46afb0
> > # good: [cc74e31d4147f26ead6ea06e4649d63a14edc0fe] scsi: lpfc: remove
> > null check on nvmebuf
> > git bisect good cc74e31d4147f26ead6ea06e4649d63a14edc0fe
> > # good: [dc335a995527fb1ee9ec5649162b22cd1ce728ee] scsi: tcmu: unmap
> > if dev is configured
> > git bisect good dc335a995527fb1ee9ec5649162b22cd1ce728ee
> > # good: [d92f5db64445ac4e2ce9a2cb7e6c929a5f4e712b] Merge branch
> > 'misc' into for-next
> > git bisect good d92f5db64445ac4e2ce9a2cb7e6c929a5f4e712b
> > # good: [0e0d75267107e6a557ea9314d55bcff05a6ede44] scsi: tcmu: use
> > u64 for dev_size
> > git bisect good 0e0d75267107e6a557ea9314d55bcff05a6ede44
> > # good: [c8a75afbf72ee4c16dad5339f55f62095879f207] Revert "scsi:
> > target/iscsi: Reduce number of __iscsit_free_cmd() callers"
> > git bisect good c8a75afbf72ee4c16dad5339f55f62095879f207
> > # good: [103c7b7e01849d3c5bc998168ccd4df2c443d24b] Merge branch
> > 'misc' into for-next
> > git bisect good 103c7b7e01849d3c5bc998168ccd4df2c443d24b
> > # first bad commit: [2d542828c5e94490480b2900f8a0cb7a8c46afb0] Merge
> > remote-tracking branch 'scsi/for-next'
> > 
> 
