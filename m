Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39D58C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 00:20:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F233D214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 00:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547079654;
	bh=vFwblmBNC/d3ZngyJiZ2tJqjmJbjiRT/+NhVajQr+ZI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bPnIjl7SPvI7bPOG/J5fQKgvy19+pwEZev+bE4CoGKRSkn8tE1XnSH3/1RYDMzJXY
	 Yi8KtUKI3MkBt2uvvt0Nt3If/WbjbVhAnuDUcfKQzGYEk+B/JJsWKzWtAN1Nx2Bhqv
	 +QAYAp0/LCh3tDU1Hf6ibrjeubCKsO/Ax/9tqMSI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbfAJAUx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 19:20:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:55236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726590AbfAJAUw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 19:20:52 -0500
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A49E02075C;
        Thu, 10 Jan 2019 00:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547079651;
        bh=vFwblmBNC/d3ZngyJiZ2tJqjmJbjiRT/+NhVajQr+ZI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FOPUlkJlo/w5OOwnnGSFx8ypwYOto4dwtFQevoqvU7DSQbLTZVppYguU+i+Ug5ERn
         WiG4DryRhhFIWDhvGmYZy+qJu6j4yg8tDmHr8HPq1ckPb6SvYX//R2ravxt6XpLEp7
         JNW9E3Dt8tdrOPo4woNsRocb6fA1ymIgd7/4AAXI=
Date:   Wed, 9 Jan 2019 19:20:50 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     "'gregkh@linuxfoundation.org'" <gregkh@linuxfoundation.org>,
        'Stephen Hemminger' <stephen@networkplumber.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        "'devel@linuxdriverproject.org'" <devel@linuxdriverproject.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        "'marcelo.cerri@canonical.com'" <marcelo.cerri@canonical.com>,
        "'apw@canonical.com'" <apw@canonical.com>,
        "'olaf@aepfle.de'" <olaf@aepfle.de>,
        vkuznets <vkuznets@redhat.com>,
        "'jasowang@redhat.com'" <jasowang@redhat.com>,
        'Dan B' <dan@structuredgrid.net>
Subject: Re: [PATCH][re-post] vmbus: fix subchannel removal
Message-ID: <20190110002050.GL166797@sasha-vm>
References: <PU1P153MB0169D32ECDF37A2DB55AD485BF8B0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <PU1P153MB0169D32ECDF37A2DB55AD485BF8B0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2019 at 08:56:06PM +0000, Dexuan Cui wrote:
>
>The changes to split ring allocation from open/close, broke
>the cleanup of subchannels. This resulted in problems using
>uio on network devices because the subchannel was left behind
>when the network device was unbound.
>
>The cause was in the disconnect logic which used list splice
>to move the subchannel list into a local variable. This won't
>work because the subchannel list is needed later during the
>process of the rescind messages (relid2channel).
>
>The fix is to just leave the subchannel list in place
>which is what the original code did. The list is cleaned
>up later when the host rescind is processed.
>
>Without the fix, we have a lot of "hang" issues in netvsc when we
>try to change the NIC's MTU, set the number of channels, etc.
>
>Fixes: ae6935ed7d42 ("vmbus: split ring buffer allocation from open")
>Cc: stable@vger.kernel.org
>Signed-off-by: Stephen Hemminger <sthemmin@microsoft.com>
>Signed-off-by: Dexuan Cui <decui@microsoft.com>

Queued, thank you.

--
Thanks,
Sasha
