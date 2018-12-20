Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40FB8C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 11:35:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10AB620815
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 11:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545305754;
	bh=qj3vijLUrrlOo6BdC3mbBB/Q8OLfcHBZBkFNmK98xAQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qJcHUTnxsyNjjHcLWYEm0OsBySE9y8yfzEd0ZrDo+fFH211N0XbbTnfJHYagTIbWl
	 FwQT2sObNAwu2PeEYyLgZaGJafMJCg49vKyJUmerNXHeq/OnuX0YvdD4yf/eUJABp0
	 1nUa1DuAMUj9QQOnZymcrQozkRbHyq47dS6yMf6Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730960AbeLTLfx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 06:35:53 -0500
Received: from mx2.suse.de ([195.135.220.15]:48464 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727990AbeLTLfw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 06:35:52 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AB0CCABDC;
        Thu, 20 Dec 2018 11:35:50 +0000 (UTC)
Date:   Thu, 20 Dec 2018 12:35:47 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        David Rientjes <rientjes@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCHv2 2/3] mm/numa: build zonelist when alloc for device on
 offline node
Message-ID: <20181220113547.GC9104@dhcp22.suse.cz>
References: <1545299439-31370-1-git-send-email-kernelfans@gmail.com>
 <1545299439-31370-3-git-send-email-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1545299439-31370-3-git-send-email-kernelfans@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 20-12-18 17:50:38, Pingfan Liu wrote:
[...]
> @@ -453,7 +456,12 @@ static inline int gfp_zonelist(gfp_t flags)
>   */
>  static inline struct zonelist *node_zonelist(int nid, gfp_t flags)
>  {
> -	return NODE_DATA(nid)->node_zonelists + gfp_zonelist(flags);
> +	if (unlikely(!possible_zonelists[nid])) {
> +		WARN_ONCE(1, "alloc from offline node: %d\n", nid);
> +		if (unlikely(build_fallback_zonelists(nid)))
> +			nid = first_online_node;
> +	}
> +	return possible_zonelists[nid] + gfp_zonelist(flags);
>  }

No, please don't do this. We do not want to make things work magically
and we definitely do not want to put something like that into the hot
path. We definitely need zonelists to be build transparently for all
possible nodes during the init time.
-- 
Michal Hocko
SUSE Labs
