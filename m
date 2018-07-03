Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56FC1C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 21:56:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8D002470D
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 21:56:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="I7ss9akH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8D002470D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753353AbeGCV4E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 17:56:04 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:43080 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753105AbeGCV4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 17:56:02 -0400
Received: by mail-pf0-f193.google.com with SMTP id y8-v6so1621257pfm.10
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 14:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HIP7axhqdfg1saSb7ZGRzcPCu5QRgd68kjMfMPzXt1c=;
        b=I7ss9akH+NT6sc3a3BQl5QeI7jCfYuZL3VUg6pTyDEHVx5EhFBihPT3eOrufbVzSIa
         8YZad0WAVzBTnfAjl0HeFOcWWtYR14Ju7PZvG+dsUr/Eoc1GHuBZt7o/gu9eoq3rKue7
         iNFZKjf8pQ/c6k7DTJcMFKyGOIifFATyNXYMg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HIP7axhqdfg1saSb7ZGRzcPCu5QRgd68kjMfMPzXt1c=;
        b=GuzAWetB/CzUdLxgA8Lpb5sGD1XzEzVjAmtihV2pr+TwJYdHUe2Xym2U8BCsTQk1Pm
         HapnblLAlzcIQfXg8iYmdaQOHMjHzYBnF7hfKbmemprGXe8kKGd4LmGkoDRfGOi4xRuq
         H5H6HAKo+EFSVcFHJPTTH9nhVNm1uCrSPZJziD50jS7uOw3NfY/0+Wx0EGnPDTFaKVMy
         Q4u9Pci3nDJ5knIpbi5Lo5jjwV3VkkEIYG1TtXaU3N0VuTn4has2V1317u8KCVr5KQcp
         Aa/hdZnill3n+1xGmVT807bYkCL+SnQnuPjnljW55j/S7J19lucFMmjexgZsDfQ+yHOs
         4akg==
X-Gm-Message-State: APt69E2AccV/i4Kvh+OxcdNKXPiDxv1UA9bjPsmi6aoanL88TuWRQnUl
        lwgKYtNksEplyWtEcrcSaVxpEw==
X-Google-Smtp-Source: AAOMgpd8cCZQIHOzdHQ4Sp0yVdw1GNgK3bw2YSqQQrKG23tXJvvZcc+l+7I0INCJYJcng7aiWIX71Q==
X-Received: by 2002:a62:2119:: with SMTP id h25-v6mr18537868pfh.112.1530654961638;
        Tue, 03 Jul 2018 14:56:01 -0700 (PDT)
Received: from ban.mtv.corp.google.com ([2620:0:1000:1501:bc2f:3082:9938:5d41])
        by smtp.gmail.com with ESMTPSA id a25-v6sm3343557pgv.51.2018.07.03.14.55.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 14:56:00 -0700 (PDT)
Date:   Tue, 3 Jul 2018 14:55:57 -0700
From:   Brian Norris <briannorris@chromium.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Govind Singh <govinds@codeaurora.org>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        ath10k@lists.infradead.org, bjorn.andersson@linaro.org,
        david.brown@linaro.org, andy.gross@linaro.org
Subject: Re: [PATCH v2 0/6]  *** Add support for wifi QMI client driver ***
Message-ID: <20180703215556.GA15106@ban.mtv.corp.google.com>
References: <20180605123304.31969-1-govinds@codeaurora.org>
 <20180619021742.GA17220@rodete-desktop-imager.corp.google.com>
 <87woucnxkh.fsf@kamboji.qca.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87woucnxkh.fsf@kamboji.qca.qualcomm.com>
