Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BC46C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 11:43:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18E6121C2B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 11:43:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18E6121C2B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730767AbeHIOIT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 10:08:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38806 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730119AbeHIOIS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 10:08:18 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A7F4B814FDCE;
        Thu,  9 Aug 2018 11:43:48 +0000 (UTC)
Received: from prarit.bos.redhat.com (prarit-guest.khw.lab.eng.bos.redhat.com [10.16.186.145])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0B6DE2166BA2;
        Thu,  9 Aug 2018 11:43:47 +0000 (UTC)
Subject: Re: [PATCH] x86/ACPI/cstate: Output AMD on APCI C1 FFH MWAIT AMD
 systems
To:     Pavel Machek <pavel@ucw.cz>
Cc:     linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-pm@vger.kernel.org
References: <20180808174735.3114-1-prarit@redhat.com>
 <20180808195856.GA20912@amd>
From:   Prarit Bhargava <prarit@redhat.com>
Message-ID: <932b8a78-a7b4-ea8c-a640-b7f657f45b63@redhat.com>
Date:   Thu, 9 Aug 2018 07:43:47 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180808195856.GA20912@amd>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Thu, 09 Aug 2018 11:43:48 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Thu, 09 Aug 2018 11:43:48 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'prarit@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/08/2018 03:58 PM, Pavel Machek wrote:
> On Wed 2018-08-08 13:47:35, Prarit Bhargava wrote:
>> commit 5209654a46ee ("x86/ACPI/cstate: Allow ACPI C1 FFH MWAIT use on AMD
>> systems") allows use of FFH for ACPI C1 but tools like cpupower and turbostat
>> display INTEL for the cstate description.
>>
>> Output "AMD" for AMD systems with FFH for ACPI C1.
> 
> Um, is it good idea?
>> First, you are changing kernel API.

I thought about that and the AMD support was only added a year ago so I think it
is okay to change.  Secondly, I did a grep for the use of the desc file in the
Fedora sources and only found a few places where the file is referenced.  They
all *report* the data but do not use it to make a decision.

For example, turbostat and cpupower only return the data to the console.

> 
>> @@ -107,9 +108,14 @@ static long acpi_processor_ffh_cstate_probe_cpu(void *_cx)
>>  			"Monitor-Mwait will be used to enter C-%d state\n",
>>  			cx->type);
>>  	}
>> -	snprintf(cx->desc,
>> -			ACPI_CX_DESC_LEN, "ACPI FFH INTEL MWAIT 0x%x",
>> -			cx->address);
>> +	if (c->x86_vendor == X86_VENDOR_INTEL)
>> +		snprintf(cx->desc,
>> +			 ACPI_CX_DESC_LEN, "ACPI FFH INTEL MWAIT 0x%x",
>> +			 cx->address);
>> +	else
>> +		snprintf(cx->desc,
>> +			 ACPI_CX_DESC_LEN, "ACPI FFH AMD MWAIT 0x%x",
>> +			 cx->address);
> 
> Second, I read it as "Intel MWAIT" instruction is used. Yes, AMD cpu can
> use Intel MWAIT, too...

That's true but the weirdness of seeing INTEL on an AMD box there made me push
this patch.

> 
> Third, there are more CPU vendors out there.

Not in this code.  It is AMD & Intel only.  I thought about dropping INTEL, and
also switching to X86.

Should we drop INTEL from the above or not (as suggested later in this thread)?
It feels like everyone is on the fence about it.

P.

> 
> 									Pavel
> 
