Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAF19C6778A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 16:47:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7564A21581
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 16:47:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7564A21581
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937039AbeF2QrJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 12:47:09 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36252 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932213AbeF2QrH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 12:47:07 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EBCA681902A5;
        Fri, 29 Jun 2018 16:47:06 +0000 (UTC)
Received: from vitty.brq.redhat.com.redhat.com (unknown [10.43.2.155])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7690721565E1;
        Fri, 29 Jun 2018 16:47:04 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Roman Kagan <rkagan@virtuozzo.com>
Cc:     kvm@vger.kernel.org, x86@kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley \(EOSG\)" <Michael.H.Kelley@microsoft.com>,
        Mohammed Gamal <mmorsy@redhat.com>,
        Cathy Avery <cavery@redhat.com>,
        Wanpeng Li <wanpeng.li@hotmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/5] KVM: x86: hyperv: use get_vcpu_by_vpidx() in kvm_hv_flush_tlb()
References: <20180629141455.19525-1-vkuznets@redhat.com>
        <20180629141455.19525-4-vkuznets@redhat.com>
        <20180629150104.GE15656@rkaganb.sw.ru>
        <87a7rdd3ec.fsf@vitty.brq.redhat.com>
        <20180629162636.GG15656@rkaganb.sw.ru>
Date:   Fri, 29 Jun 2018 18:47:03 +0200
In-Reply-To: <20180629162636.GG15656@rkaganb.sw.ru> (Roman Kagan's message of
        "Fri, 29 Jun 2018 19:26:36 +0300")
Message-ID: <874lhlczg8.fsf@vitty.brq.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Fri, 29 Jun 2018 16:47:07 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Fri, 29 Jun 2018 16:47:07 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'vkuznets@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Kagan <rkagan@virtuozzo.com> writes:

> On Fri, Jun 29, 2018 at 05:21:47PM +0200, Vitaly Kuznetsov wrote:
>> Roman Kagan <rkagan@virtuozzo.com> writes:
>> 
>> > On Fri, Jun 29, 2018 at 04:14:53PM +0200, Vitaly Kuznetsov wrote:
>> >> VP_INDEX almost always matches VCPU id and get_vcpu_by_vpidx() is fast,
>> >> use it instead of traversing full vCPU list every time.
>> >> 
>> >> To support the change switch kvm_make_vcpus_request_mask() to checking
>> >> vcpu_id instead of vcpu index,
>> >
>> > I'm afraid you can't do this: vcpu_id (== apic id) can be sparse, i.e.
>> > it's not very well suited for bitmaps and can exceed the max number of
>> > vcpus.
>> 
>> True. The bitmap should be of KVM_MAX_VCPU_ID size, not
>> KVM_MAX_VCPUS.
>> 
>> Unfortunately there's no convenient way to get VCPU idx from VCPU
>> id, kvm_vcpu_get_idx() just walks the whole list :-( I see two possible
>> options:
>> 1) Add vcpu_idx fields to struct kvm_vcpu
>> 2) Keep the change expecting masks of KVM_MAX_VCPU_ID in
>> kvm_make_vcpus_request_mask(). KVM_MAX_VCPU_ID is currently 1023 so our
>> bitmaps will be 16 longs long. Not sure if it's too much.
>
> 3) rework get_vcpu_by_vpidx into get_vcpu_idx_by_vpidx followed by
> get_cpu, and use the former for your purposes
> 4) duplicate get_vcpu_by_vpidx logic in get_vcpu_idx_by_vpidx

Oh, true, thanks!

>
> Roman.
>
> P.S. I'm starting to wonder how safe this get_vcpu_* thing is WRT vcpu
> removal, but that's a different story anyway.

As there's no CPU removal in real Hyper-V I'd expect us to find a number
of issues with Windows guests if we go down this road :-)

-- 
  Vitaly