User-Agent: Mutt/1.10+33 (2f90ec28cf74) (2018-06-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jul 03, 2018 at 06:33:34PM +0300, Kalle Valo wrote:
> Brian Norris <briannorris@chromium.org> writes:
> > On Tue, Jun 05, 2018 at 06:03:04PM +0530, Govind Singh wrote:
> >> Add QMI client driver for Q6 integrated WLAN connectivity subsystem.
> >> This module is responsible for communicating WLAN control messages to FW
> >> over QMI interface.
> >> 
> >> QUALCOMM MSM Interface(QMI) provides the control interface between
> >> components running b/w remote processors with underlying transport layer
> >> based on integrated chipset(shared memory) or discrete chipset(PCI/USB/SDIO/UART).
> >
> > So this seems to imply QMI would work with transports that are not
> > integrated. Except, your code is directly calling SNOC (one of your
> > integrated chipset interfaces) code from the QMI driver. Correct? I
> > suppose that's OK for now, but it's a little misleading. If you actually
> > intend this to support multiple transports, then you might instead want
> > a callback interface for this.
> 
> Sure. But do we even know that the QMI interfaces are even compatible?
> AFAIK QMI is just an RPC protocol, so there's no guarantee about
> interface stability. So I don't see the need to support other interfaces
> until we know exactly what we need to implement.

I think my questions were meant more of clarifying questions rather than
proper suggestions. If your explanation is correct, then I'd figure this
language should mention that we're implementing a handshake specific to
SNOC (or WCN3990), instead of appearing to be agnostic.

> >> QMI client driver implementation is based on qmi frmework https://lwn.net/Articles/729924/.
> >> 
> >> Below is the sequence of qmi handshake.
> >> 
> >>        QMI CLIENT(APPS)                                         QMI SERVER(FW in Q6)
> >> 
> >>                          <------wlan service discoverd----
> >> 
> >>                        -----connect to wlam qmi service----->
> >> 
> >>                        ------------wlan info request----->
> >> 
> >>                        <------------wlan info resp------------
> >> 
> >>                        ------------msa info req-------->
> >> 
> >>                      <------------msa info resp------------
> >> 
> >>                      ------------msa ready req-------->
> >> 
> >>                      <------------msa ready resp------------
> >> 
> >>                      <------------msa ready indication-------
> >> 
> >>                      ------------capability req------->
> >> 
> >>                     <------------capability resp------------
> >> 
> >>                     ------------qmi bdf req--------->
> >> 
> >>                      <------------qmi bdf resp------------
> >> 
> >>                       ------------qmi cal trigger------->
> >> 
> >>                   <------------ QMI FW ready indication-------
> >
> > Let's see if I'm interpreting this right:
> >
> >  * The above process is just initiating a handshake with the QMI
> >    service and doesn't actually do any loading of firmware on its own;
> >    it just hands things off to the SNOC client driver (and ath10k core)
> >    once the firmware is magically ready (??)
> >  * The ATH10K_FW_FEATURE_NON_BMI flag you added previously basically
> >    provides a way for a driver (and now we see which driver; it's this
> >    QMI / SNOC driver) to completely sidestep the typicaly in-kernel
> >    firmware load implementation; in fact, the kernel only reads the
> >    WLAN firmware just to parse some feature flags, not to actually
> >    program it to the device
> >  * Some yet-unmentioned proprietary app is involved to handle
> >    sideloading the actual firmware from user space
> >
> > Is this correct? If not, please correct me. But if it is:
> >
> >  * When does the user space app actually load the WLAN firmware? I'm not
> >    sure I can place it in the above diagram.

BTW, I think Govind answered most of these questions, but IMO, those
sorts of clarifying bits should be in the documentation here. Maybe in
the cover letter here, but also in either the patch description(s) or
code comments. It's nice to retain some of this architectural
description in the git history somehow -- particularly, to note what
outside dependencies there are.

> >  * Is there any open source implementation of this? How am I supposed to
> >    actually use this driver, if it relies on proprietary components that
> >    I can't review and aren't really even mentioned?
> >
> > I hope I'm sorely wrong on this. But if I'm not, I don't see why this
> > driver should be merged at all. Linux drivers should be self-sufficient
> > wherever possible, and I don't see a good reason why this driver can't
> > manage actually loading the WLAN firmware on its own, similar to how the
> > BMI component of the ath10k driver loads firmware for other ath10k
> > transports. But even more importantly: I believe this driver is hiding
> > the fact that it relies on undocumented proprietary components to run on
> > the CPU [1] just to make use of it at all.
> 
> First of all, thanks for bringing this up! I was aware of the need of
> user space tools to download the firmware to Q6 but I assumed they were
> Open Source, which to my surprise they were not. An upstream driver
> definitely needs to have open user space components so that anyone can
> use it, and hence I cannot apply these until that's solved. Luckily
> Bjorn has been working on that and he has done good progress on those,
> though I think there were some issues still.

Good to hear Bjorn is working on this. I've been asking through other
channels too, and I don't have anything more than lip service. In fact,
I've been told the opposite at times -- that I won't get source. But
then, I'm quite aware that the right hand often doesn't know what the
left hand is doing ;)

Anything you and Bjorn can do to help push this along would be great,
because while I'd love to have this driver upstream, this is a huge
sticking point for me.

Thanks,
Brian
