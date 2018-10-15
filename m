Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CD05C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 18:03:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E91EE214C4
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 18:03:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CmCBMp8r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E91EE214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbeJPBtp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 21:49:45 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39258 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726684AbeJPBtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 21:49:45 -0400
Received: by mail-pf1-f193.google.com with SMTP id c25-v6so10077123pfe.6
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 11:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=qOxFujzbXf8YZAlgFAV+Pi1Bg2i72lRl+Yf2EFdt664=;
        b=CmCBMp8rNRdDbqsaUTjS4tr9IhE0h/ZB1pQX5jqWeyvTqEk6sZuXQZy1RO7AMnSygg
         BxJGhUpE+YgDDaPSLpwNKhkHMP7CYthoRBgBPq/mQ5WUw4O6nskISBHqlKUr4d3KmxR+
         b2EGBEic/6QnLUe6uSAy4nM51bzYhKHFFLLAg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=qOxFujzbXf8YZAlgFAV+Pi1Bg2i72lRl+Yf2EFdt664=;
        b=ZGHE7/AoGU6B0P9mxBSQLgvRkA/bzuCnixbmZ+WgRfzNRBeiK8fVl2br8NSbUxRA0U
         odTCW1GhEgh2sFvs3s53SgYb9Drhvmlkiu26ajTxxIj2cNEhNwC4oA/f32sr/Ur6QHnT
         wIOP47DmFBdqcC1EfXYtBHF8MQXyMWoZjb2cBJQI3Z9+IRq+2/Xkn3cUaaU+RHZ9pGrv
         0xd7y6IGcuD7/iwwrx8YFu5DDCMT198/pIFXOhrwMAdWe02aJJjlRYmGsGAqOC/CJhSR
         m3SEY/L8Re5VGBekqIgFC5sdIXIJxLBA95IhhVmP2RLTPSN/ydrA1Z56fKSj7niEnkqq
         30pQ==
X-Gm-Message-State: ABuFfohAybycDc/0WNwPjtoPeo0RPG7Wmp5bzMMpFCUxu2TLw9Ckc2S9
        43frl2t52MYi23+uzvEOSLTkXA==
X-Google-Smtp-Source: ACcGV60y9KmXc0KQyH25cdaUigqGJaZbLbtzotJdihQsmLW7L9f9UliFs0jFCICR55GJIls+7453ig==
X-Received: by 2002:a62:9015:: with SMTP id a21-v6mr18645789pfe.49.1539626606600;
        Mon, 15 Oct 2018 11:03:26 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id b62-v6sm23282552pfa.159.2018.10.15.11.03.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Oct 2018 11:03:25 -0700 (PDT)
Date:   Mon, 15 Oct 2018 11:03:25 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Marcin Wojtas <mw@semihalf.com>,
        Andy Shevchenko Andy Shevchenko <andy.shevchenko@gmail.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        Loic Poulain <loic.poulain@linaro.org>,
        Brian Norris <briannorris@chromium.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH v4 1/2] Bluetooth: Add device_get_bd_address()
Message-ID: <20181015180325.GS22824@google.com>
References: <20180927004810.124185-1-mka@chromium.org>
 <20180927004810.124185-2-mka@chromium.org>
 <b28c34475e447cc29a139f9121b3c1d9@codeaurora.org>
 <e6752d4b-b22a-d951-e9db-1ae7445dc403@codeaurora.org>
 <20180927171305.GG22824@google.com>
 <20181004173338.GL22824@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181004173338.GL22824@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcel,

please let me know if any changes are needed to get this patch applied
to bluetooth-next.

Thanks

Matthias

On Thu, Oct 04, 2018 at 10:33:38AM -0700, Matthias Kaehlcke wrote:
> On Thu, Sep 27, 2018 at 10:13:05AM -0700, Matthias Kaehlcke wrote:
> > On Thu, Sep 27, 2018 at 12:47:06PM -0400, Sinan Kaya wrote:
> > > On 9/27/2018 12:41 PM, Balakrishna Godavarthi wrote:
> > > >   void bt_sock_reclassify_lock(struct sock *sk, int proto);
> > > > 
> > > > +int device_get_bd_address(struct device *dev, bdaddr_t *bd_addr);
> > > 
> > > Maybe change the API name to start with bt_ and get rid of device_?
> > 
> > device_ indicates that we get the BD_ADDR for a 'struct device' and
> > not for e.g. a 'struct fwnode_handle'.
> > 
> > Anyway with this version of the patch fwnode_get_bd_address() has been
> > scrapped and it might never be introduced again, so I'm open to change
> > the name to bt_ if there is a general preference for it.
> 
> Marcel, can you live with this being added to the Bluetooth code base
> instead of property? Also if you'd prefer the function to be named
> bt_get_bd_address() let me know.
> 
> Cheers
> 
> Matthias
