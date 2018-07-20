Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36F1CECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 10:18:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB2D9206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 10:18:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB2D9206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728384AbeGTLGG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 07:06:06 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36926 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727179AbeGTLGG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 07:06:06 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A93A081A4EB7;
        Fri, 20 Jul 2018 10:18:32 +0000 (UTC)
Received: from vitty.brq.redhat.com.redhat.com (ovpn-204-189.brq.redhat.com [10.40.204.189])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 723CA1C5B4;
        Fri, 20 Jul 2018 10:18:29 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Rik van Riel <riel@surriel.com>,
        Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Mike Galbraith <efault@gmx.de>,
        kernel-team <kernel-team@fb.com>, Ingo Molnar <mingo@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH 4/7] x86,tlb: make lazy TLB mode lazier
References: <20180716190337.26133-1-riel@surriel.com>
        <20180716190337.26133-5-riel@surriel.com>
        <CALCETrUMntRe_LYX5wj9YD4xZ+84QExK+ZNb3yxEBDEKa7nePQ@mail.gmail.com>
        <B6566AA4-2E8A-43BD-A224-0F6D4747B8FB@surriel.com>
        <F93A3335-4830-4E36-9179-D0FA5D640C8A@amacapital.net>
        <B976CC13-D014-433A-83DE-F8DF9AB4F421@surriel.com>
        <CALCETrWDiMhgiR3f8n0jdWcW31EDJ+Waq0wh5sMDutfigANGnA@mail.gmail.com>
        <87muumtjwd.fsf@vitty.brq.redhat.com>
        <20180720094906.GP2494@hirez.programming.kicks-ass.net>
Date:   Fri, 20 Jul 2018 12:18:28 +0200
In-Reply-To: <20180720094906.GP2494@hirez.programming.kicks-ass.net> (Peter
        Zijlstra's message of "Fri, 20 Jul 2018 11:49:06 +0200")
Message-ID: <87fu0etdl7.fsf@vitty.brq.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Fri, 20 Jul 2018 10:18:32 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Fri, 20 Jul 2018 10:18:32 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'vkuznets@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra <peterz@infradead.org> writes:

> On Fri, Jul 20, 2018 at 10:02:10AM +0200, Vitaly Kuznetsov wrote:
>> Andy Lutomirski <luto@amacapital.net> writes:
>> 
>> > [I added PeterZ and Vitaly -- can you see any way in which this would
>> > break something obscure?  I don't.]
>> 
>> Thanks for CCing me,
>> 
>> I don't see how this can break things either. At first glance, however,
>> I'm afraid we can add performance penalty to virtualized guests which
>> don't use native_flush_tlb_others() (Hyper-V, KVM): we will be reloading
>> CR3 without a need as we don't look at lazy mode in PV tlb flush
>> functions.
>> 
>> We can either check to switch_mm_irqs_off() that
>> native_flush_tlb_others() is in use or teach PV tlb flush functions to
>> look at lazy mode too.
>
> As Rik noted elsewhere in the thread, kvm_flush_tlb_others() ends up
> calling native_tlb_flush_others() for all running vcpu threads.

Ah, right!

>
> The Hyper-V thing is magical, we can't really do anything about it
> there. Let them worry about it.

Well, we kinda know how this magic works: we just ask the hypervisor to
flush TLB for us (if the particular vCPU is running) :-) Anyway, nothing
stops us from duplicating the logic regarding lazy mode from
native_flush_tlb_others() to hyperv_flush_tlb_others(): if TLB state is
lazy omit TLB flush.

-- 
  Vitaly
