Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45213ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 20:11:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0140E2084E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 20:11:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0140E2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730328AbeGRUub (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 16:50:31 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:46293 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729262AbeGRUub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 16:50:31 -0400
Received: by mail-qt0-f195.google.com with SMTP id d4-v6so5219352qtn.13
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 13:11:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=RKeFE7DAnwOtCWtMyGPCTe7O2exVwnfR2BzDPjpGnxs=;
        b=qoTNY+NF/Qh18oZxMKaBryMJYUQNSOBVkdPcEouuaE/jkT/g+6U3jg+UiQfuggkPSl
         4h0iRsUsEqt3EU/uJmGAUPJtws/IRBPplBPqyojos5NDrREr4pKWxFj0w4bmljeOjbHY
         F/qtyLGoOlvCLXrbDN9UzkKkzkCsr+Snhr99XupanrnQQcznWKNP9jjaxl83OZz7W0wk
         bU63fU8AlWrIr1+bSFJ8wDtMX4NkfimhFMajc9BrNNDZvii5+48rhEDn5Qnxn99QxwMI
         A9dy5OMoJVYpYKUpkd81KY1lbhjWBqegJr3iaNCPfrObzq8QdnPyF9LAs0005g0E2EXf
         mp1w==
X-Gm-Message-State: AOUpUlGHB+5oKciPariU8EYlp1aJm7VGaukLDT8uCe9MUnsu09X5vV+3
        CTicZ8j4piQ7rKZmUu99+68org==
X-Google-Smtp-Source: AAOMgpe0pUO6t0SPzKV0DmsmMLcmO48zWt5GLkzEQ2IvGaoVSf4C+Q1q384UI/hO4D0/Vr03nLccng==
X-Received: by 2002:ac8:2f84:: with SMTP id l4-v6mr7175209qta.83.1531944661591;
        Wed, 18 Jul 2018 13:11:01 -0700 (PDT)
Received: from dhcp-10-20-1-11.bss.redhat.com ([144.121.20.162])
        by smtp.gmail.com with ESMTPSA id f11-v6sm2698777qkb.43.2018.07.18.13.11.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Jul 2018 13:11:00 -0700 (PDT)
Message-ID: <2724dd5eee8a1e4e523e43915fa184ad5afe1c59.camel@redhat.com>
Subject: Re: [Nouveau] [PATCH 1/5] drm/nouveau: Prevent RPM callback
 recursion in suspend/resume paths
From:   Lyude Paul <lyude@redhat.com>
To:     Lukas Wunner <lukas@wunner.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     nouveau@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        Linux PM <linux-pm@vger.kernel.org>
Date:   Wed, 18 Jul 2018 16:11:00 -0400
In-Reply-To: <20180718083601.GC16072@wunner.de>
References: <20180716235936.11268-1-lyude@redhat.com>
         <20180716235936.11268-2-lyude@redhat.com> <20180717071641.GA5411@wunner.de>
         <d7c25a7f41df70685c0c4726315592d1d9b561ff.camel@redhat.com>
         <20180717182041.GA18363@wunner.de>
         <CAJZ5v0g8O8J0U8V-gLMe+NnTd3xgZ5_pjr9p2oci7yAfW54B-A@mail.gmail.com>
         <20180718082505.GB16072@wunner.de> <20180718083601.GC16072@wunner.de>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.3 (3.28.3-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-07-18 at 10:36 +0200, Lukas Wunner wrote:
> On Wed, Jul 18, 2018 at 10:25:05AM +0200, Lukas Wunner wrote:
> > The GPU contains an i2c subdevice for each connector with DDC lines.
> > I believe those are modelled as children of the GPU's PCI device as
> > they're accessed via mmio of the PCI device.
> > 
> > The problem here is that when the GPU's PCI device runtime suspends,
> > its i2c child device needs to be runtime active to suspend the MST
> > topology.  Catch-22.
> > 
> > I don't know whether or not it's necessary to suspend the MST topology.
> > I'm not an expert on DisplayPort MultiStream transport.
> > 
> > BTW Lyude, in patch 4 and 5 of this series, you're runtime resuming
> > pad->i2c->subdev.device->dev.  Is this the PCI device or is it the i2c
> > device?  I'm always confused by nouveau's structs.  In nvkm_i2c_bus_ctor()
> > I can see that the device you're runtime resuming is the parent of the
> > i2c_adapter:
> > 
> > 	struct nvkm_device *device = pad->i2c->subdev.device;
> > 	[...]
> > 	bus->i2c.dev.parent = device->dev;
> > 
> > If the i2c_adapter is a child of the PCI device, it's sufficient
> > to runtime resume the i2c_adapter, i.e. bus->i2c.dev, and this will
> > implicitly runtime resume its parent.
> 
> Actually, having written all this I just remembered that we have this
> in the documentation:
> 
>     8. "No-Callback" Devices
> 
>     Some "devices" are only logical sub-devices of their parent and cannot
> be
>     power-managed on their own. [...]
> 
>     Subsystems can tell the PM core about these devices by calling
>     pm_runtime_no_callbacks().
> 
> So it might actually be sufficient to just call pm_runtime_no_callbacks()

I would have hoped so, but unfortunately it seems that
pm_runtime_no_callbacks() is already called by default for i2c adapters in
i2c_register_adapter(). Unfortunately this really can't fix the problem
though, because it will still try to runtime resume the parent device of the
i2c adapter, which still leads to deadlocking in the runtime suspend/resume
path.

Additionally; I did play around with ignore_children, but unfortunately this
isn't good enough either as it just means that our i2c devices won't wake the
GPU up on access.

I'm pretty stumped here on trying to figure out any clean way to handle this
in the PM core if recursive resume calls are off the table. The only possible
solution I could see to this is if we could disable execution of runtime
callbacks in the context of a certain task (while all other tasks have to
honor the runtime PM callbacks), do what we need to do in suspend, then re-
enable them
> for the i2c devices...
> 
> Lukas
-- 
Cheers,
	Lyude Paul
