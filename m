Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49740C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 08:37:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F320920844
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 08:37:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F320920844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728676AbeGYJs0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 05:48:26 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54608 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728357AbeGYJsZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 05:48:25 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 23BE08550F;
        Wed, 25 Jul 2018 08:37:47 +0000 (UTC)
Received: from vitty.brq.redhat.com.redhat.com (unknown [10.40.205.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D8CEB111DCE8;
        Wed, 25 Jul 2018 08:37:43 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Roman Kagan <rkagan@virtuozzo.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley \(EOSG\)" <Michael.H.Kelley@microsoft.com>,
        Mohammed Gamal <mmorsy@redhat.com>,
        Cathy Avery <cavery@redhat.com>, linux-kernel@vger.kernel.org,
        Jim Mattson <jmattson@google.com>,
        Liran Alon <liran.alon@oracle.com>
Subject: Re: [PATCH v2 6/6] KVM: nVMX: optimize prepare_vmcs02{,_full} for Enlightened VMCS case
References: <20180621123046.29606-1-vkuznets@redhat.com>
        <20180621123046.29606-7-vkuznets@redhat.com>
        <a826fd88-0199-8e7b-ebfc-290e936b5efc@redhat.com>
Date:   Wed, 25 Jul 2018 10:37:43 +0200
In-Reply-To: <a826fd88-0199-8e7b-ebfc-290e936b5efc@redhat.com> (Paolo
        Bonzini's message of "Tue, 24 Jul 2018 19:09:04 +0200")
Message-ID: <87va93pv6w.fsf@vitty.brq.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Wed, 25 Jul 2018 08:37:47 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Wed, 25 Jul 2018 08:37:47 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'vkuznets@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 21/06/2018 14:30, Vitaly Kuznetsov wrote:
>> +static __always_inline bool evmcs_needs_write(struct vcpu_vmx *vmx,
>> +					      u16 clean_field)
>> +{
>> +	if (vmx->nested.dirty_vmcs12)
>> +		return true;
>
> Why is this needed?  If it weren't for it, you could pass hv_evmcs
> directly to evmcs_needs_write, which would simplify the code a bit in
> the caller.

This is an equivalent of prepare_vmcs02()/prepare_vmcs02_full() split
for eVMCS case: when we switch from L2 guest A to L2 guest B we need to
write the whole VMCS so evmcs_needs_write() needs to return true.

We can, however, make an optimisation: forcefuly reset hv_clean_fields
mask on enlightened vmptrld making 'dirty_vmcs12' check redundant.

This series was posted quite some time ago, I'll rebase and re-test with
the fix included.

Thanks!

-- 
  Vitaly
