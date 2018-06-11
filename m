Return-Path: <SRS0=KDb5=I5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 29A02C07D59
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 17:11:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C8A7208B6
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 16:48:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IZrD+P1W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C8A7208B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933841AbeFKQsV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 12:48:21 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39950 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933231AbeFKQsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 12:48:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=9fImL4uW7ViNR6liwCAiEw0e6CL2hVB980Me6cRe2ec=; b=IZrD+P1WFmNWXlyM/de6GHKN3r
        ApBEVnKewhoN7ROLeaqnSvIDs0MBz8k/3hz7eLC3vwIFbdj9lvPzFJWzNJGusNEynrBL7ri/TP+NU
        Q3bdHs4Qo7YhBw012AfwfEk5kw95Xk676Zem6dsC060L81HX0ctAdQkfuUG6ALzc9mhJB7fuNNKh+
        gyl7ln6azlx+ASYk17eM6E8rCn90pGKOnoiuoeiTsSaqa8lKS/rgIPU5Mrk9lpkOWn3B9a0O+Vk1N
        Dziw11nFujDRB9dAwM0Lu52BS+dC3FlKXF3DWhrTUpniLm8ykfInKFUi2wUgWZ+LLyVKlvjDo62r+
        eJdNWWxg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fSPzC-00069R-Vv; Mon, 11 Jun 2018 16:48:06 +0000
Date:   Mon, 11 Jun 2018 09:48:06 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        David Sterba <dsterba@suse.cz>,
        Huang Ying <ying.huang@intel.com>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Theodore Ts'o <tytso@mit.edu>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Coly Li <colyli@suse.de>, Filipe Manana <fdmanana@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH V6 00/30] block: support multipage bvec
Message-ID: <20180611164806.GA7452@infradead.org>
References: <20180609123014.8861-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180609123014.8861-1-ming.lei@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

І think the new naming scheme in this series is a nightmare.  It
confuses the heck out of me, and that is despite knowing many bits of
the block layer inside out, and reviewing previous series.

I think we need to take a step back and figure out what names what we
want in the end, and how we get there separately.

For the end result using bio_for_each_page in some form for the per-page
iteration seems like the only sensible idea, as that is what it does.

For the bio-vec iteration I'm fine with either bio_for_each_bvec as that
exactly explains what it does, or bio_for_each_segment to keep the
change at a minimum.

And in terms of how to get there: maybe we need to move all the drivers
and file systems to the new names first before the actual changes to
document all the intent.  For that using the bio_for_each_bvec variant
might be benefitial as it allows to seasily see the difference between
old uncovered code and the already converted one.
