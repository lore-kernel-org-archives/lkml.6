Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F81BC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 17:52:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E07120855
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 17:52:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ha6hOH93"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E07120855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbeLKRwB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 12:52:01 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:51256 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbeLKRwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 12:52:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=azOD/kMbCaYoWMPFB6ffydr4LXt3iwijGocViQOfoJA=; b=ha6hOH93xhwxbiQTY4/hqIt2Z
        Wh+jQWVTagg137merD3mV0v7xE9Nm8zXlrqkwOSp5Nbwx+1LfHgLQkuCteWHsaAUhGCmPY+0u0+V8
        qgOSPW4lW1yWnguysCczXtBiWZ+H5LeM3g5u4ezWNUVR4Hx9F/K4MUKcQBy4YR+2pa4E1Vt9X4zaH
        3wZ0muMRxtk1XW7gwvJD7f/GnXM1m80UJOS/ivsE0tA4qs3uJTi3JsXCZ3qQDm7+0+l0qRe3WSqh2
        Zp/nqBnyFwAkil3DLeDxNbxzl7eO3p1f0ogMRFGKxL7TCVvTgS7LxhYzdzho+Nwn1U7VXqV2zrWvx
        ZbPHo/pOQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gWmCK-0004ye-Ij; Tue, 11 Dec 2018 17:51:56 +0000
Date:   Tue, 11 Dec 2018 09:51:56 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Jeff Moyer <jmoyer@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Benjamin LaHaise <bcrl@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] aio: Convert ioctx_table to XArray
Message-ID: <20181211175156.GF6830@bombadil.infradead.org>
References: <20181128183531.5139-1-willy@infradead.org>
 <x49va46e1p0.fsf@segfault.boston.devel.redhat.com>
 <x49pnuee1gm.fsf@segfault.boston.devel.redhat.com>
 <x49mupcm11r.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <x49mupcm11r.fsf@segfault.boston.devel.redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 12:21:52PM -0500, Jeff Moyer wrote:
> I'm going to submit this version formally.  If you're interested in
> converting the ioctx_table to xarray, you can do that separately from a
> security fix.  I would include a performance analysis with that patch,
> though.  The idea of using a radix tree for the ioctx table was
> discarded due to performance reasons--see commit db446a08c23d5 ("aio:
> convert the ioctx list to table lookup v3").  I suspect using the xarray
> will perform similarly.

There's a big difference between Octavian's patch and mine.  That patch
indexed into the radix tree by 'ctx_id' directly, which was pretty
much guaranteed to exhibit some close-to-worst-case behaviour from the
radix tree due to IDs being sparsely assigned.  My patch uses the ring
ID which _we_ assigned, and so is nicely behaved, being usually a very
small integer.

What performance analysis would you find compelling?  Octavian's original
fio script:

> rw=randrw; size=256k ;directory=/mnt/fio; ioengine=libaio; iodepth=1
> blocksize=1024; numjobs=512; thread; loops=100
> 
> on an EXT2 filesystem mounted on top of a ramdisk

or something else?
