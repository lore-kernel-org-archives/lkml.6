Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58366C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 17:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EA4320672
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 17:31:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EA4320672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbeKZEXT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 23:23:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48745 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726644AbeKZEXT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 23:23:19 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AB53C307EA99;
        Sun, 25 Nov 2018 17:31:46 +0000 (UTC)
Received: from [10.36.112.19] (ovpn-112-19.ams2.redhat.com [10.36.112.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2F50F8501;
        Sun, 25 Nov 2018 17:31:43 +0000 (UTC)
Subject: Re: [PATCH] KVM: X86: Fix scan ioapic use-before-initialization
To:     Wanpeng Li <kernellwp@gmail.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Wei Wu <ww9210@gmail.com>
References: <1542702858-4318-1-git-send-email-wanpengli@tencent.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=pbonzini@redhat.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <442fc8ca-f92c-eded-9ede-c800a03bf39a@redhat.com>
Date:   Sun, 25 Nov 2018 18:31:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <1542702858-4318-1-git-send-email-wanpengli@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Sun, 25 Nov 2018 17:31:46 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/11/18 09:34, Wanpeng Li wrote:
> From: Wanpeng Li <wanpengli@tencent.com>
> 
> Reported by syzkaller:
> 
>  BUG: unable to handle kernel NULL pointer dereference at 00000000000001c8
>  PGD 80000003ec4da067 P4D 80000003ec4da067 PUD 3f7bfa067 PMD 0 
>  Oops: 0000 [#1] PREEMPT SMP PTI
>  CPU: 7 PID: 5059 Comm: debug Tainted: G           OE     4.19.0-rc5 #16
>  RIP: 0010:__lock_acquire+0x1a6/0x1990
>  Call Trace:
>   lock_acquire+0xdb/0x210
>   _raw_spin_lock+0x38/0x70
>   kvm_ioapic_scan_entry+0x3e/0x110 [kvm]
>   vcpu_enter_guest+0x167e/0x1910 [kvm]
>   kvm_arch_vcpu_ioctl_run+0x35c/0x610 [kvm]
>   kvm_vcpu_ioctl+0x3e9/0x6d0 [kvm]
>   do_vfs_ioctl+0xa5/0x690
>   ksys_ioctl+0x6d/0x80
>   __x64_sys_ioctl+0x1a/0x20
>   do_syscall_64+0x83/0x6e0
>   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
> The reason is that the testcase writes hyperv synic HV_X64_MSR_SINT6 msr 
> and triggers scan ioapic logic to load synic vectors into EOI exit bitmap. 
> However, irqchip is not initialized by this simple testcase, ioapic/apic 
> objects should not be accessed.
> This can be triggered by the following program:
> 
>     #define _GNU_SOURCE
>     
>     #include <endian.h>
>     #include <stdint.h>
>     #include <stdio.h>
>     #include <stdlib.h>
>     #include <string.h>
>     #include <sys/syscall.h>
>     #include <sys/types.h>
>     #include <unistd.h>
>     
>     uint64_t r[3] = {0xffffffffffffffff, 0xffffffffffffffff, 0xffffffffffffffff};
>     
>     int main(void)
>     {
>     	syscall(__NR_mmap, 0x20000000, 0x1000000, 3, 0x32, -1, 0);
>     	long res = 0;
>     	memcpy((void*)0x20000040, "/dev/kvm", 9);
>     	res = syscall(__NR_openat, 0xffffffffffffff9c, 0x20000040, 0, 0);
>     	if (res != -1)
>     		r[0] = res;
>     	res = syscall(__NR_ioctl, r[0], 0xae01, 0);
>     	if (res != -1)
>     		r[1] = res;
>     	res = syscall(__NR_ioctl, r[1], 0xae41, 0);
>     	if (res != -1)
>     		r[2] = res;
>     	memcpy(
>     			(void*)0x20000080,
>     			"\x01\x00\x00\x00\x00\x5b\x61\xbb\x96\x00\x00\x40\x00\x00\x00\x00\x01\x00"
>     			"\x08\x00\x00\x00\x00\x00\x0b\x77\xd1\x78\x4d\xd8\x3a\xed\xb1\x5c\x2e\x43"
>     			"\xaa\x43\x39\xd6\xff\xf5\xf0\xa8\x98\xf2\x3e\x37\x29\x89\xde\x88\xc6\x33"
>     			"\xfc\x2a\xdb\xb7\xe1\x4c\xac\x28\x61\x7b\x9c\xa9\xbc\x0d\xa0\x63\xfe\xfe"
>     			"\xe8\x75\xde\xdd\x19\x38\xdc\x34\xf5\xec\x05\xfd\xeb\x5d\xed\x2e\xaf\x22"
>     			"\xfa\xab\xb7\xe4\x42\x67\xd0\xaf\x06\x1c\x6a\x35\x67\x10\x55\xcb",
>     			106);
>     	syscall(__NR_ioctl, r[2], 0x4008ae89, 0x20000080);
>     	syscall(__NR_ioctl, r[2], 0xae80, 0);
>     	return 0;
>     }
> 
> This patch fixes it by bailing out scan ioapic if ioapic is not initialized in 
> kernel.
> 
> Reported-by: Wei Wu <ww9210@gmail.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Radim Krčmář <rkrcmar@redhat.com>
> Cc: Wei Wu <ww9210@gmail.com>
> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> ---
>  arch/x86/kvm/x86.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 66d66d7..14b2bc4 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -7455,7 +7455,8 @@ static void vcpu_scan_ioapic(struct kvm_vcpu *vcpu)
>  	else {
>  		if (vcpu->arch.apicv_active)
>  			kvm_x86_ops->sync_pir_to_irr(vcpu);
> -		kvm_ioapic_scan_entry(vcpu, vcpu->arch.ioapic_handled_vectors);
> +		if (ioapic_in_kernel(vcpu->kvm))
> +			kvm_ioapic_scan_entry(vcpu, vcpu->arch.ioapic_handled_vectors);
>  	}
>  
>  	if (is_guest_mode(vcpu))
> 

Queued, thanks.

Paolo
