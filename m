Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 359EFC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 08:45:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1F9121726
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 08:45:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rVVOp2SL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729164AbfBAIpe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 03:45:34 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:43068 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728704AbfBAIpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 03:45:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=mp1ZXz1zIhz/V86/AaDi3xksztyn8Ia+cqQv1JQ3y8w=; b=rVVOp2SLd0jPKeVDH8wRXRmJ1
        QxASTOnLWdmEnytW+Qiw5dzqJCeL89cI1nSabo2q8NnXXMaTHP9A7zVmxstB+3s9HpmLXiDoEjJ+1
        CaHy4/8PBca8BEsN0f8fVxq6YwIB9AYl5oALbtw2BMpGHgrjZ/SlmpwXqep9I4lnOnmEk8beyZm43
        fyeG056Lkp577b36RmzdmgpqDC16PsxmpOHsuV5VYj3Bd8FLkEi1Lb48YxgSEjSCaVllf7/ONDWhY
        GK8I68sJpUr0AsOCyJALLvyXlhpBTxg/8ykXUS2/PPYLBlY7OPpbshjUIAkxME0fT4ZVlknsa8nZe
        hNxWpIWUA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gpUS1-0000Qd-VH; Fri, 01 Feb 2019 08:45:29 +0000
Date:   Fri, 1 Feb 2019 00:45:29 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Oleksandr Andrushchenko <Oleksandr_Andrushchenko@epam.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel <xen-devel@lists.xenproject.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "marmarek@invisiblethingslab.com" <marmarek@invisiblethingslab.com>
Subject: Re: [Xen-devel] xen/mem-reservation API and out-of-tree kernel
 modules
Message-ID: <20190201084529.GA28907@infradead.org>
References: <f3ca533d-7f51-c59e-6a96-4e1fba687c8f@epam.com>
 <alpine.DEB.2.10.1901311343370.22962@sstabellini-ThinkPad-X260>
 <20190201082710.GA7437@infradead.org>
 <735816a7-897a-61ad-e70b-8d683c94d8ac@epam.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <735816a7-897a-61ad-e70b-8d683c94d8ac@epam.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 01, 2019 at 08:38:43AM +0000, Oleksandr Andrushchenko wrote:
> On 2/1/19 10:27 AM, Christoph Hellwig wrote:
> > On Thu, Jan 31, 2019 at 01:44:15PM -0800, Stefano Stabellini wrote:
> >> The alternative would be to turn xenmem_reservation_scrub_page into a
> >> regular function (not a static inline)?
> > All that is a moot point until said currently out of tree module gets
> > submitted for inclusion anyway.
> Indeed this is a moot point, so I can't argue here.
> But this is how it is and unfortunately we have to live
> with those modules and depend on 3rd parties willing or not
> to disclose their sources to public...

The point is that the kernel does generally not export interfaces
not used by in-tree modules.  So there is no reason to change anything
here.
