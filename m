Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04AC8C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 21:21:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE25320656
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 21:21:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390360AbfAOVVt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 16:21:49 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:34748 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733166AbfAOVVs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 16:21:48 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 23CF780D;
        Tue, 15 Jan 2019 13:21:48 -0800 (PST)
Received: from [192.168.100.241] (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9F6683F917;
        Tue, 15 Jan 2019 13:21:46 -0800 (PST)
Subject: Re: [PATCH v3 0/7] arm64: add system vulnerability sysfs entries
To:     Stefan Wahren <stefan.wahren@i2se.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     mlangsdo@redhat.com, suzuki.poulose@arm.com, marc.zyngier@arm.com,
        catalin.marinas@arm.com, julien.thierry@arm.com,
        will.deacon@arm.com, linux-kernel@vger.kernel.org,
        steven.price@arm.com, ykaukab@suse.de, dave.martin@arm.com,
        shankerd@codeaurora.org
References: <20190109235544.2992426-1-jeremy.linton@arm.com>
 <884332236.499392.1547581848222@email.ionos.de>
From:   Jeremy Linton <jeremy.linton@arm.com>
Message-ID: <c99f5da9-259c-3fc5-6150-7327ba0ff429@arm.com>
Date:   Tue, 15 Jan 2019 15:21:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <884332236.499392.1547581848222@email.ionos.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 01/15/2019 01:50 PM, Stefan Wahren wrote:
> Hi Jeremy,
> 
>> Jeremy Linton <jeremy.linton@arm.com> hat am 10. Januar 2019 um 00:55 geschrieben:
>>
>>
>> Arm64 machines should be displaying a human readable
>> vulnerability status to speculative execution attacks in
>> /sys/devices/system/cpu/vulnerabilities
>>
>> This series enables that behavior by providing the expected
>> functions. Those functions expose the cpu errata and feature
>> states, as well as whether firmware is responding appropriately
>> to display the overall machine status. This means that in a
>> heterogeneous machine we will only claim the machine is mitigated
>> or safe if we are confident all booted cores are safe or
>> mitigated.
>>
> 
> i applied this v3 series and Marc's v2 series.
> 
> Now i'm getting the following on a Raspberry Pi 3 B+ :
> 
> meltdown:Not affected
> spec_store_bypass:Not affected
> spectre_v1:Mitigation: __user pointer sanitization
> 
> So the entries l1tf and spectre_v2 disappeared.

Yes, the l1tf entry should be gone.

I believe there is a problem with the "1/2 advertise.." patch in that 
the 'arm64_requested_vuln_attrs |=' line needs to be hoisted  to the top 
of check_branch_predictor() and the '__spectrev2_safe = false' line 
needs to be hoisted 6 lines immediately above "/* Fallback to firmware 
detection*/"

That should re-enable the spectre_v2 entry.



