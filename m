Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 368F0C00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 08:47:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8D0520878
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 08:47:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8D0520878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbeJHP6Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 11:58:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48471 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726013AbeJHP6Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 11:58:24 -0400
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.25])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 75F663001BDE;
        Mon,  8 Oct 2018 08:47:47 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-85.pek2.redhat.com [10.72.12.85])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B032620165F4;
        Mon,  8 Oct 2018 08:47:38 +0000 (UTC)
Subject: Re: [tip:x86/mm] kdump, proc/vmcore: Enable kdumping encrypted memory
 with SME enabled
To:     Borislav Petkov <bp@suse.de>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org, tglx@linutronix.de,
        hpa@zytor.com, linux-tip-commits@vger.kernel.org
References: <be7b47f9-6be6-e0d1-2c2a-9125bc74b818@redhat.com>
 <tip-992b649a3f013465d8128da02e5449def662a4c3@git.kernel.org>
 <21eab36e-d113-cf88-e497-7dd620981544@redhat.com>
 <20181007084742.GA30797@zn.tnic>
 <58270f3f-f17c-8996-09cd-6da3481beb40@redhat.com>
 <20181008053714.GA6490@zn.tnic>
 <710b9d95-2f70-eadf-c4a1-c3dc80ee4ebb@redhat.com>
 <20181008080013.GB6490@zn.tnic>
From:   lijiang <lijiang@redhat.com>
Message-ID: <8147597a-f8e0-7f1a-bd2b-e914b18c5c74@redhat.com>
Date:   Mon, 8 Oct 2018 16:47:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181008080013.GB6490@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.25
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Mon, 08 Oct 2018 08:47:47 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2018年10月08日 16:00, Borislav Petkov 写道:
> On Mon, Oct 08, 2018 at 03:11:56PM +0800, lijiang wrote:
>> I used this ".config" to compile kernel in the attachment, and got a compile error.
>> Would you like to have a try?
>>
>> [root@hp-dl385g10-03 linux]# make ARCH=i386 -j32
>>   ......
>>   LD      vmlinux.o
>>   MODPOST vmlinux.o
>> fs/proc/vmcore.o：In function ‘read_from_oldmem’：
>> /home/linux/fs/proc/vmcore.c:127：undefined reference to ‘copy_oldmem_page_encrypted’
>> make: *** [vmlinux] error 1
> 
> Thanks, that triggered here. Ok, I guess something like this, to avoid
> the ugly ifdeffery:
> 
> ---
> diff --git a/arch/x86/kernel/crash_dump_32.c b/arch/x86/kernel/crash_dump_32.c
> index 33ee47670b99..8696800f2eea 100644
> --- a/arch/x86/kernel/crash_dump_32.c
> +++ b/arch/x86/kernel/crash_dump_32.c
> @@ -80,6 +80,16 @@ ssize_t copy_oldmem_page(unsigned long pfn, char *buf,
>  	return csize;
>  }
>  
> +/*
> + * 32-bit parrot version to avoid build errors.
> + */
> +ssize_t copy_oldmem_page_encrypted(unsigned long pfn, char *buf, size_t csize,
> +				   unsigned long offset, int userbuf)
> +{
> +	WARN_ON_ONCE(1);
> +	return copy_oldmem_page(pfn, buf, csize, offset, userbuf);
> +}
> +

It looks like a good way to avoid the 'ifdefined', and it's also good enough for i386.

But for other architectures, such as POWERPC/ARM..., we will also have to add the same 
function for every architecture. Otherwise, i guess that they also have a same compile
error on other architectures.

Sometimes, it's hard to make a choice.

Regards,
Lianbo
>  static int __init kdump_buf_page_init(void)
>  {
>  	int ret = 0;
> 
> 
> 
