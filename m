Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0BD1C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 22:18:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60CF92083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 22:18:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YMTY47s9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60CF92083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726103AbeLGWSq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 17:18:46 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:45440 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbeLGWSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 17:18:45 -0500
Received: by mail-qk1-f194.google.com with SMTP id y78so3331368qka.12
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 14:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4W1VwuD2kPryvvlk9RK8pYdfRhAqGGwxKUVPoohv6JI=;
        b=YMTY47s9iF3Cue/P1sn/ti59j8Tdr7rZLvahmwArsr43kXAFOM82o5kNnSGHlx2gXO
         5rcAjPYqwvNacIbencQG6G1bH+7WN/MWpxbcipl0XnVnS3lQZ5/8lIAAFtaFjT72VcUx
         hxBLA4sG1JuKVGvvbPpgZUjs0UcOjSnh6cW4c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4W1VwuD2kPryvvlk9RK8pYdfRhAqGGwxKUVPoohv6JI=;
        b=RGs75C0v3amyWxLopFmBNdgQNZsHSfeM3C1e5IMc6QvqVcM94d3qgThEpR771+bPEK
         QYAa0pzHsFvLVBCADrVprwhNPd2ihhn2m5kp8JGiTuJU3Ga6eDOZYmsrAI4vcIzniNTl
         L6DcU6D8iMhNQ5YEqPo5Q32Hf09CuhmDJ7/9aK/+zhrf15z9aNfqUFRb304NxL3e37jQ
         5Wdp7cJk42nW95u70POY6lxYaSLPSi/WtKUwW5RZLxch/wXttD5ttnPbAP2CMWQS6nan
         p97DraYiFB+W1V+6J7wV8KwfgbPJSQm7ABpJ7GIVmBjGPIOW+UK+QjQWHJpNg6htIBLT
         Y6/Q==
X-Gm-Message-State: AA+aEWbtmHM05RqZSD83Qpx97C6f1M9qsr+v6WtV8y8D3jN2KfdT0tq6
        ukQ87Lfvwswdx7d5IWzVJkUehA==
X-Google-Smtp-Source: AFSGD/UYJN0DdRfdKlxkrzkJR5qRAcudUcsruZ/oUcqne0KMrFnXeEcbiRH2qdMyWmDSoLVo/ffFNA==
X-Received: by 2002:a37:6005:: with SMTP id u5mr3247315qkb.219.1544221124140;
        Fri, 07 Dec 2018 14:18:44 -0800 (PST)
Received: from google.com ([2620:0:1003:510:59af:10e9:2d49:6b0a])
        by smtp.gmail.com with ESMTPSA id j95sm2541558qtb.74.2018.12.07.14.18.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Dec 2018 14:18:43 -0800 (PST)
Date:   Fri, 7 Dec 2018 17:18:41 -0500
From:   Kyle Williams <kdgwill@chromium.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     linux-usb@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Jack Stocker <jackstocker.93@gmail.com>,
        Michael =?iso-8859-1?Q?Niew=F6hner?= <linux@mniewoehner.de>,
        Nico Sneck <snecknico@gmail.com>,
        Tim Anderson <tsa@biglakesoftware.com>,
        Danilo Krummrich <danilokrummrich@dk-develop.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: quirks: add NO_LPM quirk for Logitech
 Flare|Meetup|Brio|Rally
Message-ID: <20181207221841.GA161210@google.com>
References: <CAAd214WBzcsFamzqkdTp0AYDRo1=Uq1=Z5fJhzkOZ6znVFo3MA@mail.gmail.com>
 <Pine.LNX.4.44L0.1812041633580.1537-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1812041633580.1537-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2018 at 04:36:18PM -0500, Alan Stern wrote:
> On Tue, 4 Dec 2018, Kyle Williams wrote:
> 
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
> > 
> > diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
> > index 0690fcff0ea2..9403edee4797 100644
> > --- a/drivers/usb/core/quirks.c
> > +++ b/drivers/usb/core/quirks.c
> > @@ -246,6 +246,22 @@ static const struct usb_device_id usb_quirk_list[] = {
> >         /* Logitech Harmony 700-series */
> >         { USB_DEVICE(0x046d, 0xc122), .driver_info = USB_QUIRK_DELAY_INIT },
> > 
> > +       /* Logitech Flare */
> > +       { USB_DEVICE(0x046d, 0x0876), .driver_info = USB_QUIRK_NO_LPM },
> 
> This entry is out of order with the preceding entry.  And some of the 
> new entries below are out of order with each other (entries are 
> supposed to be sorted by Vendor ID, then Product ID).
> 
> Also, perhaps instead of adding all these new entries, we should set 
> the NO_LPM quirk flag for all Logitech devices?
> 
> Alan Stern
Setting USB_QUIRK_NO_LPM for all Logitech devices instead of specific
ones seem to be a better solution as there are a lot of other devices
that have the issue as well

Kyle Williams
> 
> > +
> > +       /* Logitech Rally Camera */
> > +       { USB_DEVICE(0x046d, 0x0881), .driver_info = USB_QUIRK_NO_LPM },
> > +       { USB_DEVICE(0x046d, 0x0888), .driver_info = USB_QUIRK_NO_LPM },
> > +       { USB_DEVICE(0x046d, 0x0889), .driver_info = USB_QUIRK_NO_LPM },
> > +
> > +       /* Logitech Meetup */
> > +       { USB_DEVICE(0x046d, 0x0867), .driver_info = USB_QUIRK_NO_LPM },
> > +       { USB_DEVICE(0x046d, 0x0866), .driver_info = USB_QUIRK_NO_LPM },
> > +       { USB_DEVICE(0x046d, 0x086a), .driver_info = USB_QUIRK_NO_LPM },
> > +
> > +       /* Logitech Brio */
> > +       { USB_DEVICE(0x046d, 0x085e), .driver_info = USB_QUIRK_NO_LPM },
> > +
> >         /* Philips PSC805 audio device */
> >         { USB_DEVICE(0x0471, 0x0155), .driver_info = USB_QUIRK_RESET_RESUME
> > },
> > 
> > 
> 
