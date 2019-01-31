Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F036C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 14:49:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67F0920869
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 14:49:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728808AbfAaOt6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 09:49:58 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:2713 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725796AbfAaOt5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 09:49:57 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 27ABF65216B089E04109;
        Thu, 31 Jan 2019 22:49:55 +0800 (CST)
Received: from [127.0.0.1] (10.177.29.32) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.408.0; Thu, 31 Jan 2019
 22:49:45 +0800
Subject: Re: [PATCH] irqchip/gic-v3-its: Lock its device list during find and
 create its device
From:   Zheng Xiang <zhengxiang9@huawei.com>
To:     Marc Zyngier <marc.zyngier@arm.com>
CC:     <linux-kernel@vger.kernel.org>, <tglx@linutronix.de>,
        <jason@lakedaemon.net>, <wanghaibin.wang@huawei.com>
References: <20190126061624.5260-1-zhengxiang9@huawei.com>
 <86bm438x8n.wl-marc.zyngier@arm.com>
 <27e0b952-111f-f221-bcd7-1a7ceb2840b5@huawei.com>
 <0dc03914-4c8a-4fa1-fb67-f51936c54836@arm.com>
 <505e3257-3ef6-69d4-b996-5a1e200e1246@huawei.com>
Message-ID: <32354a2a-b1b3-e03b-c486-c17aee1bed8d@huawei.com>
Date:   Thu, 31 Jan 2019 22:47:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:64.0) Gecko/20100101
 Thunderbird/64.0
