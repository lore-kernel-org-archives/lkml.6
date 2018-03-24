Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752362AbeCXO3w (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Mar 2018 10:29:52 -0400
Received: from mail-pg0-f53.google.com ([74.125.83.53]:45660 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752258AbeCXO3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Mar 2018 10:29:51 -0400
X-Google-Smtp-Source: AG47ELtky3+O26icCn2v421KIseWhGjHC8qZHh/5+L3NGQdbq41m4h4b7PPzb0IUhRAXJ0j/lzCSdA==
Subject: Re: [PATCH v3 1/2] x86, msr: allow rdmsr_safe_on_cpu() to schedule
To: Ingo Molnar <mingo@kernel.org>, Eric Dumazet <edumazet@google.com>
Cc: x86 <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Hugh Dickins <hughd@google.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
References: <20180323215818.127774-1-edumazet@google.com>
 <20180324080946.3db4xdkl5i6jx2rc@gmail.com>
From: Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <336355a3-c11d-44fc-0642-671670980ac0@gmail.com>
Date: Sat, 24 Mar 2018 07:29:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180324080946.3db4xdkl5i6jx2rc@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/24/2018 01:09 AM, Ingo Molnar wrote:
> 
> * Eric Dumazet <edumazet@google.com> wrote:
> 
>> I noticed high latencies caused by a daemon periodically reading
>> various MSR on all cpus. KASAN kernels would see ~10ms latencies
>> simply reading one MSR. Even without KASAN, sending IPI to CPU
>> in deep sleep state or blocking hard IRQ in a a long section,
>> then waiting for the answer can consume hundreds of usec.
>>
>> Converts rdmsr_safe_on_cpu() to use a completion instead
>> of busy polling.
>>
>> Overall daemon cpu usage was reduced by 35 %,
>> and latencies caused by msr_read() disappeared.
> 
> What "daemon" is this and why is it reading MSRs?

It is named gsysd, "Google System Tool", a daemon+cli that is run 
on all machines in production to provide a generic interface
for interacting with the system hardware.

I am not sure if this answers your question, I probably 
could give a rough estimation of MWh this daemon consumes on the planet
if that helps.

Note that the source of the problem is not reading the MSR, but having cpus
blocking hard irqs for a long time.

Ingo, it looks like any loop protected by unlock_task_sighand() might be the main
offender.

Application writers seem to love getrusage() for example.
Can we rewrite it to not block hard irqs ?

Thanks !
