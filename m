Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EEF3C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 02:32:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF989214DB
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 02:32:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZCpQ98Mb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF989214DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730430AbeKLMXD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 07:23:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:45582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729612AbeKLMXD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 07:23:03 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 04B6320871;
        Mon, 12 Nov 2018 02:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541989925;
        bh=gkzsYs54GGYLBvF4p6dzXo6kbRPQZ+LyXv+aPjJeLYI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZCpQ98MbaFX7dEFQ4ubD2k4vc8oJyD/rUYsHqR6aEG0rKdSlk83BVvGWDNF0J+Vfj
         0uxs3hXXek0ctai4Lfs9ioacY1I9BgoCLYjaAHaFuWfAL6fMm53o9Dkvb1a54L+Ooj
         L2NkgDl1QVN7dta6B/XFRzQJzyJ0Dv460V5ubnUY=
Date:   Sun, 11 Nov 2018 18:32:04 -0800
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        Christoph Hellwig <hch@lst.de>, Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.19 078/361] nvmet-rdma: use a private workqueue for
 delete
Message-ID: <20181112023204.GC28618@kroah.com>
References: <20181111221619.915519183@linuxfoundation.org>
 <20181111221630.901793876@linuxfoundation.org>
 <a90c8564-3b8a-0c75-4a2e-bf497072f849@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a90c8564-3b8a-0c75-4a2e-bf497072f849@acm.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 11, 2018 at 05:27:05PM -0800, Bart Van Assche wrote:
> On 11/11/18 2:17 PM, Greg Kroah-Hartman wrote:
> > 4.19-stable review patch.  If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> > From: Sagi Grimberg <sagi@grimberg.me>
> > 
> > [ Upstream commit 2acf70ade79d26b97611a8df52eb22aa33814cd4 ]
> > 
> > Queue deletion is done asynchronous when the last reference on the queue
> > is dropped.  Thus, in order to make sure we don't over allocate under a
> > connect/disconnect storm, we let queue deletion complete before making
> > forward progress.
> > 
> > However, given that we flush the system_wq from rdma_cm context which
> > runs from a workqueue context, we can have a circular locking complaint
> > [1]. Fix that by using a private workqueue for queue deletion.
> 
> Hi Greg,
> 
> You may want to drop this patch. A bug was discovered in this patch a few
> days ago. I think not backporting this patch is better than backporting it.
> See also the discussion at
> http://lists.infradead.org/pipermail/linux-nvme/2018-November/020766.html. A
> quote from that e-mail thread: "I think we need to revert 2acf70a
> ("nvmet-rdma: use a private workqueue for delete") altogether because it
> never made any difference..".

Now dropped from the 4.18 and 4.19 queues, thanks.

greg k-h
