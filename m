Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 768F5C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 10:15:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EEA120835
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 10:15:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SeccW7tZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EEA120835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbeJKRmP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 13:42:15 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42870 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbeJKRmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 13:42:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=YG8UbBjfiExhO+KadlZzPriBJIjwKLYi+gzJnoeMQzc=; b=SeccW7tZGreQ14rP3ncbb/bDJ
        pZqgqGdGJld4Aft95148Xs3un62gsL3JmN6adtu0m3Fa6qWrRHBGiNhtGJdNiCe3oplZe5oRff2+S
        stYfVsAwr2Af6cZjHO9hW81sLeFZSMEhMjQdmNpYdozTKdIC1cPUr97bju4A0oSpHoU9IewYwieJp
        V2YPpqxuNkN0R7/QPi0NihtK0OC4nUnalGHovu1LqdlpXBqQIA81PX5SzHIYUDRhz8O+agYE0bzcj
        ipduHL5rZBW3cAy4n9KqKkc1yQBl+dqZGQhlOLlhJNGX0+Im3mEjzOYYLWBNJQB4kQ1M4FvKRy3IA
        sKyPwCUJQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gAY0E-0001HX-Fp; Thu, 11 Oct 2018 10:15:34 +0000
Date:   Thu, 11 Oct 2018 03:15:34 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     John Garry <john.garry@huawei.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        jejb@linux.vnet.ibm.com, linuxarm@huawei.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>,
        chenxiang <chenxiang66@hisilicon.com>
Subject: Re: [PATCH 0/7] hisi_sas: Misc bugfixes and an optimisation patch
Message-ID: <20181011101534.GA31802@infradead.org>
References: <1537801594-207139-1-git-send-email-john.garry@huawei.com>
 <yq18t354532.fsf@oracle.com>
 <20181011063603.GA3456@infradead.org>
 <118d01db-05f4-a85b-850c-c4e5a5616a16@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <118d01db-05f4-a85b-850c-c4e5a5616a16@huawei.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2018 at 10:59:11AM +0100, John Garry wrote:
> 
> > blk-mq tags are always per-host (which has actually caused problems for
> > ATA, which is now using its own per-device tags).
> > 
> 
> So, for example, if Scsi_host.can_queue = 2048 and Scsi_host.nr_hw_queues =
> 16, then rq tags are still in range [0, 2048) for that HBA, i.e. invariant
> on queue count?

Yes, if can_queue is 2048 you will gets tags from 0..2047.

IFF you device needs different tags for different queues it can use
the blk_mq_unique_tag heper to generate unique global tag.

But unless you actuall have multiple hardware queues that latter part
is rather irrelevant to start with.
