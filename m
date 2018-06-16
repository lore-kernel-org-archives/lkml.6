Return-Path: <SRS0=eDXJ=JC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90B07C433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 12:07:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A7F920891
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 12:07:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="usRTxjyQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A7F920891
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932755AbeFPMHd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Jun 2018 08:07:33 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53116 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932386AbeFPMHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jun 2018 08:07:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=b2ioswnzWdhz5qEECKAGp4/3YpmEOPOWXCkZpHPyyZg=; b=usRTxjyQYXOn6Ij4kHPknClLi
        angCMiSwvcg+ntS4Yv3V+aLKBD2Qxi9Ha5oZ0sa/yaaVwQUJBZT62dXzaI9uPML2Rvgu6ABGoXW3A
        yyvf6Yt/P4tm2pWVyTXDpZc+cwLPuSo55gicl/EzaIwHqtVkJ5IFrcOf6dZJfmSP6QxeMPOXJsztZ
        v6cay1SWiNWKob6uv7aRT59DB685w2VYUrI0PEw6I5+zCMjPM+zZMm/yIrnxUOGn7m1y5VxI94LT7
        cgnra6/pka4ULO2P4JxktrYvjHpYKrxk5m9NjIN+shpS9ofFp8Ee36EKL5bNGO4NR4vXfAkzjp4kL
        bvdSwNvng==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fU9zF-0005Pl-WE; Sat, 16 Jun 2018 12:07:22 +0000
Date:   Sat, 16 Jun 2018 05:07:21 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Ross Zwisler <ross.zwisler@linux.intel.com>, dsterba@suse.cz,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@redhat.com>,
        Lukas Czerner <lczerner@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Goldwyn Rodrigues <rgoldwyn@suse.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Ryusuke Konishi <konishi.ryusuke@lab.ntt.co.jp>,
        linux-nilfs@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v13 00/72] Convert page cache to XArray
Message-ID: <20180616120721.GA15447@bombadil.infradead.org>
References: <20180611140639.17215-1-willy@infradead.org>
 <20180612104041.GB24375@twin.jikos.cz>
 <20180612113122.GA19433@bombadil.infradead.org>
 <20180612193741.GC28436@linux.intel.com>
 <20180612194619.GH19433@bombadil.infradead.org>
 <20180613201021.GA4801@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180613201021.GA4801@linux.intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 13, 2018 at 02:10:21PM -0600, Ross Zwisler wrote:
> I tested xarray-20180612 vs next-20180612, and your patches cause a new
> deadlock with XFS + DAX + generic/269.  Here's the output from
> "echo w > /proc/sysrq-trigger":

After getting my pmem setup working (thanks for the help Dan &
Jeff), I tracked this down to a missing call to dax_wake_entry() in
dax_writeback_one().  I'm running xfstests -g auto now to see if
there's anything else that needs to be fixed.
