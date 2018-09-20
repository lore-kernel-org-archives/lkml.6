Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA682ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 23:19:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69D7721533
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 23:19:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FmeIjXi1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69D7721533
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725949AbeIUFFn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 01:05:43 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45905 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725749AbeIUFFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 01:05:43 -0400
Received: by mail-pl1-f193.google.com with SMTP id j8-v6so5024921pll.12
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 16:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HHWr1H9UzjuOQqP4vhMmeMkx3yPqQP7vJDP3kstLq44=;
        b=FmeIjXi1iKP8iUABaIl4p084hopv+LScTGILoQzaIksozEcdROt57uZVmGOi5bzlOE
         Gl6640DEhcIm87vbomZhBXJ24zgOec1Tjna0wlRjvRLy9hoLQHjZPmVFyzQf5e3BRkEV
         4XOFHWyGD8tNj2+nKYTAROpY/g/UwMNCOkCNQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HHWr1H9UzjuOQqP4vhMmeMkx3yPqQP7vJDP3kstLq44=;
        b=EKmuDU2BDgY2skCaTA9hqU7lp046npDPuKFwwPqOZzwC0a2c1GcBnMpITMJY13da7/
         67cnws/KgB0PV4Gw0eCIsGL/FqQzALvMjb00byi7c3XOeMsuXQ/93QPQZcvZDvG9vp6J
         ChK4TNH0ZEUU79O0jQO3zmftGlKnbj9Kw+ncoDtM+TWjZ9rwdTiQpDkmPJUkS5htY8LH
         gQVEi39GEfB0a4O4gyji3sEfXEEtOsMMAQOPS0iT9F5ELI0l0GXceS8sEuCuIx4+hReC
         K0NJbDxmafjc5FLjC+PnBLeCpupMQM+Z3uwUV6a0WY/PU0YKrdgTjAj6SGb//DNZmQ2d
         8aVw==
X-Gm-Message-State: APzg51An5oJPt8iOpTyubmrCIdZt4I3jk5NeUgpmN0oA3+awgg+ovHfd
        nVDqCnXtcYVAq2x0igAt5lndfQ==
X-Google-Smtp-Source: ANB0VdZNOdkFG4HDBHvRnVi7Hbc0BHBw83pi7hR4E4K1lSqPrwNAb59kz1ztyRacrBohZz6QUPJgtA==
X-Received: by 2002:a17:902:1025:: with SMTP id b34-v6mr733572pla.201.1537485588987;
        Thu, 20 Sep 2018 16:19:48 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id y4-v6sm30895292pfm.137.2018.09.20.16.19.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Sep 2018 16:19:48 -0700 (PDT)
Date:   Thu, 20 Sep 2018 16:19:47 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Sinan Kaya <okaya@codeaurora.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Marcin Wojtas <mw@semihalf.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH 0/2] Add API to retrieve the Bluetooth Device Address
 (BD_ADDR)
Message-ID: <20180920231947.GU22824@google.com>
References: <20180920223436.202454-1-mka@chromium.org>
 <0ea65ca1-8d06-72d8-3bbe-693e09605a8a@codeaurora.org>
 <20180920230121.GT22824@google.com>
 <36e5d881-a45e-c879-c275-e6e18bc99ed5@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <36e5d881-a45e-c879-c275-e6e18bc99ed5@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2018 at 07:03:15PM -0400, Sinan Kaya wrote:
> On 9/20/2018 7:01 PM, Matthias Kaehlcke wrote:
> > Certainly true if this was the only driver. However another one will
> > follow soon and 'local-bd-address' is the official binding, so it's
> > not unlikely there will be more.
> 
> I was missing this information.

https://elixir.bootlin.com/linux/latest/source/Documentation/devicetree/bindings/net/bluetooth.txt

> Is there a way to convert existing users to this if any as well?

It depends.

If the existing users use a *really* reasonable name for the property
and use the same format it could be an option to add it to the lookup
besides 'local-bd-address', similar to what fwnode_get_mac_address()
does.

If the existing users populate a custom property with the BD address
in the bootloader you could roll out a bootloader change. You'd have
to make sure that bootloader and kernel match. The bootloader could
still populate the custom property to be compatible with 'old'
kernels.
