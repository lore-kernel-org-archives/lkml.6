Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F38BEC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 11:42:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A08FC208D9
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 11:42:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A08FC208D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728397AbeIYRta (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 13:49:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36898 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727159AbeIYRta (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 13:49:30 -0400
Received: from smtp.corp.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.26])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A5B2A83F46;
        Tue, 25 Sep 2018 11:42:21 +0000 (UTC)
Received: from vitty.brq.redhat.com.redhat.com (unknown [10.43.2.217])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A036B3001930;
        Tue, 25 Sep 2018 11:42:19 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Roman Kagan <rkagan@virtuozzo.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley \(EOSG\)" <Michael.H.Kelley@microsoft.com>,
        Wanpeng Li <wanpeng.li@hotmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 RESEND 3/5] KVM: x86: hyperv: use get_vcpu_by_vpidx() in kvm_hv_flush_tlb()
In-Reply-To: <20180925101040.GA2336@rkaganb.sw.ru>
References: <20180822101832.31763-1-vkuznets@redhat.com> <20180822101832.31763-4-vkuznets@redhat.com> <8da03d2a-5405-f363-f081-e4bc46b106e3@redhat.com> <87r2hs7cco.fsf@vitty.brq.redhat.com> <87zhw62797.fsf@vitty.brq.redhat.com> <74055c3b-be66-4ce6-e727-a155f18a0ba1@redhat.com> <20180925085752.GA5391@rkaganb.sw.ru> <f8cd3988-ea7e-0e4a-ee95-927534276f84@redhat.com> <20180925101040.GA2336@rkaganb.sw.ru>
Date:   Tue, 25 Sep 2018 13:42:18 +0200
Message-ID: <871s9hreg5.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.26
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Tue, 25 Sep 2018 11:42:21 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Kagan <rkagan@virtuozzo.com> writes:

> On Tue, Sep 25, 2018 at 11:29:57AM +0200, Paolo Bonzini wrote:
>> On 25/09/2018 10:57, Roman Kagan wrote:
>> > If we can assume that in all relevant cases vp_index coincides with the
>> > cpu index (which I think we can) then Vitaly's approach is the most
>> > efficient.
>> > 
>> > If, on the opposite, we want to optimize for random mapping between
>> > vp_index and cpu index, then it's probably better instead to iterate
>> > over vcpus and test if their vp_index belongs to the requested mask.
>> 
>> Yes, that would work too.  Perhaps we can do both?  You can have a
>> kvm->num_mismatched_vp_indexes count to choose between the two.
>
> Makes sense to me.

Thanks guys,

I'll try to draft something up for v6.

-- 
Vitaly
