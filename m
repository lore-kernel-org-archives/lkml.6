Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBA55C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 09:15:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C250214F1
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 09:15:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C250214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731994AbeHBLGM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 07:06:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:52344 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726293AbeHBLGM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 07:06:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CF0B5AE20;
        Thu,  2 Aug 2018 09:15:55 +0000 (UTC)
Date:   Thu, 2 Aug 2018 11:15:54 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Jeremy Linton <jeremy.linton@arm.com>
Cc:     linux-mm@kvack.org, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, vbabka@suse.cz, Punit.Agrawal@arm.com,
        Lorenzo.Pieralisi@arm.com, linux-arm-kernel@lists.infradead.org,
        bhelgaas@google.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC 1/2] slub: Avoid trying to allocate memory on offline nodes
Message-ID: <20180802091554.GE10808@dhcp22.suse.cz>
References: <20180801200418.1325826-1-jeremy.linton@arm.com>
 <20180801200418.1325826-2-jeremy.linton@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180801200418.1325826-2-jeremy.linton@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 01-08-18 15:04:17, Jeremy Linton wrote:
[...]
> @@ -2519,6 +2519,8 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
>  		if (unlikely(!node_match(page, searchnode))) {
>  			stat(s, ALLOC_NODE_MISMATCH);
>  			deactivate_slab(s, page, c->freelist, c);
> +			if (!node_online(searchnode))
> +				node = NUMA_NO_NODE;
>  			goto new_slab;

This is inherently racy. Numa node can get offline at any point after
you check it here. Making it race free would involve some sort of
locking and I am not really convinced this is a good idea.

>  		}
>  	}
> -- 
> 2.14.3
> 

-- 
Michal Hocko
SUSE Labs
