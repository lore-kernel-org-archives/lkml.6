Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id C320AC07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 06:20:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79A09208D4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 06:20:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ay7C6FOg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79A09208D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754613AbeFNGUg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 02:20:36 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55286 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752815AbeFNGUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 02:20:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=b7g2o82AyogP2BJ8mldttmKG+tfVMhVTM4rMEp0BUMc=; b=ay7C6FOgQeC0udWAteBlVhimO
        JbJto+9ttSFTB2GDrG3Tax7l+bks5E/3ExmEcBuGdejVbHz0ZEGpEq4rpJuZMtej6MYLHpvHaSaQD
        gvafJ1+O27/g4/haTSj6Jcn03rkZ4ZdauAE0jlPQbrbtqDNcPAUWNG2r11QWBWzMtrVarGoHY0reS
        TFYugXsiBVcvfClvo+NlxKKPz2xNmjKDyIzS6xdU8KTLIuoSwqsHEjqicBeoR24QtFOgv1lD1BO0v
        ixC5y6C4UdtWbYbJrZa43GSazzVtCWfVdbibg7JnhBUmAybfuUDEumyVrdMyYZihXfXwmgGE8JbIm
        P1opgK6uw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fTLcN-0003vE-CY; Thu, 14 Jun 2018 06:20:23 +0000
Date:   Wed, 13 Jun 2018 23:20:22 -0700
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
Subject: Re: [PATCH V6 11/30] block: implement bio_pages_all() via
 bio_for_each_segment_all()
Message-ID: <20180614062022.GB3336@infradead.org>
References: <20180609123014.8861-1-ming.lei@redhat.com>
 <20180609123014.8861-12-ming.lei@redhat.com>
 <20180613144412.GB4693@infradead.org>
 <20180614012352.GC19828@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180614012352.GC19828@ming.t460p>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 14, 2018 at 09:23:54AM +0800, Ming Lei wrote:
> On Wed, Jun 13, 2018 at 07:44:12AM -0700, Christoph Hellwig wrote:
> > Given that we have a single, dubious user of bio_pages_all I'd rather
> > see it as an opencoded bio_for_each_ loop in the caller.
> 
> Yeah, that is fine since there is only one user in btrfs.

And I suspect it really is checking for the wrong thing.  I don't
fully understand that code, but as far as I can tell it really
needs to know if there is more than a file system block of data in
the bio, and btrfs conflats pages with blocks.  But I'd need btrfs
folks to confirm this.
