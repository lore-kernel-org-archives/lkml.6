Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66E98C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 21:11:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1979C208D9
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 21:11:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gJXcm6xY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1979C208D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728388AbeIYDPR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 23:15:17 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34319 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728204AbeIYDPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 23:15:16 -0400
Received: by mail-pf1-f194.google.com with SMTP id k19-v6so9654079pfi.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 14:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=x3Lq9bZE2A+JUbhYNjLaNY+SBimEJCeYmCFgP6uBUhY=;
        b=gJXcm6xYuf1mZv0jCpCIa1i2J+QhClD+MakBM1Mj+2KOy9n8umhox8p4xtQQschVuR
         klnKxEPV+cOqu5kHZQpENHr0u5F63zrVsn2nYiFr1QW0c7DzG6lmiHa0kQKx3p6GArC3
         UH7fG1Q9nZrHt4zv4j/AiSeh6oBkAdfuVWSEs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=x3Lq9bZE2A+JUbhYNjLaNY+SBimEJCeYmCFgP6uBUhY=;
        b=aU/WZFX2wVv0w2viZHDDMHKGEB+uzIfmdsfYMT3PuhVTsYGh4j7ExyglPe2vE+251q
         xOJReUDnuU2wXBuTenTlk5U1VYyreTjCjEVWj6FBClwmWlxMnZ4FOlKnprD8BxIXbRnc
         gre9ljtuM8JIUARiaZhOFSD2LNu7ODE2hR1vKNqSawjHsaSMhiFFIyuT8KZ/CGVxa+SI
         zPpISbgDmEFwPf3/OI+uYWj9Tta1H/OStVAuKs3k8bkspEecg8O5D6U6ds5kOqfpucVx
         iS6hE2BpUjA/hJ7DadM4yyfMUXxc44pcaXI7BM4uTlXuffksMSrn4nMHA9tjAiKmkqT7
         nnQA==
X-Gm-Message-State: ABuFfohIU7w0FhYwQZEJstXM1AOn1xBauB+uKQ0arhLv3ZNlkJqU0dBd
        mvIX1j5DASZCv2FGNplz3LdI4w==
X-Google-Smtp-Source: ACcGV60rXIyuwzQKUQ/OVu5YNsSKROqIso7ZsuAxH38qWchxDXr1b0O87LCbLbZKes3bd1xFAeL6iA==
X-Received: by 2002:aa7:8191:: with SMTP id g17-v6mr503740pfi.71.1537823468582;
        Mon, 24 Sep 2018 14:11:08 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id o62-v6sm304708pfb.0.2018.09.24.14.11.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Sep 2018 14:11:08 -0700 (PDT)
Date:   Mon, 24 Sep 2018 14:11:07 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Marcin Wojtas <mw@semihalf.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-bluetooth@vger.kernel.org, bgodavar@codeaurora.org,
        Loic Poulain <loic.poulain@linaro.org>,
        Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH v2 1/2] device property: Add device_get_bd_address() and
 fwnode_get_bd_address()
Message-ID: <20180924211107.GA22824@google.com>
References: <20180924193352.96335-1-mka@chromium.org>
 <20180924193352.96335-2-mka@chromium.org>
 <CAHp75VdJfDnBqgn3DSKZe-pFg4eh2tjomRoz0gyQd-O3Aqi5kA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHp75VdJfDnBqgn3DSKZe-pFg4eh2tjomRoz0gyQd-O3Aqi5kA@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

thanks for your feedback!

On Mon, Sep 24, 2018 at 11:46:37PM +0300, Andy Shevchenko wrote:
> On Mon, Sep 24, 2018 at 10:36 PM Matthias Kaehlcke <mka@chromium.org> wrote:
> >
> > Provide an API for Bluetooth drivers to retrieve the Bluetooth Device
> > address (BD_ADDR) for a device. If the device node has a property
> > 'local-bd-address' the BD address is read from this property.
> 
> > diff --git a/include/linux/property.h b/include/linux/property.h
> > index ac8a1ebc4c1b..8926cf95d27e 100644
> > --- a/include/linux/property.h
> > +++ b/include/linux/property.h
> > @@ -15,6 +15,7 @@
> >
> >  #include <linux/fwnode.h>
> >  #include <linux/types.h>
> 
> > +#include <net/bluetooth/bluetooth.h>
> 
> Hmm... I don't understand why we need this complete header here.

Yes, this is what deterred me from passing bdaddr_t in the first place.

> If you are retrieving bdaddr_t type from it, so, better to move it to
> types.h first.

Sounds good to me if it is an acceptable solution to put something
bluetoothy in types.h.

> Sorry I didn't notice this before.
> 
> >  struct device;
> 
> > +int device_get_bd_address(struct device *dev, bdaddr_t *bd_addr);
> 
> > +int fwnode_get_bd_address(struct fwnode_handle *fwnode, bdaddr_t *bd_addr);
> 
> I don't remember if we discussed below...
> Since you put implementations under #ifdef, I'm not sure we can leave
> header w/o stubs for !CONFIG_BT case.
> I can imagine the case where some driver might use BT functionality
> optionally in which case this enforces ugly #ifdef in the driver.

To avoid another possible re-spin: do you prefer a single #ifdef, for
both device_get_bd_address() and fwnode_get_bd_address(), or keep the
strict grouping of device_*() and fwnode_*() functions?

Cheers

Matthias
