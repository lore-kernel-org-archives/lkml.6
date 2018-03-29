Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751981AbeC2I4X (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 04:56:23 -0400
Received: from verein.lst.de ([213.95.11.211]:49398 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751179AbeC2I4W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 04:56:22 -0400
Date: Thu, 29 Mar 2018 10:56:21 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <keith.busch@intel.com>
Cc: Christoph Hellwig <hch@lst.de>, Baegjae Sung <baegjae@gmail.com>,
        axboe@fb.com, sagi@grimberg.me, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-multipath: implement active-active round-robin
        path selector
Message-ID: <20180329085621.GB22215@lst.de>
References: <20180327043851.6640-1-baegjae@gmail.com> <20180328080646.GB20373@lst.de> <20180328194741.GJ13039@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180328194741.GJ13039@localhost.localdomain>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 28, 2018 at 01:47:41PM -0600, Keith Busch wrote:
> single host (single path from two hosts seems more common). If that's a
> thing, we should get some numa awareness. I couldn't find your prototype,
> though. I had one stashed locally from a while back and hope it resembles
> what you had in mind:

Mine was way older before the current data structures.  Back then I
used ->map_queues hacks that I'm glad I never posted :)

> ---
> struct nvme_ns *nvme_find_path_numa(struct nvme_ns_head *head)
> {
>         int distance, current = INT_MAX, node = cpu_to_node(smp_processor_id());
>         struct nvme_ns *ns, *path = NULL;
> 
>         list_for_each_entry_rcu(ns, &head->list, siblings) {
>                 if (ns->ctrl->state != NVME_CTRL_LIVE)
>                         continue;
>                 if (ns->disk->node_id == node)
>                         return ns;
> 
>                 distance = node_distance(node, ns->disk->node_id);
>                 if (distance < current) {
>                         current = distance;
>                         path = ns;
>                 }
>         }
>         return path;

This is roughly what I'd do now.  The other important change would
be to have a per-node cache of the current path so that we don't do
it in the hot path.
