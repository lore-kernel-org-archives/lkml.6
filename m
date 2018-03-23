Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752169AbeCWWSP (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 18:18:15 -0400
Received: from terminus.zytor.com ([198.137.202.136]:39001 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751715AbeCWWSO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 18:18:14 -0400
Subject: Re: [PATCH v3 2/2] x86, cpuid: allow cpuid_read() to schedule
To: Eric Dumazet <edumazet@google.com>, x86 <x86@kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
        Ingo Molnar <mingo@redhat.com>, Hugh Dickins <hughd@google.com>
References: <20180323215818.127774-1-edumazet@google.com>
 <20180323215818.127774-2-edumazet@google.com>
From: "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <3622b64c-bae6-00db-6a61-3ccf760144aa@zytor.com>
Date: Fri, 23 Mar 2018 15:17:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180323215818.127774-2-edumazet@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/23/18 14:58, Eric Dumazet wrote:
> I noticed high latencies caused by a daemon periodically reading various
> MSR and cpuid on all cpus. KASAN kernels would see ~10ms latencies
> simply reading one cpuid. Even without KASAN, sending IPI to CPU
> in deep sleep state or blocking hard IRQ in a a long section,
> then waiting for the answer can consume hundreds of usec or more.
> 
> Switching to smp_call_function_single_async() and a completion
> allows to reschedule and not burn cpu cycles.

That being said, the Right Way for a daemon to read multiple MSRs and
CPUIDs on multiple CPUs is to spawn a thread for each CPU and use CPU
affinity to lock them down.  No IPI is needed to access MSRs on the
current CPU, and CPUID doesn't even need kernel entry.

	-hpa
