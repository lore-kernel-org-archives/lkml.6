Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FA9FC07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 22:21:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DAAC2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 22:21:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LTht1MZD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DAAC2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726226AbeLGWVm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 17:21:42 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:35074 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbeLGWVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 17:21:41 -0500
Received: by mail-qk1-f196.google.com with SMTP id w204so3373620qka.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 14:21:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bJxUlgTmsaS8fuwXArl8GxPiUBt33y/J439wHG3P8PM=;
        b=LTht1MZDvzdopQ598WNILnpK/tZo3H5TYDABx1tTbr7uttNvtF/Ia4PF7F3/Nt+aeW
         2uimUo38thBirpN0Qb8wu45D6Yd+7gVgShrakKgTanrUdgI8LNJbJHwhjHWOCRCJuOIk
         r/ImLl36tjkkqJ/sxS9/9b3sff26CJe/w3gEE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bJxUlgTmsaS8fuwXArl8GxPiUBt33y/J439wHG3P8PM=;
        b=jlPVp3QPSh2B6xzh9HwPHKP+gawbxgRscipi3Rdaa8OCcf3KiADzQye/ucOgvv4HR9
         TP8WdEuyChdBU+dgfRAZTiYc5NQc8boUBe0n0Cw2Vv31HKk8QhxPH0zm0hOqHb11VuoX
         1VMA9P5ItBlH7hnrgljv2tAyGws5q3O5a745ECPHGI0jWL/pmbukkegh1RFvs+t1zynr
         cPDyeh9BMg5DWAuWgVX8xvnAGfK0H33/Erj5eTtbpiJbW2TpuHSpwhtYMPkr4ZI2Cw2w
         JOU9arX+83tAGKi53TnG4oADaZ9LTu3AEA1+cIdXR9dVZc10w8SOPiAewv1Vo92zYeoy
         oOrQ==
X-Gm-Message-State: AA+aEWb9D2wlczCQcEV5fScKraT59PQy27nSkqCrjqYWqCYwa9LVW7gR
        k9lcaJrm9NsDsGYXet1vLzmuOQ==
X-Google-Smtp-Source: AFSGD/Xo9hgwBfkEiIJugsvwxPSMpDxKA6bdCqFjzw0IWJHIgpOELmMOOOueRXcFTsGb4t0kEBxDCg==
X-Received: by 2002:a37:492:: with SMTP id 140mr3447029qke.95.1544221300395;
        Fri, 07 Dec 2018 14:21:40 -0800 (PST)
Received: from google.com ([2620:0:1003:510:59af:10e9:2d49:6b0a])
        by smtp.gmail.com with ESMTPSA id t140sm2100383qke.6.2018.12.07.14.21.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Dec 2018 14:21:40 -0800 (PST)
Date:   Fri, 7 Dec 2018 17:21:38 -0500
From:   Kyle Williams <kdgwill@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Jack Stocker <jackstocker.93@gmail.com>,
        Michael =?iso-8859-1?Q?Niew=F6hner?= <linux@mniewoehner.de>,
        Nico Sneck <snecknico@gmail.com>,
        Tim Anderson <tsa@biglakesoftware.com>,
        Danilo Krummrich <danilokrummrich@dk-develop.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: quirks: add NO_LPM quirk for Logitech
 Flare|Meetup|Brio|Rally
Message-ID: <20181207222138.GB161210@google.com>
References: <CAAd214WBzcsFamzqkdTp0AYDRo1=Uq1=Z5fJhzkOZ6znVFo3MA@mail.gmail.com>
 <20181205093902.GA18633@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181205093902.GA18633@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2018 at 10:39:02AM +0100, Greg Kroah-Hartman wrote:
> On Tue, Dec 04, 2018 at 03:38:25PM -0500, Kyle Williams wrote:
> > Description: Some USB device / host controller combinations seem to have
> > problems with Link Power management. In particular it is described that
> > the combination of certain Logitech devices and other powered media
> > devices such as the Atrus device causes 'not enough bandwidth for
> > new device state'error.
> > 
> > This patch creates quirk entries for the tested Logitech device
> > indicating LPM should remain disabled for the device.
> > 
> > Signed-off-by: Kyle Williams <kdgwill@chromium.org>
> > ---
> >  drivers/usb/core/quirks.c | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> 
> Along with what Alan said, this patch was sent in html mode, making it
> impossible to apply, and it was rejected by the mailing lists.
> 
> Please fix up your email client before resending patches.  Or just use
> 'git send-email'.
> 
> thanks,
> 
> greg k-h

Thanks for explaining why the patches were being rejected by the mailing
lists. I will move to using git send-email for sending patches and mutt
for sending replies in the future.

Kyle Williams
