Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753362AbeC1TpQ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 15:45:16 -0400
Received: from mga02.intel.com ([134.134.136.20]:4308 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753295AbeC1TpP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 15:45:15 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,372,1517904000";
   d="scan'208";a="186826936"
Date: Wed, 28 Mar 2018 13:47:41 -0600
From: Keith Busch <keith.busch@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Baegjae Sung <baegjae@gmail.com>, axboe@fb.com, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-multipath: implement active-active round-robin path
 selector
Message-ID: <20180328194741.GJ13039@localhost.localdomain>
References: <20180327043851.6640-1-baegjae@gmail.com>
 <20180328080646.GB20373@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180328080646.GB20373@lst.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 28, 2018 at 10:06:46AM +0200, Christoph Hellwig wrote:
> For PCIe devices the right policy is not a round robin but to use
> the pcie device closer to the node.  I did a prototype for that
> long ago and the concept can work.  Can you look into that and
> also make that policy used automatically for PCIe devices?

Yeah, that is especially true if you've multiple storage accessing
threads scheduled on different nodes. On the other hand, round-robin
may still benefit if both paths are connected to different root ports
on the same node (who would do that?!).

But I wasn't aware people use dual-ported PCIe NVMe connected to a
single host (single path from two hosts seems more common). If that's a
thing, we should get some numa awareness. I couldn't find your prototype,
though. I had one stashed locally from a while back and hope it resembles
what you had in mind:
---
struct nvme_ns *nvme_find_path_numa(struct nvme_ns_head *head)
{
        int distance, current = INT_MAX, node = cpu_to_node(smp_processor_id());
        struct nvme_ns *ns, *path = NULL;

        list_for_each_entry_rcu(ns, &head->list, siblings) {
                if (ns->ctrl->state != NVME_CTRL_LIVE)
                        continue;
                if (ns->disk->node_id == node)
                        return ns;

                distance = node_distance(node, ns->disk->node_id);
                if (distance < current) {
                        current = distance;
                        path = ns;
                }
        }
        return path;
}
--
