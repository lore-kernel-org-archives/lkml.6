Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF516C04EBF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 11:13:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A02D20850
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 11:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544094813;
	bh=cqj4QkOqEE8x08Mu2Xw78WNjssnBkJOWAeqdmmW2exM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vQpf6IBpkFS/AYEJq/pv9uDgegwCgA40wP3RDdlQlN7dL31y71BVjYTO2aJNIx08M
	 ggRNxRNH5WHIPD2O7NfMcLDftk1/nEpvKPIv3D8gaRCghiN2zG0U8Ohk8mPQ75dIzo
	 3sBK1/NQc9SUciU0x5+rhifrc1ddd1AjwP8+Yk6Q=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A02D20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729601AbeLFLNc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 06:13:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:57400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729200AbeLFLNb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 06:13:31 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C053420850;
        Thu,  6 Dec 2018 11:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544094811;
        bh=cqj4QkOqEE8x08Mu2Xw78WNjssnBkJOWAeqdmmW2exM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rbDMmfK4v2/GxJkyUrCiBPHjYnD3mPngRRMaIrP2v4azCX1x+WD6NQATU+kQrVZTZ
         AOx6tpunTDGZfd3lElU3W90WLJVAPWXSJ4BQLQ79W9vLv3ZSgM9FL1PS6J6vsuJab0
         tLz3mK6PGLnIJBdGqpapjvzp2HBeMuCE9QZPS9AA=
Date:   Thu, 6 Dec 2018 12:13:28 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Roman Gushchin <guro@fb.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Yongqin Liu <yongqin.liu@linaro.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] mm: hide incomplete nr_indirectly_reclaimable in
 /proc/zoneinfo
Message-ID: <20181206111328.GP19891@kroah.com>
References: <20181030174649.16778-1-guro@fb.com>
 <20181129125228.GN3149@kroah.com>
 <a4495506-2dcf-922a-1b77-e915214dd041@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4495506-2dcf-922a-1b77-e915214dd041@suse.cz>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 03:54:10PM +0100, Vlastimil Babka wrote:
> On 11/29/18 1:52 PM, Greg KH wrote:
> > On Tue, Oct 30, 2018 at 05:48:25PM +0000, Roman Gushchin wrote:
> >> BTW, in 4.19+ the counter has been renamed and exported by
> >> the commit b29940c1abd7 ("mm: rename and change semantics of
> >> nr_indirectly_reclaimable_bytes"), so there is no such a problem
> >> anymore.
> >>
> >> Cc: <stable@vger.kernel.org> # 4.14.x-4.18.x
> >> Fixes: 7aaf77272358 ("mm: don't show nr_indirectly_reclaimable in /proc/vmstat")
> 
> ...
> 
> > I do not see this patch in Linus's tree, do you?
> > 
> > If not, what am I supposed to do with this?
> 
> Yeah it wasn't probably clear enough, but this is stable-only patch, as
> upstream avoided the (then-unknown) problem in 4.19 as part of a far
> more intrusive series. As I've said in my previous reply to this thread,
> I don't think we can backport that series to stable (e.g. it introduces
> a set of new kmalloc caches that will suddenly appear in /proc/slabinfo)
> so I think this is a case for exception from the stable rules.

Ok, now queued up, thanks.

greg k-h
