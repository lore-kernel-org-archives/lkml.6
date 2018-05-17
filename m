Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752044AbeEQSrF (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 14:47:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44258 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751892AbeEQSrD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 14:47:03 -0400
Date: Thu, 17 May 2018 15:46:58 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        x86@kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] kvm: rename HINTS_DEDICATED to KVM_HINTS_REALTIME
Message-ID: <20180517184658.GA1543@localhost.localdomain>
References: <1526568841-35372-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526568841-35372-1-git-send-email-mst@redhat.com>
X-Fnord: you can see the fnord
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 17, 2018 at 05:54:24PM +0300, Michael S. Tsirkin wrote:
> HINTS_DEDICATED seems to be somewhat confusing:
> 
> Guest doesn't really care whether it's the only task running on a host
> CPU as long as it's not preempted.
> 
> And there are more reasons for Guest to be preempted than host CPU
> sharing, for example, with memory overcommit it can get preempted on a
> memory access, post copy migration can cause preemption, etc.
> 
> Let's call it KVM_HINTS_REALTIME which seems to better
> match what guests expect.
> 
> Also, the flag most be set on all vCPUs - current guests assume this.
> Note so in the documentation.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  Documentation/virtual/kvm/cpuid.txt  | 6 +++---
>  arch/x86/include/uapi/asm/kvm_para.h | 2 +-
>  arch/x86/kernel/kvm.c                | 8 ++++----
>  3 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/virtual/kvm/cpuid.txt b/Documentation/virtual/kvm/cpuid.txt
> index d4f33eb8..ab022dc 100644
> --- a/Documentation/virtual/kvm/cpuid.txt
> +++ b/Documentation/virtual/kvm/cpuid.txt
> @@ -72,8 +72,8 @@ KVM_FEATURE_CLOCKSOURCE_STABLE_BIT ||    24 || host will warn if no guest-side
>  
>  flag                               || value || meaning
>  ==================================================================================
> -KVM_HINTS_DEDICATED                ||     0 || guest checks this feature bit to
> -                                   ||       || determine if there is vCPU pinning
> -                                   ||       || and there is no vCPU over-commitment,
> +KVM_HINTS_REALTIME                 ||     0 || guest checks this feature bit to
> +                                   ||       || determine that vCPUs are never
> +                                   ||       || preempted for an unlimited time,
>                                     ||       || allowing optimizations

My understanding of the original patch is that the intention is
to tell the guest that it is very unlikely to be preempted, so it
can choose a more appropriate spinlock implementation.  This
description implies that the guest will never be preempted, which
is much stronger guarantee.

Isn't this new description incompatible with existing usage of
the hint, which might include people who just use vCPU pinning
but no mlock?

-- 
Eduardo
