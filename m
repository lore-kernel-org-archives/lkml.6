Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68BF5C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 18:51:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 204332098A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 18:51:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AcJoOG4P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 204332098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbeJPCh7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 22:37:59 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45724 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726707AbeJPCh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 22:37:59 -0400
Received: by mail-pl1-f196.google.com with SMTP id y15-v6so9725805plr.12
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 11:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DWciO0XBN3UW6fn55r9D0ORvUXjAdv8IMu+2+L7MJCc=;
        b=AcJoOG4PlDVljWnnONd00UzurFoAYE23LtI8MUX3Fs+D9siEzOmuajLIFGksaar5ys
         sog0gg363LWiPBADrsH089Kusm3iQGVOsCwftLL1symwncmRGK39Wd/g0UkY18bjVqYA
         CIoZtHM0Xz+zXGD2D+Oo+rMOBKJOxtQXWPCh0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DWciO0XBN3UW6fn55r9D0ORvUXjAdv8IMu+2+L7MJCc=;
        b=cefyJU8rl0/vUc03JI4gB3jSufO9hjbLf2lCkJiYNJEARYqV0bMMKxwsZ8q4fl9e4R
         gli8Gw/kgUSjZ8SeHKHtvKJ9cn4mrmj4woYZvOr1y8L1CVtjIufpMmI8t48QhFw1BOOq
         klBGserGLB32sosKCRlnLTK5Tbb+sm2ABcDhIDS81yPe1CNB80876dfW5NZbLzhDyrEu
         gnzY1iXOe5VzLOwZre6oYH8hxcRwzNskMjSrZRtHKIQFLLD+IsQz180dMQCKeHWiDQBn
         s2ZWhtxtgE1zJWrMFx1aG570lXLlz5j389+9FXRn5pRBCUMhxUCXutA/JNtcq8prQCFZ
         VdOA==
X-Gm-Message-State: ABuFfojCtYLiE5z8CdRaTYM27tZEuNSByfOoriygbclH2X9PS6s97yCE
        HPuxVRY3xK+VPQAFXQ4JMR6SEg==
X-Google-Smtp-Source: ACcGV61nUcQMf/OVSXH+M1yIW4Ce3o7xMxmc3zvPhTbBMKO48Ya+NLW13+U/GA3GSAMNhGupajbrHQ==
X-Received: by 2002:a17:902:205:: with SMTP id 5-v6mr18318501plc.307.1539629489504;
        Mon, 15 Oct 2018 11:51:29 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id l10-v6sm15873841pgs.45.2018.10.15.11.51.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Oct 2018 11:51:28 -0700 (PDT)
Date:   Mon, 15 Oct 2018 11:51:28 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Sinan Kaya <okaya@codeaurora.org>,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Marcin Wojtas <mw@semihalf.com>,
        Andy Shevchenko Andy Shevchenko <andy.shevchenko@gmail.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH v4 1/2] Bluetooth: Add device_get_bd_address()
Message-ID: <20181015185128.GT22824@google.com>
References: <20180927004810.124185-1-mka@chromium.org>
 <20180927004810.124185-2-mka@chromium.org>
 <b28c34475e447cc29a139f9121b3c1d9@codeaurora.org>
 <e6752d4b-b22a-d951-e9db-1ae7445dc403@codeaurora.org>
 <20180927171305.GG22824@google.com>
 <20181004173338.GL22824@google.com>
 <9B742DB5-F584-4A47-A04B-4F72EB17519C@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9B742DB5-F584-4A47-A04B-4F72EB17519C@holtmann.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2018 at 08:06:02PM +0200, Marcel Holtmann wrote:
> Hi Matthias,
> 
> >>>>  void bt_sock_reclassify_lock(struct sock *sk, int proto);
> >>>> 
> >>>> +int device_get_bd_address(struct device *dev, bdaddr_t *bd_addr);
> >>> 
> >>> Maybe change the API name to start with bt_ and get rid of device_?
> >> 
> >> device_ indicates that we get the BD_ADDR for a 'struct device' and
> >> not for e.g. a 'struct fwnode_handle'.
> >> 
> >> Anyway with this version of the patch fwnode_get_bd_address() has been
> >> scrapped and it might never be introduced again, so I'm open to change
> >> the name to bt_ if there is a general preference for it.
> > 
> > Marcel, can you live with this being added to the Bluetooth code base
> > instead of property? Also if you'd prefer the function to be named
> > bt_get_bd_address() let me know.
> 
> explain to me again why this is useful?

The official binding for providing the BD_ADDR through the device tree
is the property 'local-bd-address'. device_get_bd_address() provides a
common API to retrieve the BD_ADDR instead of requiring BT drivers to
use the lower level fwnode_property_read_u8_array(). It also avoids
repeating the check for an all zeroes BD_ADDR in multiple drivers.

> I am failing to see the benefit if this is not part of the property.h API.

My understanding is that the intention of property.h it to provide an
API for common property types used by drivers from different
subsystems, hence the implementation 'lives' in drivers/base.
Obtaining the BD_ADDR is clearly limited to the Bluetooth subsystem,
and drivers/base doesn't seem to be the right place for it. It's true,
device_get_mac_address() lives in the common property code, but that
doesn't necessarily mean it really should be there and we should do
the same. I agree with Sakari that the the approach taken by V4L2
(drivers/media/v4l2-core/v4l2-fwnode.c) seems more appropriate.

That said I wouldn't raise opposition if the maintainers of
drivers/base agreed to add device_get_mac_address() there, however so
far several recent authors of property.[ch] have raised objections.

Thanks

Matthias
