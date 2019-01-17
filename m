Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62964C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 09:18:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BAFB20657
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 09:18:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GfUDLcDa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727968AbfAQJSU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 04:18:20 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:58740 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726732AbfAQJST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 04:18:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=tKYUtTs/bkkErXQgRT7KCA2z8JIPdvyQyEhxYuvcI+M=; b=GfUDLcDaCMFP/TLDMBZAWl8eu
        0uEqTNuLswGnymkr8F6WEIExSx9MNYbu/RI1jnWTbp7By9DmIwf9XQTRxSYdPKBLTN9XaU0b1ir0i
        ZZySONfZOyO50vIfBmNXmvTgkLpMf0GYduUYAQJKT9KWL6HFcz0grVgPcSnXPLi11dcXttq192jBM
        KLrMOQEAkzwIs8hcOTpP7Rw2k0SttQbPcVlcOC/GjnG3lNIlrq6mtutREIC1CLz9jHNLskMfqo6Mc
        RCRIfAiq8TEdv4S8JDvz0/SWbqZZRqs7IjW4IqJbHxJZPbA1cOFZ2rx066lj2Df86cA35npJ1tm3m
        cP+RtLj/g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gk3oV-0003sz-G4; Thu, 17 Jan 2019 09:18:15 +0000
Date:   Thu, 17 Jan 2019 01:18:15 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Oleksandr Andrushchenko <Oleksandr_Andrushchenko@epam.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Oleksandr Andrushchenko <andr2000@gmail.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "daniel.vetter@intel.com" <daniel.vetter@intel.com>,
        "jgross@suse.com" <jgross@suse.com>,
        "boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>,
        "noralf@tronnes.org" <noralf@tronnes.org>
Subject: Re: [PATCH v2] drm/xen-front: Make shmem backed display buffer
 coherent
Message-ID: <20190117091815.GA7090@infradead.org>
References: <20190115140420.4652-1-andr2000@gmail.com>
 <20190116063002.jq3aas6ofhaogmyk@sirius.home.kraxel.org>
 <20190116063631.GA10881@infradead.org>
 <042fe794-dec6-6d9d-5b68-6f142790f5c7@epam.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <042fe794-dec6-6d9d-5b68-6f142790f5c7@epam.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 06:43:29AM +0000, Oleksandr Andrushchenko wrote:
> > This whole issue keeps getting more and more confusing.
> Well, I don't really do DMA here, but instead the buffers in
> question are shared with other Xen domain, so effectively it
> could be thought of some sort of DMA here, where the "device" is
> that remote domain. If the buffers are not flushed then the
> remote part sees some inconsistency which in my case results
> in artifacts on screen while displaying the buffers.
> When buffers are allocated via DMA API then there are no artifacts;
> if buffers are allocated with shmem + DMA mapping then there are no
> artifacts as well.
> The only offending use-case is when I use shmem backed buffers,
> but do not flush them

The right answer would be to implement cache maintainance hooks for
this case in the Xen arch code.  These would basically look the same
as the low-level cache maintainance used by the DMA ops, but without
going through the DMA mapping layer, in fact they should probably
reuse the same low-level assembly routines.

I don't think this is the first usage of such Xen buffer sharing, so
what do the other users do?
