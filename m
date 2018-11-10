Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AFACC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 07:16:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6B6B20840
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 07:16:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6B6B20840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728925AbeKJRAW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 12:00:22 -0500
Received: from terminus.zytor.com ([198.137.202.136]:39115 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728682AbeKJRAW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 12:00:22 -0500
Received: from carbon-x1.hos.anvin.org (c-24-5-245-234.hsd1.ca.comcast.net [24.5.245.234] (may be forged))
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id wAA7G78d2694758
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Fri, 9 Nov 2018 23:16:08 -0800
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
 <2934552c-d150-0afb-6fa9-9398cb94d86a@zytor.com>
 <5a2f5cb8-7332-f490-eabf-cfcbdcd1abc4@suse.com>
From:   "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <59ca1053-9176-f1db-6e6c-96b47aaaa09d@zytor.com>
Date:   Fri, 9 Nov 2018 23:16:02 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <5a2f5cb8-7332-f490-eabf-cfcbdcd1abc4@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/9/18 11:02 PM, Juergen Gross wrote:
>>
>> Yes. We know that and it is resolved by:
>>
>> a) the length field in setup_header;
>> b) the "sentinel" field which catches legacy non-compliant bootloaders.
> 
> Doesn't help for boot loaders reading struct setup_header from the
> kernel image and then writing e.g. 512 bytes back to the setup_header
> location. The sentinel is cleared and the length field just isn't
> taken into account. And this is what happened.
> 

This is insane?! How do they manage to do this... it's not like  this isn't
written out in plain English to follow. I am, once again, utterly and
genuinely baffled about how many ways Grub can do things wrong.

So we should probably add a terminal sentinel field at offset 0x281, which is
one byte past the longest possible setup_header structure; in fact, we may
just want to explicitly pad setup_header with zeroes to its final size, if
nothing else to make it explicit how little space is actually left in there.

It would be enormously helpful if you could find out any more details about
exactly what they are doing to break things.

Many thanks,

	-hpa
