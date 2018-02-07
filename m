Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754108AbeBGNwB (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 08:52:01 -0500
Received: from mga12.intel.com ([192.55.52.136]:37730 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753630AbeBGNwA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 08:52:00 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,473,1511856000";
   d="scan'208";a="172426834"
Subject: Re: linux/drivers/cpuidle: cpuidle_enter_state() issue
To: Li Wang <wangli.ahau@gmail.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
        Colin Cross <ccross@android.com>, Nicholas Piggin <npiggin@gmail.com>,
        linux-kernel@vger.kernel.org, Linux PM <linux-pm@vger.kernel.org>
References: <CAE1O6mjJRypMK9XapAeY3GY4OLXZODzDH_kBgphGD-p6SL448w@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Organization: Intel Technology Poland Sp. z o. o., KRS 101882, ul. Slowackiego
 173, 80-298 Gdansk
Message-ID: <616a847f-500b-f0ca-2aa4-de159ba48725@intel.com>
Date: Wed, 7 Feb 2018 14:51:56 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAE1O6mjJRypMK9XapAeY3GY4OLXZODzDH_kBgphGD-p6SL448w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/7/2018 7:59 AM, Li Wang wrote:
> Hi Kernel-developers,
>
> The flowing call trace was catch from kernel-v4.15, could anyone help
> to analysis the cpuidle problem?
> or, if you need any more detail info pls let me know.
>
> Test Env:
> IBM KVM Guest on ibm-p8-kvm-03
> POWER8E (raw), altivec supported
> 9216 MB memory, 107 GB disk space
>
> --------8<----------------
> [15002.722413] swapper/15: page allocation failure: order:0,
> mode:0x1080020(GFP_ATOMIC), nodemask=(null)
> [15002.853793] swapper/15 cpuset=/ mems_allowed=0
> [15002.853932] CPU: 15 PID: 0 Comm: swapper/15 Not tainted 4.15.0 #1
> [15002.854019] Call Trace:
> [15002.854129] [c00000023ff77650] [c000000000940b50]
> .dump_stack+0xac/0xfc (unreliable)
> [15002.854285] [c00000023ff776e0] [c00000000026c678] .warn_alloc+0xe8/0x180
> [15002.854376] [c00000023ff777a0] [c00000000026d50c]
> .__alloc_pages_nodemask+0xd6c/0xf90
> [15002.854490] [c00000023ff77980] [c0000000002e9cc0]
> .alloc_pages_current+0x90/0x120
> [15002.854624] [c00000023ff77a10] [c0000000007990cc]
> .skb_page_frag_refill+0x8c/0x120
> [15002.854746] [c00000023ff77aa0] [d000000003a561a8]
> .try_fill_recv+0x368/0x620 [virtio_net]
> [15003.422855] [c00000023ff77ba0] [d000000003a568ec]
> .virtnet_poll+0x25c/0x380 [virtio_net]
> [15003.423864] [c00000023ff77c70] [c0000000007c18d0] .net_rx_action+0x330/0x4a0
> [15003.424024] [c00000023ff77d90] [c000000000960d50] .__do_softirq+0x150/0x3a8
> [15003.424197] [c00000023ff77e90] [c0000000000ff608] .irq_exit+0x198/0x1b0
> [15003.424342] [c00000023ff77f10] [c000000000015504] .__do_irq+0x94/0x1f0
> [15003.424485] [c00000023ff77f90] [c000000000026d5c] .call_do_irq+0x14/0x24
> [15003.424627] [c00000023bc63820] [c0000000000156ec] .do_IRQ+0x8c/0x100
> [15003.424776] [c00000023bc638c0] [c000000000008b34]
> hardware_interrupt_common+0x114/0x120
> [15003.424963] --- interrupt: 501 at .snooze_loop+0xa4/0x1c0
>      LR = .snooze_loop+0x60/0x1c0
> [15003.425164] [c00000023bc63bb0] [c00000023bc63c50]
> 0xc00000023bc63c50 (unreliable)
> [15003.425346] [c00000023bc63c30] [c00000000075104c]
> .cpuidle_enter_state+0xac/0x390
> [15003.425534] [c00000023bc63ce0] [c000000000157adc] .call_cpuidle+0x3c/0x70
> [15003.425669] [c00000023bc63d50] [c000000000157e90] .do_idle+0x2a0/0x300
> [15003.425815] [c00000023bc63e20] [c0000000001580ac]
> .cpu_startup_entry+0x2c/0x40
> [15003.425995] [c00000023bc63ea0] [c000000000045790]
> .start_secondary+0x4d0/0x520
> [15003.426170] [c00000023bc63f90] [c00000000000aa70]
> start_secondary_prolog+0x10/0x14
> -------------8<-------------------
>
> Any response will be appreciated!
>

I'm not sure if this is a cpuidle problem in the first place.

It looks like the kernel was unable to allocate a page for something and 
it was trying to do an atomic allocation, so that's not guaranteed to be 
successful every time even though the failure here may be unexpected.

Thanks,

Rafael
