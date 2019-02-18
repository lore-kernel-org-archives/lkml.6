Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2317EC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 12:22:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E31D6217D7
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 12:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550492568;
	bh=s5p+cqXDbvVyMz3FArSY6GSmBHdWKGF3VFDIcDSIBvM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qAM3UaQNn3uOYA4fwPe0xAnDbi9pCxVwZDIuR7IZ6EikdwqC0l6AbZCSwrDWG+b9A
	 5YxeTkB2DburoliM1ZNe9KrtuQPK9J9ffluCZ5ZPmCvGyjTtXFkpFHN97cLZ204HCE
	 g8sGziYI+YyZlO7zpW60vDI0Kaa+o6dHGaCtQI2w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730627AbfBRMWq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 07:22:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:33568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729016AbfBRMWq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 07:22:46 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DBE6021773;
        Mon, 18 Feb 2019 12:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550492565;
        bh=s5p+cqXDbvVyMz3FArSY6GSmBHdWKGF3VFDIcDSIBvM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MXunx2G7c+HRkgdKcaEziJxVgLKec8n8t0wHcgXBV/4umpchwCmm4nl1GT5MNOUnq
         Y4/nvCGh4ZGI8ljTGrWIpH5V4m1iasbAOmvG6/NwZCuQxIkK+x9ME3AvMscBQ9WHbg
         bUSfh/B7elwPZJ2dbapBUxib1eQX/pX0ThdjfZPE=
Date:   Mon, 18 Feb 2019 13:22:42 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Alakesh Haloi <alakeshh@amazon.com>
Cc:     stable@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tcp: Namespace-ify sysctl_tcp_rmem and sysctl_tcp_wmem
Message-ID: <20190218122242.GC30260@kroah.com>
References: <20190214011159.GA35034@dev-dsk-alakeshh-2c-f8a3e6e0.us-west-2.amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190214011159.GA35034@dev-dsk-alakeshh-2c-f8a3e6e0.us-west-2.amazon.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 01:12:08AM +0000, Alakesh Haloi wrote:
> [ Upstream commit 356d1833b638bd465672aefeb71def3ab93fc17d ]
> 
> Note that when a new netns is created, it inherits its
> sysctl_tcp_rmem and sysctl_tcp_wmem from initial netns.
> 
> This change is needed so that we can refine TCP rcvbuf autotuning,
> to take RTT into consideration.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Wei Wang <weiwan@google.com>
> Signed-off-by: David S. Miller <davem@davemloft.net>
> [alakeshh: backport to v4.14: The patch does not apply to v4.14
> directly and hence needed manual backport. Function signature for
> the function tcp_select_initial_window had to be changed to be able
> to pass pointer to struct sock.]
> Signed-off-by: Alakesh Haloi <alakeshh@amazon.com>

Like Sasha said, why is this needed in 4.14.y?  It looks like a new
feature.  What is keeping you from just using 4.19.y if you want this
feature?

thanks,

greg k-h
