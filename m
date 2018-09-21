Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5559C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 16:45:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FAC221565
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 16:45:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UL7q7gHn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FAC221565
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728149AbeIUWfZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 18:35:25 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41329 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388909AbeIUWfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 18:35:25 -0400
Received: by mail-pf1-f193.google.com with SMTP id h79-v6so6226261pfk.8
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 09:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=v3OKyYqIkHvpvzLFzz16EZV13E/xj6Hl40nSAfQrzqQ=;
        b=UL7q7gHnH3yzs+UtJ459rDyLujTVKtoZcusz18w6Oo0ewykoQl5pvr+rWt6MyJ4PdD
         a9PSHw+z3Of70C9TlJ/bkovO4TptpBlQVzJd7qd+OIgEJidn8ZRTWY2nhKUKc8ZSQGPK
         I436Jk0EqtvUtPICVuS1onGAEAM828KHRbXY0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=v3OKyYqIkHvpvzLFzz16EZV13E/xj6Hl40nSAfQrzqQ=;
        b=F5zD3DdlV+TQXsodNwNohfw/uvKRW9kTBLsIu61Nj2y3zd/hx3fxbxRosz7uV8Tw0c
         v+m2uhpkdTdtU0Ih9LSmVcZCOg4lWTdaZYHbkjAoaAZ63w0EUoDrB7AvUsx6WOjUeUiD
         2ZF5/SX8oEexZAQiKaYLWBbvdZolISxzIf6DmmomX1Csi8Xd9H9IKiNO/VECOOz4i1qi
         LWcWQbRKKehbFZ7fT5obzgYJ5Q9mlGc6jgz9S17cnRnw8vGuSFtDofWGq9+2EcO3ognJ
         6gjfvjCApP0WZ18WtcriAUekNCsenUROyYi6ZXxX8tVFg3/Qy+23ednyytT0eZh3Rk3V
         fdNw==
X-Gm-Message-State: APzg51C9757+Q8PS0KTZnepIDbrfspqvM1o9kg77TIMbLbTmXsotGZyf
        uKLVVZJFvFLUBDSCbBQQ4xHKaw==
X-Google-Smtp-Source: ANB0VdY2AeT2rVAfRh9/chzctT4gI2KAniUUoltMnbtujGYQDIR3XUYo+yH5Wvh0+trrpcBpC/wrdw==
X-Received: by 2002:a62:5d54:: with SMTP id r81-v6mr20266856pfb.88.1537548342407;
        Fri, 21 Sep 2018 09:45:42 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id t123-v6sm34483256pfd.51.2018.09.21.09.45.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Sep 2018 09:45:41 -0700 (PDT)
Date:   Fri, 21 Sep 2018 09:45:41 -0700
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
Message-ID: <20180921164541.GX22824@google.com>
References: <20180920223436.202454-1-mka@chromium.org>
 <0ea65ca1-8d06-72d8-3bbe-693e09605a8a@codeaurora.org>
 <20180920230121.GT22824@google.com>
 <36e5d881-a45e-c879-c275-e6e18bc99ed5@codeaurora.org>
 <20180920231947.GU22824@google.com>
 <124b6f76-a65f-e304-6c60-fbb9104415f4@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <124b6f76-a65f-e304-6c60-fbb9104415f4@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21, 2018 at 01:25:45AM -0400, Sinan Kaya wrote:
> On 9/20/2018 7:19 PM, Matthias Kaehlcke wrote:
> > If the existing users populate a custom property with the BD address
> > in the bootloader you could roll out a bootloader change. You'd have
> > to make sure that bootloader and kernel match. The bootloader could
> > still populate the custom property to be compatible with 'old'
> > kernels.
> 
> If there is no standard about the name of the property, this probably
> doesn't belong to property.c but should rather be hosted in bluetooth
> directory for consumption among the bluetooth drivers.

Well, there is a generic binding
(https://elixir.bootlin.com/linux/v4.18/source/Documentation/devicetree/bindings/net/bluetooth.txt),
the fact that there are drivers that aren't adhering to it doesn't
change that.
