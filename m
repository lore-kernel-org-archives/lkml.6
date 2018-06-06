Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 36E2B60767
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752189AbeFFOxm (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 10:53:42 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:41372 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751957AbeFFOxk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 10:53:40 -0400
Subject: Re: [PATCH] arm64: topology: Avoid checking numa mask for scheduler
 MC selection
To: Morten Rasmussen <morten.rasmussen@arm.com>
Cc: Sudeep.Holla@arm.com, Will.Deacon@arm.com, Catalin.Marinas@arm.com,
        Robin.Murphy@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, geert@linux-m68k.org,
        linux-acpi@vger.kernel.org, ard.biesheuvel@linaro.org
References: <20180605190837.493505-1-jeremy.linton@arm.com>
 <20180606144444.GB8461@e105550-lin.cambridge.arm.com>
From: Jeremy Linton <jeremy.linton@arm.com>
Message-ID: <be5f7066-0b44-ff11-37e9-87512df2294f@arm.com>
Date: Wed, 6 Jun 2018 09:53:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180606144444.GB8461@e105550-lin.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/06/2018 09:44 AM, Morten Rasmussen wrote:
> On Tue, Jun 05, 2018 at 02:08:37PM -0500, Jeremy Linton wrote:
>> The numa mask subset check has problems if !CONFIG_NUMA, over hotplug
>> operations or during early boot. Lets disable the NUMA siblings checks
>> for the time being, as NUMA in socket machines have LLC's that will
>> assure that the scheduler topology isn't "borken".
> 
> Could we add an explanation why the numa node mask check is needed in
> the first place. >
> IIUC, we have the check in case the LLC is shared across numa nodes as
> this would cause core_siblings > cpumask_of_node() which breaks the
> scheduler topology.

Yes, that sounds like a good idea, my comments probably assume that the 
reader has been part of these conversations.


> 
> While sharing LLC across numa nodes seems quite unusual, I think it is
> allowed by ACPI. Those systems might already be broken before, so might
> not change anything. It is just worth noting why the check should be
> added back later.

Right, there isn't anything in ACPI that dictates a system topology 
restriction like this. Given that other architectures have built 
machines with large directory caches that span numa nodes the check was 
a safety measure.
