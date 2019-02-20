Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0162FC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:18:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C496620880
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:18:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NRUKcwhR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbfBTPSp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 10:18:45 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:36852 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbfBTPSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 10:18:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7hwJ79++Shx+4Pia+3d7v96K7JWV3YhXvyHHKM9gzq8=; b=NRUKcwhR74wlQ8DuPeEjdb/d3
        4XQ8B+3bbLvpQ4CwrRtx/SaoyNOyVWiJuOGmc7O1wO57v4AvkLjjWCD+QEHoc0LSr8U2rnXFs8iyB
        3zE5wqU7zAaEe02oHsLea9UF3qYmkRT4s3U6xXEv3+g5+04Nis+zpyDyO4SAhzL+xZyc+LfNiJxpc
        veBNvXr+1SySy+hUovI1u2EDl7Y7VHrUFUzXPPdnhphArYm4EeYThB7+voy9cgJ+pUH79ObeFnatX
        ZxiAXR4YO1wjRa/EzWqTg4mp7qSyPWgJv8fB7+ywcrGRmPjJWtV3mdwaVQCFHnZ/fiduY7DTpjkeY
        E+bUzNM5w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gwTds-000458-VW; Wed, 20 Feb 2019 15:18:36 +0000
Date:   Wed, 20 Feb 2019 07:18:36 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jason Yan <yanaijie@huawei.com>, martin.petersen@oracle.com,
        jejb@linux.vnet.ibm.com, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        hare@suse.com, dan.j.williams@intel.com, jthumshirn@suse.de,
        Steffen Maier <maier@linux.ibm.com>
Subject: Re: [RFC PATCH] scsi: fix oops in scsi_uninit_cmd()
Message-ID: <20190220151836.GA11695@infradead.org>
References: <20190219072743.13606-1-yanaijie@huawei.com>
 <1550595388.31902.133.camel@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550595388.31902.133.camel@acm.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[fullquote removed, please follow proper mail etiquette]

On Tue, Feb 19, 2019 at 08:56:28AM -0800, Bart Van Assche wrote:
> regression in the SCSI sd driver due to the switch from the legacy block
> layer to scsi-mq. The above patch introduces two atomic operations in the
> hot path and hence would introduce a performance regression. I think this
> can be avoided by making sure that sd_uninit_command() gets called before
> the request tag is freed. What changes would be required to make the block
> layer core call sd_uninit_command() before the request tag is freed? Would
> introducing prep_rq_fn and unprep_rq_fn callbacks in struct blk_mq_ops and
> making sure that the SCSI core sets these callback function pointers
> appropriately be sufficient? Would such a change allow to simplify the NVMe
> initiator driver? Are there any alternatives to this approach that are more
> elegant?

Additional indirect calls in the I/O fast path is something I'd rather
avoid.  But I don't fully understand the problem yet - where do
we release a disk reference from blk_update_request?  And why can't
we move that release to __blk_mq_end_request?

> 
> Thanks,
> 
> Bart.
---end quoted text---
