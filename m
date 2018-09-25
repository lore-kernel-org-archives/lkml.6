Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B909CC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 10:00:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78FAC2087A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 10:00:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78FAC2087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728744AbeIYQGw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 12:06:52 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:44301 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726927AbeIYQGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 12:06:52 -0400
Received: by mail-qt1-f194.google.com with SMTP id k38-v6so12642379qtk.11;
        Tue, 25 Sep 2018 03:00:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ojpoY/RW/BGU1Dxs0TXMFSXc2L/ph/XzGeGA11gBzBw=;
        b=raUWyuWL0fPEfNFSHodl70WMgTTIUkg3xRqf/pd9nDQjEExCGF/z13/etPj5kM454k
         nUFWLG5C/3VtyxgHiizQIxr9DV7/awIEPvsgsVpvBPpXIRxtQbg5I6sp404IXYKgC5kK
         rJMZeMDQnU/Ep4+t20OA/9wWU2q8QyWmRYkWM7mTn8lsUw4x7Xd8tZABw+wEEa7GStu8
         ppTZR2V+ZuGU0RqI+WzS3QKjcxO/Wt9rQ3eH1cFUxA8m4zSM4+qzYix867iIi7AjXYet
         qjYhEKICDJn4AvNndtU5L21LdB7I5Lfb0BE0PpCSCaZlfCE0yelHnU199vFNKmaJnXRS
         lVSA==
X-Gm-Message-State: ABuFfogyKylfXqpF2UlU9LrUAybIKmuKPEyjIxJvSC/FcOlOthiIbeDc
        0F8kwNLTtMGwJCORBR7nhAhhfnLHkAHByEEf04I=
X-Google-Smtp-Source: ACcGV60EWU5FaYEzQdAVJzkDFVnk4Ycwv0cIW4sSOpvCXtYh904ZBVdkipF6HjX7NSPyKg7CSCfqyCZjMLDkdSDpduU=
X-Received: by 2002:aed:2bc6:: with SMTP id e64-v6mr171540qtd.132.1537869605174;
 Tue, 25 Sep 2018 03:00:05 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1537276837.git.ren_guo@c-sky.com> <1ccf1bed89758a5a9b57ac2ce6d11ca898a1b9ae.1537276837.git.ren_guo@c-sky.com>
 <CAK8P3a0RDiP_R8+Lo9-nwiRS3k1NrtcsCFLi0Ww0TJGoAdb3iQ@mail.gmail.com> <20180925094601.GA2102@guoren>
In-Reply-To: <20180925094601.GA2102@guoren>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 25 Sep 2018 11:59:48 +0200
Message-ID: <CAK8P3a1bv_Kx5Jo3UOyC9y0fmrH1i2+HB3_=H7pkBfBxBH-nXA@mail.gmail.com>
Subject: Re: [PATCH V7 1/2] csky/dma: bugfix dma_sync_for_cpu/device
To:     Guo Ren <ren_guo@c-sky.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com,
        Greentime Hu <green.hu@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 11:46 AM Guo Ren <ren_guo@c-sky.com> wrote:
>
> On Mon, Sep 24, 2018 at 10:38:04PM +0200, Arnd Bergmann wrote:
> > On Tue, Sep 18, 2018 at 3:48 PM Guo Ren <ren_guo@c-sky.com> wrote:
> > >
> > > ref: https://lkml.org/lkml/2018/5/18/1068
> > >
> > >         map             for_cpu         for_device      unmap
> > > TO_DEV  writeback       none            writeback       none
> > > TO_CPU  invalidate      invalidate*     invalidate      invalidate*
> > > BIDIR   writeback       invalidate      writeback       invalidate
> > >
> > > Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> >
> > Same comment as for the other patch: Explain why the original
> > version is wrong first. When giving a reference to some other
> > discussion, use the "Link" tag above your Signed-off-by line.
> > To point to a discussion on lkml, lore.kernel.org is the
> > recommended archive, so it would become
> >
> > Link: https://lore.kernel.org/lkml/20180518215548.GH17671@n2100.armlinux.org.uk/
> Ok, I'll improve the comment:
>
> Fixup dma_mapping error in linux-4.19-rc3, and we must implement all
> DMA_TO_DEVICE/FROM_DEVICE/BIDIRECTIONAL for both sync_dma_for_device/cpu.
> The implementation of arch should follow the following rules:
>
> ...

That seems ok, but it's better to start with a description of the problem
rather than the 'Fixup dma_mapping error in linux-4.19-rc3' part.
I would write this like:

| The arch_sync_dma_for_cpu()/arch_sync_dma_for_device()
| implementation is broken for some combinations that end up
| in a BUG() instead of performing the necessary flushes.
|
| The implementation of arch should follow the following rules:
| ...

The imperative 'Fix up dma_mapping error ...' is what belongs
into the subject line, and is ideally revisited at the end of the
changelog comment if you want to add more detail about what
you do.

       Arnd
