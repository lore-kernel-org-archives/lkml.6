Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752452AbeEQGtm (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 02:49:42 -0400
Received: from freki.datenkhaos.de ([81.7.17.101]:37096 "EHLO
        freki.datenkhaos.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751995AbeEQGtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 02:49:40 -0400
Date: Thu, 17 May 2018 08:49:31 +0200
From: Johannes Hirte <johannes.hirte@datenkhaos.de>
To: Borislav Petkov <bp@suse.de>
Cc: "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH 3/3] x86/MCE/AMD: Get address from already initialized
 block
Message-ID: <20180517064930.GA26421@probook>
References: <20180201184813.82253-1-Yazen.Ghannam@amd.com>
 <20180201184813.82253-3-Yazen.Ghannam@amd.com>
 <20180414004230.GA2033@probook>
 <20180416115624.GA1543@probook>
 <CY4PR12MB1557FB8EB5C17E55A9B405D8F8B70@CY4PR12MB1557.namprd12.prod.outlook.com>
 <20180515093953.GA1746@probook>
 <20180516224641.GA31929@pd.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180516224641.GA31929@pd.tnic>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018 Mai 17, Borislav Petkov wrote:
> On Tue, May 15, 2018 at 11:39:54AM +0200, Johannes Hirte wrote:
> > The out-of-bound access happens in get_block_address:
> > 
> > 	if (bankp && bankp->blocks) {
> > 		struct threshold_block *blockp blockp = &bankp->blocks[block];
> > 
> > with block=1. This doesn't exists. I don't even find any array here.
> > There is a linked list, created in allocate_threshold_blocks. On my
> > system I get 17 lists with one element each.
> 
> Yes, what a mess this is. ;-\
> 
> There's no such thing as ->blocks[block] array. We assign simply the
> threshold_block to it in allocate_threshold_blocks:
> 
> 	per_cpu(threshold_banks, cpu)[bank]->blocks = b;
> 
> And I can't say the design of this thing is really friendly but it is
> still no excuse that I missed that during review. Grrr.
> 
> So, Yazen, what really needs to happen here is to iterate the
> bank->blocks->miscj list to find the block you're looking for and return
> its address, the opposite to this here:
> 
>         if (per_cpu(threshold_banks, cpu)[bank]->blocks) {
>                 list_add(&b->miscj,
>                          &per_cpu(threshold_banks, cpu)[bank]->blocks->miscj);
>         } else {
>                 per_cpu(threshold_banks, cpu)[bank]->blocks = b;
>         }
> 
> and don't forget to look at ->blocks itself.
> 
> And then you need to make sure that searching for block addresses still
> works when resuming from suspend so that you can avoid the RDMSR IPIs.
> 

Maybe I'm missing something, but those RDMSR IPSs don't happen on
pre-SMCA systems, right? So the caching should be avoided here, cause
the whole lookup looks more expensive to me than the simple switch-block
in get_block_address.

-- 
Regards,
  Johannes
