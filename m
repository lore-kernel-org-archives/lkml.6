Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C538C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 12:58:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FAEA20883
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 12:58:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FAEA20883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966295AbeFSM6X (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 08:58:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38614 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965727AbeFSM6V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 08:58:21 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2394A40704A2;
        Tue, 19 Jun 2018 12:58:21 +0000 (UTC)
Received: from vitty.brq.redhat.com.redhat.com (unknown [10.43.2.155])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9FE7A2026D68;
        Tue, 19 Jun 2018 12:58:19 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Stephen Hemminger <sthemmin@microsoft.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, devel@linuxdriverproject.org
Subject: Re: [PATCH] x86/hyper-v: use cheaper HVCALL_FLUSH_VIRTUAL_ADDRESS_{LIST, SPACE} hypercalls when possible
References: <20180615163010.20381-1-vkuznets@redhat.com>
        <alpine.DEB.2.21.1806191403510.1684@nanos.tec.linutronix.de>
Date:   Tue, 19 Jun 2018 14:58:18 +0200
In-Reply-To: <alpine.DEB.2.21.1806191403510.1684@nanos.tec.linutronix.de>
        (Thomas Gleixner's message of "Tue, 19 Jun 2018 14:05:04 +0200
        (CEST)")
Message-ID: <87wouvkk5x.fsf@vitty.brq.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Tue, 19 Jun 2018 12:58:21 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Tue, 19 Jun 2018 12:58:21 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'vkuznets@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner <tglx@linutronix.de> writes:

> On Fri, 15 Jun 2018, Vitaly Kuznetsov wrote:
>>   * Fills in gva_list starting from offset. Returns the number of items added.
>> @@ -93,10 +95,19 @@ static void hyperv_flush_tlb_others(const struct cpumask *cpus,
>>  	if (cpumask_equal(cpus, cpu_present_mask)) {
>>  		flush->flags |= HV_FLUSH_ALL_PROCESSORS;
>>  	} else {
>> +		/*
>> +		 * It is highly likely that VP ids are in ascending order
>> +		 * matching Linux CPU ids; Check VP index for the highest CPU
>> +		 * in the supplied set to see if EX hypercall is required.
>> +		 * This is just a best guess but should work most of the time.
>
> TLB flushing based on 'best guess' and 'should work most of the time' is
> not a brilliant approach.
>

Oh no no no, that's not what I meant :-)

We have the following problem: from the supplied CPU set we need to
figure out if we can get away with HVCALL_FLUSH_VIRTUAL_ADDRESS_{LIST,
SPACE} hypercalls which are cheaper or if we need to use more expensing
HVCALL_FLUSH_VIRTUAL_ADDRESS_{LIST, SPACE}_EX ones. The dividing line is
the highest VP_INDEX of the supplied CPU set: in case it is < 64 cheaper
hypercalls are OK. Now how do we check that? In the patch I have the
following approach:
1) Check VP number for the highest CPU in the supplied set. In case it
is > 64 we for sure need more expensive hypercalls. This is the "guess"
which works most of the time because Linux CPU ids usually match
VP_INDEXes.

2) In case the answer to the previous question was negative we start
preparing input for the cheaper hypercall. However, if while walking the
CPU set we meet a CPU with VP_INDEX higher than 64 we'll discard the
prepared input and switch to the more expensive hypercall.

Said that the 'guess' here is just an optimization to avoid walking the
whole CPU set when we find the required answer quickly by looking at the
highest bit. This will help big systems with hundreds of CPUs.

-- 
  Vitaly
