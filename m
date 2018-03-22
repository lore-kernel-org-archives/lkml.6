Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751872AbeCVQnc (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 12:43:32 -0400
Received: from foss.arm.com ([217.140.101.70]:40110 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751505AbeCVQnb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 12:43:31 -0400
Subject: Re: [PATCH v4 19/22] arm64: capabilities: Handle shared entries
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, will.deacon@arm.com, dave.martin@arm.com,
        catalin.marinas@arm.com, marc.zyngier@arm.com, mark.rutland@arm.com,
        ard.biesheuvel@linaro.org, jnair@caviumnetworks.com,
        ckadabi@codeaurora.org, robin.murphy@arm.com, shankerd@codeaurora.org
References: <20180313115120.17256-1-suzuki.poulose@arm.com>
 <20180313115120.17256-20-suzuki.poulose@arm.com>
From: Suzuki K Poulose <Suzuki.Poulose@arm.com>
Message-ID: <6a7c55b2-a5a5-c672-1b85-5ba9c8e8560b@arm.com>
Date: Thu, 22 Mar 2018 16:43:28 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180313115120.17256-20-suzuki.poulose@arm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/03/18 11:51, Suzuki K Poulose wrote:
> Some capabilities have different criteria for detection and associated
> actions based on the matching criteria, even though they all share the
> same capability bit. So far we have used multiple entries with the same
> capability bit to handle this. This is prone to errors, as the
> cpu_enable is invoked for each entry, irrespective of whether the
> detection rule applies to the CPU or not. And also this complicates
> other helpers, e.g, __this_cpu_has_cap.
> 
> This patch adds a wrapper entry to cover all the possible variations
> of a capability by maintaining list of matches + cpu_enable callbacks.
> To avoid complicating the prototypes for the "matches()", we use
> arm64_cpu_capabilities maintain the list and we ignore all the other
> fields except the matches & cpu_enable.
> 
> This ensures :
> 
>   1) The capabilitiy is set when at least one of the entry detects
>   2) Action is only taken for the entries that "matches".
> 
> This avoids explicit checks in the cpu_enable() take some action.
> The only constraint here is that, all the entries should have the
> same "type" (i.e, scope and conflict rules).
> 
> If a cpu_enable() method is associated with multiple matches for a
> single capability, care should be taken that either the match criteria
> are mutually exclusive, or that the method is robust against being
> called multiple times.
> 
> This also reverts the changes introduced by commit 67948af41f2e6818ed
> ("arm64: capabilities: Handle duplicate entries for a capability").
> 
> Cc: Robin Murphy <robin.murphy@arm.com>
> Reviewed-by: Dave Martin <dave.martin@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Lost changelog:


Changes since v3
  - Rename cap_list => match_list
  - Address other comments from Dave
  - Added Reviewed-by from Dave

Cheers
Suzuki
