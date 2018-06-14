Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id C3FDFC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 06:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71FC3208D7
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 06:19:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cxU4Z8Ag"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71FC3208D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752836AbeFNGTK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 02:19:10 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54476 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752420AbeFNGTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 02:19:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=9K7FV9X0MPjgmD5lb0FsyWDZbryU4QhsFMyLvlYYWT0=; b=cxU4Z8Agm2J0JpLGIt/hj4REo
        rHnK8Ny9BLGoZJbpwFYB55gpjPHTGkechC/rdm1YspZMzb1AAUqch310ZqUuaxD17aw3vo5No4A9+
        s67TX/TRdMRiSPZtjuSuEUi7mDCUQ7e9yW7VRHrhw6v5dkODdIwJsXcRgI481hM+uMVWp8it8Q2xD
        AcEDCKUmlS2BEyDpja0p9yCBgVvpwmLyaqnsNb1b8hZo7Xkeq/qgqNkWYqddETkr8IJHm5R2ieNA8
        0Q91dD5pikWolRL9SFVbzT84GSD/QH2Yqpsxpg13MnsEKIMh/yL0JWHMM7dMerxF+Uclk7B5UD9HQ
        hFC5ndegg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fTLb1-0001ZR-CZ; Thu, 14 Jun 2018 06:18:59 +0000
Date:   Wed, 13 Jun 2018 23:18:59 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@fb.com>,
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
Message-ID: <20180614061858.GA3336@infradead.org>
References: <20180609123014.8861-1-ming.lei@redhat.com>
 <20180611164806.GA7452@infradead.org>
 <20180612034242.GC26412@ming.t460p>
 <20180613144253.GA4693@infradead.org>
 <20180614011852.GA19828@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180614011852.GA19828@ming.t460p>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 14, 2018 at 09:18:58AM +0800, Ming Lei wrote:
> This one may cause confusing, since we iterate over pages via
> bio_for_each_segment(), but the _all version takes another name
> of page, still iterate over pages.
> 
> So could we change it in the following way?
> 
>  OLD:	    bio_for_each_segment_all
>  NEW(page): bio_for_each_segment_all (update prototype in one tree-wide &
>  			big patch, to be renamed bio_for_each_page_all)
>  NEW(bvec):  (no bvec version needed once bcache is fixed up)	

Fine with me, but I thought Jens didn't like that sweeping change?
