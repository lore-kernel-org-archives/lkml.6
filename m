Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA208C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 17:53:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F6B521852
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 17:53:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="pHhDDlrw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728750AbfBZRxJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 12:53:09 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:46721 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727108AbfBZRxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 12:53:08 -0500
Received: by mail-qt1-f195.google.com with SMTP id z25so15868611qti.13
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 09:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZkICak7TAx1ec5dXU49ZvGdr7QE9uYcfKqHMH7L8rEU=;
        b=pHhDDlrw3D+nSh6skybCkY4mB9y43AKu3jhqmC4jv8qBDcl57hCDJoIfgs2faI+pZi
         sMtBf1NSdIsLKGqmH+LGR5DMx4JOKeLMq+l3IbcT+zlShc0QwsUMDrnucDOfeuvL3HNt
         4j/i0uwuE+9Met4KozGWPLv80lHRD1nkCEy5bzLs6rnc69eoZOvRcT5Zsy2k4tzdd+Nl
         CQWDBs1QODUkZERXYvI/fZtl0Z6aH+bEq1JKT5A/L3G5RzT1/S9pnwJ7ejCLllf69WCI
         bgcH0kuD1VU8Ids8C7yPk45aSFmdY2nyZGp0qdQdDJUsPiLEZAPB+ItdQkSv2FZH0uqa
         iXPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZkICak7TAx1ec5dXU49ZvGdr7QE9uYcfKqHMH7L8rEU=;
        b=P1wj213Qgh1w44fOTPw2CFPFQp1fBjLLLYuzwpeUSV2ZPrqFRCb3h3eScZN8wenJhb
         BJ6tMpeIPudAVT3chHokP0paIFsPXpv3K7bBuZlHT96OmfxLBG9IzuhqPLZGl4Vlx7fn
         c3YNhsvWR0rN591+gB09byCL/m38FZr8jliSPJFQg4jlprSNaTg4ks64qyh+6c+Nw7Ya
         Jtd7N4RtDdUb0BNWR0yibpycUp6euHhsu46/Dlcgto1RpDqnD2kYrerBQeUyDjhxKZwp
         w+cuSOIz1TwnBkXGxbyz5zk0ritIRrltAtFcGjTsUex1cPWhh8e21T4vRpHa8i0V6GMM
         SbDA==
X-Gm-Message-State: AHQUAuaFhyl4ctRRdXya4u38M10Lw5oZ4jM1YVIgtK5jv2NiGpS6Zctv
        dzC5jQQtntJpjvNCYTcSLNApdusfjj8=
X-Google-Smtp-Source: AHgI3Ia/fYrVyZqKSVJ4Wu+J06ao2h0XxWES227To9xOiH8WoqAJB/xYQ2K9aXAT7Ic22YaFPpNJrQ==
X-Received: by 2002:aed:35f0:: with SMTP id d45mr19594144qte.179.1551203587036;
        Tue, 26 Feb 2019 09:53:07 -0800 (PST)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id g24sm9607135qtc.61.2019.02.26.09.53.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 09:53:06 -0800 (PST)
Message-ID: <1551203585.6911.47.camel@lca.pw>
Subject: Re: [PATCH] mm/hotplug: fix an imbalance with DEBUG_PAGEALLOC
From:   Qian Cai <cai@lca.pw>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 26 Feb 2019 12:53:05 -0500
In-Reply-To: <20190226142352.GC10588@dhcp22.suse.cz>
References: <20190225191710.48131-1-cai@lca.pw>
         <20190226123521.GZ10588@dhcp22.suse.cz>
         <4d4d3140-6d83-6d22-efdb-370351023aea@lca.pw>
         <20190226142352.GC10588@dhcp22.suse.cz>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-02-26 at 15:23 +0100, Michal Hocko wrote:
> On Tue 26-02-19 09:16:30, Qian Cai wrote:
> > 
> > 
> > On 2/26/19 7:35 AM, Michal Hocko wrote:
> > > On Mon 25-02-19 14:17:10, Qian Cai wrote:
> > > > When onlining memory pages, it calls kernel_unmap_linear_page(),
> > > > However, it does not call kernel_map_linear_page() while offlining
> > > > memory pages. As the result, it triggers a panic below while onlining on
> > > > ppc64le as it checks if the pages are mapped before unmapping,
> > > > Therefore, let it call kernel_map_linear_page() when setting all pages
> > > > as reserved.
> > > 
> > > This really begs for much more explanation. All the pages should be
> > > unmapped as they get freed AFAIR. So why do we need a special handing
> > > here when this path only offlines free pages?
> > > 
> > 
> > It sounds like this is exact the point to explain the imbalance. When
> > offlining,
> > every page has already been unmapped and marked reserved. When onlining, it
> > tries to free those reserved pages via __online_page_free(). Since those
> > pages
> > are order 0, it goes free_unref_page() which in-turn call
> > kernel_unmap_linear_page() again without been mapped first.
> 
> How is this any different from an initial page being freed to the
> allocator during the boot?
> 

As least for IBM POWER8, it does this during the boot,

early_setup
  early_init_mmu
    harsh__early_init_mmu
      htab_initialize [1]
        htab_bolt_mapping [2]

where it effectively map all memblock regions just like
kernel_map_linear_page(), so later mem_init() -> memblock_free_all() will unmap
them just fine.

[1]
for_each_memblock(memory, reg) {
	base = (unsigned long)__va(reg->base);
	size = reg->size;

	DBG("creating mapping for region: %lx..%lx (prot: %lx)\n",
		base, size, prot);

	BUG_ON(htab_bolt_mapping(base, base + size, __pa(base),
		prot, mmu_linear_psize, mmu_kernel_ssize));
	}

[2] linear_map_hash_slots[paddr >> PAGE_SHIFT] = ret | 0x80;


