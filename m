Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C24FC4360F
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 19:21:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6448A21874
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 19:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550431297;
	bh=2YJ+biGx7sQrh2TYvzPJ0ivweqk5N3aVZ19BfMSXlTA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZrgtawAoC4EwNrpvaXKkeTCTnYchpo252tdzgE3hxHcwTrqFMx6vk23rlP5/g892/
	 750rK6ULDAJU9FlG2vqycvaNF9lN/+zkAklIa4iMn1zdYiuwDHliDXStw3cWuZKGsX
	 nGd4LQSb/CmL9OtVOb+j2nDN2G4uv8mkKrjXVd1s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbfBQTVg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 14:21:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:36064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725554AbfBQTVf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 14:21:35 -0500
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA3CD2186A;
        Sun, 17 Feb 2019 19:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550431295;
        bh=2YJ+biGx7sQrh2TYvzPJ0ivweqk5N3aVZ19BfMSXlTA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZyOw5uyUy/YJlVSH1aQ/i3XdsZyYsfnho1yR4ySDqzKkqqKoF1xx00EPo0CogesAv
         Ra4lJjxllBmUm7NkrlW/PFOiVmFZwdIguEIqwgHBu9QObmdyZHpPPGKM3TYYKQ08lC
         r/lPFgsgwPYWioeKVmBX04awrjASSvUfOmeDzd4w=
Date:   Sun, 17 Feb 2019 14:21:33 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Alakesh Haloi <alakeshh@amazon.com>
Cc:     stable@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tcp: Namespace-ify sysctl_tcp_rmem and sysctl_tcp_wmem
Message-ID: <20190217192133.GN10616@sasha-vm>
References: <20190214011159.GA35034@dev-dsk-alakeshh-2c-f8a3e6e0.us-west-2.amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190214011159.GA35034@dev-dsk-alakeshh-2c-f8a3e6e0.us-west-2.amazon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 01:12:08AM +0000, Alakesh Haloi wrote:
>[ Upstream commit 356d1833b638bd465672aefeb71def3ab93fc17d ]
>
>Note that when a new netns is created, it inherits its
>sysctl_tcp_rmem and sysctl_tcp_wmem from initial netns.
>
>This change is needed so that we can refine TCP rcvbuf autotuning,
>to take RTT into consideration.
>
>Signed-off-by: Eric Dumazet <edumazet@google.com>
>Cc: Wei Wang <weiwan@google.com>
>Signed-off-by: David S. Miller <davem@davemloft.net>
>[alakeshh: backport to v4.14: The patch does not apply to v4.14
>directly and hence needed manual backport. Function signature for
>the function tcp_select_initial_window had to be changed to be able
>to pass pointer to struct sock.]
>Signed-off-by: Alakesh Haloi <alakeshh@amazon.com>
>Cc: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
>Cc: Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
>Cc: Eric Dumazet <edumazet@google.com>
>Cc: <stable@vger.kernel.org> # 4.14.x

What does this fix? This is a new interface...

--
Thanks,
Sasha
