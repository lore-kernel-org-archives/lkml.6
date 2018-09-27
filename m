Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FE5BC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 05:12:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6240E21566
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 05:12:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6240E21566
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727259AbeI0L2v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 07:28:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54304 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726469AbeI0L2u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 07:28:50 -0400
Received: from smtp.corp.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.27])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E6A5285A01;
        Thu, 27 Sep 2018 05:12:27 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-101.pek2.redhat.com [10.72.12.101])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6E627A2791;
        Thu, 27 Sep 2018 05:12:19 +0000 (UTC)
Subject: Re: [PATCH 1/4 v8] x86/ioremap: add a function ioremap_encrypted() to
 remap kdump old memory
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, joro@8bytes.org, mingo@redhat.com,
        ebiederm@xmission.com, hpa@zytor.com, tglx@linutronix.de,
        Dave Young <dyoung@redhat.com>,
        "Lendacky, Thomas" <thomas.lendacky@amd.com>,
        kexec@lists.infradead.org
References: <20180907081805.368-1-lijiang@redhat.com>
 <20180907081805.368-2-lijiang@redhat.com>
 <20180926022123.GA2555@MiWiFi-R3L-srv>
 <e6cd5448-b314-e142-1169-9e3e907faf16@redhat.com>
 <e7634c77-1657-4665-3bc4-bd00196f28e4@redhat.com>
 <c076568c-aaf8-9b83-40bd-55c406bd88d0@redhat.com>
 <20180927020647.GH2555@MiWiFi-R3L-srv>
From:   lijiang <lijiang@redhat.com>
Message-ID: <db7caa5e-76fa-7b1c-b93d-29a4a978d37c@redhat.com>
Date:   Thu, 27 Sep 2018 13:12:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180927020647.GH2555@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.27
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Thu, 27 Sep 2018 05:12:28 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2018年09月27日 10:06, Baoquan He 写道:
> Hi Lianbo,
> 
> On 09/26/18 at 05:34pm, lijiang wrote:
>> When SME is enabled on AMD machine, the memory is encrypted in the first
>> kernel. In this case, SME also needs to be enabled in kdump kernel, and
>> we have to remap the old memory with the memory encryption mask.
>>
>> Here we only talk about the case that SME is active in the first kernel,
>> and only care it's active too in kdump kernel. there are four cases we
>> need considered.
>>
>> a. dump vmcore
>>    It is encrypted in the first kernel, and needs be read out in kdump
>>    kernel.
>>
>> b. crash notes
>>    When dumping vmcore, the people usually need to read the useful
>>    information from notes, and the notes is also encrypted.
>>
>> c. iommu device table
>>    It is allocated by kernel, need fill its pointer into mmio of amd iommu.
>>    It's encrypted in the first kernel, need read the old content to analyze
>>    and get useful information.
>>
>> d. mmio of amd iommu
>>    Register reported by amd firmware, it's not RAM, we don't encrypt in
>>    both the first kernel and kdump kernel.
>>
>> To achieve the goal, the solution is:
>> 1. add a new bool parameter "encrypted" to __ioremap_caller()
>>    It is a low level function, and check the newly added parameter, if it's
>>    true and in kdump kernel, will remap the memory with sme mask.
>>
>> 2. add a new function ioremap_encrypted() to explicitly passed in a "true"
>>    value for "encrypted".
>>    For above a, b, c, we will call ioremap_encrypted();
>>
>> 3. adjust all existed ioremap wrapper functions, passed in "false" for
>>    encrypted to make them an before.
>>
>>    ioremap_encrypted()\
>>    ioremap_cache()     |
>>    ioremap_prot()      |
>>    ioremap_wt()        |->__ioremap_caller()
>>    ioremap_wc()        |
>>    ioremap_uc()        |
>>    ioremap_nocache()  /
> 
> Thanks, I think it's better. Since no code change, just patch log
> improvement, maybe you can repost a series and carry both Tom and
> Joerg's ACK.
> 
Thank you, Baoquan.
I will resend a series, and add Tom's Reviewed-by for all patches, also
add Joerg's Acked-by for patch 3/4.

Thanks.
Lianbo
