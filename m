Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752203AbeCZOUq (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 10:20:46 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:35158 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750983AbeCZOUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 10:20:44 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Mon, 26 Mar 2018 22:20:43 +0800
From: yuankuiz@codeaurora.org
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org, lizefan@huawei.com, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, pkondeti@codeaurora.org,
        cgroups-owner@vger.kernel.org
Subject: Re: [PATCH]cgroup: __cpuset_node_allowed return bool
In-Reply-To: <20180326141212.GI2149215@devbig577.frc2.facebook.com>
References: <d2f9fe6096235032f445ab88e562560f@codeaurora.org>
 <0fee75e4a1b12f5fca30e04306a95788@codeaurora.org>
 <20180326141212.GI2149215@devbig577.frc2.facebook.com>
Message-ID: <3540bc7869927f54c409b697c743938a@codeaurora.org>
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tejun,

     inline.

On 2018-03-26 10:12 PM, Tejun Heo wrote:
> Hello, John.
> 
> On Sat, Mar 24, 2018 at 01:05:50PM +0800, yuankuiz@codeaurora.org 
> wrote:
>> From 304cec1cc42255fbd9e231a810f4eea20ab74b90 Mon Sep 17 00:00:00 2001
>> From: John Zhao <yuankuiz@codeaurora.org>
>> Date: Sat, 24 Mar 2018 13:01:32 +0800
>> Subject: [PATCH] cgroup: __cpuset_node_allowed return bool
>> 
>> as a bool, __cpuset_node_allowed(...) return should be bool.
> 
> So, as a minor cleanup patch, this is fine but can you please soften
> the commit title / description a bit?  It doesn't have to be bool.
> int is fine.  bool may be marginally more readable but that's about
> it, so let's please make the commit match that.
[ZJ] In detail, Considering the conversion after it could be compiled
  into asm such as: // cross compile it was done by
  "arm-linux-androideabi-gcc" on ubuntu
  1) return int type variable in bool function:
  bool enabled()
  {
  	int ret = 1;
  	return ret;
  }

  /**
   * ... ...
   *     mov     r3, #1
   *     str     r3, [fp, #-8]
   *     ldr     r3, [fp, #-8]
   *     cmp     r3, #0
   *     movne   r3, #1
   *     moveq   r3, #0
   *     uxtb    r3, r3
   * ... ...
   */

  2)
  bool enabled()
  {
  	bool ret = 1;
  	return ret;
  }

  /**
   * ... ...
   *     mov     r3, #1
   *     strb    r3, [fp, #-5]
   *     ldrb    r3, [fp, #-5]   @ zero_extendqisi2
   * ... ...
   */

  so the #1) style function can generate significant instructions than 
the #2).
  While, this is happened only when "-On" is not used with *-gcc 
together. Though, it is oftern there, it is best to provide this with 
decoupling of which option is used for optimization.

  Situation is only nice to have this change as test_bit() is interpreted 
in difference way in differece arch, which is "inline int" actually in 
arm-arch. Which makes the situation is not the like like the general 
case but needs to be checked and continued in the general include 
section.

  So mark this change as nice to have to keep the thing as simple as 
possible as this is what can be found under /linux/kernel related to 
this point.

> Thanks.

     Thanks,
BR//Zhao
