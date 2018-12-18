Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BB0BC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 21:05:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7BDC217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 21:05:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K61GUtsz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727531AbeLRVFx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 16:05:53 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41524 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbeLRVFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 16:05:52 -0500
Received: by mail-wr1-f67.google.com with SMTP id x10so17349394wrs.8;
        Tue, 18 Dec 2018 13:05:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:openpgp:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dzAK8JUBOs/pAFSAR9bH0Bbos0Dv9LTFMLns/vkRkVs=;
        b=K61GUtsz1ZhKaW1X+ck6shH24srFTDLdkrzOX8jwECUkGhmvyVC/45V+sSIGR52Grw
         TxD7OKc8aOPTr2qMvRkP+xH8l1IEcQeuL5qy3mtXA1p0FF5ENESrN97HTJH7AftIB/SA
         v2yYcJJy2CYCz01rnu9InzD2mqsWQ6kuVPAaSKwkKaRCiRcTrotFELfY8QtZxUfg/x01
         EUBl02sGC9B+YhsstuzEQxYycdXd/dRf6cB0AYtFanXHKy+D4L1VzAwj0M7W4aFslPzu
         JF184fHa0+R+1O/UEuR1RVD5sFubfbqBFdI2j6dWxzqogP5FiodbNFCN6fxO0xzZv2KI
         3vNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:openpgp
         :autocrypt:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=dzAK8JUBOs/pAFSAR9bH0Bbos0Dv9LTFMLns/vkRkVs=;
        b=BFopZQg9LVOTZiBy27vDwhvpm95RBuR74xVxu/+SRHHL3lkDDlhPdMClzsR7m2yeRL
         L0R+BYeauxkSZgDAaZhZ+kFcSLxkN/Nh3AbKwil8um9HCDnd/7za6XlKiuTNCnDlki4+
         vikYYamjMM+dmaeoJhCMSggsrwZo3R1oljgGcgFvskDKqC0gWu2GjP9vtowf9hRM0dzm
         A9rFIfaBE/ysyVHDj96Y1KE6962Z/cQ7L8XhQfOvqA6APoPFEAGYzvnBu5N/r+vzIJ6J
         C9liHN0GgFYuscUMVfJz8+trMoi6TAiG+ajiZMbSk7o1BrjzpOD80/LkYAlod9b/ZNbO
         yAOA==
X-Gm-Message-State: AA+aEWa+pGX7E1gEXp2UrkU+jlw+LbwvPHWA1FdGUWaoPsuURvdGcnG/
        Xhm4FO1JNwAWx3oE2dH5QqQ=
X-Google-Smtp-Source: AFSGD/UU/w93bvwVbA2uVxgdhQ7tYRNNw1fbXeMp9Pgi7HUJ1IXqTVmb75CaR5Dz25eATkSMlBJwFw==
X-Received: by 2002:adf:fd50:: with SMTP id h16mr17309329wrs.231.1545167149273;
        Tue, 18 Dec 2018 13:05:49 -0800 (PST)
Received: from [192.168.10.165] ([93.56.166.5])
        by smtp.googlemail.com with ESMTPSA id y1sm4082037wme.1.2018.12.18.13.05.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 13:05:48 -0800 (PST)
