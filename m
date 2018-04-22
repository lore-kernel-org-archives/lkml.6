Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751740AbeDVNop (ORCPT <rfc822;w@1wt.eu>);
        Sun, 22 Apr 2018 09:44:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:54871 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751163AbeDVNoo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Apr 2018 09:44:44 -0400
Date: Sun, 22 Apr 2018 07:44:39 -0600
From: Michal Hocko <mhocko@kernel.org>
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: Fengguang Wu <fengguang.wu@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-kernel@vger.kernel.org, lkp@01.org
Subject: Re: [dummy_stm_init] swapper/0: page allocation failure: order:9,
 mode:0x14040c0(GFP_KERNEL|__GFP_COMP), nodemask=(null)
Message-ID: <20180422134439.GK17484@dhcp22.suse.cz>
References: <20180419023639.cddsueaq47mohfma@wfg-t540p.sh.intel.com>
 <20180419065111.GM17484@dhcp22.suse.cz>
 <20180419102114.irntfpy6i77apfq5@node.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180419102114.irntfpy6i77apfq5@node.shutemov.name>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 19-04-18 13:21:14, Kirill A. Shutemov wrote:
> On Thu, Apr 19, 2018 at 08:51:11AM +0200, Michal Hocko wrote:
> > On Thu 19-04-18 10:36:39, Wu Fengguang wrote:
> > > Hi Alexander,
> > > 
> > > FYI this happens in mainline kernel 4.17.0-rc1.
> > > It dates back to at least v4.15.
> > > 
> > > It occurs in 4 out of 4 boots. Here KVM has 1G memory.
> > > 
> > > This high order allocation caused lots of noises in our boot testing.
> > > We could disable this device in our tests, but it would be great if
> > > there are better ways out.
> > > 
> > > [   75.039408]       Product name: fake-design-for-testing
> > > [   75.040995] fmc fake-design-for-testing-f001: Driver has no ID: matches all
> > > [   75.042509] fmc_trivial: probe of fake-design-for-testing-f001 failed with error -95
> > > [   75.044323] fmc fake-design-for-testing-f001: Driver has no ID: matches all
> > > [   75.045644] fmc_chardev fake-design-for-testing-f001: Created misc device "fake-design-for-testing-f001"
> > > [   75.061570] swapper/0: page allocation failure: order:9, mode:0x14040c0(GFP_KERNEL|__GFP_COMP), nodemask=(null)
> > 
> > Is there any reason why
> > > [   75.063338]  stm_register_device+0xf3/0x5c0:
> > > 						stm_register_device at drivers/hwtracing/stm/core.c:695
> > 
> > cannot use kvzalloc?
> 
> Michal, do you understand how allocating ~512kB leads to order-9 failure?
> Shouldn't it be order-8 at most? That's not clear to me.

How do you tell it is 512kB? The page allocator consumes order so maybe
something miscalculated the order when calling the allocator?
-- 
Michal Hocko
SUSE Labs
