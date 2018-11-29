Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE8A5C43610
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 07:44:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1168206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 07:44:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="OIgY7meO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1168206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbeK2StF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 13:49:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:53316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726651AbeK2StE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 13:49:04 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 42E17206B6;
        Thu, 29 Nov 2018 07:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543477477;
        bh=unDgugLrARl6GVyd39VaDd0XC9myoOTL4e1ztJWYp5k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OIgY7meOjMVPofwUGgYjSvmMyqJA5H3qeGzrXbPf2NyAA+5nWVpZRKZ1OASDa0eXz
         i5bCE2TFvD1bXC66bvDiydPRa6KX1VgkK/CyGL7CExo5ebc85rp+KAHym94m1og+OD
         gyRCzgj4WntSnh3dbNnd5VL6qtA6reGcEaRkYsH4=
Date:   Thu, 29 Nov 2018 08:44:35 +0100
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "apw@canonical.com" <apw@canonical.com>,
        vkuznets <vkuznets@redhat.com>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        Michael Kelley <mikelley@microsoft.com>
Subject: Re: [PATCH] [repost] Drivers: hv: vmbus: Offload the handling of
 channels to two workqueues
Message-ID: <20181129074435.GA12347@kroah.com>
References: <PU1P153MB016946D99D63F9713E32B99ABFD20@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PU1P153MB016946D99D63F9713E32B99ABFD20@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 04:36:43AM +0000, Dexuan Cui wrote:
> 
> vmbus_process_offer() mustn't call channel->sc_creation_callback()
> directly for sub-channels, because sc_creation_callback() ->
> vmbus_open() may never get the host's response to the
> OPEN_CHANNEL message (the host may rescind a channel at any time,
> e.g. in the case of hot removing a NIC), and vmbus_onoffer_rescind()
> may not wake up the vmbus_open() as it's blocked due to a non-zero
> vmbus_connection.offer_in_progress, and finally we have a deadlock.
> 
> The above is also true for primary channels, if the related device
> drivers use sync probing mode by default.
> 
> And, usually the handling of primary channels and sub-channels can
> depend on each other, so we should offload them to different
> workqueues to avoid possible deadlock, e.g. in sync-probing mode,
> NIC1's netvsc_subchan_work() can race with NIC2's netvsc_probe() ->
> rtnl_lock(), and causes deadlock: the former gets the rtnl_lock
> and waits for all the sub-channels to appear, but the latter
> can't get the rtnl_lock and this blocks the handling of sub-channels.
> 
> The patch can fix the multiple-NIC deadlock described above for
> v3.x kernels (e.g. RHEL 7.x) which don't support async-probing
> of devices, and v4.4, v4.9, v4.14 and v4.18 which support async-probing
> but don't enable async-probing for Hyper-V drivers (yet).
> 
> The patch can also fix the hang issue in sub-channel's handling described
> above for all versions of kernels, including v4.19 and v4.20-rc4.
> 
> So, actually the patch should be applied to all the existing kernels,
> not only the kernels that have 8195b1396ec8.
> 
> Fixes: 8195b1396ec8 ("hv_netvsc: fix deadlock on hotplug")
> Cc: stable@vger.kernel.org
> Cc: Stephen Hemminger <sthemmin@microsoft.com>
> Cc: K. Y. Srinivasan <kys@microsoft.com>
> Cc: Haiyang Zhang <haiyangz@microsoft.com>
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
> ---
> 
> There is no change in this repost. I just rebased this patch to today's
> char-misc's char-misc-next branch. Previously KY posted the patch with his
> Signed-off-by (which is kept in this repost), but there was a conflict issue.
> 
> Note: the patch can't be cleanly applied to char-misc's char-misc-linus branch --
> to do that, we need to cherry-pick the supporting patch first:
> 4d3c5c69191f ("Drivers: hv: vmbus: Remove the useless API vmbus_get_outgoing_channel()")

That is not going to work for the obvious reason that this dependant
patch is not going to be merged into 4.20-final.

So, what do you expect us to do here?  The only way this can be accepted
is to have it go into my -next branch, which means it will show up in
4.21-rc1, is that ok?

But then, if that happens, it will fail to apply to any stable tree for
4.20 and older, like you are asking it to be done for.

So what do you expect me to do here with this?

totally confused,

greg k-h
