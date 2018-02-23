Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752014AbeBWSA4 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 13:00:56 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:59136 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751527AbeBWSAz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 13:00:55 -0500
Message-ID: <5A90563E.4020608@arm.com>
Date: Fri, 23 Feb 2018 17:58:22 +0000
From: James Morse <james.morse@arm.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.6.0
MIME-Version: 1.0
To: Dongjiu Geng <gengdongjiu@huawei.com>
CC: catalin.marinas@arm.com, will.deacon@arm.com,
        christoffer.dall@linaro.org, marc.zyngier@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.cs.columbia.edu, huangshaoyu@huawei.com
Subject: Re: [PATCH] arm64: rename the function arm64_is_ras_serror() to avoid
 confusion
References: <1519322552-7374-1-git-send-email-gengdongjiu@huawei.com>
In-Reply-To: <1519322552-7374-1-git-send-email-gengdongjiu@huawei.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dongjiu Geng,

On 22/02/18 18:02, Dongjiu Geng wrote:
> The RAS SError Syndrome can be Implementation-Defined,
> arm64_is_ras_serror() is used to judge whether it is RAS SError,
> but arm64_is_ras_serror() does not include this judgement. In order
> to avoid function name confusion, we rename the arm64_is_ras_serror()
> to arm64_is_categorized_ras_serror(), this function is used to
> judge whether it is categorized RAS Serror.

I don't see how 'categorized' is relevant. The most significant ISS bit is used
to determine if this is an IMP-DEF ESR, or one that uses the architected layout.

DFSC of zero means uncategorised. What should we do with an uncategorised SError?

>From 2.4.3 "ESB and other physical errors" of [0]
| It is IMPLEMENTATION DEFINED whether [..]uncategorized SError interrupts
| are containable or Uncontainable, and whether they can be synchronized by an
| Error Synchronization Barrier.

We treat uncategorized as uncontainable as that's the worst thing it could be.

On aarch32 uncontainable and uncategorized even share an encoding.
(AET:00 in G7.2.43 "DFSR, Data Fault Status Register", 'state of the PE after
taking the SError interrupt exception')


> Change some code notes, unrecoverable RAS errors is imprecise, but
> Recoverable RAS errors is precise.

Unrecoverable and Recoverable (but we don't know where it is) are both grouped
into 'can't make progress'. The comment says:
| The exception may have been imprecise.
because one of those two is imprecise.

If anyone cares which one is which, they can read the spec.

I expect this code will one day be replaced with proper kernel-first support,
its only here to avoid panic()ing due to corrected errors.


Thanks,

James

[0]
https://static.docs.arm.com/ddi0587/a/RAS%20Extension-release%20candidate_march_29.pdf
