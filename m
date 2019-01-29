Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3D4AC282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:26:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E32E20882
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:26:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728364AbfA2L0F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:26:05 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:34862 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725772AbfA2L0E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:26:04 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 4680B9FE59E39C8241B3;
        Tue, 29 Jan 2019 19:26:01 +0800 (CST)
Received: from [127.0.0.1] (10.202.226.43) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.408.0; Tue, 29 Jan 2019
 19:25:54 +0800
From:   John Garry <john.garry@huawei.com>
Subject: Question on handling managed IRQs when hotplugging CPUs
To:     <tglx@linutronix.de>, Christoph Hellwig <hch@lst.de>
CC:     Marc Zyngier <marc.zyngier@arm.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        Keith Busch <keith.busch@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Linuxarm <linuxarm@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Hannes Reinecke" <hare@suse.com>
Message-ID: <f6f6e031-8b79-439d-c2af-8d3e76f30710@huawei.com>
Date:   Tue, 29 Jan 2019 11:25:48 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.43]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a question on $subject which I hope you can shed some light on.

According to commit c5cb83bb337c25 ("genirq/cpuhotplug: Handle managed 
IRQs on CPU hotplug"), if we offline the last CPU in a managed IRQ 
affinity mask, the IRQ is shutdown.

The reasoning is that this IRQ is thought to be associated with a 
specific queue on a MQ device, and the CPUs in the IRQ affinity mask are 
the same CPUs associated with the queue. So, if no CPU is using the 
queue, then no need for the IRQ.

However how does this handle scenario of last CPU in IRQ affinity mask 
being offlined while IO associated with queue is still in flight?

Or if we make the decision to use queue associated with the current CPU, 
and then that CPU (being the last CPU online in the queue's IRQ 
afffinity mask) goes offline and we finish the delivery with another CPU?

In these cases, when the IO completes, it would not be serviced and timeout.

I have actually tried this on my arm64 system and I see IO timeouts.

Thanks in advance,
John

