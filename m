Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAD19C43146
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 19:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 777CD274DC
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 14:51:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 777CD274DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966718AbeF1OvP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 10:51:15 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:9135 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966458AbeF1OvO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 10:51:14 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id DBF63442F0AD3;
        Thu, 28 Jun 2018 22:50:57 +0800 (CST)
Received: from [127.0.0.1] (10.202.226.42) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.382.0; Thu, 28 Jun 2018
 22:50:52 +0800
Subject: Re: KVM guest sometimes failed to boot because of kernel stack
 overflow if KPTI is enabled on a hisilicon ARM64 platform.
To:     Will Deacon <will.deacon@arm.com>
References: <5B2A6218.3030201@hisilicon.com> <20180620144257.GB27776@arm.com>
 <5B2A7832.4010502@hisilicon.com>
 <ebfabb8f-dcd9-3fb4-3655-368a882d8f09@arm.com>
 <5B2A7FE1.5040607@hisilicon.com>
 <e701eaa8-dcb9-777c-2211-67ee27b43acb@arm.com>
 <5B2B6DEA.2090100@hisilicon.com> <5B3274FC.7000206@hisilicon.com>
 <20180626174746.GO23375@arm.com> <5B338F7B.9070500@hisilicon.com>
 <20180627132826.GB30631@arm.com>
CC:     James Morse <james.morse@arm.com>, <mark.rutland@arm.com>,
        <catalin.marinas@arm.com>, Linuxarm <linuxarm@huawei.com>,
        Zhangyi ac <zhangyi.ac@huawei.com>, <suzuki.poulose@arm.com>,
        <marc.zyngier@arm.com>,
        "Xiongfanggou (James)" <james.xiong@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <dave.martin@arm.com>,
        "Liyuan (Larry, Turing Solution)" <Larry.T@huawei.com>,
        <libeijian@hisilicon.com>, <zhangxiquan@hisilicon.com>,
        <wxf.wang@hisilicon.com>, <dingshuai1@huawei.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        "Liguozhu (Kenneth)" <liguozhu@hisilicon.com>,
        <zhangxiquan@hisilicon.com>, <wxf.wang@hisilicon.com>,
        Hanjun Guo <guohanjun@huawei.com>, <dingshuai1@huawei.com>
From:   Wei Xu <xuwei5@hisilicon.com>
Message-ID: <5B34F5C0.9090001@hisilicon.com>
Date:   Thu, 28 Jun 2018 15:50:40 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <20180627132826.GB30631@arm.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

On 2018/6/27 14:28, Will Deacon wrote:
> On Wed, Jun 27, 2018 at 02:22:03PM +0100, Wei Xu wrote:
>> On 2018/6/26 18:47, Will Deacon wrote:
>>> If you look at the __idmap_kpti_put_pgtable_ent_ng asm macro, can you try
>>> replacing:
>>>
>>> 	dc      civac, cur_\()\type\()p
>>>
>>> with:
>>>
>>> 	dc      ivac, cur_\()\type\()p
>>>
>>> please? Only do this for the guest kernel, not the host. KVM will upgrade
>>> the clean to a clean+invalidate, so it's interesting to see if this has
>>> an effect on the behaviour.
>>
>> Only changed the guest kernel, the guest still failed to boot and the log
>> is same with the last mail.
>>
>> But if I changed to cvac as below for the guest, it is kind of stable.
>> 	dc      cvac, cur_\()\type\()p
>>
>> I have synced with our SoC guys about this and hope we can find the reason.
>> Do you have any more suggestion?
> 
> Unfortunately, not. It looks like somehow clean+invalidate is behaving
> just as an invalidate, and we're corrupting the page table as a result.
> 
> Hopefully the SoC guys will figure it out.

After replaced the dmb with dsb in both __idmap_kpti_get_pgtable_ent and
__idmap_kpti_put_pgtable_ent_ng, we tested 20 times and we can not reproduce
the issue.
Today we will continue to do the stress testing and will update the result tomorrow.

The dsb in __idmap_kpti_get_pgtable_ent is to make sure the dc has been done and
the following ldr can get the latest data.

The dsb in __idmap_kpti_put_pgtable_ent_ng is to make sure the str will be done
before dc. Although dmb can guarantee the order of the str and dc on the L2 cache,
dmb can not guarantee the order on the bus.

How do you think about it?
Thanks!

----

diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index 03646e6..bb767ea 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -209,7 +209,7 @@ ENDPROC(idmap_cpu_replace_ttbr1)

        .macro  __idmap_kpti_get_pgtable_ent, type
        dc      cvac, cur_\()\type\()p          // Ensure any existing dirty
-       dmb     sy                              // lines are written back before
+       dsb     sy                              // lines are written back before
        ldr     \type, [cur_\()\type\()p]       // loading the entry
        tbz     \type, #0, skip_\()\type        // Skip invalid and
        tbnz    \type, #11, skip_\()\type       // non-global entries
@@ -218,8 +218,9 @@ ENDPROC(idmap_cpu_replace_ttbr1)
        .macro __idmap_kpti_put_pgtable_ent_ng, type
        orr     \type, \type, #PTE_NG           // Same bit for blocks and pages
        str     \type, [cur_\()\type\()p]       // Update the entry and ensure
-       dmb     sy                              // that it is visible to all
+       dsb     sy                              // that it is visible to all
        dc      civac, cur_\()\type\()p         // CPUs. 	


Best Regards,
Wei

> 
> Will
> 
> .
> 

