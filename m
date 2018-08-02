Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBAFDC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 13:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BE8E214FF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 13:22:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BE8E214FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387505AbeHBPOA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 11:14:00 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57430 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387426AbeHBPN7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 11:13:59 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 974019D92;
        Thu,  2 Aug 2018 13:22:47 +0000 (UTC)
Received: from vitty.brq.redhat.com.redhat.com (unknown [10.43.2.155])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8D973213ED6A;
        Thu,  2 Aug 2018 13:22:45 +0000 (UTC)
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
Subject: Re: [PATCH v3 0/6] KVM: nVMX: Enlightened VMCS for Hyper-V on KVM
References: <20180725163057.13948-1-vkuznets@redhat.com>
        <4c221ed3-5de8-b9cf-663b-d31ce0834c12@redhat.com>
Date:   Thu, 02 Aug 2018 15:22:44 +0200
In-Reply-To: <4c221ed3-5de8-b9cf-663b-d31ce0834c12@redhat.com> (Paolo
        Bonzini's message of "Thu, 2 Aug 2018 14:45:10 +0200")
Message-ID: <871sbgaonv.fsf@vitty.brq.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Thu, 02 Aug 2018 13:22:47 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Thu, 02 Aug 2018 13:22:47 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'vkuznets@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 25/07/2018 18:30, Vitaly Kuznetsov wrote:
>> Changes since v2:
>> - Rebase to the current kvm/queue.
>> - Simplify clean fields check in prepare_vmcs02{,_full} and
>>   copy_enlightened_to_vmcs12() by resetting the clean fields mask in
>>   nested_vmx_handle_enlightened_vmptrld() when we switch from one L2 guest
>>   to another [Paolo Bonzini]
>> - Cope with the newly introduced vmx_get_nested_state() by returning
>>   -ENOTSUPP when eVMCS is in use. We'll do proper nested state save/restore
>>   later.
>
> Looks good, but we have to do something about live migration.

Sure,

I don't actually see any fundumental problems when eVMCS is in use,
however, I'd like to enable migration when we know that it works so I
was going to wait for your nested virtualization state migration series
to land and gain Qemu support before starting to experiment. "One bite
at a time".

> Perhaps you can write a testcase analogous to the new state_test, that
> tests eVMCS in general before we have support in QEMU.

I'll take a look, thanks for the pointer!

-- 
  Vitaly
