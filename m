Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0108AC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 14:25:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE77B22B53
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 14:25:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="n3LFYjCa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE77B22B53
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932865AbeGFOZm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 10:25:42 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53590 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753702AbeGFOZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 10:25:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=UmIJNFGbJ7i7bA4lBdkvs6UwzRMIv59tjwCy/auWLlM=; b=n3LFYjCa+6Tw243InCoXwcYYu
        ojbEV9QaydQMtoO4fNmipxFjQP6ivu0Cel7Au/u1nhy2yz6cOG68XoTXGOVmHRbAsNcY9xt7uioOY
        8B1cP9cpiv33mv4tvUPCHvQSO858dCM5WVbGDiRW49qF1M6gY/L/8dE1l8/tA2PF6bg6VHnDmV+dG
        PtzCghryDYsBV1GA53WHKWqQVSOke7jaQTezaCUrNEt02L54tmQkwIP6IgXKD3ACa3/zwwojDMof1
        4s01f97IsaD2hEP49SR2TstKvmYh3v+/v2Pn2vPy1dk6Ou6laJ5bucKyvlR7d9Hn8h+xP68HvTiBT
        Wvvx2fuRQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fbRg4-0004Cp-Rn; Fri, 06 Jul 2018 14:25:40 +0000
Date:   Fri, 6 Jul 2018 07:25:40 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        valdis.kletnieks@vt.edu
Subject: Re: [PATCH] radix-tree: avoid NULL dereference
Message-ID: <20180706142540.GB20816@bombadil.infradead.org>
References: <20180706134144.48446-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180706134144.48446-1-mark.rutland@arm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 06, 2018 at 02:41:44PM +0100, Mark Rutland wrote:
> When idr_alloc() is called for the first time on an IDR (which has no
> nodes in its radix tree), we end up with calculate_count() calling
> get_slot_offset() with a NULL node, leading to a NULL pointer
> dereference caught by UBSAN:

Thanks!

> The result of the load is passed into node_tag_get(), which ignores the
> value when node is NULL. Typically, the compiler inlines both
> get_slot_offset() and node_tag_get() into calculate_count(), optimizing
> away the NULL-pointer dereference, and hence this doesn't typically
> result in a boot failure.
> 
> We can't rely on the compiler always doing this, and must avoid
> dereferencing fields from node when it is potentially NULL.
> 
> To do so, this patch folds the generation of offset into tag_get(), such
> that this only happens when node is not NULL. Callers are updated to
> pass the relevant slot, rather than the offset derived from it.

I did think about this ... honest!  My reasoning clearly glitched at some
point.  I think this is the right way to fix the problem.

Acked-by: Matthew Wilcox <willy@infradead.org>
