Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6704C04EBC
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 22:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 964D1208B3
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 22:42:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="Cg+VUp0F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 964D1208B3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbeJPG37 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 02:29:59 -0400
Received: from a9-99.smtp-out.amazonses.com ([54.240.9.99]:38974 "EHLO
        a9-99.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726430AbeJPG37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 02:29:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1539643362;
        h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type:Feedback-ID;
        bh=fxwTb3fk5HcRMMz3gZbp/wY+XTqd89yTalFzAi/JmD0=;
        b=Cg+VUp0FPr6jerpxJQImbd5IpH1gPZRFZ/Tdha8pDJtH3OUtdBr/QZ58WZfYtzJM
        6D2Ps5mGx/6fgrjKqOljf1DgwN5nbw4/IfViHgU8LKPDiWZZA2O28Ir/AllxkFE3P7B
        RDs/3r3EgUet5RdrnvTBEvImsxIi9RnfD/g/YIAk=
Date:   Mon, 15 Oct 2018 22:42:42 +0000
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To:     David Rientjes <rientjes@google.com>
cc:     Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [patch] mm, slab: avoid high-order slab pages when it does not
 reduce waste
In-Reply-To: <alpine.DEB.2.21.1810121424420.116562@chino.kir.corp.google.com>
Message-ID: <0100016679e54c6e-67ca8716-c95e-427f-aec9-a5bee5e84792-000000@email.amazonses.com>
References: <alpine.DEB.2.21.1810121424420.116562@chino.kir.corp.google.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-SES-Outgoing: 2018.10.15-54.240.9.99
Feedback-ID: 1.us-east-1.fQZZZ0Xtj2+TD7V5apTT/NrT6QKuPgzCT/IC7XYgDKI=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Oct 2018, David Rientjes wrote:

> @@ -1803,6 +1804,20 @@ static size_t calculate_slab_order(struct kmem_cache *cachep,
>  		 */
>  		if (left_over * 8 <= (PAGE_SIZE << gfporder))
>  			break;
> +
> +		/*
> +		 * If a higher gfporder would not reduce internal fragmentation,
> +		 * no need to continue.  The preference is to keep gfporder as
> +		 * small as possible so slab allocations can be served from
> +		 * MIGRATE_UNMOVABLE pcp lists to avoid stranding.
> +		 */

I think either go for order 0 (because then you can use the pcp lists) or
go as high as possible (then you can allocator larger memory areas with a
single pass through the page allocator).

But then I am not sure that the whole approach will do any good.

