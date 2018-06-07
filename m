Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id UBV2EWYjGVtNWQAAmS7hNA
	; Thu, 07 Jun 2018 12:21:58 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 3425B608C1; Thu,  7 Jun 2018 12:21:58 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id C31386089E;
	Thu,  7 Jun 2018 12:21:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C31386089E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753574AbeFGMV4 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 08:21:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:43060 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752972AbeFGMVy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 08:21:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id EDC51ABF9;
        Thu,  7 Jun 2018 12:21:52 +0000 (UTC)
Date: Thu, 7 Jun 2018 14:21:52 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Hanjun Guo <guohanjun@huawei.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Will Deacon <will.deacon@arm.com>, xiexiuqi@huawei.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-arm <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        wanghuiqiang@huawei.com, tnowicki@caviumnetworks.com,
        linux-pci@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Subject: Re: [PATCH 1/2] arm64: avoid alloc memory on offline node
Message-ID: <20180607122152.GP32433@dhcp22.suse.cz>
References: <1527768879-88161-1-git-send-email-xiexiuqi@huawei.com>
 <1527768879-88161-2-git-send-email-xiexiuqi@huawei.com>
 <20180606154516.GL6631@arm.com>
 <CAErSpo6S0qtR42tjGZrFu4aMFFyThx1hkHTSowTt6t3XerpHnA@mail.gmail.com>
 <20180607105514.GA13139@dhcp22.suse.cz>
 <5ed798a0-6c9c-086e-e5e8-906f593ca33e@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ed798a0-6c9c-086e-e5e8-906f593ca33e@huawei.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 07-06-18 19:55:53, Hanjun Guo wrote:
> On 2018/6/7 18:55, Michal Hocko wrote:
[...]
> > I am not sure I have the full context but pci_acpi_scan_root calls
> > kzalloc_node(sizeof(*info), GFP_KERNEL, node)
> > and that should fall back to whatever node that is online. Offline node
> > shouldn't keep any pages behind. So there must be something else going
> > on here and the patch is not the right way to handle it. What does
> > faddr2line __alloc_pages_nodemask+0xf0 tells on this kernel?
> 
> The whole context is:
> 
> The system is booted with a NUMA node has no memory attaching to it
> (memory-less NUMA node), also with NR_CPUS less than CPUs presented
> in MADT, so CPUs on this memory-less node are not brought up, and
> this NUMA node will not be online (but SRAT presents this NUMA node);
> 
> Devices attaching to this NUMA node such as PCI host bridge still
> return the valid NUMA node via _PXM, but actually that valid NUMA node
> is not online which lead to this issue.

But we should have other numa nodes on the zonelists so the allocator
should fall back to other node. If the zonelist is not intiailized
properly, though, then this can indeed show up as a problem. Knowing
which exact place has blown up would help get a better picture...

-- 
Michal Hocko
SUSE Labs
