Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F05C6778A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 16:48:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD635277AC
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 16:48:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD635277AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937076AbeF2QsV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 12:48:21 -0400
Received: from foss.arm.com ([217.140.101.70]:37052 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935714AbeF2QsR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 12:48:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C28771529;
        Fri, 29 Jun 2018 09:48:16 -0700 (PDT)
Received: from [192.168.100.244] (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3AB453F266;
        Fri, 29 Jun 2018 09:48:16 -0700 (PDT)
Subject: Re: [PATCH] arm64: acpi: reenumerate topology ids
To:     Andrew Jones <drjones@redhat.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        ard.biesheuvel@linaro.org, shunyong.yang@hxt-semitech.com,
        yu.zheng@hxt-semitech.com, catalin.marinas@arm.com,
        will.deacon@arm.com
References: <20180628145128.10057-1-drjones@redhat.com>
 <a38fb684-c023-1a96-464e-dd268f3132ea@arm.com>
 <20180628173243.obydzakh2stfs26w@kamzik.brq.redhat.com>
 <20180629102927.GA18043@e107155-lin>
 <20180629112354.hefdl2pe72frl6x3@kamzik.brq.redhat.com>
 <20180629132934.GA16282@e107155-lin>
 <20180629154608.nqudibf54ti6dpjc@kamzik.brq.redhat.com>
From:   Jeremy Linton <jeremy.linton@arm.com>
Message-ID: <30d56d70-6043-0ad7-4530-208fab18c8d4@arm.com>
Date:   Fri, 29 Jun 2018 11:48:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180629154608.nqudibf54ti6dpjc@kamzik.brq.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 06/29/2018 10:46 AM, Andrew Jones wrote:
> On Fri, Jun 29, 2018 at 02:29:34PM +0100, Sudeep Holla wrote:
>> If it matters a lot, vendors must use UID for consistency. Since OS doesn't
>> use those IDs for any particular reason, OS must not care.
> 
> That depends. If you look at how topology_logical_package_id() is used in
> x86 code you'll see it gets used as an index to an array in a couple
> places. If we don't remap arbitrary IDs to counters than we may miss out
> on some opportunities to avoid lists.
> 
> Also, we're talking about what's visible to users. I think it's much more
> likely to break a user app by exposing topology IDs that have values
> greater than the linear CPU numbers (even though properly written apps
> shouldn't expect them to be strictly <=), than the opposite.
> 
>>
>>>>
>>>>>>
>>>>>> So I would like to keep it simple and just have this counters for
>>>>>> package ids as demonstrated in Shunyong's patch.
>>>>>>
>>>>>
>>>>> If we don't also handle cores when there are threads, then the cores
>>>>> will also end up having weird IDs.
>>>>>
>>>>
>>>> Yes, but if PPTT says it has valid ID, I would prefer that over DT like
>>>> generated.
>>>
>>> Valid *ACPI* ID, which just means it's a guaranteed unique ACPI UID,
>>> which isn't likely going to be anything useful to a user.
>>>
>>
>> How is that different from OS generated one from user's perspective ?
>> Vendors might assign sockets UID and he may help them to replace one.
>> Having some generated counter based id is not helpful.
> 
> I agree with this. It's a good argument for maintaining a mapping of
> package-id to id-physically-printed-on-a-package somewhere. To avoid
> maintaining a mapping it could just be stored directly in
> cpu_topology[cpu].package_id, but then how can we tell the difference
> between a valid printed-on-package-id and an ACPI offset? We'd still
> have to maintain additional state to determine if it's valid or not,
> so we could just maintain a mapping instead.

Just to be clear, there isn't anything (AFAIK) in the ACPI specification 
which dictates what values should comprise the various ACPI id's. They 
are assumed only to be machine readable, which is why it seems some 
implementations are just using a sanitized version of mpidr for the 
core/MADT acpi id. That is why simply using the id flagged as valid in a 
PPTT node doesn't necessarily give you a more human readable value.

If you want a human readable socket identifier that matches something 
stamped above the socket, that is what SMBIOS is for. Queue discussion 
about that tables reliability for functional ids. Either way, as the 
spec is written today (or any ECRs I've seen), your definitely not going 
to get both nice socket1, socket2, and cpu1, cpu2 out of the same 
PPTT/ACPIid name-space since the numerical id's conflict.

