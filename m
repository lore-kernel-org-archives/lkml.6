Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D448AC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:47:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A13D2063F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547218070;
	bh=LXQhkCWxfIcRx3k1zgs/7/n14S7bBNruDBI+x/DBQ0M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dv2fyTpJIGBHGOwxWgpAouo973t2Ghg/KZ4votHp7vn4RJ7TfOl+upgidTmcR+aeE
	 xXwmu80zMyfT9taDDtU4JgIg6DXfFhFfyd69Y2jEt4ZyIMW3nDMhblIXjJXc/JTBa3
	 6mGn1a+HIoEFLas3divnKyb3PqoC64V+8ii3lfgs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391527AbfAKOrt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:47:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:39006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391508AbfAKOro (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:47:44 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 92F2B2063F;
        Fri, 11 Jan 2019 14:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547218064;
        bh=LXQhkCWxfIcRx3k1zgs/7/n14S7bBNruDBI+x/DBQ0M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Eu0mvMqatHYjL2sZKV3KAEBbR1skqRecVy/KqUTNmqd6grpMgcxwF2FeW8k7xGn9y
         sShrA/+yKiUwEe45tOcZnqaMKAx9SP5fiw46aEojGiYNj8otlCd8eGQoJA4gdd6e3P
         N9bllFlm5vrjdJiTeHvHcDl6uhJe/V/isvHZCAb8=
Date:   Fri, 11 Jan 2019 15:35:14 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Ming Lin <ming.l@ssi.samsung.com>,
        Christoph Hellwig <hch@lst.de>, Xiao Ni <xni@redhat.com>,
        Mariusz Dabrowski <mariusz.dabrowski@intel.com>,
        Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: Re: [PATCH 4.4 72/88] block: dont deal with discard limit in
 blkdev_issue_discard()
Message-ID: <20190111143514.GA8530@kroah.com>
References: <20190111131045.137499039@linuxfoundation.org>
 <20190111131058.120784730@linuxfoundation.org>
 <20190111142539.GA10601@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190111142539.GA10601@redhat.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2019 at 09:25:39AM -0500, Mike Snitzer wrote:
> On Fri, Jan 11 2019 at  9:08am -0500,
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> 
> > 4.4-stable review patch.  If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> > From: Ming Lei <ming.lei@redhat.com>
> > 
> > commit 744889b7cbb56a64f957e65ade7cb65fe3f35714 upstream.
> 
> Hi Greg,
> 
> Please also pick up this commit:
> 89f5fa47476eda56402e29fff3c5097f5c2a1e19 ("dm: call blk_queue_split() to
> impose device limits on bios")

That's going to be hard as the dependancy for that patch is not here in
4.4.y, and this patch itself isn't even in anything older than 4.19.y.
So why add it here to 4.4.y only?

Can you send the needed patch series to the stable@ mailing list for the
different stable trees if this needs to get into them?

thanks,

greg k-h
