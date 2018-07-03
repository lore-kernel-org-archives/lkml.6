Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5E95C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 20:08:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BD902466F
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 20:08:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BD902466F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753061AbeGCUIn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 16:08:43 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35362 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752292AbeGCUIm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 16:08:42 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8F440BB43B;
        Tue,  3 Jul 2018 20:08:41 +0000 (UTC)
Received: from prarit.bos.redhat.com (prarit-guest.khw.lab.eng.bos.redhat.com [10.16.186.145])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 39F3A2156889;
        Tue,  3 Jul 2018 20:08:41 +0000 (UTC)
Subject: Re: [PATCH] x86/MCE: Fix CPU microcode version output
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-edac@vger.kernel.org
References: <20180703164844.9742-1-prarit@redhat.com>
 <20180703165849.GA17773@agluck-desk>
From:   Prarit Bhargava <prarit@redhat.com>
Message-ID: <5ed43b85-a92f-8d6c-4565-d2e88d6d3f08@redhat.com>
Date:   Tue, 3 Jul 2018 16:08:41 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180703165849.GA17773@agluck-desk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Tue, 03 Jul 2018 20:08:41 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Tue, 03 Jul 2018 20:08:41 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'prarit@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/03/2018 12:58 PM, Luck, Tony wrote:
> On Tue, Jul 03, 2018 at 12:48:44PM -0400, Prarit Bhargava wrote:
>> On systems where a runtime microcode update has occurred the
>> microcode version is wrong because boot_cpu_data.microcode is
>> not updated during runtime.
>>
>> Use the per-CPU microcode version in the MCE message.
> 
> Other option would be to fix the microcode update code to make
> sure that boot_cpu_data.microcode is right.

I thought about that too [1] but TBH I've always been a bit confused by
boot_cpu_data vs. cpu_data().  At one point I thought that boot_cpu_data is
valid only up to a specific point in boot and from that point on the cpu_data()
should be used but I'm no longer sure if that's correct.

If that is not correct when should boot_cpu_data be used vs cpu_data()?  Is
boot_cpu_data truly supposed to represent the general state of the boot cpu at
boot time?

Look at the same function mce_setup() that I modified in my patch.   There is
another reference to boot_cpu_data.x86_vendor (which obviously will never change
during runtime) that likely should be cpu_data() if my understanding above is
correct.

P.

[1] Since the kernel now uses a cpu rendezvous model to update the microcode it
would be trivial to set boot_cpu_data.microcode to the new value.

> 
> But if we go this route we should add:
> 
> Fixes: fa94d0c6e0f3 ("x86/MCE: Save microcode revision in machine check records")
> Cc: stable@vger.kernel.org
> 
> Can also get a:
> 
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> 
> -Tony Luck
> 
