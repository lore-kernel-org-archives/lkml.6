Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49F8EC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 16:24:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D732208A6
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 16:24:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D732208A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbeHTTk1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 15:40:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:38846 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726596AbeHTTk1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 15:40:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CE8B1AFEB;
        Mon, 20 Aug 2018 16:24:07 +0000 (UTC)
Date:   Mon, 20 Aug 2018 18:24:06 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Li RongQing <lirongqing@baidu.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        darrick.wong@oracle.com
Subject: Re: [PATCH] mm: introduce kvvirt_to_page() helper
Message-ID: <20180820162406.GQ29735@dhcp22.suse.cz>
References: <1534596541-31393-1-git-send-email-lirongqing@baidu.com>
 <20180820144116.GO29735@dhcp22.suse.cz>
 <20180820144923.GA25153@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180820144923.GA25153@bombadil.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 20-08-18 07:49:23, Matthew Wilcox wrote:
> On Mon, Aug 20, 2018 at 04:41:16PM +0200, Michal Hocko wrote:
> > On Sat 18-08-18 20:49:01, Li RongQing wrote:
> > > The new helper returns address mapping page, which has several users
> > > in individual subsystem, like mem_to_page in xfs_buf.c and pgv_to_page
> > > in af_packet.c, unify them
> > 
> > kvvirt_to_page is a weird name. I guess you wanted it to fit into
> > kv*alloc, kvfree naming, right? If yes then I guess kvmem_to_page
> > would be slightly better.
> > 
> > Other than that the patch makes sense to me. It would be great to add
> > some documentation and be explicit that the call is only safe on
> > directly mapped kernel address and vmalloc areas.
> 
> ... and not safe if the length crosses a page boundary.  I don't want to
> see new code emerge that does kvmalloc(PAGE_SIZE * 2, ...); kvmem_to_page()
> and have it randomly crash when kvmalloc happens to fall back to vmalloc()
> under heavy memory pressure.
> 
> Also, people are going to start using this for stack addresses.  Perhaps
> we should have a debug option to guard against them doing that.

I do agree that such an interface is quite dangerous. That's why I was
stressing out the proper documentation. I would be much happier if we
could do without it altogether. Maybe the existing users can be rewoked
to not rely on the addr2page functionality. If that is not the case then
we should probably offer a helper. With some WARN_ONs to catch misuse
would be really nice. I am not really sure how many abuses can we catch
actually though.
-- 
Michal Hocko
SUSE Labs
