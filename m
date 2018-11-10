Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47CDEC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 06:32:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12AB6204FD
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 06:32:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12AB6204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728892AbeKJQQ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 11:16:27 -0500
Received: from terminus.zytor.com ([198.137.202.136]:37315 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728567AbeKJQQ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 11:16:26 -0500
Received: from carbon-x1.hos.anvin.org (c-24-5-245-234.hsd1.ca.comcast.net [24.5.245.234] (may be forged))
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id wAA6WFZ32682346
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Fri, 9 Nov 2018 22:32:17 -0800
Subject: Re: PLEASE REVERT URGENTLY: Re: [PATCH v5 2/3] x86/boot: add acpi
 rsdp address to setup_header
To:     Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-doc@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, corbet@lwn.net,
        boris.ostrovsky@oracle.com
References: <20181010061456.22238-1-jgross@suse.com>
 <20181010061456.22238-3-jgross@suse.com>
 <f7c78ee7-b548-7f04-24da-7321b6c64c97@zytor.com>
 <bd2d17cd-072c-cad6-94ad-52373700a1c9@suse.com>
From:   "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <2934552c-d150-0afb-6fa9-9398cb94d86a@zytor.com>
Date:   Fri, 9 Nov 2018 22:32:10 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <bd2d17cd-072c-cad6-94ad-52373700a1c9@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Unfortunately there are many major distros shipping boot loaders which
> write crap data past the end of setup_header.
> 

Yes. We know that and it is resolved by:

a) the length field in setup_header;
b) the "sentinel" field which catches legacy non-compliant bootloaders.

>>
>> This field thus belongs in struct boot_params, not struct setup_header.
> 
> Okay, I can change that. Hoping that all boot loaders really write
> zeroes to that field in case they don't know it.
> 

This is what we added the sentinel field for: bootloaders which don't zero
unknown fields (read: Grub) will trigger the sentinel, and we wipe most of
this structure.

>>
>> Fields in struct boot_params are to be initialized to zero.
> 
> See above. grub2 in Debian, RHEL, ... doesn't do that reliably.
> 

See above.

>> There is a field called "sentinel" which attempts to detect broken
>> bootloaders which do not do this correctly; however, when enabling new
>> bootloaders the Right Thing to do is to make sure they adhere to the
>> protocol as defined, rather than pushing a new hack onto the kernel.
>>
>> Thus:
>>
>> 1. Please revert this patch immediately, and destroy any boot loaders
>>    which tries to implement this.> 2. Add the acpi_rsdp_addr to struct boot_params.
>> 3. DO NOT modify the boot protocol version header field. Instead
>>    make sure that the bootloader follows the protocol and zeroes
>>    all unknown fields in struct boot_params.
> 
> How can I do this for boot loaders shipped since several years?

Once again, you are adding new functionality; that is when you should fix
their implementation. The sentinel handles legacy bootloaders.

>> 4. Possibly make the kernel panic if it notices that the boot version
>>    header has been mucked with, in case some of these boot loaders
>>    have already escaped into the field.
> 
> So don't let a new kernel boot from a disk with above grub2?
> 
> I don't think so.

If there are any grubs which escaped with this broken protocol hack only.

	-hpa

