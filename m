Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC897C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 12:36:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A54C7214C4
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 12:36:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qxtfYj5c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A54C7214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730407AbeKUXKO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 18:10:14 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:58960 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729682AbeKUXKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 18:10:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=G7F0P87w5SJ55fcCxV4qV5ZpRg/hG3mg6oTNXEm7SCE=; b=qxtfYj5cOAmdarsvItdfuUJoL
        cq+iNPkhyc5YD+4FMPO8KaILGGOp2+x+Psh8Pd1TZNxn1rKc92tsqRsLU/m0GX2+ye2opHd9OmCFk
        JzDP2qM2A1WmGdHFahwc/E+oXv6F0m1xiX4Pk8KPX7czPyYggRB3gMeQOeZSWnect3phEYY9cf83/
        6oNL8spLI278KdFZMqt8Ye/66CjaAh2ZakZm6P0acpHLqt8AG1UbQgWaFttMAmibqqQwlzDcA+fW+
        6uE4dAElCcM5YSXzlR4apgyVQW/LF8bSyYbfTdP+VKNb3jl7/ShL1w/M0cwPnueL3dHB+L2WBNtPY
        09E/lS+zw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gPRir-0005gr-VB; Wed, 21 Nov 2018 12:35:13 +0000
Date:   Wed, 21 Nov 2018 04:35:13 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     William Kucharski <william.kucharski@oracle.com>
Cc:     Souptick Joarder <jrdr.linux@gmail.com>, rppt@linux.ibm.com,
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
Message-ID: <20181121123513.GF3065@bombadil.infradead.org>
References: <20181115154530.GA27872@jordon-HP-15-Notebook-PC>
 <20181116182836.GB17088@rapoport-lnx>
 <CAFqt6zYp0j999WXw9Jus0oZMjADQQkPfso8btv6du6L9CE3PXA@mail.gmail.com>
 <20181117143742.GB7861@bombadil.infradead.org>
 <CAFqt6zbOWX5LUTWwoGDJsGdf+pTR6N1yTPVxyr1W3-6Fte39ww@mail.gmail.com>
 <833B5050-DEF6-44A0-9832-276F86671212@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <833B5050-DEF6-44A0-9832-276F86671212@oracle.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 04:19:11AM -0700, William Kucharski wrote:
> Could you add a line to the description explicitly stating that a failure
> to insert any page in the range will fail the entire routine, something
> like:
> 
> > * This allows drivers to insert range of kernel pages they've allocated
> > * into a user vma. This is a generic function which drivers can use
> > * rather than using their own way of mapping range of kernel pages into
> > * user vma.
> > *
> > * A failure to insert any page in the range will fail the call as a whole.
> 
> It's obvious when reading the code, but it would be self-documenting to
> state it outright.

It's probably better to be more explicit and answer Randy's question:

 * If we fail to insert any page into the vma, the function will return
 * immediately leaving any previously-inserted pages present.  Callers
 * from the mmap handler may immediately return the error as their
 * caller will destroy the vma, removing any successfully-inserted pages.
 * Other callers should make their own arrangements for calling unmap_region().

Although unmap_region() is static so there clearly isn't any code in the
kernel today other than in mmap handlers (or fault handlers) that needs to
insert pages into a VMA.
