Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77342C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 06:28:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 258C620020
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 06:28:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 258C620020
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754405AbeGIG22 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 02:28:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41224 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751321AbeGIG21 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 02:28:27 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C04914001388;
        Mon,  9 Jul 2018 06:28:26 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-43.pek2.redhat.com [10.72.12.43])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E2FA5111E3EB;
        Mon,  9 Jul 2018 06:28:16 +0000 (UTC)
Subject: Re: [PATCH 1/5 V5] Add a function(ioremap_encrypted) for kdump when
 AMD sme enabled
From:   lijiang <lijiang@redhat.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de,
        hpa@zytor.com, ebiederm@xmission.com, joro@8bytes.org,
        thomas.lendacky@amd.com, dyoung@redhat.com,
        kexec@lists.infradead.org, iommu@lists.linux-foundation.org,
        bhe@redhat.com
References: <20180702072639.10110-1-lijiang@redhat.com>
 <20180702072639.10110-2-lijiang@redhat.com> <20180702101451.GB28730@zn.tnic>
 <4ae1cfb5-0a4b-2aac-2575-024e2c74826f@redhat.com>
 <895db996-febd-d50c-91af-4f1ef3d27bd8@redhat.com>
 <20180703111428.GB5748@zn.tnic>
 <4fbb843b-9597-a48b-8b6f-00e354b91950@redhat.com>
Message-ID: <e7357038-08bd-7ba8-5357-7c91d21d10fe@redhat.com>
Date:   Mon, 9 Jul 2018 14:28:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <4fbb843b-9597-a48b-8b6f-00e354b91950@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Mon, 09 Jul 2018 06:28:26 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Mon, 09 Jul 2018 06:28:26 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'lijiang@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2018年07月03日 19:44, lijiang 写道:
> 在 2018年07月03日 19:14, Borislav Petkov 写道:
>> On Tue, Jul 03, 2018 at 06:58:14PM +0800, lijiang wrote:
>>> For kdump, the elf header finally use the crash kernel reserved memory, it is not an old memory.
>>
>> Lamme repeat my suggestion:
>>
>> So beef up the logic in __ioremap_caller() to figure out based on the
>> address whether to access the memory encrypted or not. In general, you
>> can deduce, based on the region you're mapping, whether you need to map
>> in encrypted or decrypted.
>>
>> For example:
>>
>>         addr = elfcorehdr_addr;
>>
>>         /* Read Elf header */
>>         rc = elfcorehdr_read((char *)&ehdr, sizeof(Elf64_Ehdr), &addr);
>>         if (rc < 0)
>>                 return rc;
>>
>> elfcorehdr_addr has that elfcorehdr address. So you can check which address
>> you're mapping and do:
>>
>> __ioremap_caller:
>>
>> ...
>> 	prot = __ioremap_compute_prot(...);
>>
>> and that __ioremap_compute_prot() function which you will add will have
>> all that logic to determine encrypted or not by comparing addresses etc.
>>
>> Does that make more sense?
>>
> Thank you, Boris. Good idea, I will rethink about this issue and post it again.
> 
Hi, Boris
Last week, I had tried many ways to do this work, but it looks like that the ways of
deducing address is not suitable to another scenarios, such as mapping some devices
mmio space, which are unencrypted, and the device mmio space is outside kdump kernel
like the old memory, but the old memory is encrypted, we can't find the general rules
to decide when to encrypt or not. So it should be the best way that the caller care about
encryption or not. What do you think?

> Regards,
> Lianbo
> 
