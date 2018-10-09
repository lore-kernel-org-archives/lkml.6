Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 064E8C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 06:18:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A8D8213A2
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 06:18:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mhFnOx6X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A8D8213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbeJINeN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 09:34:13 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50698 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbeJINeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 09:34:12 -0400
Received: by mail-wm1-f65.google.com with SMTP id i8-v6so554062wmg.0;
        Mon, 08 Oct 2018 23:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HM09PGBY2ytl7mNWGz2Om3d/Lo3xcyZgj5G8IHVFuhU=;
        b=mhFnOx6XBun9MIRpFZQA3CtYh9noKZruRCFZ2S22PYFEgsMAe2DzVFBqv1Z7utIxGt
         JBz7OU8QO9AxK6GHy1/npRdgmY58NoDkR2uJeATs9SzQ3ygVThiV9tUa5sehbBh/nVz2
         Na9HhCRn0cYexGqsP3/DLAY8Qxol2JEQ/euGYt495WU0Tc+NE7CmO66YxhrEXiMEJX28
         WY7195lfaksncYoot+8jXBTaOpsxupUFafMapYg26YNlio8pC6sMQFOnd22MbEunUjnk
         PWwvYB/bHABaeabrtxeXjOnzHSPs316PuefEysc4lMXMFJ44O/EMcO0BBWwlb/jVPNtw
         3jdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=HM09PGBY2ytl7mNWGz2Om3d/Lo3xcyZgj5G8IHVFuhU=;
        b=EVJMqkOo5oYArkRLj1nIidsMJUqVYG/4BLUVH/lvce1QbVYhJHGFCR3hhNXvSYFutm
         CbSZ/YygkI3C0IvowmRmkNpO4q9OIOcDpNt75tAQpTJeqo184+e0+myEtFq1EdqXe0vw
         QQ14KvjlJJIV0GCiVoV6jcobugOPAu0nTcJCtb7+SM9lhzXMAyuwb4b9Xlav6VrUK5J6
         USbY+/kkzGPC3VZCXyHTQxD/ruZznTC9yfPMaty4U5uO1Mmw8XDeiiAfqmYKEcTnyFRZ
         ggyjHrmzyLf21gsjSmmc9gTZ9oyakFbgxyl+/Xy2KaijhQzW45ZHljCG5c9PaY5ad6Qh
         38Ew==
X-Gm-Message-State: ABuFfoiOOnxWFNegtNr5dNbCSmam9rLZsC7FL4d34lwQY5CDEErNfqCf
        n91RpkDISwD5A7M+0Ltv0bs=
X-Google-Smtp-Source: ACcGV63arkFtXV54PMqxp84ifFtxOLF25uyIIEKwYDX7BHNj42XentPzKWv3ZEH/ijHeo3TMXDob0g==
X-Received: by 2002:a1c:3b89:: with SMTP id i131-v6mr716901wma.27.1539065932589;
        Mon, 08 Oct 2018 23:18:52 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id l67-v6sm34013030wma.20.2018.10.08.23.18.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Oct 2018 23:18:51 -0700 (PDT)
Date:   Tue, 9 Oct 2018 08:18:49 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Adam Borowski <kilobyte@angband.pl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/defconfig: Enable CONFIG_USB_XHCI_HCD
Message-ID: <20181009061849.GC116930@gmail.com>
References: <20181008103223.15362-1-kilobyte@angband.pl>
 <20181008131944.GB20703@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181008131944.GB20703@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> On Mon, Oct 08, 2018 at 12:32:23PM +0200, Adam Borowski wrote:
> > A spanking new machine I just got has all but one USB ports wired as 3.0.
> > Booting defconfig resulted in no keyboard or mouse, which was pretty
> > uncool.  Let's enable that -- USB3 is ubiquitous rather than an oddity.
> > As 'y' not 'm' -- recovering from initrd problems needs a keyboard.
> > 
> > Signed-off-by: Adam Borowski <kilobyte@angband.pl>
> > ---
> >  arch/x86/configs/x86_64_defconfig | 1 +
> >  1 file changed, 1 insertion(+)
> 
> defconfig for x86 actually still works?  That's amazing in itself :)

Many of my test machines are able to boot the x86 defconfig bzImage to a shell,
so it's more like an "Ingo's minconfig". ;-)

/me tries to look innocently but fails miserably

> > diff --git a/arch/x86/configs/x86_64_defconfig b/arch/x86/configs/x86_64_defconfig
> > index e32fc1f274d8..ac9ae487cfeb 100644
> > --- a/arch/x86/configs/x86_64_defconfig
> > +++ b/arch/x86/configs/x86_64_defconfig
> > @@ -243,6 +243,7 @@ CONFIG_USB_HIDDEV=y
> >  CONFIG_USB=y
> >  CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
> >  CONFIG_USB_MON=y
> > +CONFIG_USB_XHCI_HCD=y
> >  CONFIG_USB_EHCI_HCD=y
> >  CONFIG_USB_EHCI_TT_NEWSCHED=y
> >  CONFIG_USB_OHCI_HCD=y
> 
> You can probably turn ehci and ohci off if you have xhci in the
> "default" system now.

Also, could we please refresh this in the 32-bit defconfig as well.

Other than that the patch looks good to me, no objections to adding
convenience options for people who have actually booted the thing
on reasonably common PC hardware.

Thanks,

	Ingo
