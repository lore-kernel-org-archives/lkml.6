Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 690CEC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 07:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39F4120840
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 07:14:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39F4120840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728132AbeKIQxN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 11:53:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58090 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727485AbeKIQxN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 11:53:13 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E7C6D394D48;
        Fri,  9 Nov 2018 07:13:58 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-121.pek2.redhat.com [10.72.12.121])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id ECD1C1057071;
        Fri,  9 Nov 2018 07:13:51 +0000 (UTC)
Subject: Re: [PATCH 2/2 v5] x86/kexec_file: add reserved e820 ranges to kdump
 kernel e820 table
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        x86@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        akpm@linux-foundation.org, dyoung@redhat.com
References: <20181107050019.6663-1-lijiang@redhat.com>
 <20181107050019.6663-3-lijiang@redhat.com>
 <20181107052345.GQ27491@MiWiFi-R3L-srv>
 <cc579d02-19e9-8749-ea48-3ff0fbf6461d@redhat.com>
 <20181109065146.GD31064@MiWiFi-R3L-srv>
From:   lijiang <lijiang@redhat.com>
Message-ID: <9cac4b46-2b45-b107-0e69-679acda170c5@redhat.com>
Date:   Fri, 9 Nov 2018 15:13:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181109065146.GD31064@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Fri, 09 Nov 2018 07:13:59 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2018年11月09日 14:51, Baoquan He 写道:
> On 11/07/18 at 05:10pm, lijiang wrote:
>> In fact, these patches are really simple. As the subject mentioned, this patch
>> [PATCH 2/2] adds the reserved e820 ranges to kdump kernel e820 table, and the
>> first patch [PATCH 1/2] helps to exactly add the e820(E820_TYPE_RESERVED) type
>> to kdump kernel e820 table, that is to say, it will filter out some unnecessary
>> type(E820_TYPE_RAM/E820_TYPE_UNUSABLE/E820_TYPE_RESERVED_KERN).
>>
>> At present, when we use the kexec to load the kernel image and initramfs(for
>> example: kexec -s -p xxxx), the latest kernel does not pass the e820 reserved
>> ranges to the second kernel, which might produce two problems:
>>
>> The first one is the MMCONFIG issue, although which does not make the system
>> crash or hang, this issue is still a potential risk, because my test can't
>> cover all cases due to resource constraints(Machine), and i'm not sure what
>> it will happen on other machine.
>>
>> The second issue is that the e820 reserved ranges do not setup in kdump kernel,
>> which will cause some functions which are related to the e820 reserved ranges
>> to become invalid. For example:
>>
>> early_memremap()->
>> early_memremap_pgprot_adjust()->
>> memremap_should_map_decrypted()->
>> e820__get_entry_type()
>>
>> Please focus on these functions, early_memremap_pgprot_adjust() and memremap_should_map_decrypted().
>>
>> In the first kernel, these ranges sit in e820 reserved ranges, so the memremap_should_map_decrypted()
>> will return true, that is to say, the reserved memory is decrypted, then the early_memremap_pgprot_adjust()
>> will call the pgprot_decrypted() to clear the memory encryption mask.
>>
>> In the second kernel, because the e820 reserved ranges are not passed to the second kernel, these ranges
>> don't sit in the e820 reserved ranges, so the the memremap_should_map_decrypted() will return false, that
>> is to say, the reserved memory is encrypted, and then the early_memremap_pgprot_adjust() will also call the
>> pgprot_encrypted() to set the memory encryption mask.
>>
>> Obviously, in the second kernel, the e820 reserved memory is still decrypted, it has gone wrong. So, if
>> don't fix, kdump won't work when we use the command(kexec -s -p xxx) to load the kernel image and initramfs.
> 
> Yes, this looks better. In fact, I searched cover-letter and both patch
> lg, didn't find anything to tell what will happen without these
> patchset. We should at least tell the patch is for cleanup/improvement/fix/feature.
> This "if don't fix, kdump won't work ..." is the sentence I first saw
> telling the sequence or the problem.
> 
> Please do not misunderstand those questions from me with unfriendly tone,
> words are cold and can't express emotions exactly, and appearance. Those
> questions are just meaning that people may get confusion from those
> places.
> 

Don't worry.
 
I would like to improve patch log based on your suggestion.

Regards,
Lianbo
> What: describe the problem you met.
> Why:  tell the root cause
> How:  how you fix it
> 
> This is what I usually use to write patch log. Just for your reference.
> 

Ok, thanks.

> Thanks
> Baoquan
> 
