Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA54CC46475
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 02:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 878962083E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 02:00:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 878962083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbeJZKfr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 06:35:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40088 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725834AbeJZKfr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 06:35:47 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1970230BCCD0;
        Fri, 26 Oct 2018 02:00:45 +0000 (UTC)
Received: from ming.t460p (ovpn-8-27.pek2.redhat.com [10.72.8.27])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 01722D1E6;
        Fri, 26 Oct 2018 02:00:39 +0000 (UTC)
Date:   Fri, 26 Oct 2018 10:00:35 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Rui Salvaterra <rsalvaterra@gmail.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Bug: swap discard issue with zram caused by "block: don't deal
 with discard limit in blkdev_issue_discard()"
Message-ID: <20181026020034.GA25933@ming.t460p>
References: <CALjTZvapU2xc84D7Nqjk+vrF35cAOPzDTd6dRaXpuO=Lcap5Sg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALjTZvapU2xc84D7Nqjk+vrF35cAOPzDTd6dRaXpuO=Lcap5Sg@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Fri, 26 Oct 2018 02:00:45 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 25, 2018 at 05:09:32PM +0100, Rui Salvaterra wrote:
> Hi,
> 
> After commit 744889b7cbb56a64f957e65ade7cb65fe3f35714, I started
> getting this (-EIO, it seems) on my dmesg:
> 
> swapon: discard_swap(00000000c275f02d): -5
> 
> This is an 8 GB zram swap device. It's configured like this:
> 
> modprobe zram
> echo zstd > /sys/block/zram0/comp_algorithm
> echo 8297508864 > /sys/block/zram0/disksize
> mkswap /dev/zram0
> swapon -d -p 100 /dev/zram0
> 
> I should note that if I use --discard=pages instead of -d (both
> policies) at swapon, I don't get this error.
> Reverting the commit from v4.19 final fixes the error for me, but
> surely breaks something else. :)
> Let me know if you need any additional information.

The reason is that zram doesn't call blk_queue_split() in .make_request_fn, :-(

Then the similar logic in blk_queue_split() has to be duplicated somewhere,
such as __blkdev_issue_discard().

I will post a patch for you soon.

Thanks,
Ming
