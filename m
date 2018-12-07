Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82307C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 15:56:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4280720882
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 15:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544198194;
	bh=CIV0C43gmrru8/le6dIZ07yQ3I8ZhoXKJ3uIfJghPAQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=e0x/lDU4FE+44vJQJ0xZZ4rl3oepCTHUw75HZqsNG7Jw+p1PijX3FyzdTeJe0KG4j
	 2NMF31Hlvp74B/n9jbZiFrtG8w18977vxaJyx+p41tLUju+CRuq4xjhb6gMbcm+Ndx
	 KoGYXBDa+PFeArq2lWK1BZAKjh2tzCjCYbwzHcDw=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4280720882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbeLGP4d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 10:56:33 -0500
Received: from mx2.suse.de ([195.135.220.15]:33800 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726041AbeLGP4c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 10:56:32 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BA39EACBA;
        Fri,  7 Dec 2018 15:56:30 +0000 (UTC)
Date:   Fri, 7 Dec 2018 16:56:27 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH] mm/alloc: fallback to first node if the wanted node
 offline
Message-ID: <20181207155627.GG1286@dhcp22.suse.cz>
References: <CAFgQCTsMdQSRFruZRGBuo30TjfiQ=sbrf9kUJAGgwN6uw+LsBw@mail.gmail.com>
 <CAFgQCTv7ADVW3WvB0tuqpL1U2MFGADA113MUm6ZmVcgvqyBfTA@mail.gmail.com>
 <20181206121152.GH1286@dhcp22.suse.cz>
 <CAFgQCTuqn32_pZrLBDNvC_0Aepv2F7KF7rk2nAbxmYF45KfT2w@mail.gmail.com>
 <20181207075322.GS1286@dhcp22.suse.cz>
 <CAFgQCTsFBUcOE9UKQ2vz=hg2FWp_QurZMQmJZ2wYLBqXkFHKHQ@mail.gmail.com>
 <20181207113044.GB1286@dhcp22.suse.cz>
 <CAFgQCTuf95pJSWDc1BNQ=gN76aJ_dtxMRbAV9a28X6w8vapdMQ@mail.gmail.com>
 <20181207142240.GC1286@dhcp22.suse.cz>
 <CAFgQCTuu54oZWKq_ppEvZFb4Mz31gVmsa37gTap+e9KbE=T0aQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFgQCTuu54oZWKq_ppEvZFb4Mz31gVmsa37gTap+e9KbE=T0aQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 07-12-18 22:27:13, Pingfan Liu wrote:
[...]
> diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
> index 1308f54..4dc497d 100644
> --- a/arch/x86/mm/numa.c
> +++ b/arch/x86/mm/numa.c
> @@ -754,18 +754,23 @@ void __init init_cpu_to_node(void)
>  {
>         int cpu;
>         u16 *cpu_to_apicid = early_per_cpu_ptr(x86_cpu_to_apicid);
> +       int node, nr;
> 
>         BUG_ON(cpu_to_apicid == NULL);
> +       nr = cpumask_weight(cpu_possible_mask);
> +
> +       /* bring up all possible node, since dev->numa_node */
> +       //should check acpi works for node possible,
> +       for_each_node(node)
> +               if (!node_online(node))
> +                       init_memory_less_node(node);

I suspect there is no change if you replace for_each_node by
	for_each_node_mask(nid, node_possible_map)

here. If that is the case then we are probably calling
free_area_init_node too early. I do not see it yet though.
-- 
Michal Hocko
SUSE Labs
