Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751410AbeEBNws (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 09:52:48 -0400
Received: from foss.arm.com ([217.140.101.70]:59062 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750921AbeEBNwr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 09:52:47 -0400
Subject: Re: [PATCH v2 21/27] coresight: Convert driver messages to dev_dbg
To: Kim Phillips <kim.phillips@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mathieu.poirier@linaro.org, mike.leach@linaro.org,
        robert.walker@arm.com, mark.rutland@arm.com, will.deacon@arm.com,
        sudeep.holla@arm.com, frowand.list@gmail.com, robh@kernel.org,
        john.horley@arm.com
References: <1525165857-11096-1-git-send-email-suzuki.poulose@arm.com>
 <1525165857-11096-22-git-send-email-suzuki.poulose@arm.com>
 <20180501225503.a55fb963795afb40163f3763@arm.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <adf2465b-dd2c-dc0f-51ca-da7f1a8836ba@arm.com>
Date: Wed, 2 May 2018 14:52:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180501225503.a55fb963795afb40163f3763@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/05/18 04:55, Kim Phillips wrote:
> On Tue, 1 May 2018 10:10:51 +0100
> Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
> 
>> Convert component enable/disable messages from dev_info to dev_dbg.
>> This is required to prevent LOCKDEP splats when operating in perf
>> mode where we could be called with locks held to enable a coresight
> 
> Can we see the splats?  Doesn't lockdep turn itself off if it starts
> triggering too many splats?

Without some very careful and robust reasoning for why the condition 
being reported by lockdep could not actually occur in practice, 
"avoiding the splats" is far, far less important than "avoiding the 
potential deadlock that they are reporting".

>> path. If someone wants to really see the messages, they can always
>> enable it at runtime via dynamic_debug.
> 
> Won't the splats still occur when the messages are enabled with
> dynamic_debug?
> 
> So in effect this patch only tries to mitigate the splats, all the
> while making things harder for regular users that now have to recompile
> their kernels, in exchange for a very small convenience for kernel
> developers that happen to see a splat or two with DEBUG_LOCKDEP set?

FWIW, if "regular users" means people running distro kernels, then 
chances are that they probably have DYNAMIC_DEBUG set already (100% of 
my local sample of 2 - Ubuntu x86_64 and Arch aarch64 - certainly do). 
Either way, though, this particular log spam really does only look 
vaguely useful to people debugging the coresight stack itself, so anyone 
going out of their way to turn it on has surely already gone beyond 
regular use (even if they're just reproducing an issue with additional 
logging at the request of kernel developers, rather than debugging it 
themselves).

Reducing the scope for possible deadlock from the general case to just 
debugging scenarios is certainly not a bad thing, but as you say I think 
we need a closer look at the underlying issue to know whether even 
dev_dbg() is wise.

Robin.
