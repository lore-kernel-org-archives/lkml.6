Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C7FEC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 08:10:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 155F2224E6
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 08:10:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="fq4DnXrU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 155F2224E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933950AbeGDIKO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 04:10:14 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34820 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932701AbeGDIIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 04:08:11 -0400
Received: by mail-ed1-f68.google.com with SMTP id b10-v6so3403240edi.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 01:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=w66l6tz+r9p4F+Eoe4KThD6XXTh3DwUn+pN+Ovv0ArA=;
        b=fq4DnXrU9XfzzdzAnxiW9bpfRcYcKQ2ZwlsPkbG4+UFrySbzX7JrLhzBqoWuSgk8Px
         f7c5M/CpUgJT2mehgkzrWcePFOT9KZ+DO92XdBqWkyefpfN5UFvMxMe0SFF3Xb8MjBKa
         XCulOex7ut42nVMCAVxAvktVHNz4CIumsc4gc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=w66l6tz+r9p4F+Eoe4KThD6XXTh3DwUn+pN+Ovv0ArA=;
        b=azekGri5CRNszWY7Ep5KsSO8x56DdSpfEyY/wtlOfc7hu5wqCTS1OXOIqWfNXuinRu
         dR1Ok9uXwCghkkFA1vWCVBL4EHEm8c3xgyMHAH1DQWS0Cj2idP2TrKpgPnh7SE5wiCYu
         0bTfposyKZ25PDjETZs8yXwHGghgLVazsQgB4zs7CavQMCmaPaVW9FxHmb0lR+kNx9LA
         83pBSu1QED/IaX2Jkl9ouBHlwNOfslPMdLQvB/+zmenC0IcrK9OqrIWSXY/0xu+IwZmh
         oTtim+70xBis763eSeFKSdYBUn3QziB+jt1iWwYaR3IDZtpurbXSGrK0vB8jk2HHrZvP
         F/SA==
X-Gm-Message-State: APt69E0Q46nGBgUdR+g8z741LRcE1BH+i69or0LJaFGGvpYAXZxWuzrq
        s7DwDMgw+qOB47MyBoYPEhLHDA==
X-Google-Smtp-Source: AAOMgpdcHbRDLZ3ijVt1yc51ifPGGVOJD83Y+RN5OB+aRLji3Y4YzJQtYVu+CL0a7CEBuUKQ+bweYg==
X-Received: by 2002:a50:bb41:: with SMTP id y59-v6mr1683861ede.10.1530691690319;
        Wed, 04 Jul 2018 01:08:10 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:5628:0:496f:7dc5:66d7:a057])
        by smtp.gmail.com with ESMTPSA id j34-v6sm1656944edd.2.2018.07.04.01.08.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Jul 2018 01:08:09 -0700 (PDT)
Date:   Wed, 4 Jul 2018 10:08:07 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Shuah Khan <shuah@kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v6] Add udmabuf misc device
Message-ID: <20180704080807.GH3891@phenom.ffwll.local>
Mail-Followup-To: Gerd Hoffmann <kraxel@redhat.com>,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Shuah Khan <shuah@kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DMA BUFFER SHARING FRAMEWORK" <linux-media@vger.kernel.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
References: <20180703075359.30349-1-kraxel@redhat.com>
 <20180703083757.GG7880@phenom.ffwll.local>
 <20180704055338.n3b7oexltaejqmcd@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180704055338.n3b7oexltaejqmcd@sirius.home.kraxel.org>
X-Operating-System: Linux phenom 4.16.0-2-amd64 
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 04, 2018 at 07:53:38AM +0200, Gerd Hoffmann wrote:
> On Tue, Jul 03, 2018 at 10:37:57AM +0200, Daniel Vetter wrote:
> > On Tue, Jul 03, 2018 at 09:53:58AM +0200, Gerd Hoffmann wrote:
> > > A driver to let userspace turn memfd regions into dma-bufs.
> > > 
> > > Use case:  Allows qemu create dmabufs for the vga framebuffer or
> > > virtio-gpu ressources.  Then they can be passed around to display
> > > those guest things on the host.  To spice client for classic full
> > > framebuffer display, and hopefully some day to wayland server for
> > > seamless guest window display.
> > > 
> > > qemu test branch:
> > >   https://git.kraxel.org/cgit/qemu/log/?h=sirius/udmabuf
> > > 
> > > Cc: David Airlie <airlied@linux.ie>
> > > Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> > > Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > > Cc: Daniel Vetter <daniel@ffwll.ch>
> > > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> > 
> > I think some ack for a 2nd use-case, like virtio-wl or whatever would be
> > really cool. To give us some assurance that this is generically useful.
> 
> Tomeu?  Laurent?
> 
> > Plus an ack from dma-buf folks (nag them on irc, you don't have them on Cc
> > here).
> 
> Hmm, does MAINTAINERS need an update then?  Maintainer and mailing lists
> listed in the "DMA BUFFER SHARING FRAMEWORK" entry are on Cc.

Yeah, maintainers entry with you as maintainer plus dri-devel as mailing
list plus drm-misc as repo would be good. Just grep for drm-misc.git for
tons of examples.

> Who should be Cc'ed?

dim add-missing-cc ftw :-)

Cheers, Daniel
> 
> > Then this is imo good to go.
> > 
> > I assume you'll push it to drm-misc, like all the other dma-buf stuff?
> 
> Can do that, sure, after collecting the acks ...
> 
> thanks,
>   Gerd
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-doc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
