Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751661AbeBTSju (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 13:39:50 -0500
Received: from vern.gendns.com ([206.190.152.46]:54742 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751158AbeBTSjr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 13:39:47 -0500
Subject: =?UTF-8?Q?Re:_[PATCH_v7_00/42]_ARM:_davinci:_convert_to_common_cloc?=
 =?UTF-8?Q?k_framework=e2=80=8b?=
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-clk@vger.kernel.org, devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Adam Ford <aford173@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1519071723-31790-1-git-send-email-david@lechnology.com>
 <CAMRc=MdT5Vd68eoWfJGv=5_uzD0L5m3Y+wi6r7N6O8y6HZrQSg@mail.gmail.com>
From: David Lechner <david@lechnology.com>
Message-ID: <6142ab0d-85b1-84da-3a35-bdd8733bebd9@lechnology.com>
Date: Tue, 20 Feb 2018 12:39:59 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <CAMRc=MdT5Vd68eoWfJGv=5_uzD0L5m3Y+wi6r7N6O8y6HZrQSg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/20/2018 07:33 AM, Bartosz Golaszewski wrote:
> 2018-02-19 21:21 GMT+01:00 David Lechner <david@lechnology.com>:
>> This series converts mach-davinci to use the common clock framework.
>>
>>
> 
> Hi David,
> 
> just some quick results from today's playing with v7.
> 
> I started out with da850-lcdk with my standard rootfs over NFS. I was
> not able to boot to console so far. The first problem is that mdio
> fails to probe:
> 
> libphy: Fixed MDIO Bus: probed
> davinci_mdio 1e24000.mdio: davinci mdio revision 1.5, bus freq 2200000
> davinci_mdio 1e24000.mdio: no live phy, scanning all
> davinci_mdio: probe of 1e24000.mdio failed with error -5> 
> After some digging I noticed that the supplied clock rate differs
> between mainline (114000000Hz) vs common-clock-v7 (18000000). Since
> we're not setting the rate in mdio, using LPSC_SET_RATE_PARENT would
> not help like with lcdc.

Can you post the output of this command so that I can see how your
clocks are setup:

cat /sys/kernel/debug/clk/clk_summary


> 
> After that, the boot just hangs without ever getting to emac's probe.

Using your workaround, can you run:

cat /sys/kernel/debug/pm_genpd/pm_genpd_summary

If you see:
   
1e27000.clock-controller: emac  off-0

then genpd is not working like it is supposed to. You should see something
like this for device that are working:
           
1e27000.clock-controller: uart2  on
     /devices/platform/soc@1c00000/1d0d000.serial        active


> 
> Once I set the emac clock to always enabled (a workaround that was
> necessary with v6, but could be dropped with my first
> genpd-in-a-separate-driver attempt), I'm getting a rather strange NULL
> pointer dereference:

I noticed this too when adding the power-domains property to some device
tree nodes. This is part of the reason why I didn't add it everywhere.
I wasn't able to figure out the cause of this yet. As a work around
though, please try removing the power-domains property from the emac
and mdio nodes and use your previous workaround of having an always
enabled clock.

> 
> Backtrace:
> [<c049d464>] (strlen) from [<c01f32a8>] (start_creating+0x58/0xc0)
> [<c01f3250>] (start_creating) from [<c01f34c8>] (debugfs_create_dir+0x14/0xd8)
>   r7:c04dadbc r6:c0567480 r5:c0656274 r4:c68a9300
> [<c01f34b4>] (debugfs_create_dir) from [<c0296838>]
> (clk_debug_create_one+0x28/0x1d0)
>   r5:c0656274 r4:c68a9300
> [<c0296810>] (clk_debug_create_one) from [<c05cdf84>]
> (clk_debug_init+0x100/0x15c)
>   r5:c0656274 r4:c68a9300
> [<c05cde84>] (clk_debug_init) from [<c000a54c>] (do_one_initcall+0x50/0x19c)
>   r7:c05e3834 r6:ffffe000 r5:c05f7008 r4:c05cde84
> [<c000a4fc>] (do_one_initcall) from [<c05b6eb4>]
> (kernel_init_freeable+0x110/0x1cc)
>   r9:c05b4584 r8:c05b6614 r7:c05e3834 r6:c063cc80 r5:00000073 r4:c05f2354
> [<c05b6da4>] (kernel_init_freeable) from [<c04a2ce4>] (kernel_init+0x10/0xfc)
>   r10:00000000 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:c04a2cd4
>   r4:00000000
> [<c04a2cd4>] (kernel_init) from [<c00090e0>] (ret_from_fork+0x14/0x34)
> 
> It turns out that the emac clock is correctly registered in
> __davinci_psc_register_clocks() and a corresponding clk_core structure
> is added to the list and core->name is correctly assigned, but then
> later when clk_debug_init() is called, the name in emac clk_core is
> NULL. This is the direct reason for the panic. Interestingly other
> members of clk_core seem to be fine.
> 
> I'll continue on debugging it. Let me know if you have any ideas.
> 
> Best regards,
> Bartosz Golaszewski
> 
