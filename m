Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2DD5C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 01:49:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77C2522507
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 01:49:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="I01/Rw/J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77C2522507
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730552AbeKMLpS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 06:45:18 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:32848 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbeKMLpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 06:45:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=iRqoNhjVcXFNULHc0mtUAENGHAiYhTKtS83/JxLE14s=; b=I01/Rw/Jb2P5DzgFS798XI3u8
        W5tca37G/4xKfHRh/jfODakQO8PVaOIQozRrg1M/VnZHfQgfmeL0smJ8VkznCcs59CvGfSwg4Btxq
        JqPMchkvMPQLGedqFfZ97JtBhdFKeS0AhTGYWqCNLlQvN3PRBPhxg8KsVmh54hc4OdrKv9lHOJ6Z1
        jrmp/VI3ohxmTInN7lGFd/7kySyMuwWj53u2VEE4fRUVaeuwCN+1C0d1A81RmAhF/RZCyB1V5WoO/
        m3SrsmUaP/DjQv+p35xVIUD1Pcd+NaInDriIKueZmm3njEWIAfvJwOnQHR87Np4OelCIWboORauBw
        xbhTjzH1Q==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gMNpY-0007wG-OA; Tue, 13 Nov 2018 01:49:28 +0000
Date:   Mon, 12 Nov 2018 17:49:28 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Timofey Titovets <timofey.titovets@synesis.ru>
Cc:     linux-kernel@vger.kernel.org,
        Timofey Titovets <nefelim4ag@gmail.com>, linux-mm@kvack.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH V3] KSM: allow dedup all tasks memory
Message-ID: <20181113014928.GH21824@bombadil.infradead.org>
References: <20181112231344.7161-1-timofey.titovets@synesis.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181112231344.7161-1-timofey.titovets@synesis.ru>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 13, 2018 at 02:13:44AM +0300, Timofey Titovets wrote:
> Some numbers from different not madvised workloads.
> Formulas:
>   Percentage ratio = (pages_sharing - pages_shared)/pages_unshared
>   Memory saved = (pages_sharing - pages_shared)*4/1024 MiB
>   Memory used = free -h
> 
>   * Name: My working laptop
>     Description: Many different chrome/electron apps + KDE
>     Ratio: 5%
>     Saved: ~100  MiB
>     Used:  ~2000 MiB

Your _laptop_ saves 100MB of RAM?  That's extraordinary.  Essentially
that's like getting an extra 100MB of page cache for free.  Is there
any observable slowdown?  I could even see there being a speedup (due
to your working set being allowed to be 5% larger)

I am now a big fan of this patch and shall try to give it the review
that it deserves.
