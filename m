Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46BA1C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 12:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA18820833
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 12:11:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="b6zlLZrm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA18820833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727626AbeIKRKw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 13:10:52 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43786 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbeIKRKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 13:10:51 -0400
Received: by mail-ed1-f65.google.com with SMTP id z27-v6so19040958edb.10
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 05:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=chNh33E14PeeuEFZ0HCvg8b1xy178fueSIQoA1swfzk=;
        b=b6zlLZrmJRRA+2JH1Dn+66U6G8WdH8PM+ey7WCFQNBt/cFbLwwp9Qrys0xf3VzmBIK
         n2uyxKXwf5n7If8jfcrnlF4KWuJx1UVqDm+Er2CF+u6XSR61g9MmwKVzc2paY7NR7xWf
         xkYvEloFDdG2RCcCXoRpykYEdT2xzrtxJwrFQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=chNh33E14PeeuEFZ0HCvg8b1xy178fueSIQoA1swfzk=;
        b=dD0PfuS7x9/6IiIvO3pKI1qwrMc1D0V0q1qxUzOMGDW2sa2+Yf4BqJFSCAwtdazHtB
         E4E4u+tjndtbd0/XELksWPEuPgM6e85nLEoEj8Ky0eX9BCLgtjLVgmU8eyhrMnfvzXRZ
         6i45FDdc55MvozM9W3ZpEBsFRHiqPwIkUAqACYQnSg+d9t1yBl95vCDwvhNgC0f9oiOh
         /g4/3Zm0X929fv+3h5hHNqnUj+3v7SknSBCH1zp5ndczYNIWtPFcDVIgv7BBu5qccnDR
         5CAiLpY2mo4NzfbQ2frfLiinJrKHp9egIWyuDwSwNkHHA986fI2DVtieTNBsnxeCTC61
         biDQ==
X-Gm-Message-State: APzg51BowE3EI3g/q4NRL0vUUaa0Bx3ZD9yRRH8V6S6ufwc7XGaJT8KK
        E3pOoLBW2YD9Vl6F+mFdaip5Ew==
X-Google-Smtp-Source: ANB0VdZC9/9+KW/GXv9WqXlnQ4sIAsn8HYMb3CteiPi1mnL4cyNh79uodTN2r/WZCUl6kV3yzYtpVA==
X-Received: by 2002:a50:91da:: with SMTP id h26-v6mr28071585eda.87.1536667907448;
        Tue, 11 Sep 2018 05:11:47 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id l16-v6sm9702165edb.41.2018.09.11.05.11.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Sep 2018 05:11:46 -0700 (PDT)
Date:   Tue, 11 Sep 2018 14:11:43 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Joe Perches <joe@perches.com>,
        Meng Xu <mengxu.gatech@gmail.com>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        Thomas Meyer <thomas@m3y3r.de>,
        Mike Frysinger <vapier@chromium.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Thierry Reding <treding@nvidia.com>,
        David Lechner <david@lechnology.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: [PATCH 2/4] vt: Remove vc_panic_force_write
Message-ID: <20180911121143.GJ19774@phenom.ffwll.local>
Mail-Followup-To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>, Joe Perches <joe@perches.com>,
        Meng Xu <mengxu.gatech@gmail.com>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        Thomas Meyer <thomas@m3y3r.de>,
        Mike Frysinger <vapier@chromium.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Thierry Reding <treding@nvidia.com>,
        David Lechner <david@lechnology.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Daniel Vetter <daniel.vetter@intel.com>
References: <20180822085405.10787-1-daniel.vetter@ffwll.ch>
 <20180822085405.10787-2-daniel.vetter@ffwll.ch>
 <20180822085919.GA32014@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180822085919.GA32014@kroah.com>
X-Operating-System: Linux phenom 4.14.0-3-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 22, 2018 at 10:59:19AM +0200, Greg Kroah-Hartman wrote:
> On Wed, Aug 22, 2018 at 10:54:03AM +0200, Daniel Vetter wrote:
> > It was only used by the panic support in fbcon, which is now gone.
> > Remove this now dead code too.
> > 
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Kees Cook <keescook@chromium.org>
> > Cc: Joe Perches <joe@perches.com>
> > Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> > Cc: Meng Xu <mengxu.gatech@gmail.com>
> > Cc: Nicolas Pitre <nicolas.pitre@linaro.org>
> > Cc: Thomas Meyer <thomas@m3y3r.de>
> > Cc: Mike Frysinger <vapier@chromium.org>
> > Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > Cc: Hans de Goede <hdegoede@redhat.com>
> > Cc: Thierry Reding <treding@nvidia.com>
> > Cc: David Lechner <david@lechnology.com>
> > Cc: Philippe Ombredanne <pombredanne@nexb.com>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Kate Stewart <kstewart@linuxfoundation.org>
> > Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> > ---
> 
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Queued for 4.20/5.0 in drm-misc-next together with the other patches in
this series.
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
