Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C056C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 13:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D89920989
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 13:10:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D89920989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbeK1AIq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 19:08:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38948 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726348AbeK1AIq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 19:08:46 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1075030821F1;
        Tue, 27 Nov 2018 13:10:53 +0000 (UTC)
Received: from vitty.brq.redhat.com.redhat.com (unknown [10.43.2.155])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1022D5DA63;
        Tue, 27 Nov 2018 13:10:50 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Roman Kagan <rkagan@virtuozzo.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley \(EOSG\)" <Michael.H.Kelley@microsoft.com>
Cc:     "kvm\@vger.kernel.org" <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86\@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v2 1/4] x86/hyper-v: move synic/stimer control structures definitions to hyperv-tlfs.h
In-Reply-To: <20181126200413.GA7852@rkaganb.sw.ru>
References: <20181126154732.23025-1-vkuznets@redhat.com> <20181126154732.23025-2-vkuznets@redhat.com> <20181126200413.GA7852@rkaganb.sw.ru>
Date:   Tue, 27 Nov 2018 14:10:49 +0100
Message-ID: <87wooyk6na.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Tue, 27 Nov 2018 13:10:53 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Kagan <rkagan@virtuozzo.com> writes:

> [ Sorry for having missed v1 ]
>
> On Mon, Nov 26, 2018 at 04:47:29PM +0100, Vitaly Kuznetsov wrote:
>> We implement Hyper-V SynIC and synthetic timers in KVM too so there's some
>> room for code sharing.
>> 
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> ---
>>  arch/x86/include/asm/hyperv-tlfs.h | 69 ++++++++++++++++++++++++++++++
>>  drivers/hv/hv.c                    |  2 +-
>>  drivers/hv/hyperv_vmbus.h          | 68 -----------------------------
>>  3 files changed, 70 insertions(+), 69 deletions(-)
>> 
>> diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
>> index 4139f7650fe5..b032c05cd3ee 100644
>> --- a/arch/x86/include/asm/hyperv-tlfs.h
>> +++ b/arch/x86/include/asm/hyperv-tlfs.h
>> @@ -731,6 +731,75 @@ struct hv_enlightened_vmcs {
>>  #define HV_STIMER_AUTOENABLE		(1ULL << 3)
>>  #define HV_STIMER_SINT(config)		(__u8)(((config) >> 16) & 0x0F)
>>  
>> +/* Define synthetic interrupt controller flag constants. */
>> +#define HV_EVENT_FLAGS_COUNT		(256 * 8)
>> +#define HV_EVENT_FLAGS_LONG_COUNT	(256 / sizeof(unsigned long))
>> +
>> +/*
>> + * Synthetic timer configuration.
>> + */
>> +union hv_stimer_config {
>> +	u64 as_uint64;
>> +	struct {
>> +		u64 enable:1;
>> +		u64 periodic:1;
>> +		u64 lazy:1;
>> +		u64 auto_enable:1;
>> +		u64 apic_vector:8;
>> +		u64 direct_mode:1;
>> +		u64 reserved_z0:3;
>> +		u64 sintx:4;
>> +		u64 reserved_z1:44;
>> +	};
>> +};
>> +
>> +
>> +/* Define the synthetic interrupt controller event flags format. */
>> +union hv_synic_event_flags {
>> +	unsigned long flags[HV_EVENT_FLAGS_LONG_COUNT];
>> +};
>> +
>> +/* Define SynIC control register. */
>> +union hv_synic_scontrol {
>> +	u64 as_uint64;
>> +	struct {
>> +		u64 enable:1;
>> +		u64 reserved:63;
>> +	};
>> +};
>> +
>> +/* Define synthetic interrupt source. */
>> +union hv_synic_sint {
>> +	u64 as_uint64;
>> +	struct {
>> +		u64 vector:8;
>> +		u64 reserved1:8;
>> +		u64 masked:1;
>> +		u64 auto_eoi:1;
>> +		u64 reserved2:46;
>> +	};
>> +};
>> +
>> +/* Define the format of the SIMP register */
>> +union hv_synic_simp {
>> +	u64 as_uint64;
>> +	struct {
>> +		u64 simp_enabled:1;
>> +		u64 preserved:11;
>> +		u64 base_simp_gpa:52;
>> +	};
>> +};
>> +
>> +/* Define the format of the SIEFP register */
>> +union hv_synic_siefp {
>> +	u64 as_uint64;
>> +	struct {
>> +		u64 siefp_enabled:1;
>> +		u64 preserved:11;
>> +		u64 base_siefp_gpa:52;
>> +	};
>> +};
>> +
>>  struct hv_vpset {
>>  	u64 format;
>>  	u64 valid_bank_mask;
>
> I personally tend to prefer masks over bitfields, so I'd rather do the
> consolidation in the opposite direction: use the definitions in
> hyperv-tlfs.h and replace those unions/bitfields elsewhere.  (I vaguely
> remember posting such a patchset a couple of years ago but I lacked the
> motivation to complete it).

Are there any known advantages of using masks over bitfields or the
resulting binary code is the same? Assuming there are no I'd personally
prefer bitfields - not sure why but to me e.g. 
 (stimer->config.enabled && !stimer->config.direct_mode)
 looks nicer than 
 (stimer->config & HV_STIMER_ENABLED && !(stimer->config & HV_STIMER_DIRECT))

+ there's no need to do shifts, e.g.

 vector = stimer->config.apic_vector

 looks cleaner that 

 vector = (stimer->config & HV_STIMER_APICVECTOR_MASK) >> HV_STIMER_APICVECTOR_SHIFT

... and we already use a few in hyperv-tlfs.h. I'm, however, flexible :-)

K. Y., Michael, Haiyang, Stephen - would you prefer to get rid of all
bitfields from hyperv-tlfs.h? If so I can work on a patchset. As to this
series, my understanding is that Paolo already queued it so in any case
this is going to be a separate effort (unless there are strong
objections of course).

Thanks!

-- 
Vitaly
