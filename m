Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4592C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:27:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1E5E208B1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:27:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1E5E208B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754050AbeFTI11 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 04:27:27 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38692 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751327AbeFTI1Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 04:27:25 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 73DD08790A;
        Wed, 20 Jun 2018 08:27:24 +0000 (UTC)
Received: from vitty.brq.redhat.com.redhat.com (unknown [10.43.2.155])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CAC0F2156880;
        Wed, 20 Jun 2018 08:27:22 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     KY Srinivasan <kys@microsoft.com>
Cc:     "Michael Kelley \(EOSG\)" <Michael.H.Kelley@microsoft.com>,
        "x86\@kernel.org" <x86@kernel.org>,
        "devel\@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>
Subject: Re: [PATCH] x86/hyper-v: use cheaper HVCALL_FLUSH_VIRTUAL_ADDRESS_{LIST,SPACE} hypercalls when possible
References: <20180615163010.20381-1-vkuznets@redhat.com>
        <SN6PR2101MB11209236A3C18C7CA01F4061DC700@SN6PR2101MB1120.namprd21.prod.outlook.com>
        <MW2PR2101MB111340FC6B6AFA7CEC494498A0700@MW2PR2101MB1113.namprd21.prod.outlook.com>
Date:   Wed, 20 Jun 2018 10:27:21 +0200
In-Reply-To: <MW2PR2101MB111340FC6B6AFA7CEC494498A0700@MW2PR2101MB1113.namprd21.prod.outlook.com>
        (KY Srinivasan's message of "Tue, 19 Jun 2018 18:20:36 +0000")
Message-ID: <87po0lkgly.fsf@vitty.brq.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Wed, 20 Jun 2018 08:27:24 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Wed, 20 Jun 2018 08:27:24 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'vkuznets@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KY Srinivasan <kys@microsoft.com> writes:

>> -----Original Message-----
>> From: Michael Kelley (EOSG)
>> Sent: Tuesday, June 19, 2018 10:57 AM
>> To: Vitaly Kuznetsov <vkuznets@redhat.com>; x86@kernel.org
>> Cc: devel@linuxdriverproject.org; linux-kernel@vger.kernel.org; KY
>> Srinivasan <kys@microsoft.com>; Haiyang Zhang
>> <haiyangz@microsoft.com>; Stephen Hemminger
>> <sthemmin@microsoft.com>; Thomas Gleixner <tglx@linutronix.de>; Ingo
>> Molnar <mingo@redhat.com>; H. Peter Anvin <hpa@zytor.com>; Tianyu Lan
>> <Tianyu.Lan@microsoft.com>
>> Subject: RE: [PATCH] x86/hyper-v: use cheaper
>> HVCALL_FLUSH_VIRTUAL_ADDRESS_{LIST,SPACE} hypercalls when possible
>> 
>> ...
>>>
>> This is a good idea.  We should probably do the same with the hypercalls for
>> sending
>> IPIs -- try the simpler version first and move to the more complex _EX
>> version only
>> if necessary.
> I am not sure if this would work correctly. When I was developing the IPI enlightenment, 
> what I remember was that the guest is expected to use the API recommended by the Hypervisor.
>

I was under the same impression when I implemented PV TLB flush. Turns
out HV_X64_EX_PROCESSOR_MASKS_RECOMMENDED is a misnomer or at least
Windows treats it as HV_X64_EX_PROCESSOR_MASKS_AVAILABLE instead using
only when needed.

My guess would be that the situation with IPI is the same. In any case I
can try to implement Hyper-V style PV IPIs for Windows in KVM and we'll
see how Windows uses these hypercalls :-)

-- 
  Vitaly
