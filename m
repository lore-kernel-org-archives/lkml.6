Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 577A3C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 14:23:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DF132088E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 14:23:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="H0B2ETwb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DF132088E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387549AbeHBQPB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 12:15:01 -0400
Received: from a9-99.smtp-out.amazonses.com ([54.240.9.99]:45974 "EHLO
        a9-99.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387504AbeHBQPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 12:15:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1533219814;
        h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type:Feedback-ID;
        bh=y6bulpRbEjfHIFhEoTfMdi3LypqJNGhWx4XpQySka6E=;
        b=H0B2ETwbICTy/Zab4/DHdxumCbtnMTuqzwHCV8TcPTgkSJBlmM0tvoZ8vyYwj5nE
        kbWITil3eplsvNJYeLFM2yV/d7Cbuq6I2zI1nUKra5mvvs0RkXIHWcZa5YtZd6B4ufB
        VgvK5ctPnOV0pJrrB6B9JjEhusWxocPmfQRj8j5U=
Date:   Thu, 2 Aug 2018 14:23:34 +0000
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To:     Jeremy Linton <jeremy.linton@arm.com>
cc:     linux-mm@kvack.org, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, mhocko@suse.com,
        vbabka@suse.cz, Punit.Agrawal@arm.com, Lorenzo.Pieralisi@arm.com,
        linux-arm-kernel@lists.infradead.org, bhelgaas@google.com,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC 1/2] slub: Avoid trying to allocate memory on offline
 nodes
In-Reply-To: <20180801200418.1325826-2-jeremy.linton@arm.com>
Message-ID: <01000164fb05bba7-1804e794-a08d-4ee0-b842-c44c89647716-000000@email.amazonses.com>
References: <20180801200418.1325826-1-jeremy.linton@arm.com> <20180801200418.1325826-2-jeremy.linton@arm.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-SES-Outgoing: 2018.08.02-54.240.9.99
Feedback-ID: 1.us-east-1.fQZZZ0Xtj2+TD7V5apTT/NrT6QKuPgzCT/IC7XYgDKI=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Aug 2018, Jeremy Linton wrote:

> diff --git a/mm/slub.c b/mm/slub.c
> index 51258eff4178..e03719bac1e2 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2519,6 +2519,8 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
>  		if (unlikely(!node_match(page, searchnode))) {
>  			stat(s, ALLOC_NODE_MISMATCH);
>  			deactivate_slab(s, page, c->freelist, c);
> +			if (!node_online(searchnode))
> +				node = NUMA_NO_NODE;
>  			goto new_slab;
>  		}
>  	}
>

Would it not be better to implement this check in the page allocator?
There is also the issue of how to fallback to the nearest node.

NUMA_NO_NODE should fallback to the current memory allocation policy but
it seems by inserting it here you would end up just with the default node
for the processor.

