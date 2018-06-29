Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF184C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 15:21:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 985862804F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 15:21:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 985862804F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936575AbeF2PVw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 11:21:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58964 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S936176AbeF2PVv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 11:21:51 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9087B40201C7;
        Fri, 29 Jun 2018 15:21:50 +0000 (UTC)
Received: from vitty.brq.redhat.com.redhat.com (unknown [10.43.2.155])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A7DA776EA;
        Fri, 29 Jun 2018 15:21:48 +0000 (UTC)
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
Date:   Fri, 29 Jun 2018 17:21:47 +0200
In-Reply-To: <20180629150104.GE15656@rkaganb.sw.ru> (Roman Kagan's message of
        "Fri, 29 Jun 2018 18:01:05 +0300")
Message-ID: <87a7rdd3ec.fsf@vitty.brq.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Fri, 29 Jun 2018 15:21:50 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Fri, 29 Jun 2018 15:21:50 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'vkuznets@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Kagan <rkagan@virtuozzo.com> writes:

> On Fri, Jun 29, 2018 at 04:14:53PM +0200, Vitaly Kuznetsov wrote:
>> VP_INDEX almost always matches VCPU id and get_vcpu_by_vpidx() is fast,
>> use it instead of traversing full vCPU list every time.
>> 
>> To support the change switch kvm_make_vcpus_request_mask() to checking
>> vcpu_id instead of vcpu index,
>
> I'm afraid you can't do this: vcpu_id (== apic id) can be sparse, i.e.
> it's not very well suited for bitmaps and can exceed the max number of
> vcpus.

True. The bitmap should be of KVM_MAX_VCPU_ID size, not
KVM_MAX_VCPUS.

Unfortunately there's no convenient way to get VCPU idx from VCPU
id, kvm_vcpu_get_idx() just walks the whole list :-( I see two possible
options:
1) Add vcpu_idx fields to struct kvm_vcpu
2) Keep the change expecting masks of KVM_MAX_VCPU_ID in
kvm_make_vcpus_request_mask(). KVM_MAX_VCPU_ID is currently 1023 so our
bitmaps will be 16 longs long. Not sure if it's too much.

-- 
  Vitaly
