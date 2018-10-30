Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4079EC2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 05:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0D322082B
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 05:52:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0D322082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbeJ3Oof (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 10:44:35 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:52709 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726074AbeJ3Oof (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 10:44:35 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 343F1D28E5164;
        Tue, 30 Oct 2018 13:52:29 +0800 (CST)
Received: from [10.151.23.176] (10.151.23.176) by smtp.huawei.com
 (10.3.19.211) with Microsoft SMTP Server (TLS) id 14.3.408.0; Tue, 30 Oct
 2018 13:52:20 +0800
Subject: Re: [PATCH v2] bit_spinlock: introduce smp_cond_load_relaxed
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Will Deacon" <will.deacon@arm.com>,
        <linux-kernel@vger.kernel.org>, Miao Xie <miaoxie@huawei.com>,
        Chao Yu <chao@kernel.org>
References: <1539413249-4402-1-git-send-email-hsiangkao@aol.com>
 <20181030060441.16107-1-gaoxiang25@huawei.com>
From:   Gao Xiang <gaoxiang25@huawei.com>
Message-ID: <3455f753-8f7c-91a8-c926-e06f5ed2d1bb@huawei.com>
Date:   Tue, 30 Oct 2018 13:52:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20181030060441.16107-1-gaoxiang25@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.151.23.176]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2018/10/30 14:04, Gao Xiang wrote:
> It is better to use wrapped smp_cond_load_relaxed
> instead of open-coded busy waiting for bit_spinlock.
> 
> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
> ---
> 
> change log v2:
>  - fix the incorrect expression !(VAL >> (bitnum & (BITS_PER_LONG-1)))
>  - the test result is described in the following reply.
> 
> Thanks,
> Gao Xiang


Simple test script:
#include <linux/kthread.h>
#include <linux/bit_spinlock.h>
#include <linux/module.h>

unsigned long global_lock;

int test_thread(void *data)
{
	unsigned long thread_id = (unsigned long)data;
	int i;
	u64 start = ktime_get_ns();

	for (i = 0; i < 500000; ++i) {
		bit_spin_lock(0, &global_lock);
		__asm__("yield");
		bit_spin_unlock(0, &global_lock);
	}
	pr_err("Thread id: %lu time: %llu\n", thread_id, ktime_get_ns() - start);

	do_exit(0);
}


static int __init bitspinlock_test_module_init(void)
{
	int i;

	for (i = 0; i < 8; ++i) {
		if (IS_ERR(kthread_run(test_thread, (void *)(unsigned long)i, "thread-%d", i)))
			pr_err("fail to create thread %d\n", i);
	}

	return 0;
}

static void __exit bitspinlock_test_module_exit(void)
{
}

module_init(bitspinlock_test_module_init);
module_exit(bitspinlock_test_module_exit);
MODULE_LICENSE("GPL");


...and tested in the following ARM server environment:

Processor: HI1616 (https://en.wikichip.org/wiki/hisilicon/hi16xx/hi1616)
Board: HiSilicon D05 Development Board (http://open-estuary.org/d05/)
Memory: 512GB
Host OS: Ubuntu 18.04.1 LTS (Ubuntu 4.15.0-29.31-generic 4.15.18)
QEMU KVM OS: Linux 4.19 + buildroot
QEMU KVM cmdline: qemu-system-aarch64 -enable-kvm -cpu host -smp 4 -m 256M -kernel Image -M virt,kernel_irqchip=on -nographic -hda rootfs.ext2 -append 'root=/dev/vda console=ttyAMA0 earlycon=pl011,0x9000000' -serial mon:stdio -net none

Without this patch:
  Thread 0   Thread 1   Thread 2   Thread 3   Thread 4   Thread 5   Thread 6   Thread 7
1 1283709480 1271869280  454742480 1173673820 1145643640 1118846920  774616920 1144146140
2  643580180  625143860  576841700  322982340  649987880  585749000  529178880  373374780
3  672307220  847315000  880801860 1039502040  667086380 1033939940 1035381120 1046898300
4  568635580  440547020  737000380  910040880  804543740  712314280  868896880  867049000
5  749107320  726397720  776134480  611970100  756721040  753449440  711691300  609343300

With this patch:
  Thread 0   Thread 1   Thread 2   Thread 3   Thread 4   Thread 5   Thread 6   Thread 7
1  170327620  196322160  169434180   74723860  178145600  178873460  143843260   70998780
2  166415220  129649200  166161240  175241520  155474460  112811860  157003140  150087420
3  511420780  117655640  598641860  596213720  462888760  430838600  554346300  428035120 
4  174520240  156311800  120274280   87465380  172781400  136118620  163728340   63026360
5  153677940  202786860  183626500  140721300  150311360  161266840  168154340  107247460

Thanks,
Gao Xiang
