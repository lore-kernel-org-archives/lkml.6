Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8044AC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 05:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41B9F2086B
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 05:23:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z4VYP4ha"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41B9F2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbeKZQQd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 11:16:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:59286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726145AbeKZQQd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 11:16:33 -0500
Received: from localhost (unknown [37.142.5.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B54C820855;
        Mon, 26 Nov 2018 05:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543209816;
        bh=pEdUQj00n0efCQaqoMlT6y/cwIbdN5NH/fB3d2bSFo0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z4VYP4haTiEdZlh3YUAZIJa6o3spDQlOMBx1KZSAM8q1PoSZhC/zErQ+gBwKdpqrM
         ozxh0kRHIxRktFV1awwUoC0Dz8elBqidl+z5PELuDZyK7gDs+mFoBDUFHmVlNQZ1Si
         n/CI13xA01e7/lPz6HkPyxr4lglQHDH3iAByr0TU=
Date:   Mon, 26 Nov 2018 00:23:31 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     kys@microsoft.com
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        devel@linuxdriverproject.org, olaf@aepfle.de, apw@canonical.com,
        jasowang@redhat.com, sthemmin@microsoft.com,
        Michael.H.Kelley@microsoft.com, vkuznets@redhat.com,
        Dexuan Cui <decui@microsoft.com>, stable@vger.kernel.org,
        Haiyang Zhang <haiyangz@microsoft.com>
Subject: Re: [PATCH 2/2] Drivers: hv: vmbus: offload the handling of channels
 to two workqueues
Message-ID: <20181126052331.GA34679@sasha-vm>
References: <20181126022821.11269-1-kys@linuxonhyperv.com>
 <20181126022958.11320-1-kys@linuxonhyperv.com>
 <20181126022958.11320-2-kys@linuxonhyperv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20181126022958.11320-2-kys@linuxonhyperv.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 02:29:57AM +0000, kys@linuxonhyperv.com wrote:
>From: Dexuan Cui <decui@microsoft.com>
>
>vmbus_process_offer() mustn't call channel->sc_creation_callback()
>directly for sub-channels, because sc_creation_callback() ->
>vmbus_open() may never get the host's response to the
>OPEN_CHANNEL message (the host may rescind a channel at any time,
>e.g. in the case of hot removing a NIC), and vmbus_onoffer_rescind()
>may not wake up the vmbus_open() as it's blocked due to a non-zero
>vmbus_connection.offer_in_progress, and finally we have a deadlock.
>
>The above is also true for primary channels, if the related device
>drivers use sync probing mode by default.
>
>And, usually the handling of primary channels and sub-channels can
>depend on each other, so we should offload them to different
>workqueues to avoid possible deadlock, e.g. in sync-probing mode,
>NIC1's netvsc_subchan_work() can race with NIC2's netvsc_probe() ->
>rtnl_lock(), and causes deadlock: the former gets the rtnl_lock
>and waits for all the sub-channels to appear, but the latter
>can't get the rtnl_lock and this blocks the handling of sub-channels.
>
>The patch can fix the multiple-NIC deadlock described above for
>v3.x kernels (e.g. RHEL 7.x) which don't support async-probing
>of devices, and v4.4, v4.9, v4.14 and v4.18 which support async-probing
>but don't enable async-probing for Hyper-V drivers (yet).
>
>The patch can also fix the hang issue in sub-channel's handling described
>above for all versions of kernels, including v4.19 and v4.20-rc3.
>
>So the patch should be applied to all the existing kernels.
>
>Fixes: 8195b1396ec8 ("hv_netvsc: fix deadlock on hotplug")
>Cc: stable@vger.kernel.org
>Cc: Stephen Hemminger <sthemmin@microsoft.com>
>Cc: K. Y. Srinivasan <kys@microsoft.com>
>Cc: Haiyang Zhang <haiyangz@microsoft.com>
>Signed-off-by: Dexuan Cui <decui@microsoft.com>
>Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>

This patch doesn't apply on next/linus/char-misc; there seems to be a
missing patch that touches vmbus_process_offer() which isn't a part of
this series.

--
Thanks,
Sasha
