Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6A11C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 15:20:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6115F20833
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 15:20:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="aoqvieQk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6115F20833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729975AbeIRUx2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 16:53:28 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:40200 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727348AbeIRUx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 16:53:28 -0400
Received: by mail-io1-f68.google.com with SMTP id l14-v6so1864380iob.7
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 08:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=ryAEL7a48nNcYMS3LWfkHKzI6ZASI9BfB7LspkPM5Eo=;
        b=aoqvieQkVCQavRzd/oDa4/DQymw2EXsfmyZEDijx23gmsM98yAx8la0CYVfxgwmEGi
         /veVA0ihk/W3BhcJ9FzJ+oXAuzYkM/Glr9pDGuqdRFFli3XjTmDs6zulx5GWd5lcgrHf
         gMy08FX6YnyxynOdNsnKN7C6x60be3MxxYC9E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=ryAEL7a48nNcYMS3LWfkHKzI6ZASI9BfB7LspkPM5Eo=;
        b=XyE9AuKJ61fia+8UmMp1JDshtb6yCtVHPaajMIA9maMjVYXhoICIuN6vuShVLd29sO
         Hi2EoYlNIzeNohs3/XoExVt6gzbT5s9eeS6fJjAIFbR6csyz0YSy+3f6tbPP8XK5TxPr
         yLrTMe1cHpZm8jOSk/rM5fRjhteSEeS6frdy6rDxnEROcTY9Yx2GjIKs5/TxtLg84l9k
         m2ttgM1pqNFb7ZegFuX6p8B/7MWsk24b4mnlzQfr6y2ElOTeh8Ei8zXZb1mq6QvR6PrK
         9upXiWLNrakeonErrEWh0pZ2chN8x3hBpZz2CZoM9TBjhUH3ZHDHptzHnUq2KTQ74n2N
         kCAA==
X-Gm-Message-State: ABuFfogHXteKQNwkq5niUa0Tgp8nBC/ggXP/h6fvv/oeDo8jVaWFL5R/
        6j10D7f5DunaITfBst1oPFksG9vUehZ7KJky/ckzQg==
X-Google-Smtp-Source: ACcGV60fQ6qLESJ5Y63LfuVdOSreFkunGhK9KLpDnPmSRknIx/5Hj/AFoWBwsrCJgkhBlwEJHF8PRG89CM+i6hkfHtM=
X-Received: by 2002:a5e:d50d:: with SMTP id e13-v6mr1337951iom.291.1537284025137;
 Tue, 18 Sep 2018 08:20:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:6cc5:0:0:0:0:0 with HTTP; Tue, 18 Sep 2018 08:20:24
 -0700 (PDT)
X-Originating-IP: [2a02:168:569e:0:3106:d637:d723:e855]
In-Reply-To: <20180918150244.GA21766@kroah.com>
References: <1534472646-10368-1-git-send-email-zhongjiang@huawei.com>
 <5BA112BC.8080108@huawei.com> <20180918150244.GA21766@kroah.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Tue, 18 Sep 2018 17:20:24 +0200
X-Google-Sender-Auth: licR9BPTNy9sbLfU1NGIRj1m4o0
Message-ID: <CAKMK7uGCKEy_4WtroMfk91A=j7yOo3_kgXVjNq120JNgivFVYA@mail.gmail.com>
Subject: Re: [PATCH] gpu: do not double put device node in zx_drm_probe
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     zhong jiang <zhongjiang@huawei.com>,
        Dave Airlie <airlied@linux.ie>,
        Shawn Guo <shawnguo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2018 at 5:02 PM, Greg KH <gregkh@linuxfoundation.org> wrote:
> On Tue, Sep 18, 2018 at 10:59:08PM +0800, zhong jiang wrote:
>> Hi,  Greg
>>
>> Can you pick up the patch?
>
> Nope:
> $ ./scripts/get_maintainer.pl --file drivers/gpu/drm/zte/zx_drm_drv.c
> Shawn Guo <shawnguo@kernel.org> (maintainer:DRM DRIVERS FOR ZTE ZX)
> David Airlie <airlied@linux.ie> (maintainer:DRM DRIVERS)
> dri-devel@lists.freedesktop.org (open list:DRM DRIVERS FOR ZTE ZX)
> linux-kernel@vger.kernel.org (open list)
>
> why would I take thi when all of those others are the correct
> maintainers?
>
> Also, you only posted this 1 day ago.  Please relax and give people time
> and a chance to review your patch.  It is not instant.

First submission was in August, acked by Shawn, but somehow they
forgot to actually push the patch out. I pinged Shawn.

Thanks, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
