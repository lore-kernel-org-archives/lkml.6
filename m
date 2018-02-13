Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934519AbeBMQCe (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 11:02:34 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59590 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933698AbeBMQCb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 11:02:31 -0500
Subject: Re: [PATCH v2 1/2] KVM: X86: Add per-VM no-HLT-exiting capability
To: Wanpeng Li <kernellwp@gmail.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
References: <1517813878-22248-1-git-send-email-wanpengli@tencent.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <324a8c3a-35f1-ad4b-1ff5-9ba742778470@redhat.com>
Date: Tue, 13 Feb 2018 17:02:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <1517813878-22248-1-git-send-email-wanpengli@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/02/2018 07:57, Wanpeng Li wrote:
> From: Wanpeng Li <wanpengli@tencent.com>
> 
> If host CPUs are dedicated to a VM, we can avoid VM exits on HLT.
> This patch adds the per-VM non-HLT-exiting capability.
> 
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Radim Krčmář <rkrcmar@redhat.com>
> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> ---
> v1 -> v2:
>  * vmx_clear_hlt() around INIT handling
>  * vmx_clear_hlt() upon SMI and implement auto halt restart 

Hi Wanpeng,

sorry I could not answer before.

We do not need to implement AutoHalt.  It's a messy functionality and
the way it works is much simpler: on RSM the microcode reads AutoHALT's
bit 0 and... decrements RIP if it is 1.  All you need to do however is
clear the activity state.  Guests should expect anyway that "CLI;HLT"
can be interrupted by an NMI and follow it with a JMP.

Second, I would prefer to implement at the same time MWAIT and PAUSE
passthrough, as in https://www.spinics.net/lists/kvm/msg159517.html:

> The three capabilities are more or less all doing the same thing.
> Perhaps it would make some sense to only leave PAUSE spin loops in
> guest, but not HLT/MWAIT; but apart from that I think users would
> probably enable all of them.  So I think we should put in the
> documentation that blindly passing the KVM_CHECK_EXTENSION result to
> KVM_ENABLE_CAP is a valid thing to do when vCPUs are associated to
> dedicated physical CPUs.
>
> Let's get rid of KVM_CAP_X86_GUEST_MWAIT altogether and
> add a new capability.  But let's use just one.

Thanks again for your work, and sorry for slightly contradicting Radim's
review.  I've rebased and applied patch 2.

Paolo
