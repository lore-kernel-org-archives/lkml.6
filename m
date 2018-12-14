Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B270C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 18:24:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73D97206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 18:25:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IxJhu6OA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730447AbeLNSY6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 13:24:58 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:56182 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729752AbeLNSY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 13:24:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=wR+JE2iaCIjxwFXnmbeY7VZB8IJWu/VrAQRC+gCMdDo=; b=IxJhu6OA7NIUj/gVBPs2xZ1+t
        PJjznIC4ou4jA2ncNWaKuWac+IoD5qkKayyMsSO4lc2Ekg6ZRC9glVBpwzTO2KqzIzZqenFk5ytuO
        myjPO3f7H44jV/zOP6vxSdqcNfUSCPmiieYXP0embXJdfdu24zLrar8jdtF+Wjo+ZSuJiQRJquwjK
        Y9T4q6p+u62n/pgiIBY088hLzHLw0Fwnwan9IjjEB6oBcsRQT5MP17rXdRglMBJmnkOk2UZ1JbN+G
        rzcToT5o6Me8OlU8BLRvLmcsoNMkxIqwYwGn7AzkAf91C3sOi+DPYuvBYhkM9N4H2SaiIv8s2U49K
        OqjijS2/Q==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gXs8q-0003IW-Nb; Fri, 14 Dec 2018 18:24:52 +0000
Date:   Fri, 14 Dec 2018 10:24:52 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Roman Gushchin <guroan@gmail.com>
Cc:     linux-mm@kvack.org, Alexey Dobriyan <adobriyan@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, Roman Gushchin <guro@fb.com>
Subject: Re: [RFC 1/4] mm: refactor __vunmap() to avoid duplicated call to
 find_vm_area()
Message-ID: <20181214182452.GD10600@bombadil.infradead.org>
References: <20181214180720.32040-1-guro@fb.com>
 <20181214180720.32040-2-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181214180720.32040-2-guro@fb.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2018 at 10:07:17AM -0800, Roman Gushchin wrote:
> __vunmap() calls find_vm_area() twice without an obvious reason:
> first directly to get the area pointer, second indirectly by calling
> remove_vm_area(), which is again searching for the area.
> 
> To remove this redundancy, let's split remove_vm_area() into
> __remove_vm_area(struct vmap_area *), which performs the actual area
> removal, and remove_vm_area(const void *addr) wrapper, which can
> be used everywhere, where it has been used before.
> 
> On my test setup, I've got up to 12% speed up on vfree()'ing 1000000
> of 4-pages vmalloc blocks.
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Reviewed-by: Matthew Wilcox <willy@infradead.org>
