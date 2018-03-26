Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751732AbeCZAjx (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Mar 2018 20:39:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:39633 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750832AbeCZAju (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Mar 2018 20:39:50 -0400
Date: Sun, 25 Mar 2018 17:27:32 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Wanpeng Li <kernellwp@gmail.com>, peterz@infradead.org
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim Kr??m??? <rkrcmar@redhat.com>, Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH 1/2] KVM: X86: Fix setup the virt_spin_lock_key before
 static key get initialized
Message-ID: <20180326002732.qks4cp7qq2xzysnx@linux-n805>
References: <1521951444-5087-1-git-send-email-wanpengli@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1521951444-5087-1-git-send-email-wanpengli@tencent.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 Mar 2018, Wanpeng Li wrote:

>Note: Peterz pointed out in the IRC we have to audit all the architectures that
>implement smp_prepare_boot_cpu() to see what they depend on if we want to move
>jump_label_init() before smp_prepare_boot_cpu(). So what this patch does is
>similar to the issue which handled in xen ca5d376e.

After some auditing, the jump_label_init() being moved before smp_prepare_boot_cpu()
seems fine, however, bulky mechanisms to update text segments conflict with early smp
bootup stages, such as this patch. So, while the disabling virt_spin_lock_key would
be done correctly _after_ jump_label_init(), it is still fragile in that we want to
be using lightweight patching such as jump_label_transform_static() -- which doesn't
take the text_mutex (blocking is out of the question), for example.

For pretty much all archs this means using the transform_static() version. For example
x86, this means using text_poke_early(). -- also ouchy on the !PageReserved(pages[0])
warning for text_poke().

I'm not sure yet of the best way to teach jump_label_transform() to behave like
jump_label_transform_static() under pre-smp bootup, such as when disabling hypervisor
pvspinlocks.

The s390 implementation seems safe as is given that stop_machine is now safe for early
pre-smp boot.

Thanks,
Davidlohr
