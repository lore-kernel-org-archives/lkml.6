Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF438C46475
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 12:02:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C150620825
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 12:02:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C150620825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729611AbeKEVVf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 16:21:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44008 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727048AbeKEVVe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 16:21:34 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D7E00308A972;
        Mon,  5 Nov 2018 12:02:10 +0000 (UTC)
Received: from ming.t460p (ovpn-8-33.pek2.redhat.com [10.72.8.33])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 569F865F49;
        Mon,  5 Nov 2018 12:01:59 +0000 (UTC)
Date:   Mon, 5 Nov 2018 20:01:54 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     Jens Axboe <axboe@fb.com>,
        Linux Block Layer Mailinglist <linux-block@vger.kernel.org>,
        Hannes Reinecke <hare@suse.de>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH] block: respect virtual boundary mask in bvecs
Message-ID: <20181105120153.GD12367@ming.t460p>
References: <20181105102301.9752-1-jthumshirn@suse.de>
 <20181105105548.GC12367@ming.t460p>
 <7c649b43-f952-cf94-93d6-44fb153acced@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c649b43-f952-cf94-93d6-44fb153acced@suse.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Mon, 05 Nov 2018 12:02:11 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 05, 2018 at 12:50:50PM +0100, Johannes Thumshirn wrote:
> On 05/11/2018 11:55, Ming Lei wrote:
> > On Mon, Nov 05, 2018 at 11:23:01AM +0100, Johannes Thumshirn wrote:
> >> With drivers like iSer we are seeing a lot of bio splitting and smaller I/Os
> >> being submitted to the driver.
> >>
> >> The root cause of this issue that the virtual boundary mask code does not take
> >> into consideration that some of the memory segments in the SG list may have
> >> come from a huge memory page that is being managed in the SG list as 4K
> > 
> > I guess you mean something like 64K PAGE_SIZE, instead of huge page.
> 
> No I mean like a 2M page from an upper layer.

If you mean the real huge page, this patch shouldn't have made a difference
because bio_vec->bv_offset is in [0, PAGE_SIZE), and iSer sets virt
boundary as 4K - 1.

However, things will change after multipage bvec is introduced.

Thanks,
Ming
