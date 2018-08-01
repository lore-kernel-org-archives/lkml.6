Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09A10C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 16:13:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9C6A20841
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 16:13:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UFYPi1vR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9C6A20841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390031AbeHAR74 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 13:59:56 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57626 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389742AbeHAR7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 13:59:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=a7ip1mEosZJuEhiXAjsXJ60Rfh1cl4jg6eHOTtqBYVY=; b=UFYPi1vRJj+m007LEjcJTA7Ji
        GawaTiK3WpQMakDRodIbAoQL+SajtyfHovxjko7Kf2VKZjvUfHfZ5BYbUlb3KEdTZhKNsKPI8a1gm
        RnnY2E03WoECTavo02F6vjq1XtHMWYJV7VFGMOCoePQibDt6NsvLXPiuerlR0egdRzaU3J61Z9h49
        z/Dymr7xx3n49HxZ38BzufDLtdaNJM8fQrbbPzcbsxzTmgdT9BcG7f/zVEEfVGiKjVxZviT8A1VYF
        mKcthwXNodq4fIybnJNdgajWG+PXZgQn8BNq3RAHC28yAfUO6ypi2FDpc4k85PEWQMr4tT1L81698
        acUstyRSw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fktkV-0002gC-G1; Wed, 01 Aug 2018 16:13:19 +0000
Date:   Wed, 1 Aug 2018 09:13:19 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        adilger.kernel@dilger.ca,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Eric Biggers <ebiggers@google.com>,
        Greg KH <gregkh@linuxfoundation.org>, kemi.wang@intel.com,
        Sabyasachi Gupta <sabyasachi.linux@gmail.com>,
        Brajeswar Ghosh <brajeswar.linux@gmail.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: Convert int to vm_fault_t type
Message-ID: <20180801161319.GC4039@bombadil.infradead.org>
References: <20180728085000.GA9136@jordon-HP-15-Notebook-PC>
 <20180801125512.GA10761@thunk.org>
 <CAFqt6zbxpj5DS=ONUGTJ9zaeH5k=qZpQYy-J+08tr9y0gOsCAg@mail.gmail.com>
 <20180801131330.GA4734@bombadil.infradead.org>
 <CAFqt6zYJv7SdkntY7KOBvNyfk-9MRaXBMmkbsc4J7P-tq616DA@mail.gmail.com>
 <20180801143830.GB10761@thunk.org>
 <20180801160618.GE10761@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180801160618.GE10761@thunk.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 01, 2018 at 12:06:18PM -0400, Theodore Y. Ts'o wrote:
> On Wed, Aug 01, 2018 at 10:38:30AM -0400, Theodore Y. Ts'o wrote:
> > I'm going to drop the whole ext4 changes for vm_fault_t for this
> > cycle, and I'll let you try to fix it up properly for the next cycle.
> 
> Here's the fixed up commit that I'm going to drop since you plan to be
> making changes in block_page_mkpage(), and I don't want us to get out
> of sync.

This looks sane to me.
