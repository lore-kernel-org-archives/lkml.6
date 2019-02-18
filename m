Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D4E4C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 12:58:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FCF321872
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 12:58:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728806AbfBRM6s convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 07:58:48 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:47866 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbfBRM6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 07:58:48 -0500
Received: from marcel-macpro.fritz.box (p4FF9F361.dip0.t-ipconnect.de [79.249.243.97])
        by mail.holtmann.org (Postfix) with ESMTPSA id 4381ACF2C7;
        Mon, 18 Feb 2019 14:06:39 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [RFC] Bluetooth: Retry configure request if result is
 L2CAP_CONF_UNKNOWN
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20190208025828.30901-1-andrew.smirnov@gmail.com>
Date:   Mon, 18 Feb 2019 13:58:45 +0100
Cc:     linux-bluetooth@vger.kernel.org,
        "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
        Florian Dollinger <dollinger.florian@gmx.de>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <3E87E315-0F39-49BA-BD65-2EB0C3A9A782@holtmann.org>
References: <20190208025828.30901-1-andrew.smirnov@gmail.com>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrey,

> Due to:
> 
> - current implementation of l2cap_config_rsp() dropping BT
>   connection if sender of configuration response replied with unknown
>   option failure (Result=0x0003/L2CAP_CONF_UNKNOWN)
> 
> - current implementation of l2cap_build_conf_req() adding
>   L2CAP_CONF_RFC(0x04) option to initial configure request sent by
>   the Linux host.
> 
> devices that do no recongninze L2CAP_CONF_RFC, such as Xbox One S
> controllers, will get stuck in endless connect -> configure ->
> disconnect loop, never connect and be generaly unusable.
> 
> To avoid this problem add code to do the following:
> 
> 1. Store a mask of supported conf option types per connection
> 
> 2. Parse the body of response L2CAP_CONF_UNKNOWN and adjust
>    connection's supported conf option types mask
> 
> 3. Retry configuration step the same way it's done for
>    L2CAP_CONF_UNACCEPT
> 
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Cc: Pierre-Loup A. Griffais <pgriffais@valvesoftware.com>
> Cc: Florian Dollinger <dollinger.florian@gmx.de>
> Cc: Marcel Holtmann <marcel@holtmann.org>
> Cc: Johan Hedberg <johan.hedberg@gmail.com>
> Cc: linux-bluetooth@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
> 
> Everyone:
> 
> I marked this as an RFC, since I don't have a lot of experience with
> Bluetooth subsystem and don't have hight degree of confidence about
> choices made in this patch. I do, however, thins is is good enough to
> start a discussion about the problem.

can you take a btmon -w trace.log protocol trace so that I can see where it fails. This seems a really odd behavior of the Xbox controller. We have to be careful in not breaking Bluetooth qualification to just workaround some buggy remote device.

Regards

Marcel