Subject: Re: KASAN: use-after-free Read in kvm_put_kvm (caused by: "kvm/x86:
 add coalesced pio support")
To:     Eric Biggers <ebiggers@kernel.org>, Peng Hao <peng.hao2@zte.com.cn>
Cc:     syzbot <syzbot+f87f60bb6f13f39b54e3@syzkaller.appspotmail.com>,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rkrcmar@redhat.com, syzkaller-bugs@googlegroups.com
References: <000000000000bc23740578abe82c@google.com>
 <3ad5acd8-5c73-1d82-aea5-426e598b15ed@redhat.com>
 <20181216185513.GA691@sol.localdomain>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
 uUHgL9dKIfvpm+rNXRn9wAwGjk0X/A==
Message-ID: <6d15db4f-8017-97f2-6d31-3640f67f86ba@redhat.com>
Date:   Tue, 18 Dec 2018 22:03:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181216185513.GA691@sol.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/12/18 19:55, Eric Biggers wrote:
> Hi Peng and Paolo,
> 
> On Sun, Oct 21, 2018 at 12:01:55PM +0200, Paolo Bonzini wrote:
>> On 20/10/2018 18:57, syzbot wrote:
>>> Hello,
>>>
>>> syzbot found the following crash on:
>>>
>>> HEAD commit:    8c60c36d0b8c Add linux-next specific files for 20181019
>>> git tree:       linux-next
>>> console output: https://syzkaller.appspot.com/x/log.txt?x=12d808b5400000
>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=8b6d7c4c81535e89
>>> dashboard link:
>>> https://syzkaller.appspot.com/bug?extid=f87f60bb6f13f39b54e3
>>> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17cf2f5e400000
>>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1036dcce400000
>>>
>>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>>> Reported-by: syzbot+f87f60bb6f13f39b54e3@syzkaller.appspotmail.com
>>
>> Tentative (untested) patch:
>>
>> diff --git a/virt/kvm/coalesced_mmio.c b/virt/kvm/coalesced_mmio.c
>> index 3710342cf6ad..dc76cc8d24fd 100644
>> --- a/virt/kvm/coalesced_mmio.c
>> +++ b/virt/kvm/coalesced_mmio.c
>> @@ -90,6 +90,7 @@ static int coalesced_mmio_write(struct kvm_vcpu *vcpu,
>>  	return 0;
>>  }
>>
>> +/* called with kvm->slots_lock held */
>>  static void coalesced_mmio_destructor(struct kvm_io_device *this)
>>  {
>>  	struct kvm_coalesced_mmio_dev *dev = to_mmio(this);
>> diff --git a/virt/kvm/eventfd.c b/virt/kvm/eventfd.c
>> index b20b751286fc..001e1ef18c8c 100644
>> --- a/virt/kvm/eventfd.c
>> +++ b/virt/kvm/eventfd.c
>> @@ -741,8 +741,8 @@ ioeventfd_write(struct kvm_vcpu *vcpu, struct
>> kvm_io_device *this, gpa_t addr,
>>  }
>>
>>  /*
>> - * This function is called as KVM is completely shutting down.  We do not
>> - * need to worry about locking just nuke anything we have as quickly as
>> possible
>> + * This function is called as KVM is completely shutting down, so there
>> + * are no RCU readers anymore. Called with kvm->slots_lock held.
>>   */
>>  static void
>>  ioeventfd_destructor(struct kvm_io_device *this)
>> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
>> index aff1242b7af7..e6f2ae6fedcd 100644
>> --- a/virt/kvm/kvm_main.c
>> +++ b/virt/kvm/kvm_main.c
>> @@ -783,6 +783,7 @@ static void kvm_destroy_vm(struct kvm *kvm)
>>  	list_del(&kvm->vm_list);
>>  	spin_unlock(&kvm_lock);
>>  	kvm_free_irq_routing(kvm);
>> +	mutex_lock(&kvm->slots_lock);
>>  	for (i = 0; i < KVM_NR_BUSES; i++) {
>>  		struct kvm_io_bus *bus = kvm_get_bus(kvm, i);
>>
>> @@ -790,6 +791,7 @@ static void kvm_destroy_vm(struct kvm *kvm)
>>  			kvm_io_bus_destroy(bus);
>>  		kvm->buses[i] = NULL;
>>  	}
>> +	mutex_unlock(&kvm->slots_lock);
>>  	kvm_coalesced_mmio_free(kvm);
>>  #ifdef KVM_DIRTY_LOG_PAGE_OFFSET
>>  	if (kvm->dirty_ring_size)
>>
> 
> This is still happening.  Paolo, I don't see how your patch matches this bug, as
> it has a single threaded reproducer.  I simplified it to:
> 
> 	#include <fcntl.h>
> 	#include <linux/kvm.h>
> 	#include <sys/ioctl.h>
> 
> 	int main(void)
> 	{
> 		int kvm, vm;
> 		struct kvm_coalesced_mmio_zone zone = { 0 };
> 
> 		kvm = open("/dev/kvm", O_RDWR);
> 
> 		vm = ioctl(kvm, KVM_CREATE_VM, 0);
> 
> 		ioctl(vm, KVM_REGISTER_COALESCED_MMIO, &zone);
> 
> 		zone.pio = 1;
> 		ioctl(vm, KVM_UNREGISTER_COALESCED_MMIO, &zone);
> 	}
> 
> The bug is in this commit:
> 
> 	commit 0804c849f1df0992d39a37c4fc259f7f8b16f385
> 	Author: Peng Hao <peng.hao2@zte.com.cn>
> 	Date:   Sun Oct 14 07:09:55 2018 +0800
> 
> 	    kvm/x86 : add coalesced pio support
> 
> The problem is that if you register a kvm_coalesced_mmio_zone with '.pio = 0'
> but then unregister it with '.pio = 1', KVM_UNREGISTER_COALESCED_MMIO will try
> to unregister it from KVM_PIO_BUS rather than KVM_MMIO_BUS, which is a no-op,
> but then it frees the kvm_coalesced_mmio_dev anyway.
> 
> Here's one possible fix but I don't know what was intended here.  Are you
> supposed to pass in the same value of '.pio' when unregistering or is it
> supposed to use the existing value?  Can one of you please point me to the
> documentation for these ioctls?
> 
> diff --git a/virt/kvm/coalesced_mmio.c b/virt/kvm/coalesced_mmio.c
> index 3710342cf6ad0..6855cce3e5287 100644
> --- a/virt/kvm/coalesced_mmio.c
> +++ b/virt/kvm/coalesced_mmio.c
> @@ -175,10 +175,14 @@ int kvm_vm_ioctl_unregister_coalesced_mmio(struct kvm *kvm,
>  {
>  	struct kvm_coalesced_mmio_dev *dev, *tmp;
>  
> +	if (zone->pio != 1 && zone->pio != 0)
> +		return -EINVAL;
> +
>  	mutex_lock(&kvm->slots_lock);
>  
>  	list_for_each_entry_safe(dev, tmp, &kvm->coalesced_zones, list)
> -		if (coalesced_mmio_in_range(dev, zone->addr, zone->size)) {
> +		if (zone->pio == dev->zone.pio &&
> +		    coalesced_mmio_in_range(dev, zone->addr, zone->size)) {
>  			kvm_io_bus_unregister_dev(kvm,
>  				zone->pio ? KVM_PIO_BUS : KVM_MMIO_BUS, &dev->dev);
>  			kvm_iodevice_destructor(&dev->dev);
> 

Thanks for the patch, I queued it.

Paolo
