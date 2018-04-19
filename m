Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751136AbeDSJ6H (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 05:58:07 -0400
Received: from mga11.intel.com ([192.55.52.93]:54687 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751042AbeDSJ6F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 05:58:05 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,468,1517904000";
   d="scan'208";a="49117403"
Date: Thu, 19 Apr 2018 12:57:35 +0300
From: Alexander Shishkin <alexander.shishkin@linux.intel.com>
To: Michal Hocko <mhocko@kernel.org>
Cc: Fengguang Wu <fengguang.wu@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-kernel@vger.kernel.org, lkp@01.org
Subject: Re: [dummy_stm_init] swapper/0: page allocation failure: order:9,
 mode:0x14040c0(GFP_KERNEL|__GFP_COMP), nodemask=(null)
Message-ID: <20180419095735.epy52pi5lej3w4q2@um.fi.intel.com>
References: <20180419023639.cddsueaq47mohfma@wfg-t540p.sh.intel.com>
 <20180419065111.GM17484@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180419065111.GM17484@dhcp22.suse.cz>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 19, 2018 at 08:51:11AM +0200, Michal Hocko wrote:
> On Thu 19-04-18 10:36:39, Wu Fengguang wrote:
> > Hi Alexander,
> > 
> > FYI this happens in mainline kernel 4.17.0-rc1.
> > It dates back to at least v4.15.
> > 
> > It occurs in 4 out of 4 boots. Here KVM has 1G memory.
> > 
> > This high order allocation caused lots of noises in our boot testing.
> > We could disable this device in our tests, but it would be great if
> > there are better ways out.
> > 
> > [   75.039408]       Product name: fake-design-for-testing
> > [   75.040995] fmc fake-design-for-testing-f001: Driver has no ID: matches all
> > [   75.042509] fmc_trivial: probe of fake-design-for-testing-f001 failed with error -95
> > [   75.044323] fmc fake-design-for-testing-f001: Driver has no ID: matches all
> > [   75.045644] fmc_chardev fake-design-for-testing-f001: Created misc device "fake-design-for-testing-f001"
> > [   75.061570] swapper/0: page allocation failure: order:9, mode:0x14040c0(GFP_KERNEL|__GFP_COMP), nodemask=(null)
> 
> Is there any reason why
> > [   75.063338]  stm_register_device+0xf3/0x5c0:
> > 						stm_register_device at drivers/hwtracing/stm/core.c:695
> 
> cannot use kvzalloc?

You're right, of course, I'll fix that.
I can't see, though, how it ends up asking order==9 from the buddy
allocator. The kmalloc() in question should be asking for ~512kB,
theres should be smaller slabs for that.

Regards,
--
Alex
