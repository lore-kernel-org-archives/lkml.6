Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AB22C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 12:36:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA5A6214C1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 12:36:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA5A6214C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbeLDMgT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 07:36:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34980 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725767AbeLDMgT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 07:36:19 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F40943DE2F;
        Tue,  4 Dec 2018 12:36:18 +0000 (UTC)
Received: from vitty.brq.redhat.com.redhat.com (unknown [10.43.2.155])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 04D6D272D1;
        Tue,  4 Dec 2018 12:36:16 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Roman Kagan <rkagan@virtuozzo.com>
Cc:     "kvm\@vger.kernel.org" <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "x86\@kernel.org" <x86@kernel.org>,
        "Michael Kelley \(EOSG\)" <Michael.H.Kelley@microsoft.com>
Subject: Re: [PATCH v2 3/4] x86/kvm/hyper-v: direct mode for synthetic timers
In-Reply-To: <20181203171220.GA2886@rkaganb.sw.ru>
References: <20181126154732.23025-1-vkuznets@redhat.com> <20181126154732.23025-4-vkuznets@redhat.com> <20181203171220.GA2886@rkaganb.sw.ru>
Date:   Tue, 04 Dec 2018 13:36:15 +0100
Message-ID: <87muplwjsw.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Tue, 04 Dec 2018 12:36:19 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Kagan <rkagan@virtuozzo.com> writes:

> On Mon, Nov 26, 2018 at 04:47:31PM +0100, Vitaly Kuznetsov wrote:
>> @@ -379,6 +398,14 @@ void kvm_hv_synic_send_eoi(struct kvm_vcpu *vcpu, int vector)
>>  	for (i = 0; i < ARRAY_SIZE(synic->sint); i++)
>>  		if (synic_get_sint_vector(synic_read_sint(synic, i)) == vector)
>>  			kvm_hv_notify_acked_sint(vcpu, i);
>> +
>> +	for (i = 0; i < ARRAY_SIZE(hv_vcpu->stimer); i++) {
>> +		stimer = &hv_vcpu->stimer[i];
>> +		if (stimer->msg_pending && stimer->config.enable &&
>> +		    stimer->config.direct_mode &&
>> +		    stimer->config.apic_vector == vector)
>> +			stimer_mark_pending(stimer, false);
>> +	}
>>  }
>
> While debugging another issue with synic timers, it just occurred to me
> that with direct timers no extra processing is necessary on EOI: unlike
> traditional synic timers which may have failed to deliver a message and
> want to be notified when they can retry, direct timers just set the irq
> directly in the apic.
>
> So this hunk shouldn't be needed, should it?

Hm, you're probably right: kvm_apic_set_irq() fails only when apic is
disabled (see APIC_DM_FIXED case in __apic_accept_irq()) and I'm not
convinced we should re-try in this synthetic case.

Let me test the hypothesis with Hyper-V on KVM, I'll come back with
either a patch removing this over-engineered part or a reson for it to
stay. Will do later this week.

Thanks!

-- 
Vitaly
