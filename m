Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752166AbeC2BrM (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 21:47:12 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:6904 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751207AbeC2BrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 21:47:11 -0400
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200";
   d="scan'208";a="38303357"
Subject: Re: [PATCH v9 0/5] x86/KASLR: Add parameter
 kaslr_boot_mem=nn[KMG]@ss[KMG]
To: Ingo Molnar <mingo@kernel.org>, Baoquan He <bhe@redhat.com>,
        Chao Fan <fanc.fnst@cn.fujitsu.com>, <keescook@chromium.org>
CC: Andrew Morton <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <hpa@zytor.com>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <yasu.isimatu@gmail.com>,
        <indou.takao@jp.fujitsu.com>, <lcapitulino@redhat.com>
References: <20180228105105.11487-1-fanc.fnst@cn.fujitsu.com>
 <20180312093557.gxypr66vrbftz3v3@gmail.com>
 <20180312101031.GH18656@localhost.localdomain>
 <20180312105727.mzrtjvnyxgyz7jn7@gmail.com>
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Message-ID: <e62ca2ec-a563-2f86-71f3-9eac698cf3ad@cn.fujitsu.com>
Date: Thu, 29 Mar 2018 09:47:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180312105727.mzrtjvnyxgyz7jn7@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.167.226.106]
X-yoursite-MailScanner-ID: D73A648AE76C.ADD2A
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: douly.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo, Kees, Baoquan and Chao

At 03/12/2018 06:57 PM, Ingo Molnar wrote:
[...]
> So there's apparently a mis-design here:
> 
>   - KASLR needs to be done very early on during bootup: - it's not realistic to
>     expect KASLR to be done with a booted up kernel, because pointers to various
>     KASLR-ed objects are already widely spread out in memory.
> 
>   - But for some unfathomable reason the memory hotplug attribute of memory
>     regions is not part of the regular memory map but part of late-init ACPI data
>     structures.
> 
> The right solution would be _not_ to fudge the KASLR location, but to provide the
> memory hotplug information to early code, preferably via the primary memory map.
> KASLR can then make use of it and avoid those regions, just like it avoids other
> memory regions already.
> 
> In addition to that hardware makers (including virtualized hardware) should also
> fix their systems to provide memory hotplug information to early code.
> 

Yes, but before this, can we fix this problem by the following patch 
which has been sent and reviewed by Kees before[1]. its solution is:

   Extend movable_node option to restrict kernel to be randomized in
   immovable nodes by adding a parameter. this parameter sets up
   the boundaries between the home nodes and other nodes.

My reason is here:

   - What we really want to solve is the KASLR breaks *physical Node
     hotplug*, Keep the decompressed kernel in an immovable node is
     enough.

   - AFAICS, there are not too many systems where physical Node hotplug
     actually works in practice, and there mush be one node called *home
     node* which is immovable for storing basic information.

   - the node in modern systems could have double-digit gigabytes memory,
     It can completely satisfy the operation of KASLR.

So, Just restrict kernel to be randomized in the home node, and ignore
other nodes when kernel has the *movable_node* option in the command
line.

Thoughts? may I rebase and resend the patch?

[1] https://lkml.org/lkml/2017/8/3/401

Thanks,

	dou
