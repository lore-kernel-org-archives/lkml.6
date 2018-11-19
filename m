Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24F13C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 12:29:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D214420831
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 12:29:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qS6/tW+a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D214420831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728855AbeKSWxC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 17:53:02 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:53148 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728701AbeKSWxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 17:53:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Si11AaJ0kS84qTnbFAUKDz5Ss/ZNpY48xd4ACOBB3Ms=; b=qS6/tW+a9D4f0Bl3Cb6miZMEt
        mmTeBU2xlNBPQMeXBipI3kXF+jAkdO6MFRUfBSfwgHbDiYxZPAMBZEHHTLkHs2wOVTgfPj2FlMXUV
        AZJwgQqk+lwxZoa6DZsj6n00CW+DcIVZ2wahcc57GlM7IFef8d4w1yEnf7629MwY+G26E0as5mB9H
        q1p5ib/Hj88Shrkvg6XKaX6ole3hHMw7LAZt+QZnu6dqXjBmwVpuD3mI1xud11m1Y4VfjIrGlougs
        WsJ4GIGWaoswEKgrR4fZzckAmnYwjZ49nloLgHHSAmjo5OfFPTO9rj1h+gol2oS8NzBvYp+c45mA/
        iTIS/+bjg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gOigD-000872-T6; Mon, 19 Nov 2018 12:29:29 +0000
Date:   Mon, 19 Nov 2018 04:29:29 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Oleksandr Andrushchenko <andr2000@gmail.com>
Cc:     Souptick Joarder <jrdr.linux@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        oleksandr_andrushchenko@epam.com, airlied@linux.ie,
        Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, xen-devel@lists.xen.org
Subject: Re: [Xen-devel] [PATCH 5/9] drm/xen/xen_drm_front_gem.c: Convert to
 use vm_insert_range
Message-ID: <20181119122929.GA394@bombadil.infradead.org>
References: <20181115154912.GA27969@jordon-HP-15-Notebook-PC>
 <ed294bea-bf07-6a4d-51ec-9e7082703b61@gmail.com>
 <CAFqt6zZ_FnWg2K3Lh=-1KFOk1XteHnroua6QzJrKo+khZTgieg@mail.gmail.com>
 <c76fc2fa-d08b-7db3-5693-d9c303cd7126@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c76fc2fa-d08b-7db3-5693-d9c303cd7126@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 01:02:46PM +0200, Oleksandr Andrushchenko wrote:
> On 11/19/18 12:42 PM, Souptick Joarder wrote:
> > On Mon, Nov 19, 2018 at 3:22 PM Oleksandr Andrushchenko
> > <andr2000@gmail.com> wrote:
> > > > -     unsigned long addr = vma->vm_start;
> > > > -     int i;
> > > > +     int err;
> > > I would love to keep ret, not err
> > Sure, will add it in v2.
> > But I think, err is more appropriate here.
> 
> I used "ret" throughout the driver, so this is just to remain consistent:
> 
> grep -rnw err drivers/gpu/drm/xen/ | wc -l
> 0
> grep -rnw ret drivers/gpu/drm/xen/ | wc -l
> 204

It's your driver, so that's fine.  The reason we chose 'err' over 'ret'
is that there's a history of errno vs VM_FAULT_xxx code confusion in
this area.  Naming a variable 'err' makes it clear this is an errno and
not a vm_fault_t.

> > > With the above fixed,
> > > 
> > > Reviewed-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>

Thanks.

