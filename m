Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 464D9C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 19:59:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7DE720684
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 19:59:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7DE720684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbeGSUnx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 16:43:53 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57216 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727449AbeGSUnx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 16:43:53 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D06E0CE1D6;
        Thu, 19 Jul 2018 19:59:13 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-175.bos.redhat.com [10.18.17.175])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5C842111AF1D;
        Thu, 19 Jul 2018 19:59:12 +0000 (UTC)
Subject: Re: [PATCH] xen/spinlock: Don't use pvqspinlock if only 1 vCPU
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     x86@kernel.org, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
References: <1532008100-26922-1-git-send-email-longman@redhat.com>
 <22f2465a-128e-730f-bc51-5a55ef16a039@oracle.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <daaac924-0f78-d934-886c-a90628aee7bd@redhat.com>
Date:   Thu, 19 Jul 2018 15:59:12 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <22f2465a-128e-730f-bc51-5a55ef16a039@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Thu, 19 Jul 2018 19:59:13 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Thu, 19 Jul 2018 19:59:13 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'longman@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/19/2018 03:18 PM, Boris Ostrovsky wrote:
> On 07/19/2018 09:48 AM, Waiman Long wrote:
>> On a VM with only 1 vCPU, the locking fast paths will always be
>> successful. In this case, there is no need to use the the PV qspinlock
>> code which has higher overhead on the unlock side than the native
>> qspinlock code.
>>
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>  arch/x86/xen/spinlock.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/xen/spinlock.c b/arch/x86/xen/spinlock.c
>> index cd97a62..38f47ae 100644
>> --- a/arch/x86/xen/spinlock.c
>> +++ b/arch/x86/xen/spinlock.c
>> @@ -130,7 +130,8 @@ void xen_uninit_lock_cpu(int cpu)
>>  void __init xen_init_spinlocks(void)
>>  {
>>  
>> -	if (!xen_pvspin) {
>> +	/*  Don't need to use pvqspinlock code if there is only 1 vCPU. */
>> +	if (!xen_pvspin || num_possible_cpus() == 1) {
>>  		printk(KERN_DEBUG "xen: PV spinlocks disabled\n");
>>  		return;
>>  	}
>
> I think we need to set xen_pvspin to false for such configurations.
> Notice that xen_init_lock_cpu() will try to perform some additional
> pvspinlock initializations.
>
>
> -boris

The other pvqspinlock initialization has no runtime impact other than
allocating a bit of extra memory. Anyway, I will revise the patch to
disable xen_pvspin under such condition.

-Longman