MIME-Version: 1.0
In-Reply-To: <505e3257-3ef6-69d4-b996-5a1e200e1246@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.32]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On 2019/1/29 13:42, Zheng Xiang wrote:
> On 2019/1/28 21:51, Marc Zyngier wrote:
>> On 28/01/2019 07:13, Zheng Xiang wrote:
>>> Hi Marc,
>>>
>>> Thanks for your review.
>>>
>>> On 2019/1/26 19:38, Marc Zyngier wrote:
>>>> Hi Zheng,
>>>>
>>>> On Sat, 26 Jan 2019 06:16:24 +0000,
>>>> Zheng Xiang <zhengxiang9@huawei.com> wrote:
>>>>>
>>>>> Currently each PCI device under a PCI Bridge shares the same device id
>>>>> and ITS device. Assume there are two PCI devices call its_msi_prepare
>>>>> concurrently and they are both going to find and create their ITS
>>>>> device. There is a chance that the later one couldn't find ITS device
>>>>> before the other one creating the ITS device. It will cause the later
>>>>> one to create a different ITS device even if they have the same
>>>>> device_id.
>>>>
>>>> Interesting finding. Is this something you've actually seen in practice
>>>> with two devices being probed in parallel? Or something that you found
>>>> by inspection?
>>>
>>> Yes, I find this problem after analyzing the reason of VM hung. At last, I
>>> find that the virtio-gpu cannot receive the MSI interrupts due to sharing
>>> a same event_id as virtio-serial.
>>>
>>> See https://lkml.org/lkml/2019/1/10/299 for the bug report.
>>>
>>> This problem can be reproducted with high probability by booting a Qemu/KVM
>>> VM with a virtio-serial controller and a virtio-gpu adding to a PCI Bridge
>>> and also adding some delay before creating ITS device.
>>
>> Fair enough. Do you mind sharing your QEMU command line? It'd be useful
>> if I could reproduce it here (and would give me a way to check that it
>> doesn't regress).
> 

Have you reproduced it with my QEMU command line?

If so, should I send a V2 patch with your suggestion?

> Yes of course, my QEMU command line is below:
> 
> qemu-system-aarch64 \
>     -name guest=arm64 \
>     -machine virt,accel=kvm,usb=off,gic-version=3 \
>     -cpu host \
>     -bios /usr/share/edk2/aarch64/QEMU_EFI.fd \
>     -nodefaults \
>     -m 2048 \
>     -smp 1 \
>     -device ioh3420,port=0x8,chassis=1,id=pci.1,bus=pcie.0,multifunction=on,addr=0x1 \
>     -device i82801b11-bridge,id=pci.2,bus=pcie.0,addr=0x2 \
>     -device pci-bridge,chassis_nr=3,id=pci.3,bus=pci.2,addr=0x0 \
>     -device ioh3420,port=0x9,chassis=4,id=pci.4,bus=pcie.0,addr=0x1.0x1 \
>     -device virtio-scsi-pci,id=scsi0,bus=pci.4,addr=0x0 \
>     -drive file=/home/zhengxiang/tmp.raw,format=raw,if=none,id=drive-scsi0-0-0-0,cache=none,aio=threads \
>     -device scsi-hd,bus=scsi0.0,channel=0,scsi-id=0,lun=0,drive=drive-scsi0-0-0-0,id=scsi0-0-0-0,bootindex=1 \
>     -drive file=/dev/mapper/VolGroup00-lvol_7,format=raw,if=none,id=drive-virtio-disk0,cache=none,aio=threads \
>     -device virtio-blk-pci,scsi=off,bus=pci.1,addr=0x0,drive=drive-virtio-disk0,id=virtio-disk0 \
>     -device virtio-gpu-pci,id=video0,bus=pci.3,addr=0x2 \
>     -device virtio-serial-pci,id=virtio-serial0,bus=pci.3,addr=0x3 \
>     -device usb-ehci,id=usb,bus=pci.3,addr=0x1 \
>     -device usb-kbd,id=input1,bus=usb.0,port=2 \
>     -monitor telnet:0.0.0.0:22222,server,nowait \
>     -vnc 0.0.0.0:8 \
>     -msg timestamp=on \
>     -serial stdio \
> 
> Add *msleep* between *its_find_device* and *its_create_device* to increase the
> rate of probability, .
> 
>>
>>>
>>>>
>>>> The whole RID aliasing is such a mess, I wish we never supported
>>>> it. Anyway, comments below.
>>>>
>>>>>
>>>>> Signed-off-by: Zheng Xiang <zhengxiang9@huawei.com>
>>>>> ---
>>>>>  drivers/irqchip/irq-gic-v3-its.c | 52 +++++++++++++++-------------------------
>>>>>  1 file changed, 19 insertions(+), 33 deletions(-)
>>>>>
>>>>> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
>>>>> index db20e99..397edc8 100644
>>>>> --- a/drivers/irqchip/irq-gic-v3-its.c
>>>>> +++ b/drivers/irqchip/irq-gic-v3-its.c
>>>>> @@ -2205,25 +2205,6 @@ static void its_cpu_init_collections(void)
>>>>>  	raw_spin_unlock(&its_lock);
>>>>>  }
>>>>>  
>>>>> -static struct its_device *its_find_device(struct its_node *its, u32 dev_id)
>>>>> -{
>>>>> -	struct its_device *its_dev = NULL, *tmp;
>>>>> -	unsigned long flags;
>>>>> -
>>>>> -	raw_spin_lock_irqsave(&its->lock, flags);
>>>>> -
>>>>> -	list_for_each_entry(tmp, &its->its_device_list, entry) {
>>>>> -		if (tmp->device_id == dev_id) {
>>>>> -			its_dev = tmp;
>>>>> -			break;
>>>>> -		}
>>>>> -	}
>>>>> -
>>>>> -	raw_spin_unlock_irqrestore(&its->lock, flags);
>>>>> -
>>>>> -	return its_dev;
>>>>> -}
>>>>> -
>>>>>  static struct its_baser *its_get_baser(struct its_node *its, u32 type)
>>>>>  {
>>>>>  	int i;
>>>>> @@ -2321,7 +2302,7 @@ static bool its_alloc_vpe_table(u32 vpe_id)
>>>>>  static struct its_device *its_create_device(struct its_node *its, u32 dev_id,
>>>>>  					    int nvecs, bool alloc_lpis)
>>>>>  {
>>>>> -	struct its_device *dev;
>>>>> +	struct its_device *dev = NULL, *tmp;
>>>>>  	unsigned long *lpi_map = NULL;
>>>>>  	unsigned long flags;
>>>>>  	u16 *col_map = NULL;
>>>>> @@ -2331,6 +2312,24 @@ static struct its_device *its_create_device(struct its_node *its, u32 dev_id,
>>>>>  	int nr_ites;
>>>>>  	int sz;
>>>>>  
>>>>> +	raw_spin_lock_irqsave(&its->lock, flags);
>>>>> +	list_for_each_entry(tmp, &its->its_device_list, entry) {
>>>>> +		if (tmp->device_id == dev_id) {
>>>>> +			dev = tmp;
>>>>> +			break;
>>>>> +		}
>>>>> +	}
>>>>> +	if (dev) {
>>>>> +		/*
>>>>> +		 * We already have seen this ID, probably through
>>>>> +		 * another alias (PCI bridge of some sort). No need to
>>>>> +		 * create the device.
>>>>> +		 */
>>>>> +		pr_debug("Reusing ITT for devID %x\n", dev_id);
>>>>> +		raw_spin_unlock_irqrestore(&its->lock, flags);
>>>>> +		return dev;
>>>>> +	}
>>>>> +
>>>>>  	if (!its_alloc_device_table(its, dev_id))
>>>>
>>>> You're now performing all sort of allocations in an atomic context,
>>>> which is pretty horrible (and the kernel will shout at you for doing
>>>> so).
>>>>
>>>> We could probably keep the current logic and wrap it around a mutex
>>>> instead, which would give us the appropriate guarantees WRT allocations.
>>>> Something along those lines (untested):>
>>>> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
>>>> index db20e992a40f..99feb62e63ba 100644
>>>> --- a/drivers/irqchip/irq-gic-v3-its.c
>>>> +++ b/drivers/irqchip/irq-gic-v3-its.c
>>>> @@ -97,9 +97,14 @@ struct its_device;
>>>>   * The ITS structure - contains most of the infrastructure, with the
>>>>   * top-level MSI domain, the command queue, the collections, and the
>>>>   * list of devices writing to it.
>>>> + *
>>>> + * alloc_lock has to be taken for any allocation that can happen at
>>>> + * run time, while the spinlock must be taken to parse data structures
>>>> + * such as the device list.
>>>>   */
>>>>  struct its_node {
>>>>  	raw_spinlock_t		lock;
>>>> +	struct mutex		alloc_lock;
>>>>  	struct list_head	entry;
>>>>  	void __iomem		*base;
>>>>  	phys_addr_t		phys_base;
>>>> @@ -2421,6 +2426,7 @@ static int its_msi_prepare(struct irq_domain *domain, struct device *dev,
>>>>  	struct its_device *its_dev;
>>>>  	struct msi_domain_info *msi_info;
>>>>  	u32 dev_id;
>>>> +	int err = 0;
>>>>  
>>>>  	/*
>>>>  	 * We ignore "dev" entierely, and rely on the dev_id that has
>>>> @@ -2443,6 +2449,7 @@ static int its_msi_prepare(struct irq_domain *domain, struct device *dev,
>>>>  		return -EINVAL;
>>>>  	}
>>>>  
>>>> +	mutex_lock(&its->alloc_lock);
>>>>  	its_dev = its_find_device(its, dev_id);
>>>>  	if (its_dev) {
>>>>  		/*
>>>> @@ -2455,11 +2462,14 @@ static int its_msi_prepare(struct irq_domain *domain, struct device *dev,
>>>>  	}
>>>>  
>>>>  	its_dev = its_create_device(its, dev_id, nvec, true);
>>>> -	if (!its_dev)
>>>> -		return -ENOMEM;
>>>> +	if (!its_dev) {
>>>> +		err = -ENOMEM;
>>>> +		goto out;
>>>> +	}
>>>>  
>>>>  	pr_debug("ITT %d entries, %d bits\n", nvec, ilog2(nvec));
>>>>  out:
>>>> +	mutex_unlock(&its->alloc_lock);
>>>>  	info->scratchpad[0].ptr = its_dev;>>>  	return 0;
>>>
>>> Should it return *err* here?
>>
>> Absolutely. Does it fix the problem for you?
> 
> Yes, VM doesn't get hung anymore after thousands of times of boot/reboot.
> 
>>
>> Thanks,
>>
>> 	M.
>>
-- 

Thanks,
Xiang


