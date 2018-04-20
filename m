Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754027AbeDTH1O (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 03:27:14 -0400
Received: from foss.arm.com ([217.140.101.70]:44960 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753874AbeDTH1M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 03:27:12 -0400
Subject: Re: [RFC PATCH 3/4] acpi: apei: Do not panic() in NMI because of GHES
 messages
To: "Alex G." <mr.nuke.me@gmail.com>
Cc: linux-acpi@vger.kernel.org, rjw@rjwysocki.net, lenb@kernel.org,
        tony.luck@intel.com, bp@alien8.de, tbaicar@codeaurora.org,
        will.deacon@arm.com, shiju.jose@huawei.com, zjzhang@codeaurora.org,
        gengdongjiu@huawei.com, linux-kernel@vger.kernel.org,
        alex_gagniuc@dellteam.com, austin_bolen@dell.com, shyam_iyer@dell.com
References: <20180403170830.29282-1-mr.nuke.me@gmail.com>
 <20180403170830.29282-4-mr.nuke.me@gmail.com>
 <338e9bb4-a837-69f9-36e5-5ee2ddcaaa38@arm.com>
 <d6492b41-612a-b256-44c9-4ff3b3d5ae4b@gmail.com>
 <e65986c8-55a1-14c4-5c06-f34fa25916d8@arm.com>
 <9e29e5c6-b942-617e-f92e-728627799506@gmail.com>
 <cdea7af5-6c9b-10c5-a9a9-1481446c65a8@arm.com>
 <2120d34a-41d2-9fff-2710-d11e9a19e12a@gmail.com>
 <855860ef-f84e-00af-ed44-55d6a5a41a94@arm.com>
 <70c0a230-945a-3a1a-7c49-4b0784a3cfa6@gmail.com>
From: James Morse <james.morse@arm.com>
Message-ID: <d1053bc8-959d-2d24-af90-61fa4b3fd03f@arm.com>
Date: Fri, 20 Apr 2018 08:27:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <70c0a230-945a-3a1a-7c49-4b0784a3cfa6@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

On 04/16/2018 10:59 PM, Alex G. wrote:
 > On 04/13/2018 11:38 AM, James Morse wrote:
 >> This assumes a cache-invalidate will clear the error, which I don't 
think we're
 >> guaranteed on arm.
 >> It also destroys any adjacent data, "everyone's happy" includes the 
thread that
 >> got a chunk of someone-else's stack frame, I don't think it will be 
happy for
 >> very long!
 >
 > Hmm, no cache-line (or page) invalidation on arm64? How does
 > dma_map/unmap_*() work then? You may not guarantee to fix the error, but

There are cache-invalidate instructions, but I don't think 'solving' a 
RAS error with them is the right thing to do.


 > I don't buy into the "let's crash without trying" argument.

Our 'cache writeback granule' may be as large as 2K, so we may have to 
invalidate up to 2K of data to convince the hardware this address is 
okay again.

All we've done here is differently-corrupt the data so that it no longer 
generates a RAS fault, it just gives you the wrong data instead. 
Cache-invalidation is destructive.

I don't think there is a one-size-fits-all solution here.


 >> (this is a side issue for AER though)
 >
 > Somebody muddled up AER with these tables, so we now have to worry about
 > it. :)

Eh? I see there is a v2, maybe I'll understand this comment once I read it.


 >>> How does FFS handle race conditions that can occur when accessing HW
 >>> concurrently with the OS? I'm told it's the main reasons why BIOS
 >>> doesn't release unused cores from SMM early.
 >>
 >> This is firmware's problem, it depends on whether there is any 
hardware that is
 >> shared with the OS. Some hardware can be marked 'secure' in which 
case only
 >> firmware can access it, alternatively firmware can trap or just 
disable the OS's
 >> access to the shared hardware.
 >
 > It's everyone's problem. It's the firmware's responsibility.

It depends on the SoC design. If there is no hardware that the OS and 
firmware both need to access to handle an error then I don't think 
firmware needs to do this.


 >> For example, with the v8.2 RAS Extensions, there are some per-cpu error
 >> registers. Firmware can disable these for the OS, so that it always 
reads 0 from
 >> them. Instead firmware takes the error via FF, reads the registers from
 >> firmware, and dumps CPER records into the OS's memory.
 >>
 >> If there is a shared hardware resource that both the OS and firmware 
may be
 >> accessing, yes firmware needs to pull the other CPUs in, but this 
depends on the
 >> SoC design, it doesn't necessarily happen.
 >
 > The problem with shared resources is just a problem. I've seen systems
 > where all 100 cores are held up for 300+ ms. In latency-critical
 > applications reliability drops exponentially. Am I correct in assuming
 > your answer would be to "hide" more stuff from the OS?

No, I'm not a fan of firmware cycle stealing. If you can design the SoC or
firmware so that the 'all CPUs' stuff doesn't need to happen, then you 
won't get
these issues. (I don't design these things, I'm sure they're much more 
complicated
than I think!)

Because the firmware is SoC-specific, so it only needs to do exactly 
what is necessary.


 >>> I think the idea of firmware-first is broken. But it's there, it's
 >>> shipping in FW, so we have to accommodate it in SW.
 >>
 >> Part of our different-views here is firmware-first is taking 
something away from
 >> you, whereas for me its giving me information that would otherwise be in
 >> secret-soc-specific registers.
 >
 > Under this interpretation, FFS is a band-aid to the problem of "secret"
 > registers. "Secret" hardware doesn't really fit well into the idea of an
 > OS [1].

Sorry, I'm being sloppy with my terminology, by secret-soc-specific I 
mean either Linux can't access them (firmware privilege-level only) or 
Linux can't reasonably know where these registers are, as they're 
soc-specific and vary by manufacture.


 >>> And linux can handle a wide subset of MCEs just fine, so the
 >>> ghes_is_deferrable() logic would, under my argument, agree to pass
 >>> execution to the actual handlers.
 >>
 >> For some classes of error we can't safely get there.
 >
 > Optimize for the common case.

At the expense of reliability?


Thanks,

James
