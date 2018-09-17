Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A671EECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 08:33:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B0E1214C4
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 08:33:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B0E1214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728202AbeIQN7V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 09:59:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47082 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727329AbeIQN7V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 09:59:21 -0400
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.24])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 407C8C0587DF;
        Mon, 17 Sep 2018 08:32:59 +0000 (UTC)
Received: from vitty.brq.redhat.com.redhat.com (unknown [10.43.2.155])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 33408308BDA0;
        Mon, 17 Sep 2018 08:32:57 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Roman Kagan <rkagan@virtuozzo.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley \(EOSG\)" <Michael.H.Kelley@microsoft.com>,
        Wanpeng Li <wanpeng.li@hotmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 RESEND 3/5] KVM: x86: hyperv: use get_vcpu_by_vpidx() in kvm_hv_flush_tlb()
References: <20180822101832.31763-1-vkuznets@redhat.com>
        <20180822101832.31763-4-vkuznets@redhat.com>
        <8da03d2a-5405-f363-f081-e4bc46b106e3@redhat.com>
Date:   Mon, 17 Sep 2018 10:32:55 +0200
In-Reply-To: <8da03d2a-5405-f363-f081-e4bc46b106e3@redhat.com> (Paolo
        Bonzini's message of "Fri, 14 Sep 2018 19:33:34 +0200")
Message-ID: <87r2hs7cco.fsf@vitty.brq.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.24
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Mon, 17 Sep 2018 08:32:59 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 22/08/2018 12:18, Vitaly Kuznetsov wrote:
>> VP_INDEX almost always matches VCPU id and get_vcpu_by_vpidx() is fast,
>> use it instead of traversing full vCPU list every time.
>
> ... but if it doesn't, the algorithm is now quadratic, isn't i?

Yes,

I even had an implementation with a logarythmic search back in v2 but
we had a discussion with Roman and he convinced me this is an overkill
and not currently required. It seems that with Qemu this is true indeed,
vp_index always matches vcpu is but in case some other userspace decides
to break this unwritten rule users may experience significant slowdown.

-- 
  Vitaly
