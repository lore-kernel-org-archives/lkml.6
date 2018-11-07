Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 165FDC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 10:49:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA8C32086C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 10:49:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA8C32086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728076AbeKGUS6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 15:18:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36120 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726225AbeKGUS5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 15:18:57 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id ED68C58E38;
        Wed,  7 Nov 2018 10:49:08 +0000 (UTC)
Received: from vitty.brq.redhat.com.redhat.com (unknown [10.43.2.9])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6F26E104C529;
        Wed,  7 Nov 2018 10:49:06 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Tianyu Lan <ltykernel@gmail.com>
Cc:     Lan Tianyu <Tianyu.Lan@microsoft.com>, pbonzini@redhat.com,
        rkrcmar@redhat.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, michael.h.kelley@microsoft.com,
        kys@microsoft.com
Subject: Re: [PATCH] KVM/VMX: Check ept_pointer before flushing ept tlb
In-Reply-To: <bcd1cd98-0b2f-2c3b-c1d2-a4f4ea960063@gmail.com>
References: <20181106133043.83570-1-Tianyu.Lan@microsoft.com> <87lg66urwd.fsf@vitty.brq.redhat.com> <bcd1cd98-0b2f-2c3b-c1d2-a4f4ea960063@gmail.com>
Date:   Wed, 07 Nov 2018 11:49:05 +0100
Message-ID: <8736sdupr2.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Wed, 07 Nov 2018 10:49:09 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tianyu Lan <ltykernel@gmail.com> writes:

> Hi Vitaly:
> 	Thanks for your review.
>
> On 11/6/2018 11:50 PM, Vitaly Kuznetsov wrote:
>> ltykernel@gmail.com writes:
>> 
>>> From: Lan Tianyu <Tianyu.Lan@microsoft.com>
>>>
>>> This patch is to initialize ept_pointer to INVALID_PAGE and check it
>>> before flushing ept tlb. If ept_pointer is invalidated, bypass the flush
>>> request.
>>>
>> 
>> To be honest I fail to understand the reason behind the patch: instead
>> of doing one unneeded flush request with ept_pointer==0 (after vCPU is
>> initialized) we now do the check every time. Could you please elaborate
>> on why this is needed?
>
> The reason to introduce the check here is to avoid flushing ept tlb
> without valid ept table. When nested guest boots up and only BP is
> active, we should not do flush for APs and L1 hypervisor hasn't set
> valid EPT table for APs.

Yes, I understand that but I'm trying to avoid additional checks on
hotpath as during normal operation EPT pointer is always set.

Could we just initialize ept_pointers_match to something like
EPT_POINTERS_NOTSET and achive the same result?

-- 
Vitaly
