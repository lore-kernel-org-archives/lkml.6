Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7673C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 13:13:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A5F9208A4
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 13:13:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lDXKmxZt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A5F9208A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389362AbeHAO7X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 10:59:23 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57668 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389196AbeHAO7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 10:59:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7sZvwn6w0P9XpM1AvtBuKOc/eckwRVT/EpJgsePPxfQ=; b=lDXKmxZtXhVIy05Vb2jAfQMWq
        crwsu68+EhyiXaBG7297gkswDbfLQ3OnyUARk9C+NviWm/QWA4L64pvbGdPnSM90xP48l0liBfq/T
        5l+HeZITJnp83K4pkNpNhp106ac8wd6BdWoA7xcBxr0ZAvXYmwU7Km6gyqwGdJoAQn3Jieam+bkuX
        3M4Ml4R16mPRdmKRwJWFkhAToQXDINk/RYxl6D5Ew7cHJ7jHlAogA+XlC8t7RGaKWgMofF2JbxPSA
        hVO7NfnUNWzRmlW0UHc/sDoZW7RgavM5dn/vM5153HdgbWdDWxU81Sin8GhCFB6sf9fX/UdTOz2kg
        z138r5mZg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fkqwU-0005PD-Fz; Wed, 01 Aug 2018 13:13:30 +0000
Date:   Wed, 1 Aug 2018 06:13:30 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>, adilger.kernel@dilger.ca,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Eric Biggers <ebiggers@google.com>,
        Greg KH <gregkh@linuxfoundation.org>, kemi.wang@intel.com,
        Sabyasachi Gupta <sabyasachi.linux@gmail.com>,
        Brajeswar Ghosh <brajeswar.linux@gmail.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: Convert int to vm_fault_t type
Message-ID: <20180801131330.GA4734@bombadil.infradead.org>
References: <20180728085000.GA9136@jordon-HP-15-Notebook-PC>
 <20180801125512.GA10761@thunk.org>
 <CAFqt6zbxpj5DS=ONUGTJ9zaeH5k=qZpQYy-J+08tr9y0gOsCAg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFqt6zbxpj5DS=ONUGTJ9zaeH5k=qZpQYy-J+08tr9y0gOsCAg@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 01, 2018 at 06:34:45PM +0530, Souptick Joarder wrote:
> > The fact that ext4_page_mkwrite() returns a vm_fault_t, while
> > block_page_mkwrite() returns an int which then has to get translated
> > into a vm_fault_t via block_page_mkwrite_return() is I suspect going
> > to confuse an awful lot of callers.
> 
> We have also changed block_page_mkwrite() to return vm_fault_t, but in
> a different patch. Hopefully that patch will be in linux-next tree soon.

I didn't sign off on that, so that's not "we", but "I".  And this is
completely against everything I've been telling you for this whole effort.
Patches should each make sense individually.  You can't make this patch
dependent on another patch without putting that in writing.

Leave block_page_mkwrite() alone for now.  Eventually it should return
a vm_fault_t, probably.  But that patch needs to be delayed at least
one kernel cycle.
