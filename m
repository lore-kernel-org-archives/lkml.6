Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751857AbeCXBBK (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 21:01:10 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:33076 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751400AbeCXBBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 21:01:09 -0400
X-Google-Smtp-Source: AG47ELvF+RswVCl5v7JAynO0BukZHkK0NmTv6etByZLQfPAT/OcOoOD322PhLWkfqdQFsA/2uadQVg==
Subject: Re: [PATCH v3 2/2] x86, cpuid: allow cpuid_read() to schedule
To: "H. Peter Anvin" <hpa@zytor.com>, Eric Dumazet <edumazet@google.com>,
        x86 <x86@kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
        Ingo Molnar <mingo@redhat.com>, Hugh Dickins <hughd@google.com>
References: <20180323215818.127774-1-edumazet@google.com>
 <20180323215818.127774-2-edumazet@google.com>
 <3622b64c-bae6-00db-6a61-3ccf760144aa@zytor.com>
From: Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <df40ad66-8bab-67ca-bce7-b82f09083f2e@gmail.com>
Date: Fri, 23 Mar 2018 18:01:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <3622b64c-bae6-00db-6a61-3ccf760144aa@zytor.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/23/2018 03:17 PM, H. Peter Anvin wrote:
> On 03/23/18 14:58, Eric Dumazet wrote:
>> I noticed high latencies caused by a daemon periodically reading various
>> MSR and cpuid on all cpus. KASAN kernels would see ~10ms latencies
>> simply reading one cpuid. Even without KASAN, sending IPI to CPU
>> in deep sleep state or blocking hard IRQ in a a long section,
>> then waiting for the answer can consume hundreds of usec or more.
>>
>> Switching to smp_call_function_single_async() and a completion
>> allows to reschedule and not burn cpu cycles.
> 
> That being said, the Right Way for a daemon to read multiple MSRs and
> CPUIDs on multiple CPUs is to spawn a thread for each CPU and use CPU
> affinity to lock them down.  No IPI is needed to access MSRs on the
> current CPU, and CPUID doesn't even need kernel entry.

Indeed, assuming a daemon can have threads running on all cpus :/

Some environments like to partition cpus for different jobs/containers.

Yes, we can avoid IPI by carefully re-designing these user programs.
