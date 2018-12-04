Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FF8FC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 07:22:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC10A20834
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 07:22:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC10A20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726036AbeLDHW5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 02:22:57 -0500
Received: from mx2.suse.de ([195.135.220.15]:41898 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725988AbeLDHW5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 02:22:57 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CFEE3AF7A;
        Tue,  4 Dec 2018 07:22:53 +0000 (UTC)
Date:   Tue, 4 Dec 2018 08:22:51 +0100
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
Message-ID: <20181204072251.GT31738@dhcp22.suse.cz>
References: <1543892757-4323-1-git-send-email-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1543892757-4323-1-git-send-email-kernelfans@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 04-12-18 11:05:57, Pingfan Liu wrote:
> During my test on some AMD machine, with kexec -l nr_cpus=x option, the
> kernel failed to bootup, because some node's data struct can not be allocated,
> e.g, on x86, initialized by init_cpu_to_node()->init_memory_less_node(). But
> device->numa_node info is used as preferred_nid param for
> __alloc_pages_nodemask(), which causes NULL reference
>   ac->zonelist = node_zonelist(preferred_nid, gfp_mask);
> This patch tries to fix the issue by falling back to the first online node,
> when encountering such corner case.

We have seen similar issues already and the bug was usually that the
zonelists were not initialized yet or the node is completely bogus.
Zonelists should be initialized by build_all_zonelists quite early so I
am wondering whether the later is the case. What is the actual node
number the device is associated with?

Your patch is not correct btw, because we want to fallback into the node in
the distance order rather into the first online node.
-- 
Michal Hocko
SUSE Labs
