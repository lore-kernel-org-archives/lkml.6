Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1252C4151A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 15:49:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD0E9218CD
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 15:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549986544;
	bh=K0aoyY/nb/VrHdL1zAx8Hnxt0yP94fhovRVQnknUtQU=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=sN+O41PpVEHe/4LqG/6ihokY9/4GgbzkttVxRcd9X3X2ewW/nd8ijECQE0vsNdH3W
	 fKb/WEoqdstdNS9uM4jUluYNQvYPjPwskLgH5AvyVu02Yid/Vv8R6cFz0TIZIa5A1r
	 yNnGyUIK7eqgrK4IYsZFeCZiBbcJSfiKyOhuBgeQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730740AbfBLPtD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 10:49:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:51134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728585AbfBLPtD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 10:49:03 -0500
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF8F320842;
        Tue, 12 Feb 2019 15:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549986542;
        bh=K0aoyY/nb/VrHdL1zAx8Hnxt0yP94fhovRVQnknUtQU=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=bYzagzjirKHE5hOPkjMM1eAPxn0VUwCCwpIpcySxA/iVtphDZycLfaiJEJSdQtaaQ
         7xynE/cz1bfB1cEKyrodMbE0ALVjPwLCkdcotWgLGz8o63sTGTDQxwJAnJB01EJ4cF
         i2/BMJJeb3l4zLoqEtpuQz/MhfCmw6tbsyZDQ78g=
Date:   Tue, 12 Feb 2019 16:48:56 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
cc:     Michal Hocko <mhocko@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-api@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jann Horn <jannh@google.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Kevin Easton <kevin@guarana.org>,
        Matthew Wilcox <willy@infradead.org>,
        Cyril Hrubis <chrubis@suse.cz>, Tejun Heo <tj@kernel.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Daniel Gruss <daniel@gruss.cc>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/3] mm/filemap: initiate readahead even if IOCB_NOWAIT
 is set for the I/O
In-Reply-To: <20190201014446.GU6173@dastard>
Message-ID: <nycvar.YFH.7.76.1902121645470.11598@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.1901051817390.16954@cbobk.fhfr.pm> <20190130124420.1834-1-vbabka@suse.cz> <20190130124420.1834-3-vbabka@suse.cz> <20190131095644.GR18811@dhcp22.suse.cz> <20190201014446.GU6173@dastard>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Feb 2019, Dave Chinner wrote:

> So, I'll invite the incoherent, incandescent O_DIRECT rage flames of
> Linus to be unleashed again and point out the /other reference/ to
> IOCB_NOWAIT in mm/filemap.c. That is, in generic_file_read_iter(),
> in the *generic O_DIRECT read path*:
> 
> 	if (iocb->ki_flags & IOCB_DIRECT) {
> .....
> 		if (iocb->ki_flags & IOCB_NOWAIT) {
> 			if (filemap_range_has_page(mapping, iocb->ki_pos,
> 						   iocb->ki_pos + count - 1))
> 				return -EAGAIN;
> 		} else {
> .....

OK, thanks Dave, this is a good point I've missed in this mail before 
(probabably as I focused only on the aspect of disagreement what NONBLOCK 
actually means :) ). I will look into fixing it for next iteration.

> It's effectively useless as a workaround because you can avoid the
> readahead IO being issued relatively easily:
> 
> void page_cache_sync_readahead(struct address_space *mapping,
>                                struct file_ra_state *ra, struct file *filp,
>                                pgoff_t offset, unsigned long req_size)
> {
>         /* no read-ahead */
>         if (!ra->ra_pages)
>                 return;
> 
>         if (blk_cgroup_congested())
>                 return;
> ....
> 
> IOWs, we just have to issue enough IO to congest the block device (or,
> even easier, a rate-limited cgroup), and we can still use RWF_NOWAIT
> to probe the page cache. Or if we can convince ra->ra_pages to be
> zero (e.g. it's on bdi device with no readahead configured because
> it's real fast) then it doesn't work there, either.

It's though questionable whether the noise level here wouldn't be too high 
already for any sidechannel to work reliably. So I'd suggest to operate 
under the assumption that it would be too noisy, unless anyone is able to 
prove otherwise.

Thanks,

-- 
Jiri Kosina
SUSE Labs

