Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D852C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 05:44:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB85C2087A
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 05:44:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB85C2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728166AbeKOPum (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 10:50:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52054 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726689AbeKOPum (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 10:50:42 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A7813315487C;
        Thu, 15 Nov 2018 05:44:18 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-127.pek2.redhat.com [10.72.12.127])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A51B75DD7F;
        Thu, 15 Nov 2018 05:44:11 +0000 (UTC)
Subject: Re: [PATCH 1/2 v6] x86/kexec_file: add e820 entry in case e820 type
 string matches to io resource name
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        x86@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        akpm@linux-foundation.org, dyoung@redhat.com, bhe@redhat.com
References: <20181114072926.13312-1-lijiang@redhat.com>
 <20181114072926.13312-2-lijiang@redhat.com> <20181114112600.GD13926@zn.tnic>
From:   lijiang <lijiang@redhat.com>
Message-ID: <9eb61523-7a08-24c4-ac15-050537bd9203@redhat.com>
Date:   Thu, 15 Nov 2018 13:44:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181114112600.GD13926@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Thu, 15 Nov 2018 05:44:18 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2018年11月14日 19:26, Borislav Petkov 写道:
> On Wed, Nov 14, 2018 at 03:29:25PM +0800, Lianbo Jiang wrote:
>> When load the kernel image and initramfs by kexec_file_load syscall, it can
>> not add exact e820 reserved type to kdump kernel e820 table.
>>
>> Kdump uses walk_iomem_res_desc() to iterate io resources, then adds matched
>> desc to e820 table for kdump kernel. But, when convert the e820 type into
>> the iores descriptors, several e820 types are converted to 'IORES_DES_NONE'
>> in this function e820_type_to_iores_desc(). So the walk_iomem_res_desc()
>> will get these unnecessary types(E820_TYPE_RAM/E820_TYPE_UNUSABLE/E820_TYPE
>> _KERN) when iterate io resources by the 'IORES_DES_NONE'.
>>
>> It needs filter out these redundant type(such as E820_TYPE_RAM/E820_TYPE_
>> UNUSABLE/E820_TYPE_KERN) in order to add exact e820 reserved type to kdump
>> kernel e820 table. Thus it also needs an extra checking in memmap_entry_
>> callback() to match the e820 type and resource name.
> 
> Ok, it took me a while to parse what this is trying to say so let's
> start from the top:
> 
> * What resource type do you do need in the second kernel?
> 

Thanks for your comment.

The e820 reserved ranges need to be passed to the second kernel.

> * The most important question: why?
> 

At present, the upstream kernel does not pass the e820 reserved ranges to the
second kernel, which might cause two problems:

The first one is the MMCONFIG issue, the PCI MMCONFIG(extended mode) requires
the reserved region otherwise it falls back to legacy mode, which might lead to
the hot-plug device could not be recognized in kdump kernel.

Another one is that the e820 reserved ranges do not setup in kdump kernel, which
could cause kdump can't work in some machines. To know more information, please
refer to the [PATCH 2/2 v6] patch log.


> * If it is the reserved resource, why aren't you adding
> IORES_DESC_RESERVED or so which to look for instead of this hacky string
> comparison?
> 

Adding the new descriptor 'IORES_DESC_RESERVED' is also a good solution. I will
modify these patches based on your suggestion and post again.

Thanks.
Lianbo
