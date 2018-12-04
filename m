Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3F67C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 08:56:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5159214D9
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 08:56:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5159214D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725946AbeLDI4E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 03:56:04 -0500
Received: from mx2.suse.de ([195.135.220.15]:52918 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725613AbeLDI4E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 03:56:04 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2E460ADE2;
        Tue,  4 Dec 2018 08:56:02 +0000 (UTC)
Date:   Tue, 4 Dec 2018 09:56:01 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH] mm/alloc: fallback to first node if the wanted node
 offline
Message-ID: <20181204085601.GC1286@dhcp22.suse.cz>
References: <1543892757-4323-1-git-send-email-kernelfans@gmail.com>
 <20181204072251.GT31738@dhcp22.suse.cz>
 <CAFgQCTv56drDBx-sTr6KdeQNKJnojG3g_a-k8wKe_q2y9w9NtA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFgQCTv56drDBx-sTr6KdeQNKJnojG3g_a-k8wKe_q2y9w9NtA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 04-12-18 16:20:32, Pingfan Liu wrote:
> On Tue, Dec 4, 2018 at 3:22 PM Michal Hocko <mhocko@kernel.org> wrote:
> >
> > On Tue 04-12-18 11:05:57, Pingfan Liu wrote:
> > > During my test on some AMD machine, with kexec -l nr_cpus=x option, the
> > > kernel failed to bootup, because some node's data struct can not be allocated,
> > > e.g, on x86, initialized by init_cpu_to_node()->init_memory_less_node(). But
> > > device->numa_node info is used as preferred_nid param for
> > > __alloc_pages_nodemask(), which causes NULL reference
> > >   ac->zonelist = node_zonelist(preferred_nid, gfp_mask);
> > > This patch tries to fix the issue by falling back to the first online node,
> > > when encountering such corner case.
> >
> > We have seen similar issues already and the bug was usually that the
> > zonelists were not initialized yet or the node is completely bogus.
> > Zonelists should be initialized by build_all_zonelists quite early so I
> > am wondering whether the later is the case. What is the actual node
> > number the device is associated with?
> >
> The device's node num is 2. And in my case, I used nr_cpus param. Due
> to init_cpu_to_node() initialize all the possible node.  It is hard
> for me to figure out without this param, how zonelists is accessed
> before page allocator works.

I believe we should focus on this. Why does the node have no zonelist
even though all zonelists should be initialized already? Maybe this is
nr_cpus pecularity and we do not initialize all the existing numa nodes.
Or maybe the device is associated to a non-existing node with that
setup. A full dmesg might help us here.

> > Your patch is not correct btw, because we want to fallback into the node in
> > the distance order rather into the first online node.
> > --
> What about this:
> +extern int find_next_best_node(int node, nodemask_t *used_node_mask);
> +
>  /*
>   * We get the zone list from the current node and the gfp_mask.
>   * This zone list contains a maximum of MAXNODES*MAX_NR_ZONES zones.
> @@ -453,6 +455,11 @@ static inline int gfp_zonelist(gfp_t flags)
>   */
>  static inline struct zonelist *node_zonelist(int nid, gfp_t flags)
>  {
> +       if (unlikely(!node_online(nid))) {
> +               nodemask_t used_mask;
> +               nodes_complement(used_mask, node_online_map);
> +               nid = find_next_best_node(nid, &used_mask);
> +       }
>         return NODE_DATA(nid)->node_zonelists + gfp_zonelist(flags);
>  }
> 
> I just finished the compiling, not test it yet, since the machine is
> not on hand yet. It needs some time to get it again.

This is clearly a no-go. nodemask_t can be giant and you cannot have it
on the stack for allocation paths which might be called from a deep
stack already. Also this is called from the allocator hot paths and each
branch counts.

-- 
Michal Hocko
SUSE Labs
