Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8230C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 15:59:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B494D218AD
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 15:59:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Rsj1R9x7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729735AbfBFP7C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 10:59:02 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37657 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726989AbfBFP7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 10:59:01 -0500
Received: by mail-ed1-f68.google.com with SMTP id h15so6309757edb.4
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 07:59:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=fmPmPo/9O32fv4X6GrI0hzcwV0S8jsNtK+HzIrBALy0=;
        b=Rsj1R9x7jBN+9XD/35icuoqmGdy4auVmehU0l4PKY8TlqSGHq+EnpmfxZhiihINuJN
         fAgW/sJ2BJy2lsL/8jY8OkH4Si2SmSvge3YCsxY+mV2Otk+Y/oDU9vEULEXckOoAAzyd
         3l72A3uogriz+1OAjhsM6cZt+WLnti5b4MXrc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=fmPmPo/9O32fv4X6GrI0hzcwV0S8jsNtK+HzIrBALy0=;
        b=ewpe+VWXMfckxaD1m9MvjKync8xwjTkc+CZTRqeCOm421SOK9aVbahpZkNKJGxc0sa
         /5xsMeA5Bi5EftA79PD+BfYbl800MBeGI86EqiuAiC5NKAzmpoxAV2u9WU8dweawNp3B
         u9+AOvHjlL2HhIJayHPPDmW6SMpjVB2d9cNWl8wew/wEt2aj2J1Hrk0lz1Wf7DqejFQm
         hXPdjnDuJWmfQEMvtb4mGLvxsxUqF8ZaAEDgJduVpeSOCdErf88wAI+7l6482ZeA8MWF
         qIin4o3Yw2i9WDxnp3fCDbHrhX7hBQRmI4OFqTe3mhRiqUs/mVIJOtLueXZ1p3HzAUJP
         Ue3A==
X-Gm-Message-State: AHQUAuarJi0Evvsnl9x7ASXZG6YvA1NIgEBNdNs9KhSaPYDUz85VDOn8
        xGEphcsKDjdboSIsi5wXDYMGK+jeWaM=
X-Google-Smtp-Source: AHgI3IbMXDKLyAfR77AAwqCik//8kID8IwdO5X9VZKNMIXER3tWJ/7XM4QbiR8YjSaiXjkWCMCQPRg==
X-Received: by 2002:a50:bae3:: with SMTP id x90mr8962193ede.221.1549468739444;
        Wed, 06 Feb 2019 07:58:59 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id x47sm6184549eda.91.2019.02.06.07.58.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Feb 2019 07:58:58 -0800 (PST)
Date:   Wed, 6 Feb 2019 16:58:56 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Nicholas Mc Guire <der.herr@hofr.at>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Fabio Rafael da Rosa <fdr@pid42.net>
Subject: Re: [PATCH 2/2] staging/vboxvideo: Add TODO
Message-ID: <20190206155856.GK3271@phenom.ffwll.local>
Mail-Followup-To: Sam Ravnborg <sam@ravnborg.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Nicholas Mc Guire <der.herr@hofr.at>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Fabio Rafael da Rosa <fdr@pid42.net>
References: <20190204103114.30772-1-daniel.vetter@ffwll.ch>
 <20190204103114.30772-2-daniel.vetter@ffwll.ch>
 <20190204185416.GC2834@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190204185416.GC2834@ravnborg.org>
X-Operating-System: Linux phenom 4.19.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 04, 2019 at 07:54:16PM +0100, Sam Ravnborg wrote:
> Hi Daniel
> 
> On Mon, Feb 04, 2019 at 11:31:14AM +0100, Daniel Vetter wrote:
> > Noticed why wonder what vboxvideo is using the ->master_set/drop hooks
> > for.
> Can you improve the gammar a little, I find it hard to read.
> 
> > 
> > Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Fabio Rafael da Rosa <fdr@pid42.net>
> > Cc: Nicholas Mc Guire <der.herr@hofr.at>
> > Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> > Cc: Hans de Goede <hdegoede@redhat.com>
> > ---
> >  drivers/staging/vboxvideo/TODO | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/staging/vboxvideo/TODO b/drivers/staging/vboxvideo/TODO
> > index 2e0f99c3f10c..2953e7f794fb 100644
> > --- a/drivers/staging/vboxvideo/TODO
> > +++ b/drivers/staging/vboxvideo/TODO
> > @@ -1,5 +1,7 @@
> >  TODO:
> >  -Get a full review from the drm-maintainers on dri-devel done on this driver
> > +-Drop all the logic around initial_mode_queried/master_set&_drop and everything
> > +related to this. kms clients can handle hotplugs.
> >  -Extend this TODO with the results of that review
> >  
> >  Please send any patches to Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
> 
> The syntax around "master_set&_drop" could be better.
> I wondered if the "&" was some rst syntax.
> 
> But anyway, despite grammar nit and syntax nit:
> Reviewed-by: Sam Ravnborg <sam@ravnborg.org>

Both patches queued for 5.1 in drm-misc, thanks for taking a look.

> Which bring me back to a question asked a week ago or so.
> What is missing before we can move vboxvideo out of staging/

I think it boils down to someone needs to submit it and we'll take a look.

> Could we carry a few TODO items over in drm/ ar do we need a clean TODO?

We carry todos in drm too, it's going to be a judgement call.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
