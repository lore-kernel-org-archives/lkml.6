Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3631C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 06:41:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78EB12145D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 06:41:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gYDeP8zn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78EB12145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389064AbeKPQwo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 11:52:44 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:44782 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727353AbeKPQwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 11:52:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=1C7V5FVrNtv+M7+hYpBUHIIeNht9dKbBFswk3ptBQQU=; b=gYDeP8zndU9ddeiNWompQ4UyW
        H7s/k/vO9A/HBLa8riABR2ohItgfoGuabIKZ8e7fxVw9cMeLbcOWYd9b24GrZJn0XugvVF7S+SQA+
        CXX5yC+iaNPbib9tRQDuQ19gIR2e00MyfYfrndwNTnxBnMPjORaukNiE+4qEwZurWoGXPdwQGkkkn
        u9caGjRDjjPwBPKj4VkpTejIMmdtC5l+3knTSDo4v7KjteNsWJNd8TMqAGrlCOuyi+hENIFA8nwa8
        heTkpqA5uo6Z90QLGs6LTn90CKP08484unVEXcQMWJbf81jwJLFpwbMEYSeg9ydX8xbwfjBLA0QTr
        Iz3H7TRFw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gNXo9-0004QI-Bd; Fri, 16 Nov 2018 06:40:49 +0000
Date:   Thu, 15 Nov 2018 22:40:49 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        vbabka@suse.cz, Rik van Riel <riel@surriel.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        rppt@linux.vnet.ibm.com, Peter Zijlstra <peterz@infradead.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        robin.murphy@arm.com, iamjoonsoo.kim@lge.com, treding@nvidia.com,
        Kees Cook <keescook@chromium.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        stefanr@s5r6.in-berlin.de, hjc@rock-chips.com,
        Heiko Stuebner <heiko@sntech.de>, airlied@linux.ie,
        oleksandr_andrushchenko@epam.com, joro@8bytes.org,
        pawel@osciak.com, Kyungmin Park <kyungmin.park@samsung.com>,
        mchehab@kernel.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org,
        Linux-MM <linux-mm@kvack.org>,
        linux-arm-kernel@lists.infradead.org,
        linux1394-devel@lists.sourceforge.net,
        dri-devel@lists.freedesktop.org,
        linux-rockchip@lists.infradead.org, xen-devel@lists.xen.org,
        iommu@lists.linux-foundation.org, linux-media@vger.kernel.org
Subject: Re: [PATCH 1/9] mm: Introduce new vm_insert_range API
Message-ID: <20181116064049.GA5320@bombadil.infradead.org>
References: <20181115154530.GA27872@jordon-HP-15-Notebook-PC>
 <9655a12e-bd3d-aca2-6155-38924028eb5d@infradead.org>
 <CAFqt6zbLjtDab3Bz67trbnQRQdutvgA=YvAFhoW4bxsg657mGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFqt6zbLjtDab3Bz67trbnQRQdutvgA=YvAFhoW4bxsg657mGQ@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 16, 2018 at 11:00:30AM +0530, Souptick Joarder wrote:
> On Thu, Nov 15, 2018 at 11:44 PM Randy Dunlap <rdunlap@infradead.org> wrote:
> > On 11/15/18 7:45 AM, Souptick Joarder wrote:
> > What is the opposite of vm_insert_range() or even of vm_insert_page()?
> > or is there no need for that?
> 
> There is no opposite function of vm_insert_range() / vm_insert_page().
> My understanding is, in case of any error, mmap handlers will return the
> err to user process and user space will decide the next action. So next
> time when mmap handler is getting invoked it will map from the beginning.
> Correct me if I am wrong.

The opposite function, I suppose, is unmap_region().

> > s/no./number/
> 
> I didn't get it ??

This is a 'sed' expression.  's' is the 'substitute' command; the /
is a separator, 'no.' is what you wrote, and 'number' is what Randy
is recommending instead.

> > > +     for (i = 0; i < page_count; i++) {
> > > +             ret = vm_insert_page(vma, uaddr, pages[i]);
> > > +             if (ret < 0)
> > > +                     return ret;
> >
> > For a non-trivial value of page_count:
> > Is it a problem if vm_insert_page() succeeds for several pages
> > and then fails?
> 
> No, it will be considered as total failure and mmap handler will return
> the err to user space.

I think what Randy means is "What happens to the inserted pages?" and
the answer is that mmap_region() jumps to the 'unmap_and_free_vma'
label, which is an accurate name.

Thanks for looking, Randy.
