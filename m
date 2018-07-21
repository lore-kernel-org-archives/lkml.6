Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2769ECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 23:18:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8928B20864
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 23:18:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="Cm1HPFHN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8928B20864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=runbox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728545AbeGVAMj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 20:12:39 -0400
Received: from aibo.runbox.com ([91.220.196.211]:57364 "EHLO aibo.runbox.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728220AbeGVAMj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 20:12:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
         s=rbselector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject;
        bh=T0SzDch1GOzE3G6UgJ4bbwECZDIjyedf3SNFZ2mRQTk=; b=Cm1HPFHN76pLxjDCO7XYgDcxKa
        k8a++pfuiMVdwtp/rDLdGc5Wfk9nXHpCf7bgEhOe1SosTB0v2YLE9Bq4fRopAqwezL/BadAPuSW2z
        LRqwxjydGBkonfWPOIakpa7zsqV+Luhv/91ssIFVtwfx0KNRaa9lwPY5F0frFB1Aat9G9i9tkN7Bq
        gh3jXvmtiLzeu3WBF9OkntO1Fqj33w3B3/g8rPx6dRdv3Tlr/2tUwnxnLa7Y8BipMPEH3tg4lt5yA
        rFM4aQ4gFkDauLcv4IVa04BJ1u/ufEB0XyoTU12NAm37ZNSLywvnA/dZRRWQXbxEOnjtHnLv3iT3y
        Kj1LL0DQ==;
Received: from [10.9.9.211] (helo=mailfront11.runbox.com)
        by mailtransmit02.runbox with esmtp (Exim 4.86_2)
        (envelope-from <m.v.b@runbox.com>)
        id 1fh18X-0000LB-1P; Sun, 22 Jul 2018 01:18:05 +0200
Received: by mailfront11.runbox.com with esmtpsa  (uid:769847 )  (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.82)
        id 1fh18M-0005Cb-Gp; Sun, 22 Jul 2018 01:17:54 +0200
Subject: Re: [PATCH 2/2] xen/pv: Call get_cpu_address_sizes to set
 x86_virt/phys_bits
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        linux-kernel@vger.kernel.org
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Juergen Gross <jgross@suse.com>,
        xen-devel@lists.xenproject.org, x86@kernel.org,
        stable@vger.kernel.org
References: <20180721194909.23903-1-m.v.b@runbox.com>
 <20180721194909.23903-2-m.v.b@runbox.com>
 <90bc371d-a296-51b3-8b78-62106c9690de@oracle.com>
From:   "M. Vefa Bicakci" <m.v.b@runbox.com>
Message-ID: <d85c93da-4549-a7c1-af48-9c62cba8ae71@runbox.com>
Date:   Sat, 21 Jul 2018 19:17:49 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <90bc371d-a296-51b3-8b78-62106c9690de@oracle.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/21/2018 05:25 PM, Boris Ostrovsky wrote:
> On 07/21/2018 03:49 PM, M. Vefa Bicakci wrote:
>> diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
>> index 439a94bf89ad..87afb000142a 100644
>> --- a/arch/x86/xen/enlighten_pv.c
>> +++ b/arch/x86/xen/enlighten_pv.c
>> @@ -1257,6 +1257,7 @@ asmlinkage __visible void __init xen_start_kernel(void)
>>   
>>   	/* Work out if we support NX */
>>   	get_cpu_cap(&boot_cpu_data);
>> +	get_cpu_address_sizes(&boot_cpu_data);
>>   	x86_configure_nx();
> 
> 
> Have you observed any problems without this call? get_cpu_cap() is only
> called here to set X86_FEATURE_NX, and is then called again, together
> with get_cpu_address_sizes(), from early_identify_cpu().

Hello Boris,

Thank you for the reviews! Without the call to get_cpu_address_sizes,
paravirtualized virtual machines do not boot up kernels with versions
4.17 and up at all; this includes dom0 and domU. No domU logs are
generated in dom0's /var/log/xen/console/ directory either, despite
having earlyprintk=xen on the kernel command line for my test domU.

(For the record, I am using the patched version of Xen 4.6.6 provided
by Qubes OS R3.2.)

Thank you,

Vefa
