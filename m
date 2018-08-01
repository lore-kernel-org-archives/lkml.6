Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5CE9C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 22:52:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5176C20844
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 22:52:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="uqvMVvYH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5176C20844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732364AbeHBAkw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 20:40:52 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:55972 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731516AbeHBAkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 20:40:52 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 3804E8EE13D;
        Wed,  1 Aug 2018 15:52:47 -0700 (PDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id LnOcQOLbgfVD; Wed,  1 Aug 2018 15:52:47 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id A03608EE079;
        Wed,  1 Aug 2018 15:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1533163966;
        bh=oFjJircmtxSk9oP21qLwKvDHZzpyApKEwh446rm0HHI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=uqvMVvYHbYkHeMMc1omKicQ9UH4eVmM7YJEjl+xnl0jDuW29ahr1NN/aTzxR1ETdF
         3Dol4pOL5MbBkS3lR5KzoTqGilnit/quB3cCtL1wSvmtWRze5gOkAGruwWwChnJNEf
         IT3BXrJ6PC+U87zzUJpHMYZdz36CJqlJy23MfkWY=
Message-ID: <1533163965.3158.1.camel@HansenPartnership.com>
Subject: Re: linux-next: Tree for Aug 1
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-scsi <linux-scsi@vger.kernel.org>
Date:   Wed, 01 Aug 2018 15:52:45 -0700
In-Reply-To: <20180801224813.GA13074@roeck-us.net>
References: <20180801175852.36549130@canb.auug.org.au>
         <20180801224813.GA13074@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-08-01 at 15:48 -0700, Guenter Roeck wrote:
> On Wed, Aug 01, 2018 at 05:58:52PM +1000, Stephen Rothwell wrote:
> > Hi all,
> > 
> > Changes since 20180731:
> > 
> > The pci tree gained a conflict against the pci-current tree.
> > 
> > The net-next tree gained a conflict against the bpf tree.
> > 
> > The block tree lost its build failure.
> > 
> > The staging tree still had its build failure due to an interaction
> > with
> > the vfs tree for which I disabled CONFIG_EROFS_FS.
> > 
> > The kspp tree lost its build failure.
> > 
> > Non-merge commits (relative to Linus' tree): 10070
> >  9137 files changed, 417605 insertions(+), 179996 deletions(-)
> > 
> > -----------------------------------------------------------------
> > -----------
> > 
> 
> The widespread kernel hang issues are still seen. I managed
> to bisect it after working around the transient build failures.
> Bisect log is attached below. Unfortunately, it doesn't help much.
> The culprit is reported as:
> 
> 2d542828c5e9 Merge remote-tracking branch 'scsi/for-next'
> 
> The preceding merge,
> 
> 453f1d821165 Merge remote-tracking branch 'cgroup/for-next'
> 
> checks out fine, as does the tip of scsi-next (commit 103c7b7e0184,
> "Merge branch 'misc' into for-next"). No idea how to proceed.

This sounds like you may have a problem with this patch:

    commit d5038a13eca72fb216c07eb717169092e92284f1
     Author: Johannes Thumshirn <jthumshirn@suse.de>
     Date:   Wed Jul 4 10:53:56 2018 +0200

         scsi: core: switch to scsi-mq by default

To verify, boot with the additional kernel parameter

scsi_mod.use_blk_mq=0

Which will reverse the effect of the above patch.

We already have one report of this patch causing boot failures:

https://marc.info/?t=153305327000002

So I've added linux-scsi to see if they want any more information.

James

> 
> Guenter
> 
> ---
> bisect (mips:malta_defconfig and i386):
> 
> # bad: [d9bd94c0bcaa42d9cace337590718afd22c47bcc] Add linux-next
> specific files for 20180801
> # good: [acb1872577b346bd15ab3a3f8dff780d6cca4b70] Linux 4.18-rc7
> git bisect start 'HEAD' 'v4.18-rc7'
> # good: [f7952a1210bce43e88d69f371c6226aed481f307] Merge remote-
> tracking branch 'spi-nor/spi-nor/next'
> git bisect good f7952a1210bce43e88d69f371c6226aed481f307
> # good: [fa3bb608cd0d41a02583a7ceb3d162c4dee7e0e4] Merge remote-
> tracking branch 'spi/for-next'
> git bisect good fa3bb608cd0d41a02583a7ceb3d162c4dee7e0e4
> # good: [39c5cce976449c934b60e31cec9cea6986531b94] Merge remote-
> tracking branch 'char-misc/char-misc-next'
> git bisect good 39c5cce976449c934b60e31cec9cea6986531b94
> # good: [453f1d8211658b75542f4581759f022420bdaea8] Merge remote-
> tracking branch 'cgroup/for-next'
> git bisect good 453f1d8211658b75542f4581759f022420bdaea8
> # bad: [f11e9f9af170533e660c5deddccc4c494784c1fa] Merge remote-
> tracking branch 'nvdimm/libnvdimm-for-next'
> git bisect bad f11e9f9af170533e660c5deddccc4c494784c1fa
> # bad: [d8a758324b2e012cdba05b82ecbda6b84905f6ec] Merge remote-
> tracking branch 'rpmsg/for-next'
> git bisect bad d8a758324b2e012cdba05b82ecbda6b84905f6ec
> # good: [97fe222524f8fdbcc528b44d160d1df71d96af86] scsi: arcmsr: Fix
> error of resuming from hibernation for adapter type E
> git bisect good 97fe222524f8fdbcc528b44d160d1df71d96af86
> # bad: [2d542828c5e94490480b2900f8a0cb7a8c46afb0] Merge remote-
> tracking branch 'scsi/for-next'
> git bisect bad 2d542828c5e94490480b2900f8a0cb7a8c46afb0
> # good: [cc74e31d4147f26ead6ea06e4649d63a14edc0fe] scsi: lpfc: remove
> null check on nvmebuf
> git bisect good cc74e31d4147f26ead6ea06e4649d63a14edc0fe
> # good: [dc335a995527fb1ee9ec5649162b22cd1ce728ee] scsi: tcmu: unmap
> if dev is configured
> git bisect good dc335a995527fb1ee9ec5649162b22cd1ce728ee
> # good: [d92f5db64445ac4e2ce9a2cb7e6c929a5f4e712b] Merge branch
> 'misc' into for-next
> git bisect good d92f5db64445ac4e2ce9a2cb7e6c929a5f4e712b
> # good: [0e0d75267107e6a557ea9314d55bcff05a6ede44] scsi: tcmu: use
> u64 for dev_size
> git bisect good 0e0d75267107e6a557ea9314d55bcff05a6ede44
> # good: [c8a75afbf72ee4c16dad5339f55f62095879f207] Revert "scsi:
> target/iscsi: Reduce number of __iscsit_free_cmd() callers"
> git bisect good c8a75afbf72ee4c16dad5339f55f62095879f207
> # good: [103c7b7e01849d3c5bc998168ccd4df2c443d24b] Merge branch
> 'misc' into for-next
> git bisect good 103c7b7e01849d3c5bc998168ccd4df2c443d24b
> # first bad commit: [2d542828c5e94490480b2900f8a0cb7a8c46afb0] Merge
> remote-tracking branch 'scsi/for-next'
> 

