Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBEEBECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 06:06:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7697121531
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 06:06:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="orgQOW4A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7697121531
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389298AbeIULxu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 07:53:50 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42536 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbeIULxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 07:53:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=gFO/fn2oWyk6NJ/nsObl+kBHkThgQXPFYOlWq5e7ih8=; b=orgQOW4AP5phgut73SGxuv5Kx
        NjPcwV/WdbFnkAldBVhknJ5r5vBr9UOQBMPkkQ4lHFeSj8TP8avrmyp4erT8TGb5KhabCCGaowp/y
        U4hrbW+DouQBKRpZMczSUNZiLzHLvMgC41RLQsPvk9RKvjgEpyAn5N5HwnYDQvA17fETzMrVFqEYK
        JpvjoT4sh7ERmy1vYIbsaQI2t4k4vW6u6GahPkcTfahJTy4JPqtkfZ064Z1RHJ0JQlffDbJVPQj8R
        t2vWax7VvFYWwum7xH7LUpKOcFLtQhwghUNSWIeCMN4gYv5GQsgcYf2uoY1o8NezQXN5/sbmegGdf
        kEykF1tgA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g3EaD-0001AR-Ay; Fri, 21 Sep 2018 06:06:29 +0000
Date:   Thu, 20 Sep 2018 23:06:29 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, chao@kernel.org
Subject: Re: [PATCH] f2fs: fix to recover inode's uid/gid during POR
Message-ID: <20180921060629.GA13865@infradead.org>
References: <20180920094130.124622-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180920094130.124622-1-yuchao0@huawei.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2018 at 05:41:30PM +0800, Chao Yu wrote:
> Step to reproduce this bug:
> 1. logon as root
> 2. mount -t f2fs /dev/sdd /mnt;
> 3. touch /mnt/file;
> 4. chown system /mnt/file; chgrp system /mnt/file;
> 5. xfs_io -f /mnt/file -c "fsync";
> 6. godown /mnt;
> 7. umount /mnt;
> 8. mount -t f2fs /dev/sdd /mnt;

Please wire this up for xfstests (as a generic test).
